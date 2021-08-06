///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Функция записи массива замеров 
//
// Параметры:
//  Замеры - Массив из Структура
//
// Возвращаемое значение:
//   Число - текущее значение периода записи замеров на сервере в секундах в случае записи замеров.
//
Функция ЗафиксироватьДлительностьКлючевыхОпераций(ЗамерыДляЗаписи) Экспорт
	
	ПериодЗаписи = ОценкаПроизводительности.ПериодЗаписи();
	
	Если МонопольныйРежим() Тогда
		Возврат ПериодЗаписи;
	КонецЕсли;
	
	Если НЕ Константы.ВыполнятьЗамерыПроизводительности.Получить() Тогда
		Возврат ПериодЗаписи;
	КонецЕсли;
		
	Замеры = ЗамерыДляЗаписи.ЗамерыЗавершенные;
	ИнформацияПрограммыПросмотра = ЗамерыДляЗаписи.ИнформацияПрограммыПросмотра;	
	
	УстановитьПривилегированныйРежим(Истина);
	
	НаборЗаписей = РегистрыСведений.ЗамерыВремени.СоздатьНаборЗаписей();
	НаборЗаписейТехнологический = РегистрыСведений.ЗамерыВремениТехнологические.СоздатьНаборЗаписей();
	НомерСеанса = НомерСеансаИнформационнойБазы();
	ДатаЗаписи = Дата(1,1,1) + ТекущаяУниверсальнаяДатаВМиллисекундах()/1000;
	ДатаЗаписиНачалоЧаса = НачалоЧаса(ДатаЗаписи);
	Пользователь = ПользователиИнформационнойБазы.ТекущийПользователь();
	ДатаЗаписиЛокальная = ТекущаяДатаСеанса();
	
	ЧтениеJSON = Новый ЧтениеJSON();
	ЧтениеJSON.УстановитьСтроку(ПараметрыСеанса.КомментарийЗамераВремени);
	КомментарийПоУмолчанию = ПрочитатьJSON(ЧтениеJSON, Истина);
	КомментарийПоУмолчанию.Вставить("ИнфКл", ИнформацияПрограммыПросмотра);
	
	ЗаписьJSON = Новый ЗаписьJSON;
	ЗаписьJSON.УстановитьСтроку(Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Нет));
	ЗаписатьJSON(ЗаписьJSON, КомментарийПоУмолчанию);
	КомментарийПоУмолчаниюСтрока = ЗаписьJSON.Закрыть();
		
	Для Каждого Замер Из Замеры Цикл
		ПараметрыЗамера = Замер.Значение;
		Длительность = (ПараметрыЗамера["ВремяОкончания"] - ПараметрыЗамера["ВремяНачала"])/1000;
		Длительность = ?(Длительность = 0, 0.001, Длительность);
		
		Если ПараметрыЗамера["Технологический"] Тогда
			НоваяЗапись = НаборЗаписейТехнологический.Добавить();
		Иначе
			НоваяЗапись = НаборЗаписей.Добавить();
		КонецЕсли;
		
		КлючеваяОперация = ПараметрыЗамера["КлючеваяОперация"];
		ВыполненСОшибкой = ПараметрыЗамера["ВыполненаСОшибкой"];
		
		Если НЕ ЗначениеЗаполнено(КлючеваяОперация) Тогда
			Продолжить;
		КонецЕсли;
				
		Если ТипЗнч(КлючеваяОперация) = Тип("Строка") Тогда
			КлючеваяОперацияСсылка = ОценкаПроизводительностиПовтИсп.ПолучитьКлючевуюОперациюПоИмени(КлючеваяОперация);
		Иначе
			КлючеваяОперацияСсылка = КлючеваяОперация;
		КонецЕсли;
		
		
		Если ПараметрыЗамера["Комментарий"] <> Неопределено Тогда
			КомментарийПоУмолчанию.Вставить("ДопИнф", ПараметрыЗамера["Комментарий"]);
			ЗаписьJSON = Новый ЗаписьJSON;
			ЗаписьJSON.УстановитьСтроку(Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Нет));
			ЗаписатьJSON(ЗаписьJSON, КомментарийПоУмолчанию);
			КомментарийПоУмолчаниюСтрока = ЗаписьJSON.Закрыть();
		КонецЕсли;
				
		НоваяЗапись.КлючеваяОперация = КлючеваяОперацияСсылка;
		НоваяЗапись.ДатаНачалаЗамера = ПараметрыЗамера["ВремяНачала"];
		НоваяЗапись.НомерСеанса = НомерСеанса;
		НоваяЗапись.ВремяВыполнения = Длительность;
		НоваяЗапись.ВесЗамера = ПараметрыЗамера["ВесЗамера"];
		НоваяЗапись.ДатаЗаписи = ДатаЗаписи;
		НоваяЗапись.ДатаЗаписиНачалоЧаса = ДатаЗаписиНачалоЧаса;
		НоваяЗапись.ДатаОкончания = ПараметрыЗамера["ВремяОкончания"];
		
		Если НЕ ПараметрыЗамера["Технологический"] Тогда
			НоваяЗапись.ВыполненСОшибкой = ВыполненСОшибкой;
		КонецЕсли;
		
		НоваяЗапись.Пользователь = Пользователь;
		НоваяЗапись.ДатаЗаписиЛокальная = ДатаЗаписиЛокальная;
		НоваяЗапись.Комментарий = КомментарийПоУмолчаниюСтрока;
		
		// Запись вложенных замеров.
		ВложенныеЗамеры = Замер.Значение["ВложенныеЗамеры"];
		Если ВложенныеЗамеры = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		УдельноеВремяОбщее = 0;
	
		Для Каждого ВложенныйЗамер Из ВложенныеЗамеры Цикл
			ДанныеЗамера = ВложенныйЗамер.Значение;
			ВесВложенногоЗамера = ДанныеЗамера["ВесЗамера"];
			ДлительностьВложенногоЗамера = ДанныеЗамера["Длительность"];
			КомментарийВложенногоЗамера = ДанныеЗамера["Комментарий"];
			КлючеваяОперацияВложенногоШага = КлючеваяОперация + "." + ВложенныйЗамер.Ключ;
			КлючеваяОперацияВложенногоШагаСсылка = ОценкаПроизводительностиПовтИсп.ПолучитьКлючевуюОперациюПоИмени(КлючеваяОперацияВложенногоШага, Истина);
			УдельноеВремя = ?(ВесВложенногоЗамера = 0, ДлительностьВложенногоЗамера, ДлительностьВложенногоЗамера / ВесВложенногоЗамера);
			УдельноеВремяОбщее = УдельноеВремяОбщее + УдельноеВремя;
			
			Если КомментарийВложенногоЗамера <> Неопределено Тогда
				КомментарийПоУмолчанию.Вставить("ДопИнф", КомментарийВложенногоЗамера);
				ЗаписьJSON = Новый ЗаписьJSON;
				ЗаписьJSON.УстановитьСтроку(Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Нет));
				ЗаписатьJSON(ЗаписьJSON, КомментарийПоУмолчанию);
				КомментарийШагаСтрока = ЗаписьJSON.Закрыть();
			КонецЕсли;
		
			НоваяЗапись = НаборЗаписей.Добавить();
			НоваяЗапись.КлючеваяОперация = КлючеваяОперацияВложенногоШагаСсылка;
			НоваяЗапись.ДатаНачалаЗамера = ДанныеЗамера["ВремяНачала"];
			НоваяЗапись.НомерСеанса = НомерСеанса;
			НоваяЗапись.ВремяВыполнения = УдельноеВремя/1000;
			НоваяЗапись.ВесЗамера = ВесВложенногоЗамера;
			НоваяЗапись.ДатаОкончания = ДанныеЗамера["ВремяОкончания"];		
			НоваяЗапись.ДатаЗаписи = ДатаЗаписи;
			НоваяЗапись.ДатаЗаписиНачалоЧаса = ДатаЗаписиНачалоЧаса;						
			НоваяЗапись.Пользователь = Пользователь;
			НоваяЗапись.ДатаЗаписиЛокальная = ДатаЗаписиЛокальная;
			НоваяЗапись.Комментарий = КомментарийШагаСтрока;
		КонецЦикла;
		// Фиксация удельного времени ключевой операции.
		Если ВложенныеЗамеры.Количество() > 0 Тогда
			КлючеваяОперацияУдельная = КлючеваяОперация + ".Удельный";
			КлючеваяОперацияУдельнаяСсылка = ОценкаПроизводительностиПовтИсп.ПолучитьКлючевуюОперациюПоИмени(КлючеваяОперацияУдельная, Истина);
			НоваяЗапись = НаборЗаписей.Добавить();
			НоваяЗапись.КлючеваяОперация = КлючеваяОперацияУдельнаяСсылка;
			НоваяЗапись.ДатаНачалаЗамера = ПараметрыЗамера["ВремяНачала"];
			НоваяЗапись.НомерСеанса = НомерСеанса;
			НоваяЗапись.ВремяВыполнения = УдельноеВремяОбщее/1000;
			НоваяЗапись.ВесЗамера = ПараметрыЗамера["ВесЗамера"];
			НоваяЗапись.ДатаЗаписи = ДатаЗаписи;
			НоваяЗапись.ДатаЗаписиНачалоЧаса = ДатаЗаписиНачалоЧаса;
			НоваяЗапись.ДатаОкончания = ПараметрыЗамера["ВремяОкончания"];		
			НоваяЗапись.Пользователь = Пользователь;
			НоваяЗапись.ДатаЗаписиЛокальная = ДатаЗаписиЛокальная;
			НоваяЗапись.Комментарий = КомментарийПоУмолчаниюСтрока;
		КонецЕсли;
	КонецЦикла;
	
	Если НаборЗаписей.Количество() > 0 Тогда
		Попытка
			НаборЗаписей.Записать(Ложь);
		Исключение
			ЗаписьЖурналаРегистрации(НСтр("ru = 'Не удалось сохранить замеры производительности'", 
				ОценкаПроизводительностиСлужебный.КодОсновногоЯзыка()),
				УровеньЖурналаРегистрации.Ошибка,,,ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		КонецПопытки;
	КонецЕсли;
	
	Если НаборЗаписейТехнологический.Количество() > 0 Тогда
		Попытка
			НаборЗаписейТехнологический.Записать(Ложь);
		Исключение
			ЗаписьЖурналаРегистрации(НСтр("ru = 'Не удалось сохранить технологические замеры производительности'", 
				ОценкаПроизводительностиСлужебный.КодОсновногоЯзыка()),
				УровеньЖурналаРегистрации.Ошибка,,,ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		КонецПопытки;
    КонецЕсли;
	
	Возврат ПериодЗаписи;
	
КонецФункции

// Параметры оценки производительности
//
// Возвращаемое значение:
//   Структура - параметры, полученные на сервере.
//
Функция ПолучитьПараметрыНаСервере() Экспорт
	
	Параметры = Новый Структура("ДатаИВремяНаСервере, ПериодЗаписи");
	Параметры.ДатаИВремяНаСервере = ТекущаяУниверсальнаяДатаВМиллисекундах();
	
	УстановитьПривилегированныйРежим(Истина);
	ТекущийПериод = Константы.ОценкаПроизводительностиПериодЗаписи.Получить();
	Параметры.ПериодЗаписи = ?(ТекущийПериод >= 1, ТекущийПериод, 60);
	
	Возврат Параметры;
	
КонецФункции

#КонецОбласти