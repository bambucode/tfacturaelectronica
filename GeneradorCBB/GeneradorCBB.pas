(******************************************************************************
 PROYECTO FACTURACION ELECTRONICA
 Copyright (C) 2010-2014 - Bambú Code SA de CV - Ing. Eduardo Padilla

 Esta clase se encarga de generar un Código de barras bidimensional QR, con
 base al estándar ISO/IEC 18004:2000, conteniendo los siguientes datos en el
 siguiente formato:

 1. RFC del emisor
 2. RFC del receptor
 3. Total (a 6 decimales fijos)
 4. Identificador único del timbre (UUID) asignado

 Generamos la imagen QR ayudandonos de la liberia Quaricol Open Source para
 generación de QR Codes.

 Este archivo pertenece al proyecto de codigo abierto de Bambu Code:
 http://bambucode.com/codigoabierto

 La licencia de este codigo fuente se encuentra en:
 http://github.com/bambucode/tfacturaelectronica/blob/master/LICENCIA
 ******************************************************************************)
unit GeneradorCBB;

interface

uses
  FacturaTipos,
  Windows, SysUtils, Classes,ExtCtrls, StdCtrls;

type

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  <para>
  ///	    Esta clase se encarga de generar un Código de barras bidimensional
  ///	    QR, con base al estándar ISO/IEC 18004:2000, conteniendo los
  ///	    siguientes datos en el siguiente formato:
  ///	  </para>
  ///	  <para>
  ///	    1. RFC del emisor
  ///	  </para>
  ///	  <para>
  ///	    2. RFC del receptor
  ///	  </para>
  ///	  <para>
  ///	    3. Total (a 6 decimales fijos)
  ///	  </para>
  ///	  <para>
  ///	    4. Identificador único del timbre (UUID) asignado
  ///	  </para>
  ///	</summary>
  ///	<remarks>
  ///	  <note type="note">
  ///	    Generamos la imagen QR ayudandonos de la liberia Quaricol Open Source
  ///	    para generación de QR Codes.
  ///	  </note>
  ///	</remarks>
  {$ENDREGION}
  TGeneradorCBB = class
  private
  public
    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Se encarga de generar la imagen del CBB para CFDI segun los
    ///	  requerimientos del SAT
    ///	</summary>
    {$ENDREGION}
    procedure AfterConstruction; override;
    function GenerarImagen(const aEmisor, aReceptor: TFEContribuyente; const
        aTotal: Currency; const aUUID, aRutaAGuardar: string): Boolean;
  end;

implementation

uses QuricolCode, QuricolAPI, pngimage, Jpeg,
  {$IF Compilerversion >= 20}
   Vcl.Graphics;
  {$ELSE}
   Graphics;
  {$IFEND}

procedure TGeneradorCBB.AfterConstruction;
begin
  inherited;
end;

function TGeneradorCBB.GenerarImagen(const aEmisor, aReceptor:
    TFEContribuyente; const aTotal: Currency; const aUUID, aRutaAGuardar:
    string): Boolean;
var
  cadenaParaCBB: String;
  jpgResultado: TJpegImage;
  bmpCBB: TBitmap;
const
  _TAMANO_DE_UUID = 36;
  _IMAGEN_MARGEN = 0;
  _TAMANO_PIXELES = 24;
  _ANCHO_ESTANDARD = 1200;
  _ALTO_ESTANDARD = 1200;
begin
  

  Result := False;
  // Checamos que los parámetros esten correctos
  Assert(Length(aUUID) = _TAMANO_DE_UUID,
         'El UUID no tuvo la longitud correcta de ' + IntToStr(_TAMANO_DE_UUID));
  Assert(aRutaAGuardar <> '', 'La ruta fue vacia');

  // 1. Definimos la cadena con la que vamos a generar el CBB segun la especificacion del SAT
  // segun el rubro II.E del Anexo 20
  cadenaParaCBB := Format('?re=%s&rr=%s&tt=%s&id=%s',
                          [aEmisor.RFC,
                           aReceptor.RFC,
                           FloatToStrF(aTotal, ffFixed, 17, 6),
                           aUUID]);

  // 2. Generamos la imagen auxiliandonos de la liberia Quaricol
  jpgResultado := TJPEGImage.Create;
  try
    bmpCBB := TQRCode.GetBitmapImage(cadenaParaCBB,
                                    _ANCHO_ESTANDARD, _ANCHO_ESTANDARD, _IMAGEN_MARGEN, _TAMANO_PIXELES, QualityHigh);
    try
      // La asignamos el JPG y la guardamos
      jpgResultado.Assign(bmpCBB);
      jpgResultado.SaveToFile(aRutaAGuardar);
      Result := True;
    finally
      bmpCBB.Free;
    end;
  finally
    jpgResultado.Free;
  end;
end;

end.
