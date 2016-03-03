{******************************************************************************
 PROYECTO FACTURACION ELECTRONICA
 Copyright (C) 2010-2014 - Bambu Code SA de CV - Ing. Luis Carrasco

 Clase usada para generar la Cadena Original del XML del Timbre Fiscal
 recibido cuando se manda el comprobante a un PAC para su timbrado.

 Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
 http://bambucode.com/codigoabierto

 La licencia de este codigo fuente se encuentra en:
 http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
 ******************************************************************************}
unit CadenaOriginalTimbre;

interface

// Incluimos el recurso que guarda el archivo XSLT para cuando se compile
// esta unidad en cualquier proyecto que la use, se incluya en el ejecutable
// Ref: http://delphi.about.com/od/objectpascalide/a/embed_resources.htm
{$R 'CadenaOriginalTimbre.res' 'CadenaOriginalTimbre.rc'}

uses FacturaTipos,
     Classes,
     XMLDoc,
     XMLIntf,
     //XSLProd,
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
    fXMLTimbre: TStringCadenaOriginal;
    fXSLT: string;
    function LeerXSLTDeRecurso(const aNombreRecurso: string): string;
  public
    constructor Create(const aXMLTimbre: WideString; const aRutaXSLT: WideString);
        overload;
    function Generar: TStringCadenaOriginal;
  end;

implementation

constructor TCadenaOriginalDeTimbre.Create(const aXMLTimbre: WideString; const
    aRutaXSLT: WideString);
const
  _NOMBRE_DEL_RECURSO_XSLT = 'CADENA_ORIGINAL_TFD_1_0';
begin
  fXMLTimbre := aXMLTimbre;

  // Obtenemos el archivo XSLT para transformar el XML del timbre a cadena original usando
  // el XSLT proveido por el SAT de la direccion:
  // ftp://ftp2.sat.gob.mx/asistencia_servicio_ftp/publicaciones/solcedi/cadenaoriginal_TFD_1_0.xslt
  fXSLT := LeerXSLTDeRecurso(_NOMBRE_DEL_RECURSO_XSLT);

  Assert(fXMLTimbre <> '', 'El XML del timbre no debe ser vacio');
  Assert(fXSLT <> '', 'El XSLT de transformacion del timbre no debe ser vacio');
end;


function TCadenaOriginalDeTimbre.Generar: TStringCadenaOriginal;
var
  XML : IXMLDocument;
  XSL : IXMLDocument;
  res: WideString;
begin
  XML := LoadXMLData(fXMLTimbre);
  XSL := LoadXMLData(fXSLT);

  // Transformamos el XML del timbre usando el XSLT proveido por el SAT
  XML.DocumentElement.TransformNode(XSL.DocumentElement, res);

  // Fix temporal debido a que por alguna razon el XSLT no aplica correctamente las cadenas de inicio y terminacion
  Result := '|' + res + '||';
end;


function TCadenaOriginalDeTimbre.LeerXSLTDeRecurso(const aNombreRecurso:
    string): string;
var
  RS: TResourceStream;
  sl: TStringList;
begin
  RS := TResourceStream.Create(HInstance, aNombreRecurso, 'TEXT');
  try
    SL := TStringList.Create;
    SL.LoadFromStream(RS);
    Result := sl.Text;
  finally
    RS.Free;
    sl.Free;
  end;
end;

end.
