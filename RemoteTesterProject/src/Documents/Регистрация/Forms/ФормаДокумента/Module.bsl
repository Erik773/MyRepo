&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	Если ЛогинУникальный() Тогда
		ДобавитьПользователя();
	Иначе
		Сообщить("Пользователь с таким логином уже зарегистрирован.");
		Отказ = Истина;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Функция ЛогинУникальный()
	Результат = Ложь;
	
	ТекущийОбъект = ЭтаФорма.Object;
	Пользователь = Справочники.Пользователи.НайтиПоРеквизиту("Логин", ТекущийОбъект.Логин);
	
	Если Пользователь.Пустая() Тогда
		Результат = Истина;
	КонецЕсли;
	
	Возврат Результат;
КонецФункции

&НаСервере
Процедура ДобавитьПользователя()
	
	ТекущийОбъект = ЭтаФорма.Object;
	Пользователь = Справочники.Пользователи.СоздатьЭлемент();
	Пользователь.Наименование = ТекущийОбъект.Логин;
	Пользователь.Логин = ТекущийОбъект.Логин;
	Пользователь.ФамилияИмяОтчество = ТекущийОбъект.ФамилияИмяОтчество;
	Пользователь.ТипПользователя = ТекущийОбъект.ТипПользователя;
	Пользователь.УникальныйИдентификатор = Новый УникальныйИдентификатор();
	
	Если Пользователь.ТипПользователя = Перечисления.ТипыПользователей.Тестировщик Тогда
		ДобавитьТестировщика(Пользователь);
	ИначеЕсли Пользователь.ТипПользователя = Перечисления.ТипыПользователей.УдаленныйТестировщик Тогда
		ДобавитьУдаленногоТестировщика(Пользователь);
	ИначеЕсли Пользователь.ТипПользователя = Перечисления.ТипыПользователей.Заказчик Тогда
		ДобавитьЗаказчика(Пользователь);
	Иначе
		Сообщить("Не верно указан тип пользователя.");
		Возврат;
	КонецЕсли;
		
	Попытка
		Пользователь.Записать();
		Сообщить("Пользователь добавлен.");
	Исключение
		Сообщить("Не удалось добавить пользователя.");
	КонецПопытки
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьЗаказчика(Пользователь)
	Заказчик = Справочники.Заказчики.СоздатьЭлемент();
	Заказчик.Пользователь = Пользователь.УникальныйИдентификатор;
	Заказчик.ФамилияИмяОтчество = Пользователь.ФамилияИмяОтчество;
	Заказчик.Наименование = Пользователь.ФамилияИмяОтчество;
	
	Попытка
		Заказчик.Записать();
		Сообщить("Заказчик добавлен.")
	Исключение
		Сообщить("Не удалось добавить заказчика!");
	КонецПопытки
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьУдаленногоТестировщика(Пользователь)
	УдаленныйТестировщик = Справочники.УдаленныеТестировщики.СоздатьЭлемент();
	УдаленныйТестировщик.Пользователь = Пользователь.УникальныйИдентификатор;
	УдаленныйТестировщик.ФамилияИмяОтчество = Пользователь.ФамилияИмяОтчество;
	УдаленныйТестировщик.Наименование = Пользователь.ФамилияИмяОтчество;
	УдаленныйТестировщик.Квалификация = Перечисления.КвалификацииУдаленныхТестировщиков.Начальный;
	
	Попытка
		УдаленныйТестировщик.Записать();
		Сообщить("Удаленный тестировщик добавлен.")
	Исключение
		Сообщить("Не удалось добавить Удаленного тестировщик!");
	КонецПопытки
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьТестировщика(Пользователь)
	Тестировщик = Справочники.Тестировщики.СоздатьЭлемент();
	Тестировщик.Пользователь = Пользователь.УникальныйИдентификатор;
	Тестировщик.ФамилияИмяОтчество = Пользователь.ФамилияИмяОтчество;
	Тестировщик.Наименование = Пользователь.ФамилияИмяОтчество;
	
	Попытка
		Тестировщик.Записать();
		Сообщить("Тестировщик добавлен.")
	Исключение
		Сообщить("Не удалось добавить тестировщика!");
	КонецПопытки
	
КонецПроцедуры

