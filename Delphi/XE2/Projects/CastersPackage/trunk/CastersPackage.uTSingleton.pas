{$WARNINGS OFF}
unit CastersPackage.uTSingleton;

interface

type
  // Базовый класс для объектов, реализующих паттерн
  // "Singleton". Для получения доступа к экземпляру
  // необходимо вызвать GetInstance. Если экземпляр
  // еще не существует, то он будет создан. Иначе -
  // возвращена ссылка на ранее созданный экземпляр.
  // Уничтожить экземпляр можно вручную, вызвав Free,
  // иначе он будет уничтожен автоматически перед
  // завершением приложения
  TSingleton = class(TObject)
  strict private
    class procedure RegisterInstance(AInstance: TSingleton);
    procedure UnRegisterInstance;
    class function FindInstance: TSingleton;
  protected
    constructor Create; virtual;
    // Инициализацию производить только в этом конструкторе, а не в GetInstance! Не рекомендуется выносить этот конструктор из секции protected
  public
    class function NewInstance: TObject; override;
    procedure BeforeDestruction; override;
    constructor GetInstance; // Точка доступа к экземпляру
  end;

implementation

uses
  System.Classes,
  System.Contnrs;

var
  SingletonList: TObjectList;

  { TSingleton }

procedure TSingleton.BeforeDestruction;
begin
  UnRegisterInstance;
  inherited;
end;

constructor TSingleton.Create;
begin
  inherited;
end;

class function TSingleton.FindInstance: TSingleton;
var
  i: Integer;
begin
  Result := nil;
  if Assigned(SingletonList) then
  begin
    for i := 0 to SingletonList.Count - 1 do
    begin
      if SingletonList[i].ClassType = Self then
      begin
        Result := TSingleton(SingletonList[i]);
        Break;
      end;
    end;
  end;
end;

constructor TSingleton.GetInstance;
begin
  inherited Create;
end;

class function TSingleton.NewInstance: TObject;
begin
  Result := FindInstance;
  if Result = nil then
  begin
    Result := inherited NewInstance;
    Result.Create;
    RegisterInstance(TSingleton(Result));
  end;
end;

class procedure TSingleton.RegisterInstance(AInstance: TSingleton);
begin
  if Assigned(SingletonList) then
  begin
    SingletonList.Add(AInstance);
  end;
end;

procedure TSingleton.UnRegisterInstance;
begin
  if Assigned(SingletonList) then
  begin
    SingletonList.Extract(Self);
  end;
end;

initialization

SingletonList := TObjectList.Create(True);

finalization

if Assigned(SingletonList) then
begin
  SingletonList.Free;
end;

end.
