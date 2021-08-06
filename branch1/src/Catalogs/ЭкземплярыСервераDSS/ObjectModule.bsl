///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ОбработчикиСобытий

Процедура ПриКопировании(ОбъектКопирования)
	
	ВнутреннийИдентификатор = "";
	ИдентификаторЦИ = "";
	Используется = Истина;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ВнутреннийИдентификатор) 
		И НЕ ДополнительныеСвойства.Свойство("ПоставляемыеДанные") Тогда
		ТекстСообщения = НСтр("ru = 'Поставляемые серверы облачной подписи предназначены для программного изменения.'");
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, "АдресСервера", "Объект", Отказ);
		Отказ = Истина;
	КонецЕсли;
	
	Если ПустаяСтрока(Наименование) Тогда
		Наименование = СокрЛП(АдресСервера);
	КонецЕсли;	
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	КлючиПроверки = СервисКриптографииDSSСлужебный.КлючиУникальностиСправочника("ЭкземплярыСервераDSS");
	Если ЗначениеЗаполнено(КлючиПроверки) 
		И НЕ ДополнительныеСвойства.Свойство("ПоставляемыеДанные") Тогда
		ДанныеКлюча = Новый Структура(КлючиПроверки);
		ЗаполнитьЗначенияСвойств(ДанныеКлюча, ЭтотОбъект);
		ЕстьПовтор = СервисКриптографииDSSСлужебный.ПроверитьДублированиеСерверов(Ссылка, ДанныеКлюча);
		Если ЗначениеЗаполнено(ЕстьПовтор) Тогда
			ТекстСообщения = НСтр("ru = 'Обнаружена дублирующая запись в справочнике Экземпляры сервера DSS:'") + " " + АдресСервера;
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, "АдресСервера", "Объект");
		КонецЕсли;	
	КонецЕсли;	
	
	ИдВерсии = СервисКриптографииDSSКлиентСервер.ИдентификаторВерсииСервера(ВерсияАПИ);
	
	Если ИдВерсии > 1 Тогда
		ПроверяемыеРеквизиты.Добавить("СервисАудита");
		ПроверяемыеРеквизиты.Добавить("СервисОбработкиДокументов");
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	ВсеВерсии = СервисКриптографииDSSКлиентСервер.ПоддерживаемыеВерсии();

	ТаймАут = 120;
	ВерсияАПИ 	= ВсеВерсии[0];
	Используется = Истина;
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли