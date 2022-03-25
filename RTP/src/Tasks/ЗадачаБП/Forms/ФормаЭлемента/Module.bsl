&НаКлиенте
Процедура КомандаНаИсполнение(Команда)
	УстановитьСтатусЗадачи(ПредопределенноеЗначение("Перечисление.СтатусыЗадачи.НаИсполнении"));
	УстановитьСтатусВыполненияЗадачи(Ложь);
	ЭтаФорма.Закрыть();
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	ФормаСпискаЗадачиБП = ПолучитьФорму("Задача.ЗадачаБП.ФормаСписка");
	ФормаСпискаЗадачиБП.Элементы.СписокОткрыто.Обновить();;
	ФормаСпискаЗадачиБП.Элементы.СписокНаИсполнении.Обновить();
	ФормаСпискаЗадачиБП.Элементы.СписокЗакрыто.Обновить();
КонецПроцедуры

&НаКлиенте
Процедура КомандаЗавершитьЗадачу(Команда)
	УстановитьСтатусЗадачи(ПредопределенноеЗначение("Перечисление.СтатусыЗадачи.Закрытый"));
	УстановитьСтатусВыполненияЗадачи(Истина);
	ЭтаФорма.Закрыть();
КонецПроцедуры

&НаКлиенте
Процедура КомандаОстановить(Команда)
	УстановитьСтатусЗадачи(ПредопределенноеЗначение("Перечисление.СтатусыЗадачи.Открытый"));
	УстановитьСтатусВыполненияЗадачи(Ложь);
	ЭтаФорма.Закрыть();
КонецПроцедуры

&НаСервере
Процедура УстановитьСтатусВыполненияЗадачи(ВыполненаЛиЗадача)
	ЭтотОбъект.Объект.Выполнена = ВыполненаЛиЗадача;
	Записать();
КонецПроцедуры

&НаСервере
Процедура УстановитьСтатусЗадачи(СтатусЗадачи)
	ЭтотОбъект.Объект.Статус = СтатусЗадачи;	
	Записать();
КонецПроцедуры

&НаКлиенте
Процедура Исполнитель1АвтоПодбор1(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	УИдентификатор = Объект.БизнесПроцесс.Менеджер.Пользователь;
	Исполнитель = ПолучитьПользователя(УИдентификатор);
	Для Каждого Реквизит Из ЭтаФорма.ПолучитьРеквизиты() Цикл
		Если Реквизит.Имя = "Исполнитель" Тогда
			Реквизит = Исполнитель;	
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

&НаСервере
Функция ПолучитьПользователя(УИдентификатор)
	Исполнитель = Справочники.Пользователи.НайтиПоРеквизиту("УникальныйИдентификатор", УИдентификатор);
	Возврат Исполнитель;
КонецФункции

&НаКлиенте
Процедура Согласовать(Команда)
	СогласоватьНаСервере();
КонецПроцедуры

&НаСервере
Процедура СогласоватьНаСервере()
	ТекущийБизнесПроцесс = БизнесПроцессы.ПредоставлениеУслугУдаленногоТестирования.НайтиПоНомеру(Объект.БизнесПроцесс.Номер);
	ТекущийБизнесПроцесс.СогласованиеЗаказа = Истина;
КонецПроцедуры