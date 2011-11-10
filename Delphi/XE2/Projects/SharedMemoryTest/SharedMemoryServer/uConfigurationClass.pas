unit uConfigurationClass;

interface

type
  TConfiguration=class
  public
    constructor Create;
    destructor Destroy; override;
    procedure Load;
    procedure Save;
  end;

implementation

{ TConfiguration }

constructor TConfiguration.Create;
begin
  inherited;

end;

destructor TConfiguration.Destroy;
begin

  inherited;
end;

procedure TConfiguration.Load;
begin

end;

procedure TConfiguration.Save;
begin

end;

end.
