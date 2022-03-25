
&НаКлиенте
Процедура СписокОткрытоПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	ОбновитьСтатусЗадач(ПараметрыПеретаскивания.Значение, ПредопределенноеЗначение("Перечисление.СтатусыЗадачи.Открытый"));
КонецПроцедуры

&НаКлиенте
Процедура СписокНаИсполненииПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	ОбновитьСтатусЗадач(ПараметрыПеретаскивания.Значение, ПредопределенноеЗначение("Перечисление.СтатусыЗадачи.НаИсполнении"));
КонецПроцедуры

&НаКлиенте
Процедура СписокЗакрытоПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	ОбновитьСтатусЗадач(ПараметрыПеретаскивания.Значение, ПредопределенноеЗначение("Перечисление.СтатусыЗадачи.Закрытый"));
КонецПроцедуры

&НаСервере
Процедура УстановитьСтатусЗадач(ВыбранныеЭлементы, НовыйСтатусЗадачи)
	Для Каждого Элемент Из ВыбранныеЭлементы Цикл
		Задача = Элемент.ПолучитьОбъект();
		Если Задача.Статус = НовыйСтатусЗадачи Тогда
			Продолжить
		Иначе
			Задача.Статус = НовыйСтатусЗадачи;
			Попытка
				Задача.Записать();				
			Исключение
				СообщениеОбОшибке = Новый СообщениеПользователю();
				СообщениеОбОшибке.Текст = ОписаниеОшибки();
				СообщениеОбОшибке.Сообщить();
			КонецПопытки;
		КонецЕсли;
	КонецЦикла; 
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСтатусЗадач(ВыбранныеЗаписи, НовыйСтатус)
	УстановитьСтатусЗадач(ВыбранныеЗаписи, НовыйСтатус);
	ОбновитьИнтерфейс();	
КонецПроцедуры
