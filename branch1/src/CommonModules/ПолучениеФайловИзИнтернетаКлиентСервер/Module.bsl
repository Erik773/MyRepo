///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Возвращает структуру параметров для получения файла из Интернета.
//
// Возвращаемое значение:
//  Структура:
//     * ПутьДляСохранения            - Строка       - путь на сервере (включая имя файла) для сохранения скачанного файла.
//                                                     Не заполняется при сохранении файла во временное хранилище.
//     * Пользователь                 - Строка       - пользователь, от имени которого установлено соединение.
//     * Пароль                       - Строка       - пароль, пользователя от которого установлено соединение.
//     * Порт                         - Число        - порт сервера, с которым установлено соединение.
//     * Таймаут                      - Число        - таймаут на получение файла в секундах.
//     * ЗащищенноеСоединение         - Булево       - признак использования защищенного соединения ftps или https.
//                                    - ЗащищенноеСоединениеOpenSSL
//                                    - Неопределено - в случае, если защищенное соединение не используется.
//
//    Параметры только для http (https) соединения:
//     * Заголовки                    - Соответствие - см. в синтакс-помощнике описание параметра Заголовки объекта HTTPЗапрос.
//     * ИспользоватьАутентификациюОС - Булево       - см. в синтакс-помощнике описание параметра
//                                                     ИспользоватьАутентификациюОС объекта HTTPСоединение.
//
//    Параметры только для ftp (ftps) соединения:
//     * ПассивноеСоединение          - Булево       - флаг указывает, что соединение должно пассивным (или активным).
//     * УровеньИспользованияЗащищенногоСоединения - УровеньИспользованияЗащищенногоСоединенияFTP - см. описание
//         одноименного свойства в синтакс-помощнике платформы. Значение по умолчанию - Авто.
//
Функция ПараметрыПолученияФайла() Экспорт
	
	ПараметрыПолучения = Новый Структура;
	ПараметрыПолучения.Вставить("ПутьДляСохранения", Неопределено);
	ПараметрыПолучения.Вставить("Пользователь", Неопределено);
	ПараметрыПолучения.Вставить("Пароль", Неопределено);
	ПараметрыПолучения.Вставить("Порт", Неопределено);
	ПараметрыПолучения.Вставить("Таймаут", АвтоматическоеОпределениеТаймаута());
	ПараметрыПолучения.Вставить("ЗащищенноеСоединение", Неопределено);
	ПараметрыПолучения.Вставить("ПассивноеСоединение", Неопределено);
	ПараметрыПолучения.Вставить("Заголовки", Новый Соответствие);
	ПараметрыПолучения.Вставить("ИспользоватьАутентификациюОС", Ложь);
	ПараметрыПолучения.Вставить("УровеньИспользованияЗащищенногоСоединения", Неопределено);
	
	Возврат ПараметрыПолучения;
	
КонецФункции

#Область УстаревшиеПроцедурыИФункции

// Устарела. Следует использовать ПолучениеФайловИзИнтернета.ПолучитьПрокси.
// Возвращает объект ИнтернетПрокси для доступа в Интернет.
// Допустимые протоколы для создания ИнтернетПрокси http, https, ftp и ftps.
//
// Параметры:
//    URLИлиПротокол - Строка - url в формате [Протокол://]<Сервер>/<Путь к файлу на сервере>,
//                              либо идентификатор протокола (http, ftp, ...).
//
// Возвращаемое значение:
//    ИнтернетПрокси - описывает параметры прокси-серверов для различных протоколов.
//                     Если не удалось распознать схему сетевой протокол,
//                     то будет создать прокси на основании протокола HTTP.
//
Функция ПолучитьПрокси(Знач URLИлиПротокол) Экспорт
	
#Если ВебКлиент Тогда
	ВызватьИсключение НСтр("ru = 'Прокси не доступен в веб-клиенте.'");
