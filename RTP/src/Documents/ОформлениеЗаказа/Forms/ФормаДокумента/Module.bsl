&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	Если Не ЗначениеЗаполнено(ТекущийОбъект.СвязанныйБизнесПроцесс) Тогда
		НовыйБизнесПроцесс = СоздатьБизнесПроцесс();		
		Если Не НовыйБизнесПроцесс = Неопределено Тогда
			ТекущийОбъект.СвязанныйБизнесПроцесс = НовыйБизнесПроцесс.Ссылка;
			НовыйБизнесПроцесс.Старт();
			//@skip-check use-non-recommended-method
			Сообщить("Бизнес-процесс стартован!");
		КонецЕсли;
	Иначе
		Отказ = Истина;	
		Сообщение = Новый СообщениеПользователю();
		Сообщение.Текст = "Бизнес-процесс уже запущен!";
		Сообщение.Сообщить();		
	КонецЕсли;	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	УстановитьПараметрыПоУмолчанию();
КонецПроцедуры

&НаСервере
Процедура УстановитьПараметрыПоУмолчанию()
	ЭтаФорма.Объект.Заказчик = ПолучитьЗаказчика();
	ЭтаФорма.Объект.Дата = ТекущаяДатаСеанса();
КонецПроцедуры

&НаСервере
Функция ПолучитьЗаказчика()
	ТекущийПользователь =  ПараметрыСеанса.ТекущийПользователь;
	Заказчик = Справочники.Заказчики.НайтиПоРеквизиту("Пользователь", ТекущийПользователь.УникальныйИдентификатор);	
	Возврат Заказчик;
КонецФункции

&НаСервере
Функция СоздатьБизнесПроцесс()
	НовыйБизнесПроцесс = Неопределено;
	ОформлениеЗаказа = ЭтотОбъект.Объект;
	РабочаяГруппа = ПолучитьДоступнуюРабочуюГруппу(); 
	Если РабочаяГруппа = Неопределено Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Не найдена доступная рабочая группа";
		Сообщение.Сообщить();
	Иначе
		НовыйБизнесПроцесс = БизнесПроцессы.ПредоставлениеУслугУдаленногоТестирования.СоздатьБизнесПроцесс();
		НовыйБизнесПроцесс.Заказчик = ПолучитьЗаказчика();
		НовыйБизнесПроцесс.Менеджер = РабочаяГруппа.Менеджер;
		НовыйБизнесПроцесс.Тестировщик = РабочаяГруппа.Тестировщик;
		НовыйБизнесПроцесс.УдаленныйТестировщик = РабочаяГруппа.УдаленныйТестировщик;
		НовыйБизнесПроцесс.ВидТестирования = ОформлениеЗаказа.ВидТестирования; 
		НовыйБизнесПроцесс.ОписаниеЗадачи = ОформлениеЗаказа.Комментарии;
		НовыйБизнесПроцесс.Дата = ТекущаяДатаСеанса();	
		НовыйБизнесПроцесс.Записать();	
		СоздатьЗаказ(НовыйБизнесПроцесс.Ссылка, РабочаяГруппа);	
		ОбъектРабочаяГруппа = РабочаяГруппа.ПолучитьОбъект();
		ОбъектРабочаяГруппа.КоличествоАктивныхЗаказов = ПолучитьКоличествоЗаказовДляГруппы(РабочаяГруппа);
		ОбъектРабочаяГРуппа.Записать();
	КонецЕсли;
	
	Возврат НовыйБизнесПроцесс;
КонецФункции

&НаСервере
Функция СоздатьЗаказ(БизнесПроцесс, РабочаяГруппа)
	НовыйЗаказ = Справочники.Заказы.СоздатьЭлемент();
	НовыйЗаказ.Название = "Заказ №" + МестноеВремя(ТекущаяДатаСеанса());
	НовыйЗаказ.БизнесПроцесс = БизнесПроцесс;
	НовыйЗаказ.РабочаяГруппа = РабочаяГруппа;
	НовыйЗаказ.Выполнен = Ложь;
	НовыйЗаказ.Заказчик = Справочники.Заказчики.НайтиПоРеквизиту("Пользователь", ПараметрыСеанса.ТекущийПользователь.УникальныйИдентификатор);
	НовыйЗаказ.Записать();
	Возврат НовыйЗаказ.Ссылка;
КонецФункции

&НаСервере
Функция ПолучитьДоступнуюРабочуюГруппу()
	ДоступнаяРабочаяГруппа = Неопределено;
	
	Запрос = Новый Запрос();
	Запрос.Текст = "Выбрать 
	|РГ.Наименование, 
	|РГ.Ссылка,
	|РГ.УникальныйИдентификатор,
	|РГ.КоличествоАктивныхЗаказов
	|ИЗ Справочник.РабочиеГруппы 
	|КАК РГ 
	|ГДЕ РГ.НаСмене = ИСТИНА";
	Результат = Запрос.Выполнить();
	
	Если НЕ Результат.Пустой() Тогда
		Выборка = Результат.Выбрать();
		Возврат ПолучитьМенееЗагруженнуюРабочуюГруппу(Выборка);
	КонецЕсли;
	
	Возврат ДоступнаяРабочаяГруппа;
КонецФункции

&НаСервере
Функция ПолучитьКоличествоЗаказовДляГруппы(РабочаяГруппа)
	КоличествоЗаказов = 0;
	Запрос = Новый Запрос();
	Запрос.Текст = "Выбрать 
	|заказы.Название
	|ИЗ Справочник.Заказы 
	|КАК заказы 
	|ГДЕ заказы.Выполнен = ЛОЖЬ И заказы.РабочаяГруппа = &РабочаяГруппа";
	Запрос.УстановитьПараметр("РабочаяГруппа", РабочаяГруппа);
	Результат = Запрос.Выполнить();
	
	Если Не Результат.Пустой() Тогда
		Выборка = Результат.Выбрать();
		КоличествоЗаказов = Выборка.Количество();
	КонецЕсли;
	
	Возврат КоличествоЗаказов;
КонецФункции

&НаСервере
Функция ПолучитьМенееЗагруженнуюРабочуюГруппу(Выборка)
	ГруппаСНаименьшимКоличествомЗаказов = Неопределено;
	
	НаименьшееЗначение = 0;
	Счетчик = 0;	
	Пока Выборка.Следующий() Цикл
		Если Счетчик = 0 Тогда
			НаименьшееЗначение = Выборка.КоличествоАктивныхЗаказов;
			ГруппаСНаименьшимКоличествомЗаказов = Выборка.Ссылка;
		ИначеЕсли Выборка.КоличествоАктивныхЗаказов <= НаименьшееЗначение Тогда
			НаименьшееЗначение = Выборка.КоличествоАктивныхЗаказов;
			ГруппаСНаименьшимКоличествомЗаказов = Выборка.Ссылка;			
		КонецЕсли;
		
		Счетчик = Счетчик + 1;
	КонецЦикла;	
	
	Возврат ГруппаСНаименьшимКоличествомЗаказов;
КонецФункции