///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

// См. МенеджерСервисаКриптографии.СоздатьКонтейнерИЗапросНаСертификат
Функция СоздатьКонтейнерИЗапросНаСертификат(ИдентификаторЗаявления,
										СодержаниеЗапроса,
										НомерТелефона,
										ЭлектроннаяПочта,
										ИдентификаторАбонента = Неопределено,
										НотариусАдвокатГлаваКФХ = Ложь) Экспорт
	
	ПараметрыПроцедуры 	= Новый Структура;
	ПараметрыПроцедуры.Вставить("ИдентификаторЗаявления", 	ИдентификаторЗаявления);
	ПараметрыПроцедуры.Вставить("СодержаниеЗапроса", 		СодержаниеЗапроса);
	ПараметрыПроцедуры.Вставить("НомерТелефона", 			НомерТелефона);
	ПараметрыПроцедуры.Вставить("ЭлектроннаяПочта", 		ЭлектроннаяПочта);
	ПараметрыПроцедуры.Вставить("ИдентификаторАбонента", 	ИдентификаторАбонента);
	ПараметрыПроцедуры.Вставить("НотариусАдвокатГлаваКФХ", 	НотариусАдвокатГлаваКФХ);
		
	Возврат СервисКриптографииСлужебный.ВыполнитьВФоне("МенеджерСервисаКриптографии.СоздатьКонтейнерИЗапросНаСертификат", 
						ПараметрыПроцедуры);
	
КонецФункции	

// См. МенеджерСервисаКриптографии.УстановитьСертификатВКонтейнерИХранилище
Функция УстановитьСертификатВКонтейнерИХранилище(ИдентификаторЗаявления, ДанныеСертификата) Экспорт
	
	ПараметрыПроцедуры 	= Новый Структура;
	ПараметрыПроцедуры.Вставить("ИдентификаторЗаявления",	ИдентификаторЗаявления);
	ПараметрыПроцедуры.Вставить("ДанныеСертификата", 		ДанныеСертификата);
		
	Возврат СервисКриптографииСлужебный.ВыполнитьВФоне("МенеджерСервисаКриптографии.УстановитьСертификатВКонтейнерИХранилище", 
					ПараметрыПроцедуры);
	
КонецФункции

#КонецОбласти