#Иначе
	
	ДопустимыеПротоколы = Новый Соответствие();
	ДопустимыеПротоколы.Вставить("HTTP",  Истина);
	ДопустимыеПротоколы.Вставить("HTTPS", Истина);
	ДопустимыеПротоколы.Вставить("FTP",   Истина);
	ДопустимыеПротоколы.Вставить("FTPS",  Истина);
	
	НастройкаПроксиСервера = НастройкаПроксиСервера();
	
	Если СтрНайти(URLИлиПротокол, "://") > 0 Тогда
		Протокол = РазделитьURL(URLИлиПротокол).Протокол;
	Иначе
		Протокол = НРег(URLИлиПротокол);
	КонецЕсли;
	
	Если ДопустимыеПротоколы[ВРег(Протокол)] = Неопределено Тогда
		Протокол = "HTTP";
	КонецЕсли;
	
	Возврат НовыйИнтернетПрокси(НастройкаПроксиСервера, Протокол);
	
#КонецЕсли
	
КонецФункции

// Устарела. Следует использовать ОбщегоНазначенияКлиентСервер.СтруктураURI.
// Разделяет URL по составным частям: протокол, сервер, путь к ресурсу.
//
// Параметры:
//    URL - Строка - ссылка на ресурс в сети Интернет.
//
// Возвращаемое значение:
//    Структура:
//        * Протокол            - Строка - протокол доступа к ресурсу.
//        * ИмяСервера          - Строка - сервер, на котором располагается ресурс.
//        * ПутьКФайлуНаСервере - Строка - путь к ресурсу на сервере.
//
Функция РазделитьURL(Знач URL) Экспорт
	
	СтруктураURL = ОбщегоНазначенияКлиентСервер.СтруктураURI(URL);
	
	Результат = Новый Структура;
	Результат.Вставить("Протокол", ?(ПустаяСтрока(СтруктураURL.Схема), "http", СтруктураURL.Схема));
	Результат.Вставить("ИмяСервера", СтруктураURL.ИмяСервера);
	Результат.Вставить("ПутьКФайлуНаСервере", СтруктураURL.ПутьНаСервере);
	
	Возврат Результат;
	
КонецФункции

// Устарела. Следует использовать ОбщегоНазначенияКлиентСервер.СтруктураURI.
// Разбирает строку URI на составные части и возвращает в виде структуры.
// На основе RFC 3986.
//
// Параметры:
//     СтрокаURI - Строка - ссылка на ресурс в формате:
//                          <схема>://<логин>:<пароль>@<хост>:<порт>/<путь>?<параметры>#<якорь>.
//
// Возвращаемое значение:
//    Структура - составные части URI согласно формату:
//        * Схема         - Строка - схема URI.
//        * Логин         - Строка - имя пользователя.
//        * Пароль        - Строка - пароль пользователя.
//        * ИмяСервера    - Строка - часть <хост>:<порт> входного параметра.
//        * Хост          - Строка - имя сервера.
//        * Порт          - Строка - порт сервера.
//        * ПутьНаСервере - Строка - часть <путь>?<параметры>#<якорь> входного параметра.
//
Функция СтруктураURI(Знач СтрокаURI) Экспорт
	
	Возврат ОбщегоНазначенияКлиентСервер.СтруктураURI(СтрокаURI);
	
КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область УстаревшиеПроцедурыИФункции

// Служебная информация для отображения текущих настроек и состояний прокси для выполнения диагностики.
//
// Возвращаемое значение:
//  Структура:
//     * СоединениеЧерезПрокси - Булево - признак того, что соединение должно выполняться через прокси.
//     * Представление - Строка - представление текущего настроенного прокси.
//
Функция СостояниеНастроекПрокси() Экспорт
	
#Если ВебКлиент Тогда
	
	Результат = Новый Структура;
	Результат.Вставить("СоединениеЧерезПрокси", Ложь);
	Результат.Вставить("Представление", НСтр("ru = 'Прокси не доступен в веб-клиенте.'"));
	Возврат Результат;
	
#Иначе
	
	Возврат ПолучениеФайловИзИнтернетаСлужебныйВызовСервера.СостояниеНастроекПрокси();
	
#КонецЕсли
	
КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция АвтоматическоеОпределениеТаймаута() Экспорт
	
	Возврат -1;
	
КонецФункции

#Область УстаревшиеПроцедурыИФункции

#Если Не ВебКлиент Тогда

