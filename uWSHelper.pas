unit uWSHelper;

interface

uses Types, Classes;

var
  _WSHELPER_ULTIMO_XML_ENVIADO: string;
  _WSHELPER_ULTIMO_XML_RECIBIDO: string;

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
    property UltimoXMLEnviado: string read GetUltimoXMLEnviado;
    property UltimoXMLRecibido: string read GetUltimoXMLRecibido;
  end;

implementation

uses
  {$IFDEF CODESITE}CodeSiteLogging, {$ENDIF}System.SysUtils;

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
  _WSHELPER_ULTIMO_XML_ENVIADO := ss.DataString;

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
  _WSHELPER_ULTIMO_XML_RECIBIDO := ss.DataString;
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
  Result := _WSHELPER_ULTIMO_XML_ENVIADO;
end;

function TWSHelper.GetUltimoXMLRecibido: string;
begin
  Result := _WSHELPER_ULTIMO_XML_RECIBIDO;
end;

procedure TWSHelper.SetUltimoXMLEnviado(const Value: string);
begin
  _WSHELPER_ULTIMO_XML_ENVIADO := Value;
end;

procedure TWSHelper.SetUltimoXMLRecibido(const Value: string);
begin
  _WSHELPER_ULTIMO_XML_RECIBIDO := Value;
end;

end.
