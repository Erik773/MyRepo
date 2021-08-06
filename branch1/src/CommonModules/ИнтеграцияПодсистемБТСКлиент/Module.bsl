///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

#Область ОбработчикиСобытийБСП
// Обработка программных событий, возникающих в подсистемах БСП.
// Только для вызовов из библиотеки БСП в БТС.

// Определяет события, на которые подписана эта библиотека.
//
// Параметры:
//  Подписки - Структура - ключами свойств структуры являются имена событий, на которые
//           подписана эта библиотека.
//
Процедура ПриОпределенииПодписокНаСобытияБСП(Подписки) Экспорт
	
	// БазоваяФункциональность
	Подписки.ПередНачаломРаботыСистемы = Истина;
	Подписки.ПриНачалеРаботыСистемы = Истина;
	
	// ЗавершениеРаботыПользователей
	Подписки.ПриЗавершенииСеансов = Истина;
	
	// ПрофилиБезопасности
	Подписки.ПриПодтвержденииЗапросовНаИспользованиеВнешнихРесурсов = Истина;
	
КонецПроцедуры

#Область БазоваяФункциональность

// См. ОбщегоНазначенияКлиентПереопределяемый.ПередНачаломРаботыСистемы
Процедура ПередНачаломРаботыСистемы(Параметры) Экспорт
	
	Параметры.Модули.Добавить(РаботаВМоделиСервисаКлиент);
	
КонецПроцедуры

// См. ОбщегоНазначенияКлиентПереопределяемый.ПриНачалеРаботыСистемы
Процедура ПриНачалеРаботыСистемы(Параметры) Экспорт
	
	Параметры.Модули.Добавить(ВитриныКлиент);
	
	ИменаПодсистем = СтандартныеПодсистемыКлиент.ПараметрыРаботыКлиента().ИменаПодсистем;
	Если ИменаПодсистем.Получить("ТехнологияСервиса.МиграцияПриложений") <> Неопределено Тогда
		Параметры.Модули.Добавить(Вычислить("МиграцияПриложенийКлиент"));
	КонецЕсли;
	
	Если ИменаПодсистем.Получить("ТехнологияСервиса.РасширенияВМоделиСервиса") <> Неопределено Тогда
		Параметры.Модули.Добавить(Вычислить("КаталогРасширенийКлиент"));		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ЗавершениеРаботыПользователей

// См. процедуру УдаленноеАдминистрированиеБТСКлиент.ПриЗавершенииСеансов.
Процедура ПриЗавершенииСеансов(ФормаВладелец, Знач НомераСеансов, СтандартнаяОбработка, Знач ОповещениеПослеЗавершенияСеанса = Неопределено) Экспорт
	
	УдаленноеАдминистрированиеБТСКлиент.ПриЗавершенииСеансов(ФормаВладелец, НомераСеансов, СтандартнаяОбработка, ОповещениеПослеЗавершенияСеанса);
	
КонецПроцедуры

#КонецОбласти

#Область ПрофилиБезопасности

// См. процедуру РаботаВБезопасномРежимеКлиентПереопределяемый.ПриПодтвержденииЗапросовНаИспользованиеВнешнихРесурсов.
Процедура ПриПодтвержденииЗапросовНаИспользованиеВнешнихРесурсов(Знач ИдентификаторыЗапросов, ФормаВладелец, ОповещениеОЗакрытии, СтандартнаяОбработка) Экспорт

	НастройкаРазрешенийНаИспользованиеВнешнихРесурсовВМоделиСервисаКлиент.ПриПодтвержденииЗапросовНаИспользованиеВнешнихРесурсов(
		ИдентификаторыЗапросов, ФормаВладелец, ОповещениеОЗакрытии, СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область ИнформационныйЦентр

// См. ВызовОнлайнПоддержкиКлиент.ОбработкаОповещения.
Процедура ИнтеграцияВызовОнлайнПоддержкиКлиентОбработкаОповещения(ИмяСобытия, Элемент) Экспорт
	
	Если ИнтеграцияПодсистемБТСКлиентПовтИсп.ПодпискиБСП().ИнтеграцияВызовОнлайнПоддержкиКлиентОбработкаОповещения Тогда
		ИнтеграцияПодсистемБСПКлиент.ИнтеграцияВызовОнлайнПоддержкиКлиентОбработкаОповещения(ИмяСобытия, Элемент);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Определяет события, на которые могут подписаться другие библиотеки.
//
// Возвращаемое значение:
//   Структура - ключами свойств структуры являются имена событий, на которые могут быть подписаны библиотеки.
//
Функция СобытияБТС() Экспорт
	
	События = Новый Структура;
	
	// ВыгрузкаЗагрузкаДанных
	События.Вставить("ИнтеграцияВызовОнлайнПоддержкиКлиентОбработкаОповещения", Ложь);
	
	Возврат События;
	
КонецФункции

#КонецОбласти