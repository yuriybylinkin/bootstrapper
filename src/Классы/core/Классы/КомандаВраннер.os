#Использовать 1commands

Перем Команда;
Перем Настройки;

&Желудь
&Характер("Компанейский")
Процедура ПриСозданииОбъекта(&Пластилин НастройкиРабочейОбласти)

	Настройки = НастройкиРабочейОбласти;

	Команда = Новый Команда;
	Команда.УстановитьКоманду("vrunner");

КонецПроцедуры

Функция ДобавитьПараметр(Параметр) Экспорт
	Команда.ДобавитьПараметр(Параметр);
	Возврат ЭтотОбъект;
КонецФункции

Функция Исполнить() Экспорт

	Если НЕ ЗначениеЗаполнено(Настройки.СтрокаПодключения) Тогда
		ВызватьИсключение "Не указана строка подключения";
	КонецЕсли;
	
	Команда.ДобавитьПараметр("--ibconnection " + Настройки.СтрокаПодключения);

	Если ЗначениеЗаполнено(Настройки.ВерсияПлатформы) Тогда
		Команда.ДобавитьПараметр("--v8version " + Настройки.ВерсияПлатформы);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Настройки.Пользователь) Тогда
		Команда.ДобавитьПараметр("--db-user " + Настройки.Пользователь);
	КонецЕсли;

	Если ЗначениеЗаполнено(Настройки.Пароль) Тогда
		Команда.ДобавитьПараметр("--db-pwd " + Настройки.Пароль);
	КонецЕсли;

	Если Настройки.ИБКМД = Истина Тогда
		Команда.ДобавитьПараметр("--ibcmd");
	КонецЕсли;

	Команда.Исполнить();

	Возврат Команда.ПолучитьВывод();

КонецФункции