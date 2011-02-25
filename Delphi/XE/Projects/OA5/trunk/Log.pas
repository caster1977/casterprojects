unit Log;

interface

type
TLog = class
  strict private
    FHost: string;
    FApplication: string;
    procedure SetHost(const Value: string);
    procedure SetApplication(const Value: string);
  public
    procedure SendError(AString: String);
    procedure SendWarning(AString: String);
    procedure SendInfo(AString: String);
    procedure SendDebug(AString: String);
    procedure SendSQL(AString: String);
    procedure Send(AString: String);
    procedure SendHeader(AString: String);
    procedure SendFooter(AString: String);
    property Host: string read FHost write SetHost;
    property Application: string read FApplication write SetApplication;
end;

implementation

{ TLog }

procedure TLog.Send(AString: String);
begin

end;

procedure TLog.SendDebug(AString: String);
begin

end;

procedure TLog.SendError(AString: String);
begin

end;

procedure TLog.SendFooter(AString: String);
begin

end;

procedure TLog.SendHeader(AString: String);
begin

end;

procedure TLog.SendInfo(AString: String);
begin

end;

procedure TLog.SendSQL(AString: String);
begin

end;

procedure TLog.SendWarning(AString: String);
begin

end;

procedure TLog.SetApplication(const Value: string);
begin
  FApplication := Value;
end;


procedure TLog.SetHost(const Value: string);
begin
  FHost := Value;
end;

end.
