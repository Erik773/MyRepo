///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// Параметры:
//   Ограничение - см. УправлениеДоступомПереопределяемый.ПриЗаполненииОграниченияДоступа.Ограничение.
//
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	
	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЧтениеСпискаРазрешено(ТипСсылки)
	|	И ЗначениеРазрешено(Организация)
	|	И ЗначениеРазрешено(МестоХранения)";
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Параметры:
//   Документ - ДокументОбъект
//
Процедура ОбновитьРеестрСкладскихДокументов(Документ) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если ОбщегоНазначения.ЭтоСсылка(ТипЗнч(Документ)) Тогда
		Ссылка = Документ;
		
		Реквизиты = "Ссылка, ПометкаУдаления, Проведен, Дата, Номер, Организация, Ответственный, Комментарий";
		
		Если ТипЗнч(Ссылка) = Тип("ДокументСсылка._ДемоПеремещениеТоваров") Тогда
			Реквизиты = Реквизиты + ", МестоХраненияИсточник, МестоХраненияПриемник";
		Иначе
			Реквизиты = Реквизиты + ", МестоХранения";
		КонецЕсли;
		
		Данные = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Ссылка, Реквизиты);
		Если Не ЗначениеЗаполнено(Данные.Ссылка) Тогда
			Возврат; // Объект удален, связанная запись удаляется платформой.
		КонецЕсли;
	Иначе
		Ссылка = Документ.Ссылка;
		Данные = Документ;
	КонецЕсли;
	
	НаборЗаписей = СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Ссылка.Установить(Ссылка);
	Запись = НаборЗаписей.Добавить();
	ЗаполнитьЗначенияСвойств(Запись, Данные);
	Запись.ТипСсылки = ОбщегоНазначения.ИдентификаторОбъектаМетаданных(ТипЗнч(Запись.Ссылка));
	
	Если ТипЗнч(Ссылка) = Тип("ДокументСсылка._ДемоПеремещениеТоваров") Тогда
		Запись.МестоХранения = Данные.МестоХраненияИсточник;
		// Дополнительная запись для операции перемещения.
		ВтораяЗапись = НаборЗаписей.Добавить();
		ЗаполнитьЗначенияСвойств(ВтораяЗапись, Данные);
		ВтораяЗапись.ТипСсылки = Запись.ТипСсылки;
		ВтораяЗапись.МестоХранения = Данные.МестоХраненияПриемник;
		ВтораяЗапись.ДополнительнаяЗапись = Истина;
	КонецЕсли;
	
	НаборЗаписей.Записать();
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
