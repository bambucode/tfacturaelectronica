unit CadenaOriginalTimbre;

interface

uses FacturaTipos,
     Classes,
     XMLDoc,
     XMLIntf,
     XSLProd,
     System.SysUtils;

type

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Clase que se encarga de generar la Cadena Original del Timbre para
  ///	  mostrarla en la representación gráfica.
  ///	</summary>
  {$ENDREGION}
  TCadenaOriginalDeTimbre = class
  private
    fFileXSLT: string;
    fRecursoXSLT: TResourceStream;
    fXMLTimbre: TStringCadenaOriginal;
    fXSLT: string;
    function LeerContenidoDeArchivo(sNombreArchivo: String): WideString;
    procedure LoadStringListFromResource(const ResName: string;SL : TStringList);
  public
    constructor Create(const aXMLTimbre: WideString; const aRutaXSLT: WideString);
        overload;
    function Generar: TStringCadenaOriginal;
  end;

implementation

constructor TCadenaOriginalDeTimbre.Create(const aXMLTimbre: WideString; const
    aRutaXSLT: WideString);
var
  SL: TStringList;
const
   //http://delphi.about.com/od/objectpascalide/a/embed_resources.htm
  _NOMBRE_DEL_RECURSO_XSLT = 'CADENA_ORIGINAL_TFD_1_0';
begin
  try
    // Obtenemos el archivo XSLT para transformar el XML del timbre a cadena original usando
    // el XSLT proveido por el SAT de la direccion:
    // ftp://ftp2.sat.gob.mx/asistencia_servicio_ftp/publicaciones/solcedi/cadenaoriginal_TFD_1_0.xslt
    fRecursoXSLT := TResourceStream.Create(hInstance, _NOMBRE_DEL_RECURSO_XSLT, 'TEXT');

    fXMLTimbre := aXMLTimbre;
    //fFileXSLT := aRutaXSLT;
    //fXSLT := LeerContenidoDeArchivo(fFileXSLT);

    SL := TStringList.Create;
    SL.LoadFromStream(fRecursoXSLT);

    fXSLT := SL.Text;

    Assert(fXMLTimbre <> '', 'El XML del timbre no debe ser vacio');
    Assert(fXSLT <> '', 'El XSLT de transformacion del timbre no debe ser vacio');
  finally
    fRecursoXSLT.Free;
    SL.Free;
  end;
end;

function TCadenaOriginalDeTimbre.Generar: TStringCadenaOriginal;
var
  XML : IXMLDocument;
  XSL : IXMLDocument;
  res: WideString;
begin
  XML := LoadXMLData(fXMLTimbre);
  XSL := LoadXMLData(fXSLT);

  XML.DocumentElement.TransformNode(XSL.DocumentElement, res);

  // TODO: FACTURACION Refactorizar transformacion XSLT
  // Fix temporal debido a que delphi no aplica correctamente las cadenas de inicio y terminacion
  res := '|' + res + '||';

  Result := res;
end;

function TCadenaOriginalDeTimbre.LeerContenidoDeArchivo(sNombreArchivo: String): WideString;
var
  slArchivo: TStrings;
begin
  slArchivo := TStringList.Create;
  slArchivo.LoadFromFile(sNombreArchivo);
  {$IF Compilerversion >= 20}
  Result:=Trim(slArchivo.Text);
  {$ELSE}
  Result:=Trim(UTF8Encode(slArchivo.Text));
  {$IFEND}
  FreeAndNil(slArchivo);
end;

procedure TCadenaOriginalDeTimbre.LoadStringListFromResource(const ResName: string; SL : TStringList);
var
  RS: TResourceStream;
begin
  RS := TResourceStream.Create(HInstance, ResName, 'TEXT');
  try
    SL := TStringList.Create;
    SL.LoadFromStream(RS);
  finally
    RS.Free;
  end;
end;

end.