// Возвращает прокси по настройкам НастройкаПроксиСервера для заданного протокола Протокол.
//
// Параметры:
//   НастройкаПроксиСервера - Соответствие:
//    ИспользоватьПрокси - использовать ли прокси-сервер.
//    НеИспользоватьПроксиДляЛокальныхАдресов - использовать ли прокси-сервер для локальных адресов.
//    ИспользоватьСистемныеНастройки - использовать ли системные настройки прокси-сервера.
//    Сервер       - адрес прокси-сервера.
//    Порт         - порт прокси-сервера.
//    Пользователь - имя пользователя для авторизации на прокси-сервере.
//    Пароль       - пароль пользователя.
//    ИспользоватьАутентификациюОС - Булево - признак использования аутентификации средствами операционной системы.
//   Протокол - Строка - протокол для которого устанавливаются параметры прокси сервера, например "http", "https",
//                       "ftp".
//
// Возвращаемое значение:
//   ИнтернетПрокси
//
Функция НовыйИнтернетПрокси(НастройкаПроксиСервера, Протокол)
	
	Если НастройкаПроксиСервера = Неопределено Тогда
		// Системные установки прокси-сервера.
		Возврат Неопределено;
	КонецЕсли;
	
	ИспользоватьПрокси = НастройкаПроксиСервера.Получить("ИспользоватьПрокси");
	Если Не ИспользоватьПрокси Тогда
		// Не использовать прокси-сервер.
		Возврат Новый ИнтернетПрокси(Ложь);
	КонецЕсли;
	
	ИспользоватьСистемныеНастройки = НастройкаПроксиСервера.Получить("ИспользоватьСистемныеНастройки");
	Если ИспользоватьСистемныеНастройки Тогда
		// Системные настройки прокси-сервера.
		Возврат Новый ИнтернетПрокси(Истина);
	КонецЕсли;
	
	// Настройки прокси-сервера, заданные вручную.
	Прокси = Новый ИнтернетПрокси;
	
	// Определение адреса и порта прокси-сервера.
	ДополнительныеНастройки = НастройкаПроксиСервера.Получить("ДополнительныеНастройкиПрокси");
	ПроксиПоПротоколу = Неопределено;
	Если ТипЗнч(ДополнительныеНастройки) = Тип("Соответствие") Тогда
		ПроксиПоПротоколу = ДополнительныеНастройки.Получить(Протокол);
	КонецЕсли;
	
	ИспользоватьАутентификациюОС = НастройкаПроксиСервера.Получить("ИспользоватьАутентификациюОС");
	ИспользоватьАутентификациюОС = ?(ИспользоватьАутентификациюОС = Истина, Истина, Ложь);
	
	Если ТипЗнч(ПроксиПоПротоколу) = Тип("Структура") Тогда
		Прокси.Установить(Протокол, ПроксиПоПротоколу.Адрес, ПроксиПоПротоколу.Порт,
			НастройкаПроксиСервера["Пользователь"], НастройкаПроксиСервера["Пароль"], ИспользоватьАутентификациюОС);
	Иначе
		Прокси.Установить(Протокол, НастройкаПроксиСервера["Сервер"], НастройкаПроксиСервера["Порт"], 
			НастройкаПроксиСервера["Пользователь"], НастройкаПроксиСервера["Пароль"], ИспользоватьАутентификациюОС);
	КонецЕсли;
	
	Прокси.НеИспользоватьПроксиДляЛокальныхАдресов = НастройкаПроксиСервера["НеИспользоватьПроксиДляЛокальныхАдресов"];
	
	АдресаИсключений = НастройкаПроксиСервера.Получить("НеИспользоватьПроксиДляАдресов");
	Если ТипЗнч(АдресаИсключений) = Тип("Массив") Тогда
		Для каждого АдресИсключения Из АдресаИсключений Цикл
			Прокси.НеИспользоватьПроксиДляАдресов.Добавить(АдресИсключения);
		КонецЦикла;
	КонецЕсли;
	
	Возврат Прокси;
	
КонецФункции

#КонецЕсли

Функция НастройкаПроксиСервера()
	
	// АПК:547-выкл код сохранен для обратной совместимости, используется в устаревшем программном интерфейсе.
	
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	НастройкаПроксиСервера = ПолучениеФайловИзИнтернета.НастройкиПроксиНаСервере();
#Иначе
	НастройкаПроксиСервера = СтандартныеПодсистемыКлиент.ПараметрыРаботыКлиента().НастройкиПроксиСервера;
#КонецЕсли
	
	// АПК:547-вкл
	
	Возврат НастройкаПроксиСервера;
	
КонецФункции

#КонецОбласти

#КонецОбласти