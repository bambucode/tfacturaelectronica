unit uWSHelper;

interface

uses Types, Classes;

var
  fUltimoXMLEnviado: string;
  fUltimoXMLRecibido: string;

type
  TWSHelper = class
  private
    function GetUltimoXMLEnviado: string;
    function GetUltimoXMLRecibido: string;
    procedure SetUltimoXMLEnviado(const Value: string);
    procedure SetUltimoXMLRecibido(const Value: string);
  public
    procedure BeforeExecute(const MethodName: string; SOAPRequest: TStream);
    procedure AfterExecute (const MethodName: string; SOAPResponse: TStream);
    property UltimoXMLEnviado: string read GetUltimoXMLEnviado write
        SetUltimoXMLEnviado;
    property UltimoXMLRecibido: string read GetUltimoXMLRecibido write
        SetUltimoXMLRecibido;

  end;

implementation

uses
  CodeSiteLogging, System.SysUtils;

procedure TWSHelper.BeforeExecute(const MethodName: string; SOAPRequest: TStream);
var
//  Xml:TStringList;
  ss: tstringstream;
  clave: string;
  stringXml: string;
begin
//  Xml := TStringList.Create;
  ss := tStringStream.create('');
//  try
  SOAPRequest.Position := 0;
  ss.CopyFrom(SOAPRequest, SOAPRequest.Size);
//    Xml.text := ss.DataString;
//    Xml.SaveToFile( 'c:send.xml' );
  fUltimoXMLEnviado := ss.DataString;

  {$IFDEF WEBSERVICEDEBUG}
  //CodeSite.Send('XML enviado:', ss.DataString);
  {$ENDIF}
//  except
//  end;
  ss.free;
//  Xml.Free;
end;

procedure TWSHelper.AfterExecute(const MethodName: string; SOAPResponse: TStream);
var
//  Xml:TStringList;
  ss: tstringstream;
begin
//  Xml := TStringList.Create;
  ss := tStringStream.create('');
//  try
  SOAPResponse.Position := 0;
  ss.CopyFrom(SOAPResponse, SOAPResponse.Size);
//    Xml.text := ss.DataString;
//    Xml.SaveToFile( 'c:fact.xml' );
  fUltimoXMLRecibido := ss.DataString;
  {$IFDEF WEBSERVICEDEBUG}
  //CodeSite.Send('XML recibido:', ss.DataString);
  {$ENDIF}
//  except
//  end;
//  ss.free;
//  Xml.Free;
end;

function TWSHelper.GetUltimoXMLEnviado: string;
begin
  Result := fUltimoXMLEnviado;
end;

function TWSHelper.GetUltimoXMLRecibido: string;
begin
  Result := fUltimoXMLRecibido;
end;

procedure TWSHelper.SetUltimoXMLEnviado(const Value: string);
begin
  fUltimoXMLEnviado := Value;
end;

procedure TWSHelper.SetUltimoXMLRecibido(const Value: string);
begin
  fUltimoXMLRecibido := Value;
end;

end.
