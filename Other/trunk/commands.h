//Формат
//поля разделяются ':'
//первое поле - комманда
//далее набор полей
//КОММАНДА
//1 запрос информации по коду фирмы
//2 запрос информации по коду отдела
//3 запрос информации по принадлежности номера телефона
#define INFO_GET_FIRMA_BY_CODE		1
#define INFO_GET_OTDEL_BY_CODE		2
#define INFO_GET_FIRMA_BY_PHONE		3
#define INFO_GET_ABON_BY_PHONE		4
#define INFO_GET_FIRMA_BY_NAME		5
#define INFO_GET_PRONOUNCE_PHONE	6
#define INFO_GET_CONNECT_PHONE		7

//Безымянный - BaseInfo

if (FindWindow('TMainForm','OA4')<>0) then // если не было найдено окно операторской программы
