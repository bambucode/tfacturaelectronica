unit CadenaOriginalTimbre;

interface

uses FacturaTipos,
     Classes;

type

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Clase que se encarga de generar la Cadena Original del Timbre para
  ///	  mostrarla en la representación gráfica.
  ///	</summary>
  {$ENDREGION}
  TCadenaOriginalDeTimbre = class
  private
    fRecursoXSLT: TResourceStream;
  public
    constructor Create(const aXMLTimbre: WideString); overload;
    function Generar: TStringCadenaOriginal;
  end;

// Incluimos el XSLT como recurso para no depender de el externo
// Ref: http://stackoverflow.com/questions/1153394/how-do-i-make-a-png-resource/
{.$R 'XSLT/cadenaoriginal_TFD_1_0.res' 'XSLT/cadenaoriginal_TFD_1_0.rc'}

implementation

constructor TCadenaOriginalDeTimbre.Create(const aXMLTimbre: WideString);
const
  _NOMBRE_DEL_RECURSO_XSLT = 'cadenaoriginal_TFD_1_0';
begin
  // TODO: Inicializar variables internas

  // Obtenemos el archivo XSLT para transformar el XML del timbre a cadena original usando
  // el XSLT proveido por el SAT de la direccion:
  // ftp://ftp2.sat.gob.mx/asistencia_servicio_ftp/publicaciones/solcedi/cadenaoriginal_TFD_1_0.xslt
  fRecursoXSLT := TResourceStream.Create(hInstance, _NOMBRE_DEL_RECURSO_XSLT, 'BIN');
end;

function TCadenaOriginalDeTimbre.Generar: TStringCadenaOriginal;
begin
  // TODO: Agregar codigo para calcular por XSLT la cadena original del timbre
  //Result := ;
end;

end.
