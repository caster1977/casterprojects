unit MainForm;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  mysql;

type
  TForm1= class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    MySQLConnectionHandler: PMYSQL;
    procedure Do_Connect;
    procedure Do_Disconnect;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Do_Connect;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Do_Disconnect;
end;

procedure TForm1.Do_Connect;
var
  s: string;
  i: integer;
  pm: PMYSQL;
begin
  Screen.Cursor:=crHourGlass;
  MySQLConnectionHandler:=mysql_init(nil);
  Screen.Cursor:=crDefault;
  if MySQLConnectionHandler<>nil then
    begin
      s:='Инициализация объекта соединения MySQL прошла успешно.';
      Screen.Cursor:=crHourGlass;
      pm:=mysql_real_connect(MySQLConnectionHandler, PAnsiChar('10.1.1.240'), // Configuration.sMySQLHost
        PAnsiChar('root'), // Configuration.sMySQLUser
        PAnsiChar('sqladmin'), // Configuration.sMySQLPassword
        PAnsiChar('rne4'), // Configuration.sMySQLDatabase
        MYSQL_PORT, nil, 1); // Configuration.iMySQLPort
      Screen.Cursor:=crDefault;
      if pm=MySQLConnectionHandler then
        begin
          s:='Подключение к серверу MySQL выполнено успешно.';
        end
      else
        begin
          i:=mysql_errno(MySQLConnectionHandler);
          // s:=mysql_error(MySQLConnectionHandler);
          if i=2003 then
            s:='Возникла ошибка при попытке подключения к серверу MySQL, так как сервер MySQL не запущен!'
          else
            s:='Возникла ошибка при попытке подключения к серверу MySQL!';
        end;
    end
  else
    s:='Возникла ошибка при инициализации объекта соединения MySQL!';
end;

procedure TForm1.Do_Disconnect;
begin
  if MySQLConnectionHandler<>nil then
    begin
      mysql_close(MySQLConnectionHandler);
      MySQLConnectionHandler:=nil;
    end;
end;

end.
