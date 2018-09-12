{***********************************************************}
{                                                           }
{       TFacturaElectronica                                 }
{                                                           }
{       Copyright (C) 2018 Bambu Code SA de CV              }
{       Soporte del Complemento ComercioExterior v1.1       }
{                                                           }
{***********************************************************}

{***********************************************************************************************************}
{                                                                                                           }
{                                          XML Data Binding                                                 }
{                                                                                                           }
{         Generated on: 11/09/2018 07:33:50 p. m.                                                           }
{       Generated from: http://www.sat.gob.mx/sitio_internet/cfd/ComercioExterior11/ComercioExterior11.xsd  }
{                                                                                                           }
{***********************************************************************************************************}

unit Facturacion.ComplementoComercioExteriorV11;

interface

uses xmldom, XMLDoc, XMLIntf, Facturacion.Comprobante;

type

{ Forward Decls }

  IComercioExterior = interface;
  IComercioExterior_Emisor = interface;
  IComercioExterior_Emisor_Domicilio = interface;
  IComercioExterior_Propietario = interface;
  IComercioExterior_PropietarioList = interface;
  IComercioExterior_Receptor = interface;
  IComercioExterior_Receptor_Domicilio = interface;
  IComercioExterior_Destinatario = interface;
  IComercioExterior_DestinatarioList = interface;
  IComercioExterior_Destinatario_Domicilio = interface;
  IComercioExterior_Mercancias = interface;
  IComercioExterior_Mercancias_Mercancia = interface;
  IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas = interface;

{ IComercioExterior }

  IComercioExterior = interface(IXMLNode)
    ['{41A50FFB-FC90-4E3E-BD5E-CCFD5EB6EAB4}']
    { Property Accessors }
    function Get_Version: UnicodeString;
    function Get_MotivoTraslado: UnicodeString;
    function Get_TipoOperacion: UnicodeString;
    function Get_ClaveDePedimento: UnicodeString;
    function Get_CertificadoOrigen: Integer;
    function Get_NumCertificadoOrigen: UnicodeString;
    function Get_NumeroExportadorConfiable: UnicodeString;
    function Get_Incoterm: UnicodeString;
    function Get_Subdivision: Integer;
    function Get_Observaciones: UnicodeString;
    function Get_TipoCambioUSD: UnicodeString;
    function Get_TotalUSD: UnicodeString;
    function Get_Emisor: IComercioExterior_Emisor;
    function Get_Propietario: IComercioExterior_PropietarioList;
    function Get_Receptor: IComercioExterior_Receptor;
    function Get_Destinatario: IComercioExterior_DestinatarioList;
    function Get_Mercancias: IComercioExterior_Mercancias;
    procedure Set_Version(Value: UnicodeString);
    procedure Set_MotivoTraslado(Value: UnicodeString);
    procedure Set_TipoOperacion(Value: UnicodeString);
    procedure Set_ClaveDePedimento(Value: UnicodeString);
    procedure Set_CertificadoOrigen(Value: Integer);
    procedure Set_NumCertificadoOrigen(Value: UnicodeString);
    procedure Set_NumeroExportadorConfiable(Value: UnicodeString);
    procedure Set_Incoterm(Value: UnicodeString);
    procedure Set_Subdivision(Value: Integer);
    procedure Set_Observaciones(Value: UnicodeString);
    procedure Set_TipoCambioUSD(Value: UnicodeString);
    procedure Set_TotalUSD(Value: UnicodeString);
    { Methods & Properties }
    property Version: UnicodeString read Get_Version write Set_Version;
    property MotivoTraslado: UnicodeString read Get_MotivoTraslado write Set_MotivoTraslado;
    property TipoOperacion: UnicodeString read Get_TipoOperacion write Set_TipoOperacion;
    property ClaveDePedimento: UnicodeString read Get_ClaveDePedimento write Set_ClaveDePedimento;
    property CertificadoOrigen: Integer read Get_CertificadoOrigen write Set_CertificadoOrigen;
    property NumCertificadoOrigen: UnicodeString read Get_NumCertificadoOrigen write Set_NumCertificadoOrigen;
    property NumeroExportadorConfiable: UnicodeString read Get_NumeroExportadorConfiable write Set_NumeroExportadorConfiable;
    property Incoterm: UnicodeString read Get_Incoterm write Set_Incoterm;
    property Subdivision: Integer read Get_Subdivision write Set_Subdivision;
    property Observaciones: UnicodeString read Get_Observaciones write Set_Observaciones;
    property TipoCambioUSD: UnicodeString read Get_TipoCambioUSD write Set_TipoCambioUSD;
    property TotalUSD: UnicodeString read Get_TotalUSD write Set_TotalUSD;
    property Emisor: IComercioExterior_Emisor read Get_Emisor;
    property Propietario: IComercioExterior_PropietarioList read Get_Propietario;
    property Receptor: IComercioExterior_Receptor read Get_Receptor;
    property Destinatario: IComercioExterior_DestinatarioList read Get_Destinatario;
    property Mercancias: IComercioExterior_Mercancias read Get_Mercancias;
  end;

{ IComercioExterior_Emisor }

  IComercioExterior_Emisor = interface(IXMLNode)
    ['{26DED737-0E19-4F6B-83E6-9A59560DB06E}']
    { Property Accessors }
    function Get_Curp: UnicodeString;
    function Get_Domicilio: IComercioExterior_Emisor_Domicilio;
    procedure Set_Curp(Value: UnicodeString);
    { Methods & Properties }
    property Curp: UnicodeString read Get_Curp write Set_Curp;
    property Domicilio: IComercioExterior_Emisor_Domicilio read Get_Domicilio;
  end;

{ IComercioExterior_Emisor_Domicilio }

  IComercioExterior_Emisor_Domicilio = interface(IXMLNode)
    ['{5C0D8F37-748C-4E40-B95B-EE38C87EF05E}']
    { Property Accessors }
    function Get_Calle: UnicodeString;
    function Get_NumeroExterior: UnicodeString;
    function Get_NumeroInterior: UnicodeString;
    function Get_Colonia: UnicodeString;
    function Get_Localidad: UnicodeString;
    function Get_Referencia: UnicodeString;
    function Get_Municipio: UnicodeString;
    function Get_Estado: UnicodeString;
    function Get_Pais: UnicodeString;
    function Get_CodigoPostal: UnicodeString;
    procedure Set_Calle(Value: UnicodeString);
    procedure Set_NumeroExterior(Value: UnicodeString);
    procedure Set_NumeroInterior(Value: UnicodeString);
    procedure Set_Colonia(Value: UnicodeString);
    procedure Set_Localidad(Value: UnicodeString);
    procedure Set_Referencia(Value: UnicodeString);
    procedure Set_Municipio(Value: UnicodeString);
    procedure Set_Estado(Value: UnicodeString);
    procedure Set_Pais(Value: UnicodeString);
    procedure Set_CodigoPostal(Value: UnicodeString);
    { Methods & Properties }
    property Calle: UnicodeString read Get_Calle write Set_Calle;
    property NumeroExterior: UnicodeString read Get_NumeroExterior write Set_NumeroExterior;
    property NumeroInterior: UnicodeString read Get_NumeroInterior write Set_NumeroInterior;
    property Colonia: UnicodeString read Get_Colonia write Set_Colonia;
    property Localidad: UnicodeString read Get_Localidad write Set_Localidad;
    property Referencia: UnicodeString read Get_Referencia write Set_Referencia;
    property Municipio: UnicodeString read Get_Municipio write Set_Municipio;
    property Estado: UnicodeString read Get_Estado write Set_Estado;
    property Pais: UnicodeString read Get_Pais write Set_Pais;
    property CodigoPostal: UnicodeString read Get_CodigoPostal write Set_CodigoPostal;
  end;

{ IComercioExterior_Propietario }

  IComercioExterior_Propietario = interface(IXMLNode)
    ['{B73DF91D-A63C-413C-86B2-701A7464AE9F}']
    { Property Accessors }
    function Get_NumRegIdTrib: UnicodeString;
    function Get_ResidenciaFiscal: UnicodeString;
    procedure Set_NumRegIdTrib(Value: UnicodeString);
    procedure Set_ResidenciaFiscal(Value: UnicodeString);
    { Methods & Properties }
    property NumRegIdTrib: UnicodeString read Get_NumRegIdTrib write Set_NumRegIdTrib;
    property ResidenciaFiscal: UnicodeString read Get_ResidenciaFiscal write Set_ResidenciaFiscal;
  end;

{ IComercioExterior_PropietarioList }

  IComercioExterior_PropietarioList = interface(IXMLNodeCollection)
    ['{CA30C183-4805-4D38-A8F9-33EC63712AB5}']
    { Methods & Properties }
    function Add: IComercioExterior_Propietario;
    function Insert(const Index: Integer): IComercioExterior_Propietario;

    function Get_Item(Index: Integer): IComercioExterior_Propietario;
    property Items[Index: Integer]: IComercioExterior_Propietario read Get_Item; default;
  end;

{ IComercioExterior_Receptor }

  IComercioExterior_Receptor = interface(IXMLNode)
    ['{9F4D9A68-CEBD-41AE-897E-ED0E55C3B309}']
    { Property Accessors }
    function Get_NumRegIdTrib: UnicodeString;
    function Get_Domicilio: IComercioExterior_Receptor_Domicilio;
    procedure Set_NumRegIdTrib(Value: UnicodeString);
    { Methods & Properties }
    property NumRegIdTrib: UnicodeString read Get_NumRegIdTrib write Set_NumRegIdTrib;
    property Domicilio: IComercioExterior_Receptor_Domicilio read Get_Domicilio;
  end;

{ IComercioExterior_Receptor_Domicilio }

  IComercioExterior_Receptor_Domicilio = interface(IXMLNode)
    ['{4253AFB1-9267-4893-89F4-9BC0C7E11C28}']
    { Property Accessors }
    function Get_Calle: UnicodeString;
    function Get_NumeroExterior: UnicodeString;
    function Get_NumeroInterior: UnicodeString;
    function Get_Colonia: UnicodeString;
    function Get_Localidad: UnicodeString;
    function Get_Referencia: UnicodeString;
    function Get_Municipio: UnicodeString;
    function Get_Estado: UnicodeString;
    function Get_Pais: UnicodeString;
    function Get_CodigoPostal: UnicodeString;
    procedure Set_Calle(Value: UnicodeString);
    procedure Set_NumeroExterior(Value: UnicodeString);
    procedure Set_NumeroInterior(Value: UnicodeString);
    procedure Set_Colonia(Value: UnicodeString);
    procedure Set_Localidad(Value: UnicodeString);
    procedure Set_Referencia(Value: UnicodeString);
    procedure Set_Municipio(Value: UnicodeString);
    procedure Set_Estado(Value: UnicodeString);
    procedure Set_Pais(Value: UnicodeString);
    procedure Set_CodigoPostal(Value: UnicodeString);
    { Methods & Properties }
    property Calle: UnicodeString read Get_Calle write Set_Calle;
    property NumeroExterior: UnicodeString read Get_NumeroExterior write Set_NumeroExterior;
    property NumeroInterior: UnicodeString read Get_NumeroInterior write Set_NumeroInterior;
    property Colonia: UnicodeString read Get_Colonia write Set_Colonia;
    property Localidad: UnicodeString read Get_Localidad write Set_Localidad;
    property Referencia: UnicodeString read Get_Referencia write Set_Referencia;
    property Municipio: UnicodeString read Get_Municipio write Set_Municipio;
    property Estado: UnicodeString read Get_Estado write Set_Estado;
    property Pais: UnicodeString read Get_Pais write Set_Pais;
    property CodigoPostal: UnicodeString read Get_CodigoPostal write Set_CodigoPostal;
  end;

{ IComercioExterior_Destinatario }

  IComercioExterior_Destinatario = interface(IXMLNodeCollection)
    ['{BCD1E149-2278-40BA-A485-4C9998253411}']
    { Property Accessors }
    function Get_NumRegIdTrib: UnicodeString;
    function Get_Nombre: UnicodeString;
    function Get_Domicilio(Index: Integer): IComercioExterior_Destinatario_Domicilio;
    procedure Set_NumRegIdTrib(Value: UnicodeString);
    procedure Set_Nombre(Value: UnicodeString);
    { Methods & Properties }
    function Add: IComercioExterior_Destinatario_Domicilio;
    function Insert(const Index: Integer): IComercioExterior_Destinatario_Domicilio;
    property NumRegIdTrib: UnicodeString read Get_NumRegIdTrib write Set_NumRegIdTrib;
    property Nombre: UnicodeString read Get_Nombre write Set_Nombre;
    property Domicilio[Index: Integer]: IComercioExterior_Destinatario_Domicilio read Get_Domicilio; default;
  end;

{ IComercioExterior_DestinatarioList }

  IComercioExterior_DestinatarioList = interface(IXMLNodeCollection)
    ['{31E87C73-02EA-46C3-958C-A4BF7CBF29B7}']
    { Methods & Properties }
    function Add: IComercioExterior_Destinatario;
    function Insert(const Index: Integer): IComercioExterior_Destinatario;

    function Get_Item(Index: Integer): IComercioExterior_Destinatario;
    property Items[Index: Integer]: IComercioExterior_Destinatario read Get_Item; default;
  end;

{ IComercioExterior_Destinatario_Domicilio }

  IComercioExterior_Destinatario_Domicilio = interface(IXMLNode)
    ['{B47E5C99-7F8A-45D2-B306-A0D37AF0E53B}']
    { Property Accessors }
    function Get_Calle: UnicodeString;
    function Get_NumeroExterior: UnicodeString;
    function Get_NumeroInterior: UnicodeString;
    function Get_Colonia: UnicodeString;
    function Get_Localidad: UnicodeString;
    function Get_Referencia: UnicodeString;
    function Get_Municipio: UnicodeString;
    function Get_Estado: UnicodeString;
    function Get_Pais: UnicodeString;
    function Get_CodigoPostal: UnicodeString;
    procedure Set_Calle(Value: UnicodeString);
    procedure Set_NumeroExterior(Value: UnicodeString);
    procedure Set_NumeroInterior(Value: UnicodeString);
    procedure Set_Colonia(Value: UnicodeString);
    procedure Set_Localidad(Value: UnicodeString);
    procedure Set_Referencia(Value: UnicodeString);
    procedure Set_Municipio(Value: UnicodeString);
    procedure Set_Estado(Value: UnicodeString);
    procedure Set_Pais(Value: UnicodeString);
    procedure Set_CodigoPostal(Value: UnicodeString);
    { Methods & Properties }
    property Calle: UnicodeString read Get_Calle write Set_Calle;
    property NumeroExterior: UnicodeString read Get_NumeroExterior write Set_NumeroExterior;
    property NumeroInterior: UnicodeString read Get_NumeroInterior write Set_NumeroInterior;
    property Colonia: UnicodeString read Get_Colonia write Set_Colonia;
    property Localidad: UnicodeString read Get_Localidad write Set_Localidad;
    property Referencia: UnicodeString read Get_Referencia write Set_Referencia;
    property Municipio: UnicodeString read Get_Municipio write Set_Municipio;
    property Estado: UnicodeString read Get_Estado write Set_Estado;
    property Pais: UnicodeString read Get_Pais write Set_Pais;
    property CodigoPostal: UnicodeString read Get_CodigoPostal write Set_CodigoPostal;
  end;

{ IComercioExterior_Mercancias }

  IComercioExterior_Mercancias = interface(IXMLNodeCollection)
    ['{B3D6E13B-C5DD-46D8-8444-D31EC4966B3C}']
    { Property Accessors }
    function Get_Mercancia(Index: Integer): IComercioExterior_Mercancias_Mercancia;
    { Methods & Properties }
    function Add: IComercioExterior_Mercancias_Mercancia;
    function Insert(const Index: Integer): IComercioExterior_Mercancias_Mercancia;
    property Mercancia[Index: Integer]: IComercioExterior_Mercancias_Mercancia read Get_Mercancia; default;
  end;

{ IComercioExterior_Mercancias_Mercancia }

  IComercioExterior_Mercancias_Mercancia = interface(IXMLNodeCollection)
    ['{A1CEF554-D16A-466D-A862-FF30EA845689}']
    { Property Accessors }
    function Get_NoIdentificacion: UnicodeString;
    function Get_FraccionArancelaria: UnicodeString;
    function Get_CantidadAduana: UnicodeString;
    function Get_UnidadAduana: UnicodeString;
    function Get_ValorUnitarioAduana: UnicodeString;
    function Get_ValorDolares: UnicodeString;
    function Get_DescripcionesEspecificas(Index: Integer): IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas;
    procedure Set_NoIdentificacion(Value: UnicodeString);
    procedure Set_FraccionArancelaria(Value: UnicodeString);
    procedure Set_CantidadAduana(Value: UnicodeString);
    procedure Set_UnidadAduana(Value: UnicodeString);
    procedure Set_ValorUnitarioAduana(Value: UnicodeString);
    procedure Set_ValorDolares(Value: UnicodeString);
    { Methods & Properties }
    function Add: IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas;
    function Insert(const Index: Integer): IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas;
    property NoIdentificacion: UnicodeString read Get_NoIdentificacion write Set_NoIdentificacion;
    property FraccionArancelaria: UnicodeString read Get_FraccionArancelaria write Set_FraccionArancelaria;
    property CantidadAduana: UnicodeString read Get_CantidadAduana write Set_CantidadAduana;
    property UnidadAduana: UnicodeString read Get_UnidadAduana write Set_UnidadAduana;
    property ValorUnitarioAduana: UnicodeString read Get_ValorUnitarioAduana write Set_ValorUnitarioAduana;
    property ValorDolares: UnicodeString read Get_ValorDolares write Set_ValorDolares;
    property DescripcionesEspecificas[Index: Integer]: IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas read Get_DescripcionesEspecificas; default;
  end;

{ IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas }

  IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas = interface(IXMLNode)
    ['{AA9380DA-E31C-494A-BE49-E0D73795734C}']
    { Property Accessors }
    function Get_Marca: UnicodeString;
    function Get_Modelo: UnicodeString;
    function Get_SubModelo: UnicodeString;
    function Get_NumeroSerie: UnicodeString;
    procedure Set_Marca(Value: UnicodeString);
    procedure Set_Modelo(Value: UnicodeString);
    procedure Set_SubModelo(Value: UnicodeString);
    procedure Set_NumeroSerie(Value: UnicodeString);
    { Methods & Properties }
    property Marca: UnicodeString read Get_Marca write Set_Marca;
    property Modelo: UnicodeString read Get_Modelo write Set_Modelo;
    property SubModelo: UnicodeString read Get_SubModelo write Set_SubModelo;
    property NumeroSerie: UnicodeString read Get_NumeroSerie write Set_NumeroSerie;
  end;

{ Forward Decls }

  TComercioExterior = class;
  TComercioExterior_Emisor = class;
  TComercioExterior_Emisor_Domicilio = class;
  TComercioExterior_Propietario = class;
  TComercioExterior_PropietarioList = class;
  TComercioExterior_Receptor = class;
  TComercioExterior_Receptor_Domicilio = class;
  TComercioExterior_Destinatario = class;
  TComercioExterior_DestinatarioList = class;
  TComercioExterior_Destinatario_Domicilio = class;
  TComercioExterior_Mercancias = class;
  TComercioExterior_Mercancias_Mercancia = class;
  TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas = class;

{ TComercioExterior }

  TComercioExterior = class(TXMLNode, IComercioExterior)
  private
    FPropietario: IComercioExterior_PropietarioList;
    FDestinatario: IComercioExterior_DestinatarioList;
  protected
    { IComercioExterior }
    function Get_Version: UnicodeString;
    function Get_MotivoTraslado: UnicodeString;
    function Get_TipoOperacion: UnicodeString;
    function Get_ClaveDePedimento: UnicodeString;
    function Get_CertificadoOrigen: Integer;
    function Get_NumCertificadoOrigen: UnicodeString;
    function Get_NumeroExportadorConfiable: UnicodeString;
    function Get_Incoterm: UnicodeString;
    function Get_Subdivision: Integer;
    function Get_Observaciones: UnicodeString;
    function Get_TipoCambioUSD: UnicodeString;
    function Get_TotalUSD: UnicodeString;
    function Get_Emisor: IComercioExterior_Emisor;
    function Get_Propietario: IComercioExterior_PropietarioList;
    function Get_Receptor: IComercioExterior_Receptor;
    function Get_Destinatario: IComercioExterior_DestinatarioList;
    function Get_Mercancias: IComercioExterior_Mercancias;
    procedure Set_Version(Value: UnicodeString);
    procedure Set_MotivoTraslado(Value: UnicodeString);
    procedure Set_TipoOperacion(Value: UnicodeString);
    procedure Set_ClaveDePedimento(Value: UnicodeString);
    procedure Set_CertificadoOrigen(Value: Integer);
    procedure Set_NumCertificadoOrigen(Value: UnicodeString);
    procedure Set_NumeroExportadorConfiable(Value: UnicodeString);
    procedure Set_Incoterm(Value: UnicodeString);
    procedure Set_Subdivision(Value: Integer);
    procedure Set_Observaciones(Value: UnicodeString);
    procedure Set_TipoCambioUSD(Value: UnicodeString);
    procedure Set_TotalUSD(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TComercioExterior_Emisor }

  TComercioExterior_Emisor = class(TXMLNode, IComercioExterior_Emisor)
  protected
    { IComercioExterior_Emisor }
    function Get_Curp: UnicodeString;
    function Get_Domicilio: IComercioExterior_Emisor_Domicilio;
    procedure Set_Curp(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TComercioExterior_Emisor_Domicilio }

  TComercioExterior_Emisor_Domicilio = class(TXMLNode, IComercioExterior_Emisor_Domicilio)
  protected
    { IComercioExterior_Emisor_Domicilio }
    function Get_Calle: UnicodeString;
    function Get_NumeroExterior: UnicodeString;
    function Get_NumeroInterior: UnicodeString;
    function Get_Colonia: UnicodeString;
    function Get_Localidad: UnicodeString;
    function Get_Referencia: UnicodeString;
    function Get_Municipio: UnicodeString;
    function Get_Estado: UnicodeString;
    function Get_Pais: UnicodeString;
    function Get_CodigoPostal: UnicodeString;
    procedure Set_Calle(Value: UnicodeString);
    procedure Set_NumeroExterior(Value: UnicodeString);
    procedure Set_NumeroInterior(Value: UnicodeString);
    procedure Set_Colonia(Value: UnicodeString);
    procedure Set_Localidad(Value: UnicodeString);
    procedure Set_Referencia(Value: UnicodeString);
    procedure Set_Municipio(Value: UnicodeString);
    procedure Set_Estado(Value: UnicodeString);
    procedure Set_Pais(Value: UnicodeString);
    procedure Set_CodigoPostal(Value: UnicodeString);
  end;

{ TComercioExterior_Propietario }

  TComercioExterior_Propietario = class(TXMLNode, IComercioExterior_Propietario)
  protected
    { IComercioExterior_Propietario }
    function Get_NumRegIdTrib: UnicodeString;
    function Get_ResidenciaFiscal: UnicodeString;
    procedure Set_NumRegIdTrib(Value: UnicodeString);
    procedure Set_ResidenciaFiscal(Value: UnicodeString);
  end;

{ TComercioExterior_PropietarioList }

  TComercioExterior_PropietarioList = class(TXMLNodeCollection, IComercioExterior_PropietarioList)
  protected
    { IComercioExterior_PropietarioList }
    function Add: IComercioExterior_Propietario;
    function Insert(const Index: Integer): IComercioExterior_Propietario;

    function Get_Item(Index: Integer): IComercioExterior_Propietario;
  end;

{ TComercioExterior_Receptor }

  TComercioExterior_Receptor = class(TXMLNode, IComercioExterior_Receptor)
  protected
    { IComercioExterior_Receptor }
    function Get_NumRegIdTrib: UnicodeString;
    function Get_Domicilio: IComercioExterior_Receptor_Domicilio;
    procedure Set_NumRegIdTrib(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TComercioExterior_Receptor_Domicilio }

  TComercioExterior_Receptor_Domicilio = class(TXMLNode, IComercioExterior_Receptor_Domicilio)
  protected
    { IComercioExterior_Receptor_Domicilio }
    function Get_Calle: UnicodeString;
    function Get_NumeroExterior: UnicodeString;
    function Get_NumeroInterior: UnicodeString;
    function Get_Colonia: UnicodeString;
    function Get_Localidad: UnicodeString;
    function Get_Referencia: UnicodeString;
    function Get_Municipio: UnicodeString;
    function Get_Estado: UnicodeString;
    function Get_Pais: UnicodeString;
    function Get_CodigoPostal: UnicodeString;
    procedure Set_Calle(Value: UnicodeString);
    procedure Set_NumeroExterior(Value: UnicodeString);
    procedure Set_NumeroInterior(Value: UnicodeString);
    procedure Set_Colonia(Value: UnicodeString);
    procedure Set_Localidad(Value: UnicodeString);
    procedure Set_Referencia(Value: UnicodeString);
    procedure Set_Municipio(Value: UnicodeString);
    procedure Set_Estado(Value: UnicodeString);
    procedure Set_Pais(Value: UnicodeString);
    procedure Set_CodigoPostal(Value: UnicodeString);
  end;

{ TComercioExterior_Destinatario }

  TComercioExterior_Destinatario = class(TXMLNodeCollection, IComercioExterior_Destinatario)
  protected
    { IComercioExterior_Destinatario }
    function Get_NumRegIdTrib: UnicodeString;
    function Get_Nombre: UnicodeString;
    function Get_Domicilio(Index: Integer): IComercioExterior_Destinatario_Domicilio;
    procedure Set_NumRegIdTrib(Value: UnicodeString);
    procedure Set_Nombre(Value: UnicodeString);
    function Add: IComercioExterior_Destinatario_Domicilio;
    function Insert(const Index: Integer): IComercioExterior_Destinatario_Domicilio;
  public
    procedure AfterConstruction; override;
  end;

{ TComercioExterior_DestinatarioList }

  TComercioExterior_DestinatarioList = class(TXMLNodeCollection, IComercioExterior_DestinatarioList)
  protected
    { IComercioExterior_DestinatarioList }
    function Add: IComercioExterior_Destinatario;
    function Insert(const Index: Integer): IComercioExterior_Destinatario;

    function Get_Item(Index: Integer): IComercioExterior_Destinatario;
  end;

{ TComercioExterior_Destinatario_Domicilio }

  TComercioExterior_Destinatario_Domicilio = class(TXMLNode, IComercioExterior_Destinatario_Domicilio)
  protected
    { IComercioExterior_Destinatario_Domicilio }
    function Get_Calle: UnicodeString;
    function Get_NumeroExterior: UnicodeString;
    function Get_NumeroInterior: UnicodeString;
    function Get_Colonia: UnicodeString;
    function Get_Localidad: UnicodeString;
    function Get_Referencia: UnicodeString;
    function Get_Municipio: UnicodeString;
    function Get_Estado: UnicodeString;
    function Get_Pais: UnicodeString;
    function Get_CodigoPostal: UnicodeString;
    procedure Set_Calle(Value: UnicodeString);
    procedure Set_NumeroExterior(Value: UnicodeString);
    procedure Set_NumeroInterior(Value: UnicodeString);
    procedure Set_Colonia(Value: UnicodeString);
    procedure Set_Localidad(Value: UnicodeString);
    procedure Set_Referencia(Value: UnicodeString);
    procedure Set_Municipio(Value: UnicodeString);
    procedure Set_Estado(Value: UnicodeString);
    procedure Set_Pais(Value: UnicodeString);
    procedure Set_CodigoPostal(Value: UnicodeString);
  end;

{ TComercioExterior_Mercancias }

  TComercioExterior_Mercancias = class(TXMLNodeCollection, IComercioExterior_Mercancias)
  protected
    { IComercioExterior_Mercancias }
    function Get_Mercancia(Index: Integer): IComercioExterior_Mercancias_Mercancia;
    function Add: IComercioExterior_Mercancias_Mercancia;
    function Insert(const Index: Integer): IComercioExterior_Mercancias_Mercancia;
  public
    procedure AfterConstruction; override;
  end;

{ TComercioExterior_Mercancias_Mercancia }

  TComercioExterior_Mercancias_Mercancia = class(TXMLNodeCollection, IComercioExterior_Mercancias_Mercancia)
  protected
    { IComercioExterior_Mercancias_Mercancia }
    function Get_NoIdentificacion: UnicodeString;
    function Get_FraccionArancelaria: UnicodeString;
    function Get_CantidadAduana: UnicodeString;
    function Get_UnidadAduana: UnicodeString;
    function Get_ValorUnitarioAduana: UnicodeString;
    function Get_ValorDolares: UnicodeString;
    function Get_DescripcionesEspecificas(Index: Integer): IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas;
    procedure Set_NoIdentificacion(Value: UnicodeString);
    procedure Set_FraccionArancelaria(Value: UnicodeString);
    procedure Set_CantidadAduana(Value: UnicodeString);
    procedure Set_UnidadAduana(Value: UnicodeString);
    procedure Set_ValorUnitarioAduana(Value: UnicodeString);
    procedure Set_ValorDolares(Value: UnicodeString);
    function Add: IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas;
    function Insert(const Index: Integer): IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas;
  public
    procedure AfterConstruction; override;
  end;

{ TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas }

  TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas = class(TXMLNode, IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas)
  protected
    { IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas }
    function Get_Marca: UnicodeString;
    function Get_Modelo: UnicodeString;
    function Get_SubModelo: UnicodeString;
    function Get_NumeroSerie: UnicodeString;
    procedure Set_Marca(Value: UnicodeString);
    procedure Set_Modelo(Value: UnicodeString);
    procedure Set_SubModelo(Value: UnicodeString);
    procedure Set_NumeroSerie(Value: UnicodeString);
  end;

{ Global Functions }

function GetComercioExterior(Doc: IXMLDocument): IComercioExterior;
function LoadComercioExterior(const FileName: string): IComercioExterior;
function NewComercioExterior: IComercioExterior;

const
  TargetNamespace = 'http://www.sat.gob.mx/ComercioExterior11';

implementation

{ Global Functions }

function GetComercioExterior(Doc: IXMLDocument): IComercioExterior;
begin
  Result := Doc.GetDocBinding('cce11:ComercioExterior', TComercioExterior, TargetNamespace) as IComercioExterior;
end;

function LoadComercioExterior(const FileName: string): IComercioExterior;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('cce11:ComercioExterior', TComercioExterior, TargetNamespace) as IComercioExterior;
end;

function NewComercioExterior: IComercioExterior;
begin
  Result := NewXMLDocument.GetDocBinding('cce11:ComercioExterior', TComercioExterior, TargetNamespace) as IComercioExterior;
end;

{ TComercioExterior }

procedure TComercioExterior.AfterConstruction;
begin
  if (Self.AttributeNodes.FindNode('Version') = nil) then
      Self.Set_Version('1.1');
  RegisterChildNode('Emisor', TComercioExterior_Emisor);
  RegisterChildNode('Propietario', TComercioExterior_Propietario);
  RegisterChildNode('Receptor', TComercioExterior_Receptor);
  RegisterChildNode('Destinatario', TComercioExterior_Destinatario);
  RegisterChildNode('Mercancias', TComercioExterior_Mercancias);
  FPropietario := CreateCollection(TComercioExterior_PropietarioList, IComercioExterior_Propietario, 'cce11:Propietario') as IComercioExterior_PropietarioList;
  FDestinatario := CreateCollection(TComercioExterior_DestinatarioList, IComercioExterior_Destinatario, 'cce11:Destinatario') as IComercioExterior_DestinatarioList;
  inherited;
end;

function TComercioExterior.Get_Version: UnicodeString;
begin
  Result := AttributeNodes['Version'].Text;
end;

procedure TComercioExterior.Set_Version(Value: UnicodeString);
begin
  SetAttribute('Version', Value);
end;

function TComercioExterior.Get_MotivoTraslado: UnicodeString;
begin
  Result := AttributeNodes['MotivoTraslado'].Text;
end;

procedure TComercioExterior.Set_MotivoTraslado(Value: UnicodeString);
begin
  SetAttribute('MotivoTraslado', Value);
end;

function TComercioExterior.Get_TipoOperacion: UnicodeString;
begin
  Result := AttributeNodes['TipoOperacion'].Text;
end;

procedure TComercioExterior.Set_TipoOperacion(Value: UnicodeString);
begin
  SetAttribute('TipoOperacion', Value);
end;

function TComercioExterior.Get_ClaveDePedimento: UnicodeString;
begin
  Result := AttributeNodes['ClaveDePedimento'].Text;
end;

procedure TComercioExterior.Set_ClaveDePedimento(Value: UnicodeString);
begin
  SetAttribute('ClaveDePedimento', Value);
end;

function TComercioExterior.Get_CertificadoOrigen: Integer;
begin
  Result := AttributeNodes['CertificadoOrigen'].NodeValue;
end;

procedure TComercioExterior.Set_CertificadoOrigen(Value: Integer);
begin
  SetAttribute('CertificadoOrigen', Value);
end;

function TComercioExterior.Get_NumCertificadoOrigen: UnicodeString;
begin
  Result := AttributeNodes['NumCertificadoOrigen'].Text;
end;

procedure TComercioExterior.Set_NumCertificadoOrigen(Value: UnicodeString);
begin
  SetAttribute('NumCertificadoOrigen', Value);
end;

function TComercioExterior.Get_NumeroExportadorConfiable: UnicodeString;
begin
  Result := AttributeNodes['NumeroExportadorConfiable'].Text;
end;

procedure TComercioExterior.Set_NumeroExportadorConfiable(Value: UnicodeString);
begin
  SetAttribute('NumeroExportadorConfiable', Value);
end;

function TComercioExterior.Get_Incoterm: UnicodeString;
begin
  Result := AttributeNodes['Incoterm'].Text;
end;

procedure TComercioExterior.Set_Incoterm(Value: UnicodeString);
begin
  SetAttribute('Incoterm', Value);
end;

function TComercioExterior.Get_Subdivision: Integer;
begin
  Result := AttributeNodes['Subdivision'].NodeValue;
end;

procedure TComercioExterior.Set_Subdivision(Value: Integer);
begin
  SetAttribute('Subdivision', Value);
end;

function TComercioExterior.Get_Observaciones: UnicodeString;
begin
  Result := AttributeNodes['Observaciones'].Text;
end;

procedure TComercioExterior.Set_Observaciones(Value: UnicodeString);
begin
  SetAttribute('Observaciones', Value);
end;

function TComercioExterior.Get_TipoCambioUSD: UnicodeString;
begin
  Result := AttributeNodes['TipoCambioUSD'].Text;
end;

procedure TComercioExterior.Set_TipoCambioUSD(Value: UnicodeString);
begin
  SetAttribute('TipoCambioUSD', Value);
end;

function TComercioExterior.Get_TotalUSD: UnicodeString;
begin
  Result := AttributeNodes['TotalUSD'].Text;
end;

procedure TComercioExterior.Set_TotalUSD(Value: UnicodeString);
begin
  SetAttribute('TotalUSD', Value);
end;

function TComercioExterior.Get_Emisor: IComercioExterior_Emisor;
begin
  Result := ChildNodes['Emisor'] as IComercioExterior_Emisor;
end;

function TComercioExterior.Get_Propietario: IComercioExterior_PropietarioList;
begin
  Result := FPropietario;
end;

function TComercioExterior.Get_Receptor: IComercioExterior_Receptor;
begin
  Result := ChildNodes['Receptor'] as IComercioExterior_Receptor;
end;

function TComercioExterior.Get_Destinatario: IComercioExterior_DestinatarioList;
begin
  Result := FDestinatario;
end;

function TComercioExterior.Get_Mercancias: IComercioExterior_Mercancias;
begin
  Result := ChildNodes['Mercancias'] as IComercioExterior_Mercancias;
end;

{ TComercioExterior_Emisor }

procedure TComercioExterior_Emisor.AfterConstruction;
begin
  RegisterChildNode('Domicilio', TComercioExterior_Emisor_Domicilio);
  inherited;
end;

function TComercioExterior_Emisor.Get_Curp: UnicodeString;
begin
  Result := AttributeNodes['Curp'].Text;
end;

procedure TComercioExterior_Emisor.Set_Curp(Value: UnicodeString);
begin
  SetAttribute('Curp', Value);
end;

function TComercioExterior_Emisor.Get_Domicilio: IComercioExterior_Emisor_Domicilio;
begin
  Result := ChildNodes['Domicilio'] as IComercioExterior_Emisor_Domicilio;
end;

{ TComercioExterior_Emisor_Domicilio }

function TComercioExterior_Emisor_Domicilio.Get_Calle: UnicodeString;
begin
  Result := AttributeNodes['Calle'].Text;
end;

procedure TComercioExterior_Emisor_Domicilio.Set_Calle(Value: UnicodeString);
begin
  SetAttribute('Calle', Value);
end;

function TComercioExterior_Emisor_Domicilio.Get_NumeroExterior: UnicodeString;
begin
  Result := AttributeNodes['NumeroExterior'].Text;
end;

procedure TComercioExterior_Emisor_Domicilio.Set_NumeroExterior(Value: UnicodeString);
begin
  SetAttribute('NumeroExterior', Value);
end;

function TComercioExterior_Emisor_Domicilio.Get_NumeroInterior: UnicodeString;
begin
  Result := AttributeNodes['NumeroInterior'].Text;
end;

procedure TComercioExterior_Emisor_Domicilio.Set_NumeroInterior(Value: UnicodeString);
begin
  SetAttribute('NumeroInterior', Value);
end;

function TComercioExterior_Emisor_Domicilio.Get_Colonia: UnicodeString;
begin
  Result := AttributeNodes['Colonia'].Text;
end;

procedure TComercioExterior_Emisor_Domicilio.Set_Colonia(Value: UnicodeString);
begin
  SetAttribute('Colonia', Value);
end;

function TComercioExterior_Emisor_Domicilio.Get_Localidad: UnicodeString;
begin
  Result := AttributeNodes['Localidad'].Text;
end;

procedure TComercioExterior_Emisor_Domicilio.Set_Localidad(Value: UnicodeString);
begin
  SetAttribute('Localidad', Value);
end;

function TComercioExterior_Emisor_Domicilio.Get_Referencia: UnicodeString;
begin
  Result := AttributeNodes['Referencia'].Text;
end;

procedure TComercioExterior_Emisor_Domicilio.Set_Referencia(Value: UnicodeString);
begin
  SetAttribute('Referencia', Value);
end;

function TComercioExterior_Emisor_Domicilio.Get_Municipio: UnicodeString;
begin
  Result := AttributeNodes['Municipio'].Text;
end;

procedure TComercioExterior_Emisor_Domicilio.Set_Municipio(Value: UnicodeString);
begin
  SetAttribute('Municipio', Value);
end;

function TComercioExterior_Emisor_Domicilio.Get_Estado: UnicodeString;
begin
  Result := AttributeNodes['Estado'].Text;
end;

procedure TComercioExterior_Emisor_Domicilio.Set_Estado(Value: UnicodeString);
begin
  SetAttribute('Estado', Value);
end;

function TComercioExterior_Emisor_Domicilio.Get_Pais: UnicodeString;
begin
  Result := AttributeNodes['Pais'].Text;
end;

procedure TComercioExterior_Emisor_Domicilio.Set_Pais(Value: UnicodeString);
begin
  SetAttribute('Pais', Value);
end;

function TComercioExterior_Emisor_Domicilio.Get_CodigoPostal: UnicodeString;
begin
  Result := AttributeNodes['CodigoPostal'].Text;
end;

procedure TComercioExterior_Emisor_Domicilio.Set_CodigoPostal(Value: UnicodeString);
begin
  SetAttribute('CodigoPostal', Value);
end;

{ TComercioExterior_Propietario }

function TComercioExterior_Propietario.Get_NumRegIdTrib: UnicodeString;
begin
  Result := AttributeNodes['NumRegIdTrib'].Text;
end;

procedure TComercioExterior_Propietario.Set_NumRegIdTrib(Value: UnicodeString);
begin
  SetAttribute('NumRegIdTrib', Value);
end;

function TComercioExterior_Propietario.Get_ResidenciaFiscal: UnicodeString;
begin
  Result := AttributeNodes['ResidenciaFiscal'].Text;
end;

procedure TComercioExterior_Propietario.Set_ResidenciaFiscal(Value: UnicodeString);
begin
  SetAttribute('ResidenciaFiscal', Value);
end;

{ TComercioExterior_PropietarioList }

function TComercioExterior_PropietarioList.Add: IComercioExterior_Propietario;
begin
  Result := AddItem(-1) as IComercioExterior_Propietario;
end;

function TComercioExterior_PropietarioList.Insert(const Index: Integer): IComercioExterior_Propietario;
begin
  Result := AddItem(Index) as IComercioExterior_Propietario;
end;

function TComercioExterior_PropietarioList.Get_Item(Index: Integer): IComercioExterior_Propietario;
begin
  Result := List[Index] as IComercioExterior_Propietario;
end;

{ TComercioExterior_Receptor }

procedure TComercioExterior_Receptor.AfterConstruction;
begin
  RegisterChildNode('Domicilio', TComercioExterior_Receptor_Domicilio);
  inherited;
end;

function TComercioExterior_Receptor.Get_NumRegIdTrib: UnicodeString;
begin
  Result := AttributeNodes['NumRegIdTrib'].Text;
end;

procedure TComercioExterior_Receptor.Set_NumRegIdTrib(Value: UnicodeString);
begin
  SetAttribute('NumRegIdTrib', Value);
end;

function TComercioExterior_Receptor.Get_Domicilio: IComercioExterior_Receptor_Domicilio;
begin
  Result := ChildNodes['Domicilio'] as IComercioExterior_Receptor_Domicilio;
end;

{ TComercioExterior_Receptor_Domicilio }

function TComercioExterior_Receptor_Domicilio.Get_Calle: UnicodeString;
begin
  Result := AttributeNodes['Calle'].Text;
end;

procedure TComercioExterior_Receptor_Domicilio.Set_Calle(Value: UnicodeString);
begin
  SetAttribute('Calle', Value);
end;

function TComercioExterior_Receptor_Domicilio.Get_NumeroExterior: UnicodeString;
begin
  Result := AttributeNodes['NumeroExterior'].Text;
end;

procedure TComercioExterior_Receptor_Domicilio.Set_NumeroExterior(Value: UnicodeString);
begin
  SetAttribute('NumeroExterior', Value);
end;

function TComercioExterior_Receptor_Domicilio.Get_NumeroInterior: UnicodeString;
begin
  Result := AttributeNodes['NumeroInterior'].Text;
end;

procedure TComercioExterior_Receptor_Domicilio.Set_NumeroInterior(Value: UnicodeString);
begin
  SetAttribute('NumeroInterior', Value);
end;

function TComercioExterior_Receptor_Domicilio.Get_Colonia: UnicodeString;
begin
  Result := AttributeNodes['Colonia'].Text;
end;

procedure TComercioExterior_Receptor_Domicilio.Set_Colonia(Value: UnicodeString);
begin
  SetAttribute('Colonia', Value);
end;

function TComercioExterior_Receptor_Domicilio.Get_Localidad: UnicodeString;
begin
  Result := AttributeNodes['Localidad'].Text;
end;

procedure TComercioExterior_Receptor_Domicilio.Set_Localidad(Value: UnicodeString);
begin
  SetAttribute('Localidad', Value);
end;

function TComercioExterior_Receptor_Domicilio.Get_Referencia: UnicodeString;
begin
  Result := AttributeNodes['Referencia'].Text;
end;

procedure TComercioExterior_Receptor_Domicilio.Set_Referencia(Value: UnicodeString);
begin
  SetAttribute('Referencia', Value);
end;

function TComercioExterior_Receptor_Domicilio.Get_Municipio: UnicodeString;
begin
  Result := AttributeNodes['Municipio'].Text;
end;

procedure TComercioExterior_Receptor_Domicilio.Set_Municipio(Value: UnicodeString);
begin
  SetAttribute('Municipio', Value);
end;

function TComercioExterior_Receptor_Domicilio.Get_Estado: UnicodeString;
begin
  Result := AttributeNodes['Estado'].Text;
end;

procedure TComercioExterior_Receptor_Domicilio.Set_Estado(Value: UnicodeString);
begin
  SetAttribute('Estado', Value);
end;

function TComercioExterior_Receptor_Domicilio.Get_Pais: UnicodeString;
begin
  Result := AttributeNodes['Pais'].Text;
end;

procedure TComercioExterior_Receptor_Domicilio.Set_Pais(Value: UnicodeString);
begin
  SetAttribute('Pais', Value);
end;

function TComercioExterior_Receptor_Domicilio.Get_CodigoPostal: UnicodeString;
begin
  Result := AttributeNodes['CodigoPostal'].Text;
end;

procedure TComercioExterior_Receptor_Domicilio.Set_CodigoPostal(Value: UnicodeString);
begin
  SetAttribute('CodigoPostal', Value);
end;

{ TComercioExterior_Destinatario }

procedure TComercioExterior_Destinatario.AfterConstruction;
begin
  RegisterChildNode('Domicilio', TComercioExterior_Destinatario_Domicilio);
  ItemTag := 'Domicilio';
  ItemInterface := IComercioExterior_Destinatario_Domicilio;
  inherited;
end;

function TComercioExterior_Destinatario.Get_NumRegIdTrib: UnicodeString;
begin
  Result := AttributeNodes['NumRegIdTrib'].Text;
end;

procedure TComercioExterior_Destinatario.Set_NumRegIdTrib(Value: UnicodeString);
begin
  SetAttribute('NumRegIdTrib', Value);
end;

function TComercioExterior_Destinatario.Get_Nombre: UnicodeString;
begin
  Result := AttributeNodes['Nombre'].Text;
end;

procedure TComercioExterior_Destinatario.Set_Nombre(Value: UnicodeString);
begin
  SetAttribute('Nombre', Value);
end;

function TComercioExterior_Destinatario.Get_Domicilio(Index: Integer): IComercioExterior_Destinatario_Domicilio;
begin
  Result := List[Index] as IComercioExterior_Destinatario_Domicilio;
end;

function TComercioExterior_Destinatario.Add: IComercioExterior_Destinatario_Domicilio;
begin
  Result := AddItem(-1) as IComercioExterior_Destinatario_Domicilio;
end;

function TComercioExterior_Destinatario.Insert(const Index: Integer): IComercioExterior_Destinatario_Domicilio;
begin
  Result := AddItem(Index) as IComercioExterior_Destinatario_Domicilio;
end;

{ TComercioExterior_DestinatarioList }

function TComercioExterior_DestinatarioList.Add: IComercioExterior_Destinatario;
begin
  Result := AddItem(-1) as IComercioExterior_Destinatario;
end;

function TComercioExterior_DestinatarioList.Insert(const Index: Integer): IComercioExterior_Destinatario;
begin
  Result := AddItem(Index) as IComercioExterior_Destinatario;
end;

function TComercioExterior_DestinatarioList.Get_Item(Index: Integer): IComercioExterior_Destinatario;
begin
  Result := List[Index] as IComercioExterior_Destinatario;
end;

{ TComercioExterior_Destinatario_Domicilio }

function TComercioExterior_Destinatario_Domicilio.Get_Calle: UnicodeString;
begin
  Result := AttributeNodes['Calle'].Text;
end;

procedure TComercioExterior_Destinatario_Domicilio.Set_Calle(Value: UnicodeString);
begin
  SetAttribute('Calle', Value);
end;

function TComercioExterior_Destinatario_Domicilio.Get_NumeroExterior: UnicodeString;
begin
  Result := AttributeNodes['NumeroExterior'].Text;
end;

procedure TComercioExterior_Destinatario_Domicilio.Set_NumeroExterior(Value: UnicodeString);
begin
  SetAttribute('NumeroExterior', Value);
end;

function TComercioExterior_Destinatario_Domicilio.Get_NumeroInterior: UnicodeString;
begin
  Result := AttributeNodes['NumeroInterior'].Text;
end;

procedure TComercioExterior_Destinatario_Domicilio.Set_NumeroInterior(Value: UnicodeString);
begin
  SetAttribute('NumeroInterior', Value);
end;

function TComercioExterior_Destinatario_Domicilio.Get_Colonia: UnicodeString;
begin
  Result := AttributeNodes['Colonia'].Text;
end;

procedure TComercioExterior_Destinatario_Domicilio.Set_Colonia(Value: UnicodeString);
begin
  SetAttribute('Colonia', Value);
end;

function TComercioExterior_Destinatario_Domicilio.Get_Localidad: UnicodeString;
begin
  Result := AttributeNodes['Localidad'].Text;
end;

procedure TComercioExterior_Destinatario_Domicilio.Set_Localidad(Value: UnicodeString);
begin
  SetAttribute('Localidad', Value);
end;

function TComercioExterior_Destinatario_Domicilio.Get_Referencia: UnicodeString;
begin
  Result := AttributeNodes['Referencia'].Text;
end;

procedure TComercioExterior_Destinatario_Domicilio.Set_Referencia(Value: UnicodeString);
begin
  SetAttribute('Referencia', Value);
end;

function TComercioExterior_Destinatario_Domicilio.Get_Municipio: UnicodeString;
begin
  Result := AttributeNodes['Municipio'].Text;
end;

procedure TComercioExterior_Destinatario_Domicilio.Set_Municipio(Value: UnicodeString);
begin
  SetAttribute('Municipio', Value);
end;

function TComercioExterior_Destinatario_Domicilio.Get_Estado: UnicodeString;
begin
  Result := AttributeNodes['Estado'].Text;
end;

procedure TComercioExterior_Destinatario_Domicilio.Set_Estado(Value: UnicodeString);
begin
  SetAttribute('Estado', Value);
end;

function TComercioExterior_Destinatario_Domicilio.Get_Pais: UnicodeString;
begin
  Result := AttributeNodes['Pais'].Text;
end;

procedure TComercioExterior_Destinatario_Domicilio.Set_Pais(Value: UnicodeString);
begin
  SetAttribute('Pais', Value);
end;

function TComercioExterior_Destinatario_Domicilio.Get_CodigoPostal: UnicodeString;
begin
  Result := AttributeNodes['CodigoPostal'].Text;
end;

procedure TComercioExterior_Destinatario_Domicilio.Set_CodigoPostal(Value: UnicodeString);
begin
  SetAttribute('CodigoPostal', Value);
end;

{ TComercioExterior_Mercancias }

procedure TComercioExterior_Mercancias.AfterConstruction;
begin
  RegisterChildNode('Mercancia', TComercioExterior_Mercancias_Mercancia);
  ItemTag := 'Mercancia';
  ItemInterface := IComercioExterior_Mercancias_Mercancia;
  inherited;
end;

function TComercioExterior_Mercancias.Get_Mercancia(Index: Integer): IComercioExterior_Mercancias_Mercancia;
begin
  Result := List[Index] as IComercioExterior_Mercancias_Mercancia;
end;

function TComercioExterior_Mercancias.Add: IComercioExterior_Mercancias_Mercancia;
begin
  Result := AddItem(-1) as IComercioExterior_Mercancias_Mercancia;
end;

function TComercioExterior_Mercancias.Insert(const Index: Integer): IComercioExterior_Mercancias_Mercancia;
begin
  Result := AddItem(Index) as IComercioExterior_Mercancias_Mercancia;
end;

{ TComercioExterior_Mercancias_Mercancia }

procedure TComercioExterior_Mercancias_Mercancia.AfterConstruction;
begin
  RegisterChildNode('DescripcionesEspecificas', TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas);
  ItemTag := 'DescripcionesEspecificas';
  ItemInterface := IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas;
  inherited;
end;

function TComercioExterior_Mercancias_Mercancia.Get_NoIdentificacion: UnicodeString;
begin
  Result := AttributeNodes['NoIdentificacion'].Text;
end;

procedure TComercioExterior_Mercancias_Mercancia.Set_NoIdentificacion(Value: UnicodeString);
begin
  SetAttribute('NoIdentificacion', Value);
end;

function TComercioExterior_Mercancias_Mercancia.Get_FraccionArancelaria: UnicodeString;
begin
  Result := AttributeNodes['FraccionArancelaria'].Text;
end;

procedure TComercioExterior_Mercancias_Mercancia.Set_FraccionArancelaria(Value: UnicodeString);
begin
  SetAttribute('FraccionArancelaria', Value);
end;

function TComercioExterior_Mercancias_Mercancia.Get_CantidadAduana: UnicodeString;
begin
  Result := AttributeNodes['CantidadAduana'].Text;
end;

procedure TComercioExterior_Mercancias_Mercancia.Set_CantidadAduana(Value: UnicodeString);
begin
  SetAttribute('CantidadAduana', Value);
end;

function TComercioExterior_Mercancias_Mercancia.Get_UnidadAduana: UnicodeString;
begin
  Result := AttributeNodes['UnidadAduana'].Text;
end;

procedure TComercioExterior_Mercancias_Mercancia.Set_UnidadAduana(Value: UnicodeString);
begin
  SetAttribute('UnidadAduana', Value);
end;

function TComercioExterior_Mercancias_Mercancia.Get_ValorUnitarioAduana: UnicodeString;
begin
  Result := AttributeNodes['ValorUnitarioAduana'].Text;
end;

procedure TComercioExterior_Mercancias_Mercancia.Set_ValorUnitarioAduana(Value: UnicodeString);
begin
  SetAttribute('ValorUnitarioAduana', Value);
end;

function TComercioExterior_Mercancias_Mercancia.Get_ValorDolares: UnicodeString;
begin
  Result := AttributeNodes['ValorDolares'].Text;
end;

procedure TComercioExterior_Mercancias_Mercancia.Set_ValorDolares(Value: UnicodeString);
begin
  SetAttribute('ValorDolares', Value);
end;

function TComercioExterior_Mercancias_Mercancia.Get_DescripcionesEspecificas(Index: Integer): IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas;
begin
  Result := List[Index] as IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas;
end;

function TComercioExterior_Mercancias_Mercancia.Add: IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas;
begin
  Result := AddItem(-1) as IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas;
end;

function TComercioExterior_Mercancias_Mercancia.Insert(const Index: Integer): IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas;
begin
  Result := AddItem(Index) as IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas;
end;

{ TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas }

function TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas.Get_Marca: UnicodeString;
begin
  Result := AttributeNodes['Marca'].Text;
end;

procedure TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas.Set_Marca(Value: UnicodeString);
begin
  SetAttribute('Marca', Value);
end;

function TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas.Get_Modelo: UnicodeString;
begin
  Result := AttributeNodes['Modelo'].Text;
end;

procedure TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas.Set_Modelo(Value: UnicodeString);
begin
  SetAttribute('Modelo', Value);
end;

function TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas.Get_SubModelo: UnicodeString;
begin
  Result := AttributeNodes['SubModelo'].Text;
end;

procedure TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas.Set_SubModelo(Value: UnicodeString);
begin
  SetAttribute('SubModelo', Value);
end;

function TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas.Get_NumeroSerie: UnicodeString;
begin
  Result := AttributeNodes['NumeroSerie'].Text;
end;

procedure TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificas.Set_NumeroSerie(Value: UnicodeString);
begin
  SetAttribute('NumeroSerie', Value);
end;

end.