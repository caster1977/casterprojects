unit uCommon;

interface

resourcestring
  TEXT_READDATA='WM_READDATA';
  TEXT_WRITEDATA='WM_WRITEDATA';
  TEXT_DONE='WM_DONE';

type
  CommonFunctions=class
  public
    class function LockMappedFile: Boolean;
    class procedure UnlockMappedFile;
  end;

implementation

{ CommonFunctions }

class function CommonFunctions.LockMappedFile: Boolean;
begin
end;

class procedure CommonFunctions.UnlockMappedFile;
begin
end;

end.
