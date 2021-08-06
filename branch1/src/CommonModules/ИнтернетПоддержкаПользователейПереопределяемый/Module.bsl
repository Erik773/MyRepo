///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2018, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Подсистема "Интернет-поддержка пользователей".
// ОбщийМодуль.ИнтернетПоддержкаПользователейПереопределяемый.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

#Область ОбщегоНазначения

// В процедуре заполняется код языка интерфейса конфигурации (Метаданные.Языки),
// который передается сервисам Интернет-поддержки.
// Код языка заполняется в формате ISO-639-1.
// Если коды языков интерфейса конфигурации определены в формате ISO-639-1,
// тогда тело метода заполнять не нужно.
//
// Параметры:
//	КодЯзыка - Строка - в параметре передается код языка, указанный в
//		Метаданные.Языки;
//	КодЯзыкаВФорматеISO639_1 - Строка - в параметре возвращается
//		код языка в формате ISO-639-1.
//
// Пример:
//	Если КодЯзыка = "rus" Тогда
//		КодЯзыкаВФорматеISO639_1 = "ru";
//	ИначеЕсли КодЯзыка = "english" Тогда
//		КодЯзыкаВФорматеISO639_1 = "en";
//	КонецЕсли;
//
Процедура ПриОпределенииКодаЯзыкаИнтерфейсаКонфигурации(КодЯзыка, КодЯзыкаВФорматеISO639_1) Экспорт
	
	
	
КонецПроцедуры

// Определяет список модулей библиотек и конфигурации, которые предоставляют
// основные сведения о сервисах: идентификатор, наименование, описание и картинка.
// Модуль должен обязательно содержать процедуру ПриДобавленииОписанийСервисовСопровождения. Пример см.
// процедуру СПАРКРиски.ПриДобавленииОписанийСервисовСопровождения.
//
// Параметры:
//  МодулиСервисов - Массив - имена серверных общих модулей библиотек и конфигурации.
//
// Пример:
//  МодулиСервисов.Добавить("СПАРКРиски");
//  МодулиСервисов.Добавить("РаботаСКонтрагентами");
//
Процедура ПриОпределенииСервисовСопровождения(МодулиСервисов) Экспорт
	
	
КонецПроцедуры

#КонецОбласти

#Область ОбработкаСобытийБиблиотеки

// Реализует обработку события сохранения в информационной базе данных
// аутентификации пользователя Интернет-поддержки - логина и пароля
// для подключения к сервисам Интернет-поддержки.
//
// Параметры:
//  ДанныеПользователя - Структура, Неопределено - структура с полями. Если в метод передано значение
//                       Неопределено, данные аутентификации были удалены.
//    * Логин - Строка - логин пользователя;
//    * Пароль - Строка - пароль пользователя;
//
Процедура ПриИзмененииДанныхАутентификацииИнтернетПоддержки(ДанныеПользователя) Экспорт
	
	
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
