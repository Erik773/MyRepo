///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ВидКонтактнойИнформацииСсылка = УправлениеКонтактнойИнформацией.ВидКонтактнойИнформацииПоИмени("Справочник_ДемоКонтактныеЛицаПартнеров");
	
	Блокировка = Новый БлокировкаДанных;
	ЭлементБлокировки = Блокировка.Добавить("Справочник.ВидыКонтактнойИнформации");
	ЭлементБлокировки.УстановитьЗначение("Ссылка", ВидКонтактнойИнформацииСсылка.Ссылка);
		
	НачатьТранзакцию();
	Попытка
			
		Блокировка.Заблокировать();
	
		КонтактныеЛицПартнеров = ВидКонтактнойИнформацииСсылка.ПолучитьОбъект();
		КонтактныеЛицПартнеров.Используется = Значение;
		ОбновлениеИнформационнойБазы.ЗаписатьДанные(КонтактныеЛицПартнеров);
	
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли