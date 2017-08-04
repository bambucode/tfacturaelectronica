{*******************************************************}
{                                                       }
{       TFacturaElectronica                             }
{                                                       }
{       Copyright (C) 2017 Bambu Code SA de CV          }
{                                                       }
{*******************************************************}

unit Facturacion.Comprobante;

interface

uses xmldom, XMLDoc, XMLIntf;

type

  // Definimos el tipo de Cadena estándard que manejaremos en toda la libreia
  // con codificacion en UTF8
  {$IF Compilerversion >= 20}
  TCadenaUTF8 = RawByteString;
  {$ELSE}
  TCadenaUTF8 = UTF8String;
  {$IFEND}

  TFacturacionCredencialesPAC = record
    RFC: String;
    DistribuidorID: string;
  end;

  /// <summary>
  ///   Comprobante Fiscal "Base" comun cuyas propiedades/metodos existen en
  ///   todas las versiones de los comprobantes
  /// </summary>
  /// <remarks>
  ///   <note type="note">
  ///     Toda nueva versión de un CFDI deberá implementar esta interfase.
  ///     Para mayor información consultar el wiki en:
  ///     https://github.com/bambucode/tfacturaelectronica/wiki
  ///   </note>
  /// </remarks>
  IComprobanteFiscal = interface(IXMLNode)
    ['{2F952C1C-EEC6-41D4-90E9-BA3F54325C18}']
    function Get_Version: UnicodeString;
    procedure Set_Version(Value: UnicodeString);
    function Get_Sello: UnicodeString;
    procedure Set_Sello(Value: UnicodeString);
    function Get_Certificado: UnicodeString;
    function Get_NoCertificado: UnicodeString;
    procedure Set_NoCertificado(Value: UnicodeString);
    procedure Set_Certificado(Value: UnicodeString);

    property NoCertificado: UnicodeString read Get_NoCertificado write Set_NoCertificado;
    property Certificado: UnicodeString read Get_Certificado write Set_Certificado;
    property Version: UnicodeString read Get_Version write Set_Version;
    property Sello: UnicodeString read Get_Sello write Set_Sello;
    /// <summary>
    ///   Procedimiento estandarizado que deben tener todos los heredantes para
    ///   poder agregar el timbre fiscal digital
    /// </summary>
    /// <param name="aXMLTimbre">
    ///   XML del timbre tal cual lo mandó el PAC
    /// </param>
    procedure AsignarTimbreFiscal(const aXMLTimbre: TCadenaUTF8);
    procedure AgregarComplemento(aNodoAAgregar: IXMLNode;
                                 const aNameSpacePrefijo : String;
                                 const aNameSpaceURI: String;
                                 const aAnexarSchema: String);
  end;

implementation

end.
