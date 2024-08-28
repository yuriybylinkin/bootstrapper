
&Лог("oscript.app.bootstrapper")
Перем Лог;

&Пластилин
Перем НастройкиПроекта;

&Дуб
Процедура ПриСозданииОбъекта()
		
КонецПроцедуры

#Область Утилиты

&Завязь(Значение = "КаталогСборки", Тип = "Строка")
Функция ПолучитьКаталогСборки() Экспорт
	Возврат НастройкиПроекта.КаталогСборки();
КонецФункции

&Завязь(Значение = "ЖурналСобытий", Тип = "Лог")
Функция ПолучитьЖурналСобытий() Экспорт
	Возврат Лог;
КонецФункции

&Завязь(Значение = "ТипОтчетаБСЛЛС", Тип = "Строка")
Функция ПолучитьТипОтчетаБСЛЛС() Экспорт
	Возврат "generic";
КонецФункции

&Завязь(Значение = "ИмяФайлаМетаданныхОтчетаБСЛЛС", Тип = "Строка")
Функция ПолучитьИмяФайлаМетаданныхОтчетаБСЛЛС() Экспорт
	Возврат ".reportmetadata";
КонецФункции

&Завязь(Значение = "ПодкаталогОтчетовБСЛЛС", Тип = "Строка")
Функция ПолучитьПодкаталогОтчетовБСЛЛС() Экспорт
	Возврат "bslls_reports";
КонецФункции

#КонецОбласти

#Область ЭлементыГлавногоМеню

&Завязь(Значение = "МенюКонфигурация", Тип = "Структура")
&Порядок(10)
&Прозвище("ЭлементГлавноеМеню")
Функция ПолучитьМенюКонфигурация() Экспорт
	Возврат ЭлементМеню("Конфигурация", "/cfInfo");
КонецФункции

&Завязь(Значение = "МенюРасширения", Тип = "Структура")
&Порядок(15)
&Прозвище("ЭлементГлавноеМеню")
Функция ПолучитьМенюРасширения() Экспорт
	Возврат ЭлементМеню("Расширения", "/extList");
КонецФункции

&Завязь(Значение = "МенюТесты", Тип = "Структура")
&Порядок(20)
&Прозвище("ЭлементГлавноеМеню")
Функция ПолучитьМенюТесты() Экспорт
	Возврат ЭлементМеню("Тесты", "/testsInfo");
КонецФункции

&Завязь(Значение = "МенюСтатАнализ", Тип = "Структура")
&Порядок(25)
&Прозвище("ЭлементГлавноеМеню")
Функция ПолучитьМенюСтатАнализ() Экспорт
	Возврат ЭлементМеню("Анализ BSL LS", "/bsl/list");
КонецФункции

#КонецОбласти

Функция ЭлементМеню(Заголовок = "", Ссылка = "")
	Возврат Новый Структура("Заголовок, Ссылка, Подменю", Заголовок, Ссылка, Новый Массив() );
КонецФункции