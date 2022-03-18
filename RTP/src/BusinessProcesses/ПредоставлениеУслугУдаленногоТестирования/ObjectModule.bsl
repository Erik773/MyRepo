
Процедура ОбработкаЗаказаПриСозданииЗадач(ТочкаМаршрута, ФормируемыеЗадачи, Отказ)
	Для Каждого Задача Из ФормируемыеЗадачи Цикл
		УстановитьПользователя(Задача, Перечисления.ТипыПользователей.Менеджер);
	КонецЦикла;
КонецПроцедуры

Процедура СогласованиеУсловийПриСозданииЗадач(ТочкаМаршрута, ФормируемыеЗадачи, Отказ)
	Для Каждого Задача Из ФормируемыеЗадачи Цикл
		УстановитьПользователя(Задача, Перечисления.ТипыПользователей.Менеджер);
	КонецЦикла;
КонецПроцедуры

Процедура СогласованиеСКлиентомПроверкаУсловия(ТочкаМаршрута, Результат)	
	Результат = СогласованиеЗаказа;
КонецПроцедуры

Процедура СоставлениеЧекЛистаПриСозданииЗадач(ТочкаМаршрута, ФормируемыеЗадачи, Отказ)
	Для Каждого Задача Из ФормируемыеЗадачи Цикл
		УстановитьПользователя(Задача, Перечисления.ТипыПользователей.Тестировщик);
	КонецЦикла;
КонецПроцедуры

Процедура ТестированиеПриСозданииЗадач(ТочкаМаршрута, ФормируемыеЗадачи, Отказ)
	Для Каждого Задача Из ФормируемыеЗадачи Цикл
		УстановитьПользователя(Задача, Перечисления.ТипыПользователей.УдаленныйТестировщик);
	КонецЦикла;
КонецПроцедуры

Процедура ПодготовкаОтчётаПриСозданииЗадач(ТочкаМаршрута, ФормируемыеЗадачи, Отказ)
	Для Каждого Задача Из ФормируемыеЗадачи Цикл
		УстановитьПользователя(Задача, Перечисления.ТипыПользователей.Тестировщик);
	КонецЦикла;
КонецПроцедуры

Процедура ЗавершитьРасчётСЗаказчикомПриСозданииЗадач(ТочкаМаршрута, ФормируемыеЗадачи, Отказ)
	Для Каждого Задача Из ФормируемыеЗадачи Цикл
		УстановитьПользователя(Задача, Перечисления.ТипыПользователей.Менеджер);
	КонецЦикла;
КонецПроцедуры

Процедура ПроизвестиРасчётУТПриСозданииЗадач(ТочкаМаршрута, ФормируемыеЗадачи, Отказ)
	Для Каждого Задача Из ФормируемыеЗадачи Цикл
		УстановитьПользователя(Задача, Перечисления.ТипыПользователей.Менеджер);
	КонецЦикла;
КонецПроцедуры

Процедура ЗакрытьЗаказПриСозданииЗадач(ТочкаМаршрута, ФормируемыеЗадачи, Отказ)
	Для Каждого Задача Из ФормируемыеЗадачи Цикл
		УстановитьПользователя(Задача, Перечисления.ТипыПользователей.Менеджер);
	КонецЦикла;
КонецПроцедуры


Процедура УстановитьПользователя(Задача, ТипПользователя)
	УИдентификатор = Неопределено;
	
	Если ТипПользователя = Перечисления.ТипыПользователей.Менеджер Тогда 
		УИдентификатор = ЭтотОбъект.Менеджер.Пользователь;
	ИначеЕсли ТипПользователя = Перечисления.ТипыПользователей.Тестировщик Тогда 
		УИдентификатор = ЭтотОбъект.Тестировщик.Пользователь;
	ИначеЕсли ТипПользователя = Перечисления.ТипыПользователей.УдаленныйТестировщик Тогда 
		УИдентификатор = ЭтотОбъект.УдаленныйТестировщик.Пользователь;
	КонецЕсли;
	
	Пользователь = Справочники.Пользователи.НайтиПоРеквизиту("УникальныйИдентификатор", УИдентификатор);
	Задача.Исполнитель = Пользователь;
	Записать();
КонецПроцедуры