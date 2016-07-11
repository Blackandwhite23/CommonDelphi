{{
Purpose:
* A class that encrypt string and file using BlowFish.
* A few API for the dog ****** Dog functions are in unit EncryptionDogLib
}
unit EncryptionLib;
interface
uses Windows, classes,  LbCipher, LbClass, SysUtils;

type
  HEncryption = class
  private
    procedure SetEcb(const Value: boolean);
  protected
    //: The object doing the job
    cipher      :  TLbBlowFish;
  public
    constructor Create; // shold not be called in MainForm.OnCreate
    destructor Destroy; override;

    function EncryptString(const ming : string; const ToEcb : boolean=false) : string;
    function DecryptString(const ph : string; const ToEcb : boolean=false) : string;
    procedure EncryptStream(InStream, OutStream : TStream);
    procedure DecryptStream(InStream, OutStream : TStream);

    function EncryptFile(const src, dest : string) : boolean;
    function DecryptFile(const src, dest : string) : boolean;
    procedure SetPassPhrase(const pass : string);

    property Ecb : boolean write SetEcb;

  end;

    function EncryptString(const ming, pass : string; const ToEcb : boolean=false) : string;
    function DecryptString(const ph, pass : string; const ToEcb : boolean=false) : string;

    function GetPassphase1 : string;
    function GetPassphase2 : string;
    function GetPassphase3 : string;

implementation
{ HEncryption }

function GetPassphase1 : string;
begin
  Result:='3204064904';
end;

function GetPassphase2 : string;
begin
  Result:='Zijian Media Rental Huang';
end;

function GetPassphase3 : string;
begin
  Result:='General, password';
end;

function EncryptString(const ming, pass : string; const ToEcb : boolean) : string;
var
  c : HEncryption;
begin
  c:=HEncryption.Create;

  try

  c.SetPassPhrase(pass);
  Result:=c.EncryptString(ming, ToEcb);
  finally
  c.Free;
  end;
end;

function DecryptString(const ph, pass : string; const ToEcb : boolean) : string;
var
  c : HEncryption;
begin
  c:=HEncryption.Create;

  try
  c.SetPassPhrase(pass);
  Result:=c.DecryptString(ph, ToEcb);
  finally
  c.Free;
  end;
end;

constructor HEncryption.Create;
begin
  inherited;
  cipher:=TLbBlowFish.Create(nil);
  cipher.CipherMode:=cmCbc;
end;

function HEncryption.DecryptFile(const src, dest: string): boolean;
begin
  cipher.DecryptFile(src, dest);
  Result := true;
end;

procedure HEncryption.DecryptStream(InStream, OutStream: TStream);
begin
  cipher.DecryptStream(InStream, OutStream);
end;

function HEncryption.DecryptString(const ph: string; const ToEcb : boolean): string;
begin
  if ToEcb then
    cipher.cipherMode:=cmEcb
  else
    cipher.CipherMode:=cmCbc;

  try
    Result:=cipher.DecryptString(ph);
  except
    Result:='';//'01234567890abcdefghijklmnopqrstuvwxyz';
  end;
end;

destructor HEncryption.Destroy;
begin
  cipher.Free;
  inherited;
end;

function HEncryption.EncryptFile(const src, dest: string): boolean;
begin
  cipher.EncryptFile(src, dest);
  Result := true;
end;

procedure HEncryption.EncryptStream(InStream, OutStream: TStream);
begin
  cipher.EncryptStream(InStream, OutStream);
end;

function HEncryption.EncryptString(const ming: string; const ToEcb : boolean): string;
begin
  if ToEcb then
    cipher.cipherMode:=cmEcb
  else
    cipher.CipherMode:=cmCbc;

  Result:=cipher.EncryptString(ming);
end;

procedure HEncryption.SetEcb(const Value: boolean);
begin
  if Value then
    cipher.cipherMode:=cmEcb
  else
    cipher.CipherMode:=cmCbc;

end;

procedure HEncryption.SetPassPhrase(const pass: string);
begin
  cipher.GenerateKey(pass);
end;

end.












