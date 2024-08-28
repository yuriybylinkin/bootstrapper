
Перем Замечания;
Перем КоличествоЗамечаний;
Перем КешФайловИсходников;
Перем ВремяТехдолга;

&Желудь
&Характер("Компанейский")
Процедура ПриСозданииОбъекта()
	Замечания = Новый Соответствие();
	КоличествоЗамечаний = 0;
	ВремяТехдолга = 0;
	КешФайловИсходников = Новый Соответствие();
КонецПроцедуры

Процедура ДобавитьЗамеченияИзФайла(Путь) Экспорт

	Если НЕ Замечания[Путь] = Неопределено Тогда
		Возврат;
	КонецЕсли;

	ЧтениеJSON = Новый ЧтениеJSON();
	ЧтениеJSON.ОткрытьФайл(Путь);
	ЗамечанияИзФайла = ПрочитатьJSON(ЧтениеJSON, Ложь);
	ЧтениеJSON.Закрыть();

	МассивЗамечаний = РаспарситьЗамечания(ЗамечанияИзФайла);
	Замечания[Путь] = МассивЗамечаний;

КонецПроцедуры

Функция Получить() Экспорт
	Результат = Новый Массив();

	Для Каждого КиЗ из Замечания Цикл
		Для Каждого Замечание Из КиЗ.Значение Цикл
			Результат.Добавить(Замечание);
		КонецЦикла;
	КонецЦикла;

	Возврат Результат;
КонецФункции

Функция КоличествоЗамечаний() Экспорт
	Возврат КоличествоЗамечаний;
КонецФункции

Функция ВремяТехдолга() Экспорт
	Возврат ВремяТехдолга;
КонецФункции

Функция РаспарситьЗамечания(ЗамечанияИзФайла)
	МассивЗамечаний = Новый Массив();

	Для Каждого Замечание Из ЗамечанияИзФайла.issues Цикл
		НовоеЗамечание = СтруктураЗамечания();
		НовоеЗамечание.Правило = Замечание.ruleId;
		НовоеЗамечание.Критичность = Замечание.severity;
		НовоеЗамечание.Тип = Замечание.type;
		НовоеЗамечание.Текст = Замечание.primaryLocation.message;
		НовоеЗамечание.ВремяИсправления = Замечание.effortMinutes;

		НовоеЗамечание.МестаИспользования.Добавить(РаспарситьМестоИспользования(Замечание.primaryLocation));
		КоличествоЗамечаний = КоличествоЗамечаний + 1;
		ВремяТехдолга = ВремяТехдолга + Замечание.effortMinutes;

		Для Каждого МестоИспользования Из Замечание.secondaryLocations Цикл
			НовоеМестоИспользования = РаспарситьМестоИспользования(МестоИспользования);
			НовоеЗамечание.МестаИспользования.Добавить(НовоеМестоИспользования);
			КоличествоЗамечаний = КоличествоЗамечаний + 1;
		КонецЦикла;

		НовоеЗамечание.МестаИспользования = Новый ФиксированныйМассив(НовоеЗамечание.МестаИспользования);

		НовоеЗамечание = Новый ФиксированнаяСтруктура(НовоеЗамечание);

		МассивЗамечаний.Добавить(НовоеЗамечание);

	КонецЦикла;


	Возврат МассивЗамечаний;
КонецФункции

Функция РаспарситьМестоИспользования(МестоИспользованияИзФайла)
	НовоеМестоИспользования = СтруктураМестаИспользования();
	НовоеМестоИспользования.СтрокаНачало = МестоИспользованияИзФайла.textRange.startLine;
	НовоеМестоИспользования.СтрокаКонец = МестоИспользованияИзФайла.textRange.endLine;
	НовоеМестоИспользования.КолонкаНачало = МестоИспользованияИзФайла.textRange.startColumn;
	НовоеМестоИспользования.КолонкаКонец = МестоИспользованияИзФайла.textRange.endColumn;
	НовоеМестоИспользования.Файл = МестоИспользованияИзФайла.filePath;
	НовоеМестоИспользования.Код = ПолучитьСодержаниеФайла(НовоеМестоИспользования.Файл, 
														НовоеМестоИспользования.СтрокаНачало,
														НовоеМестоИспользования.СтрокаКонец);
	Возврат Новый ФиксированнаяСтруктура(НовоеМестоИспользования);
КонецФункции

Функция ПолучитьСодержаниеФайла(ПутьКФайлу, СтрокаНачало, СтрокаКонец)

	Содержание = КешФайловИсходников[ПутьКФайлу];

	Если Содержание = Неопределено Тогда
		ЧтениеТекста = Новый ЧтениеТекста(ПутьКФайлу, КодировкаТекста.UTF8,,, Ложь);
		Текст = ЧтениеТекста.Прочитать();
		Содержание = СтрРазделить(Текст, Символы.ПС);
		КешФайловИсходников[ПутьКФайлу] = Содержание;
	КонецЕсли;

	Результат = Новый Массив();

	Для Счетчик = СтрокаНачало - 1 По СтрокаКонец - 1 Цикл
		Результат.Добавить(Содержание[Счетчик]);
	КонецЦикла;

	Возврат СтрСоединить(Результат, Символы.ПС);

КонецФункции

Функция СтруктураЗамечания()
	Возврат Новый Структура("МестаИспользования, Правило, Критичность, Тип, Текст, ВремяИсправления", Новый Массив);
КонецФункции

Функция СтруктураМестаИспользования()
	Возврат Новый Структура("СтрокаНачало, СтрокаКонец, КолонкаНачало, КолонкаКонец, Код, Файл");
КонецФункции