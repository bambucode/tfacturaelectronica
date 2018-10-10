
{****************************************************************************************************************}
{                                                                                                                }
{                                          XML Data Binding                                                      }
{                                                                                                                }
{         Generated on: 11/09/2018 07:33:50 p. m.                                                                }
{       Generated from: http://www.sat.gob.mx/sitio_internet/cfd/ComercioExterior11/ComercioExterior11.xsd       }
{                                                                                                                }
{****************************************************************************************************************}

unit Facturacion.ComplementoComercioExteriorV11;

interface

uses xmldom, XMLDoc, XMLIntf, Facturacion.Comprobante;

type

{ Forward Decls }

  IComercioExteriorV11 = interface;
  IComercioExteriorV11_Emisor = interface;
  IComercioExteriorV11_Emisor_Domicilio = interface;
  IComercioExteriorV11_Propietario = interface;
  IComercioExteriorV11_PropietarioList = interface;
  IComercioExteriorV11_Receptor = interface;
  IComercioExteriorV11_Receptor_Domicilio = interface;
  IComercioExteriorV11_Destinatario = interface;
  IComercioExteriorV11_DestinatarioList = interface;
  IComercioExteriorV11_Destinatario_Domicilio = interface;
  IComercioExteriorV11_Mercancias = interface;
  IComercioExteriorV11_Mercancias_Mercancia = interface;
  IComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas = interface;

{ IComercioExterior }

  IComercioExteriorV11 = interface(IXMLNode)
    ['{FAAD7239-1E31-4EE1-A5DB-CBE5E2305096}']
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
    function Get_Emisor: IComercioExteriorV11_Emisor;
    function Get_Propietario: IComercioExteriorV11_PropietarioList;
    function Get_Receptor: IComercioExteriorV11_Receptor;
    function Get_Destinatario: IComercioExteriorV11_DestinatarioList;
    function Get_Mercancias: IComercioExteriorV11_Mercancias;
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
    property Emisor: IComercioExteriorV11_Emisor read Get_Emisor;
    property Propietario: IComercioExteriorV11_PropietarioList read Get_Propietario;
    property Receptor: IComercioExteriorV11_Receptor read Get_Receptor;
    property Destinatario: IComercioExteriorV11_DestinatarioList read Get_Destinatario;
    property Mercancias: IComercioExteriorV11_Mercancias read Get_Mercancias;
  end;

{ IComercioExteriorV11_Emisor }

  IComercioExteriorV11_Emisor = interface(IXMLNode)
    ['{5E7EF1CD-2292-407C-B06A-7F3BBBE0C3D9}']
    { Property Accessors }
    function Get_Curp: UnicodeString;
    function Get_Domicilio: IComercioExteriorV11_Emisor_Domicilio;
    procedure Set_Curp(Value: UnicodeString);
    { Methods & Properties }
    property Curp: UnicodeString read Get_Curp write Set_Curp;
    property Domicilio: IComercioExteriorV11_Emisor_Domicilio read Get_Domicilio;
  end;

{ IComercioExteriorV11_Emisor_Domicilio }

  IComercioExteriorV11_Emisor_Domicilio = interface(IXMLNode)
    ['{A93737C3-DC72-4A8F-88AB-C825662644CD}']
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

{ IComercioExteriorV11_Propietario }

  IComercioExteriorV11_Propietario = interface(IXMLNode)
    ['{63FACE0F-0CD1-42B4-8B58-897859329863}']
    { Property Accessors }
    function Get_NumRegIdTrib: UnicodeString;
    function Get_ResidenciaFiscal: UnicodeString;
    procedure Set_NumRegIdTrib(Value: UnicodeString);
    procedure Set_ResidenciaFiscal(Value: UnicodeString);
    { Methods & Properties }
    property NumRegIdTrib: UnicodeString read Get_NumRegIdTrib write Set_NumRegIdTrib;
    property ResidenciaFiscal: UnicodeString read Get_ResidenciaFiscal write Set_ResidenciaFiscal;
  end;

{ IComercioExteriorV11_PropietarioList }

  IComercioExteriorV11_PropietarioList = interface(IXMLNodeCollection)
    ['{87EFC71C-A1AC-44C3-AAF1-C3271951DCA0}']
    { Methods & Properties }
    function Add: IComercioExteriorV11_Propietario;
    function Insert(const Index: Integer): IComercioExteriorV11_Propietario;

    function Get_Item(Index: Integer): IComercioExteriorV11_Propietario;
    property Items[Index: Integer]: IComercioExteriorV11_Propietario read Get_Item; default;
  end;

{ IComercioExteriorV11_Receptor }

  IComercioExteriorV11_Receptor = interface(IXMLNode)
    ['{3AEB4BBB-A3D7-459B-9D32-79BEB996E9D7}']
    { Property Accessors }
    function Get_NumRegIdTrib: UnicodeString;
    function Get_Domicilio: IComercioExteriorV11_Receptor_Domicilio;
    procedure Set_NumRegIdTrib(Value: UnicodeString);
    { Methods & Properties }
    property NumRegIdTrib: UnicodeString read Get_NumRegIdTrib write Set_NumRegIdTrib;
    property Domicilio: IComercioExteriorV11_Receptor_Domicilio read Get_Domicilio;
  end;

{ IComercioExteriorV11_Receptor_Domicilio }

  IComercioExteriorV11_Receptor_Domicilio = interface(IXMLNode)
    ['{1057F994-1A8A-4FDC-9ADB-57B1D97F9C9E}']
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

{ IComercioExteriorV11_Destinatario }

  IComercioExteriorV11_Destinatario = interface(IXMLNodeCollection)
    ['{8ED925B3-087B-4333-B175-88DBA526F622}']
    { Property Accessors }
    function Get_NumRegIdTrib: UnicodeString;
    function Get_Nombre: UnicodeString;
    function Get_Domicilio(Index: Integer): IComercioExteriorV11_Destinatario_Domicilio;
    procedure Set_NumRegIdTrib(Value: UnicodeString);
    procedure Set_Nombre(Value: UnicodeString);
    { Methods & Properties }
    function Add: IComercioExteriorV11_Destinatario_Domicilio;
    function Insert(const Index: Integer): IComercioExteriorV11_Destinatario_Domicilio;
    property NumRegIdTrib: UnicodeString read Get_NumRegIdTrib write Set_NumRegIdTrib;
    property Nombre: UnicodeString read Get_Nombre write Set_Nombre;
    property Domicilio[Index: Integer]: IComercioExteriorV11_Destinatario_Domicilio read Get_Domicilio; default;
  end;

{ IComercioExteriorV11_DestinatarioList }

  IComercioExteriorV11_DestinatarioList = interface(IXMLNodeCollection)
    ['{038C8B96-5628-4437-AB1A-CB1F70F6C17D}']
    { Methods & Properties }
    function Add: IComercioExteriorV11_Destinatario;
    function Insert(const Index: Integer): IComercioExteriorV11_Destinatario;

    function Get_Item(Index: Integer): IComercioExteriorV11_Destinatario;
    property Items[Index: Integer]: IComercioExteriorV11_Destinatario read Get_Item; default;
  end;

{ IComercioExteriorV11_Destinatario_Domicilio }

  IComercioExteriorV11_Destinatario_Domicilio = interface(IXMLNode)
    ['{EEEABB6E-7269-4C5E-A479-12758F2FDF79}']
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

{ IComercioExteriorV11_Mercancias }

  IComercioExteriorV11_Mercancias = interface(IXMLNodeCollection)
    ['{5CD77B30-4A67-4809-A397-60405A5691D8}']
    { Property Accessors }
    function Get_Mercancia(Index: Integer): IComercioExteriorV11_Mercancias_Mercancia;
    { Methods & Properties }
    function Add: IComercioExteriorV11_Mercancias_Mercancia;
    function Insert(const Index: Integer): IComercioExteriorV11_Mercancias_Mercancia;
    property Mercancia[Index: Integer]: IComercioExteriorV11_Mercancias_Mercancia read Get_Mercancia; default;
  end;

{ IComercioExteriorV11_Mercancias_Mercancia }

  IComercioExteriorV11_Mercancias_Mercancia = interface(IXMLNodeCollection)
    ['{ADE4925B-D2EB-4D80-B831-66D75966D1D5}']
    { Property Accessors }
    function Get_NoIdentificacion: UnicodeString;
    function Get_FraccionArancelaria: UnicodeString;
    function Get_CantidadAduana: UnicodeString;
    function Get_UnidadAduana: UnicodeString;
    function Get_ValorUnitarioAduana: UnicodeString;
    function Get_ValorDolares: UnicodeString;
    function Get_DescripcionesEspecificas(Index: Integer): IComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas;
    procedure Set_NoIdentificacion(Value: UnicodeString);
    procedure Set_FraccionArancelaria(Value: UnicodeString);
    procedure Set_CantidadAduana(Value: UnicodeString);
    procedure Set_UnidadAduana(Value: UnicodeString);
    procedure Set_ValorUnitarioAduana(Value: UnicodeString);
    procedure Set_ValorDolares(Value: UnicodeString);
    { Methods & Properties }
    function Add: IComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas;
    function Insert(const Index: Integer): IComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas;
    property NoIdentificacion: UnicodeString read Get_NoIdentificacion write Set_NoIdentificacion;
    property FraccionArancelaria: UnicodeString read Get_FraccionArancelaria write Set_FraccionArancelaria;
    property CantidadAduana: UnicodeString read Get_CantidadAduana write Set_CantidadAduana;
    property UnidadAduana: UnicodeString read Get_UnidadAduana write Set_UnidadAduana;
    property ValorUnitarioAduana: UnicodeString read Get_ValorUnitarioAduana write Set_ValorUnitarioAduana;
    property ValorDolares: UnicodeString read Get_ValorDolares write Set_ValorDolares;
    property DescripcionesEspecificas[Index: Integer]: IComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas read Get_DescripcionesEspecificas; default;
  end;

{ IComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas }

  IComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas = interface(IXMLNode)
    ['{FD2DFDA2-3DC2-4855-83C0-59522729D4F7}']
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

  TComercioExteriorV11 = class;
  TComercioExteriorV11_Emisor = class;
  TComercioExteriorV11_Emisor_Domicilio = class;
  TComercioExteriorV11_Propietario = class;
  TComercioExteriorV11_PropietarioList = class;
  TComercioExteriorV11_Receptor = class;
  TComercioExteriorV11_Receptor_Domicilio = class;
  TComercioExteriorV11_Destinatario = class;
  TComercioExteriorV11_DestinatarioList = class;
  TComercioExteriorV11_Destinatario_Domicilio = class;
  TComercioExteriorV11_Mercancias = class;
  TComercioExteriorV11_Mercancias_Mercancia = class;
  TComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas = class;

{ TComercioExterior }

  TComercioExteriorV11 = class(TXMLNode, IComercioExteriorV11)
  private
    FPropietario: IComercioExteriorV11_PropietarioList;
    FDestinatario: IComercioExteriorV11_DestinatarioList;
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
    function Get_Emisor: IComercioExteriorV11_Emisor;
    function Get_Propietario: IComercioExteriorV11_PropietarioList;
    function Get_Receptor: IComercioExteriorV11_Receptor;
    function Get_Destinatario: IComercioExteriorV11_DestinatarioList;
    function Get_Mercancias: IComercioExteriorV11_Mercancias;
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

{ TComercioExteriorV11_Emisor }

  TComercioExteriorV11_Emisor = class(TXMLNode, IComercioExteriorV11_Emisor)
  protected
    { IComercioExteriorV11_Emisor }
    function Get_Curp: UnicodeString;
    function Get_Domicilio: IComercioExteriorV11_Emisor_Domicilio;
    procedure Set_Curp(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TComercioExteriorV11_Emisor_Domicilio }

  TComercioExteriorV11_Emisor_Domicilio = class(TXMLNode, IComercioExteriorV11_Emisor_Domicilio)
  protected
    { IComercioExteriorV11_Emisor_Domicilio }
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

{ TComercioExteriorV11_Propietario }

  TComercioExteriorV11_Propietario = class(TXMLNode, IComercioExteriorV11_Propietario)
  protected
    { IComercioExteriorV11_Propietario }
    function Get_NumRegIdTrib: UnicodeString;
    function Get_ResidenciaFiscal: UnicodeString;
    procedure Set_NumRegIdTrib(Value: UnicodeString);
    procedure Set_ResidenciaFiscal(Value: UnicodeString);
  end;

{ TComercioExteriorV11_PropietarioList }

  TComercioExteriorV11_PropietarioList = class(TXMLNodeCollection, IComercioExteriorV11_PropietarioList)
  protected
    { IComercioExteriorV11_PropietarioList }
    function Add: IComercioExteriorV11_Propietario;
    function Insert(const Index: Integer): IComercioExteriorV11_Propietario;

    function Get_Item(Index: Integer): IComercioExteriorV11_Propietario;
  end;

{ TComercioExteriorV11_Receptor }

  TComercioExteriorV11_Receptor = class(TXMLNode, IComercioExteriorV11_Receptor)
  protected
    { IComercioExteriorV11_Receptor }
    function Get_NumRegIdTrib: UnicodeString;
    function Get_Domicilio: IComercioExteriorV11_Receptor_Domicilio;
    procedure Set_NumRegIdTrib(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TComercioExteriorV11_Receptor_Domicilio }

  TComercioExteriorV11_Receptor_Domicilio = class(TXMLNode, IComercioExteriorV11_Receptor_Domicilio)
  protected
    { IComercioExteriorV11_Receptor_Domicilio }
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

{ TComercioExteriorV11_Destinatario }

  TComercioExteriorV11_Destinatario = class(TXMLNodeCollection, IComercioExteriorV11_Destinatario)
  protected
    { IComercioExteriorV11_Destinatario }
    function Get_NumRegIdTrib: UnicodeString;
    function Get_Nombre: UnicodeString;
    function Get_Domicilio(Index: Integer): IComercioExteriorV11_Destinatario_Domicilio;
    procedure Set_NumRegIdTrib(Value: UnicodeString);
    procedure Set_Nombre(Value: UnicodeString);
    function Add: IComercioExteriorV11_Destinatario_Domicilio;
    function Insert(const Index: Integer): IComercioExteriorV11_Destinatario_Domicilio;
  public
    procedure AfterConstruction; override;
  end;

{ TComercioExteriorV11_DestinatarioList }

  TComercioExteriorV11_DestinatarioList = class(TXMLNodeCollection, IComercioExteriorV11_DestinatarioList)
  protected
    { IComercioExteriorV11_DestinatarioList }
    function Add: IComercioExteriorV11_Destinatario;
    function Insert(const Index: Integer): IComercioExteriorV11_Destinatario;

    function Get_Item(Index: Integer): IComercioExteriorV11_Destinatario;
  end;

{ TComercioExteriorV11_Destinatario_Domicilio }

  TComercioExteriorV11_Destinatario_Domicilio = class(TXMLNode, IComercioExteriorV11_Destinatario_Domicilio)
  protected
    { IComercioExteriorV11_Destinatario_Domicilio }
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

{ TComercioExteriorV11_Mercancias }

  TComercioExteriorV11_Mercancias = class(TXMLNodeCollection, IComercioExteriorV11_Mercancias)
  protected
    { IComercioExteriorV11_Mercancias }
    function Get_Mercancia(Index: Integer): IComercioExteriorV11_Mercancias_Mercancia;
    function Add: IComercioExteriorV11_Mercancias_Mercancia;
    function Insert(const Index: Integer): IComercioExteriorV11_Mercancias_Mercancia;
  public
    procedure AfterConstruction; override;
  end;

{ TComercioExteriorV11_Mercancias_Mercancia }

  TComercioExteriorV11_Mercancias_Mercancia = class(TXMLNodeCollection, IComercioExteriorV11_Mercancias_Mercancia)
  protected
    { IComercioExteriorV11_Mercancias_Mercancia }
    function Get_NoIdentificacion: UnicodeString;
    function Get_FraccionArancelaria: UnicodeString;
    function Get_CantidadAduana: UnicodeString;
    function Get_UnidadAduana: UnicodeString;
    function Get_ValorUnitarioAduana: UnicodeString;
    function Get_ValorDolares: UnicodeString;
    function Get_DescripcionesEspecificas(Index: Integer): IComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas;
    procedure Set_NoIdentificacion(Value: UnicodeString);
    procedure Set_FraccionArancelaria(Value: UnicodeString);
    procedure Set_CantidadAduana(Value: UnicodeString);
    procedure Set_UnidadAduana(Value: UnicodeString);
    procedure Set_ValorUnitarioAduana(Value: UnicodeString);
    procedure Set_ValorDolares(Value: UnicodeString);
    function Add: IComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas;
    function Insert(const Index: Integer): IComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas;
  public
    procedure AfterConstruction; override;
  end;

{ TComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas }

  TComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas = class(TXMLNode, IComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas)
  protected
    { IComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas }
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

function GetComercioExteriorV11(Doc: IXMLDocument): IComercioExteriorV11;
function LoadComercioExteriorV11(const FileName: string): IComercioExteriorV11;
function LoadComercioExteriorDataV11(const aXML: string): IComercioExteriorV11;
function NewComercioExteriorV11: IComercioExteriorV11;

const
  TargetNamespace = 'http://www.sat.gob.mx/ComercioExterior11';

implementation

{ Global Functions }

function GetComercioExteriorV11(Doc: IXMLDocument): IComercioExteriorV11;
begin
  Result := Doc.GetDocBinding('cce11:ComercioExterior', TComercioExteriorV11, TargetNamespace) as IComercioExteriorV11;
end;

function LoadComercioExteriorV11(const FileName: string): IComercioExteriorV11;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('cce11:ComercioExterior', TComercioExteriorV11, TargetNamespace) as IComercioExteriorV11;
end;

function LoadComercioExteriorDataV11(const aXML: string): IComercioExteriorV11;
begin
  Result := LoadXMLData(AXml).GetDocBinding('cce11:ComercioExterior', TComercioExteriorV11, TargetNamespace) as IComercioExteriorV11;
end;

function NewComercioExteriorV11: IComercioExteriorV11;
begin
  Result := NewXMLDocument.GetDocBinding('cce11:ComercioExterior', TComercioExteriorV11, TargetNamespace) as IComercioExteriorV11;
end;

{ TComercioExterior }

procedure TComercioExteriorV11.AfterConstruction;
begin
  if (Self.AttributeNodes.FindNode('Version') = nil) then
      Self.Set_Version('1.1');
  RegisterChildNode('Emisor', TComercioExteriorV11_Emisor);
  RegisterChildNode('Propietario', TComercioExteriorV11_Propietario);
  RegisterChildNode('Receptor', TComercioExteriorV11_Receptor);
  RegisterChildNode('Destinatario', TComercioExteriorV11_Destinatario);
  RegisterChildNode('Mercancias', TComercioExteriorV11_Mercancias);
  FPropietario := CreateCollection(TComercioExteriorV11_PropietarioList, IComercioExteriorV11_Propietario, 'Propietario') as IComercioExteriorV11_PropietarioList;
  FDestinatario := CreateCollection(TComercioExteriorV11_DestinatarioList, IComercioExteriorV11_Destinatario, 'Destinatario') as IComercioExteriorV11_DestinatarioList;
  inherited;
end;

function TComercioExteriorV11.Get_Version: UnicodeString;
begin
  Result := AttributeNodes['Version'].Text;
end;

procedure TComercioExteriorV11.Set_Version(Value: UnicodeString);
begin
  SetAttribute('Version', Value);
end;

function TComercioExteriorV11.Get_MotivoTraslado: UnicodeString;
begin
  Result := AttributeNodes['MotivoTraslado'].Text;
end;

procedure TComercioExteriorV11.Set_MotivoTraslado(Value: UnicodeString);
begin
  SetAttribute('MotivoTraslado', Value);
end;

function TComercioExteriorV11.Get_TipoOperacion: UnicodeString;
begin
  Result := AttributeNodes['TipoOperacion'].Text;
end;

procedure TComercioExteriorV11.Set_TipoOperacion(Value: UnicodeString);
begin
  SetAttribute('TipoOperacion', Value);
end;

function TComercioExteriorV11.Get_ClaveDePedimento: UnicodeString;
begin
  Result := AttributeNodes['ClaveDePedimento'].Text;
end;

procedure TComercioExteriorV11.Set_ClaveDePedimento(Value: UnicodeString);
begin
  SetAttribute('ClaveDePedimento', Value);
end;

function TComercioExteriorV11.Get_CertificadoOrigen: Integer;
begin
  Result := AttributeNodes['CertificadoOrigen'].NodeValue;
end;

procedure TComercioExteriorV11.Set_CertificadoOrigen(Value: Integer);
begin
  SetAttribute('CertificadoOrigen', Value);
end;

function TComercioExteriorV11.Get_NumCertificadoOrigen: UnicodeString;
begin
  Result := AttributeNodes['NumCertificadoOrigen'].Text;
end;

procedure TComercioExteriorV11.Set_NumCertificadoOrigen(Value: UnicodeString);
begin
  SetAttribute('NumCertificadoOrigen', Value);
end;

function TComercioExteriorV11.Get_NumeroExportadorConfiable: UnicodeString;
begin
  Result := AttributeNodes['NumeroExportadorConfiable'].Text;
end;

procedure TComercioExteriorV11.Set_NumeroExportadorConfiable(Value: UnicodeString);
begin
  SetAttribute('NumeroExportadorConfiable', Value);
end;

function TComercioExteriorV11.Get_Incoterm: UnicodeString;
begin
  Result := AttributeNodes['Incoterm'].Text;
end;

procedure TComercioExteriorV11.Set_Incoterm(Value: UnicodeString);
begin
  SetAttribute('Incoterm', Value);
end;

function TComercioExteriorV11.Get_Subdivision: Integer;
begin
  Result := AttributeNodes['Subdivision'].NodeValue;
end;

procedure TComercioExteriorV11.Set_Subdivision(Value: Integer);
begin
  SetAttribute('Subdivision', Value);
end;

function TComercioExteriorV11.Get_Observaciones: UnicodeString;
begin
  Result := AttributeNodes['Observaciones'].Text;
end;

procedure TComercioExteriorV11.Set_Observaciones(Value: UnicodeString);
begin
  SetAttribute('Observaciones', Value);
end;

function TComercioExteriorV11.Get_TipoCambioUSD: UnicodeString;
begin
  Result := AttributeNodes['TipoCambioUSD'].Text;
end;

procedure TComercioExteriorV11.Set_TipoCambioUSD(Value: UnicodeString);
begin
  SetAttribute('TipoCambioUSD', Value);
end;

function TComercioExteriorV11.Get_TotalUSD: UnicodeString;
begin
  Result := AttributeNodes['TotalUSD'].Text;
end;

procedure TComercioExteriorV11.Set_TotalUSD(Value: UnicodeString);
begin
  SetAttribute('TotalUSD', Value);
end;

function TComercioExteriorV11.Get_Emisor: IComercioExteriorV11_Emisor;
begin
  Result := ChildNodes['Emisor'] as IComercioExteriorV11_Emisor;
end;

function TComercioExteriorV11.Get_Propietario: IComercioExteriorV11_PropietarioList;
begin
  Result := FPropietario;
end;

function TComercioExteriorV11.Get_Receptor: IComercioExteriorV11_Receptor;
begin
  Result := ChildNodes['Receptor'] as IComercioExteriorV11_Receptor;
end;

function TComercioExteriorV11.Get_Destinatario: IComercioExteriorV11_DestinatarioList;
begin
  Result := FDestinatario;
end;

function TComercioExteriorV11.Get_Mercancias: IComercioExteriorV11_Mercancias;
begin
  Result := ChildNodes['Mercancias'] as IComercioExteriorV11_Mercancias;
end;

{ TComercioExteriorV11_Emisor }

procedure TComercioExteriorV11_Emisor.AfterConstruction;
begin
  RegisterChildNode('Domicilio', TComercioExteriorV11_Emisor_Domicilio);
  inherited;
end;

function TComercioExteriorV11_Emisor.Get_Curp: UnicodeString;
begin
  Result := AttributeNodes['Curp'].Text;
end;

procedure TComercioExteriorV11_Emisor.Set_Curp(Value: UnicodeString);
begin
  SetAttribute('Curp', Value);
end;

function TComercioExteriorV11_Emisor.Get_Domicilio: IComercioExteriorV11_Emisor_Domicilio;
begin
  Result := ChildNodes['Domicilio'] as IComercioExteriorV11_Emisor_Domicilio;
end;

{ TComercioExteriorV11_Emisor_Domicilio }

function TComercioExteriorV11_Emisor_Domicilio.Get_Calle: UnicodeString;
begin
  Result := AttributeNodes['Calle'].Text;
end;

procedure TComercioExteriorV11_Emisor_Domicilio.Set_Calle(Value: UnicodeString);
begin
  SetAttribute('Calle', Value);
end;

function TComercioExteriorV11_Emisor_Domicilio.Get_NumeroExterior: UnicodeString;
begin
  Result := AttributeNodes['NumeroExterior'].Text;
end;

procedure TComercioExteriorV11_Emisor_Domicilio.Set_NumeroExterior(Value: UnicodeString);
begin
  SetAttribute('NumeroExterior', Value);
end;

function TComercioExteriorV11_Emisor_Domicilio.Get_NumeroInterior: UnicodeString;
begin
  Result := AttributeNodes['NumeroInterior'].Text;
end;

procedure TComercioExteriorV11_Emisor_Domicilio.Set_NumeroInterior(Value: UnicodeString);
begin
  SetAttribute('NumeroInterior', Value);
end;

function TComercioExteriorV11_Emisor_Domicilio.Get_Colonia: UnicodeString;
begin
  Result := AttributeNodes['Colonia'].Text;
end;

procedure TComercioExteriorV11_Emisor_Domicilio.Set_Colonia(Value: UnicodeString);
begin
  SetAttribute('Colonia', Value);
end;

function TComercioExteriorV11_Emisor_Domicilio.Get_Localidad: UnicodeString;
begin
  Result := AttributeNodes['Localidad'].Text;
end;

procedure TComercioExteriorV11_Emisor_Domicilio.Set_Localidad(Value: UnicodeString);
begin
  SetAttribute('Localidad', Value);
end;

function TComercioExteriorV11_Emisor_Domicilio.Get_Referencia: UnicodeString;
begin
  Result := AttributeNodes['Referencia'].Text;
end;

procedure TComercioExteriorV11_Emisor_Domicilio.Set_Referencia(Value: UnicodeString);
begin
  SetAttribute('Referencia', Value);
end;

function TComercioExteriorV11_Emisor_Domicilio.Get_Municipio: UnicodeString;
begin
  Result := AttributeNodes['Municipio'].Text;
end;

procedure TComercioExteriorV11_Emisor_Domicilio.Set_Municipio(Value: UnicodeString);
begin
  SetAttribute('Municipio', Value);
end;

function TComercioExteriorV11_Emisor_Domicilio.Get_Estado: UnicodeString;
begin
  Result := AttributeNodes['Estado'].Text;
end;

procedure TComercioExteriorV11_Emisor_Domicilio.Set_Estado(Value: UnicodeString);
begin
  SetAttribute('Estado', Value);
end;

function TComercioExteriorV11_Emisor_Domicilio.Get_Pais: UnicodeString;
begin
  Result := AttributeNodes['Pais'].Text;
end;

procedure TComercioExteriorV11_Emisor_Domicilio.Set_Pais(Value: UnicodeString);
begin
  SetAttribute('Pais', Value);
end;

function TComercioExteriorV11_Emisor_Domicilio.Get_CodigoPostal: UnicodeString;
begin
  Result := AttributeNodes['CodigoPostal'].Text;
end;

procedure TComercioExteriorV11_Emisor_Domicilio.Set_CodigoPostal(Value: UnicodeString);
begin
  SetAttribute('CodigoPostal', Value);
end;

{ TComercioExteriorV11_Propietario }

function TComercioExteriorV11_Propietario.Get_NumRegIdTrib: UnicodeString;
begin
  Result := AttributeNodes['NumRegIdTrib'].Text;
end;

procedure TComercioExteriorV11_Propietario.Set_NumRegIdTrib(Value: UnicodeString);
begin
  SetAttribute('NumRegIdTrib', Value);
end;

function TComercioExteriorV11_Propietario.Get_ResidenciaFiscal: UnicodeString;
begin
  Result := AttributeNodes['ResidenciaFiscal'].Text;
end;

procedure TComercioExteriorV11_Propietario.Set_ResidenciaFiscal(Value: UnicodeString);
begin
  SetAttribute('ResidenciaFiscal', Value);
end;

{ TComercioExteriorV11_PropietarioList }

function TComercioExteriorV11_PropietarioList.Add: IComercioExteriorV11_Propietario;
begin
  Result := AddItem(-1) as IComercioExteriorV11_Propietario;
end;

function TComercioExteriorV11_PropietarioList.Insert(const Index: Integer): IComercioExteriorV11_Propietario;
begin
  Result := AddItem(Index) as IComercioExteriorV11_Propietario;
end;

function TComercioExteriorV11_PropietarioList.Get_Item(Index: Integer): IComercioExteriorV11_Propietario;
begin
  Result := List[Index] as IComercioExteriorV11_Propietario;
end;

{ TComercioExteriorV11_Receptor }

procedure TComercioExteriorV11_Receptor.AfterConstruction;
begin
  RegisterChildNode('Domicilio', TComercioExteriorV11_Receptor_Domicilio);
  inherited;
end;

function TComercioExteriorV11_Receptor.Get_NumRegIdTrib: UnicodeString;
begin
  Result := AttributeNodes['NumRegIdTrib'].Text;
end;

procedure TComercioExteriorV11_Receptor.Set_NumRegIdTrib(Value: UnicodeString);
begin
  SetAttribute('NumRegIdTrib', Value);
end;

function TComercioExteriorV11_Receptor.Get_Domicilio: IComercioExteriorV11_Receptor_Domicilio;
begin
  Result := ChildNodes['Domicilio'] as IComercioExteriorV11_Receptor_Domicilio;
end;

{ TComercioExteriorV11_Receptor_Domicilio }

function TComercioExteriorV11_Receptor_Domicilio.Get_Calle: UnicodeString;
begin
  Result := AttributeNodes['Calle'].Text;
end;

procedure TComercioExteriorV11_Receptor_Domicilio.Set_Calle(Value: UnicodeString);
begin
  SetAttribute('Calle', Value);
end;

function TComercioExteriorV11_Receptor_Domicilio.Get_NumeroExterior: UnicodeString;
begin
  Result := AttributeNodes['NumeroExterior'].Text;
end;

procedure TComercioExteriorV11_Receptor_Domicilio.Set_NumeroExterior(Value: UnicodeString);
begin
  SetAttribute('NumeroExterior', Value);
end;

function TComercioExteriorV11_Receptor_Domicilio.Get_NumeroInterior: UnicodeString;
begin
  Result := AttributeNodes['NumeroInterior'].Text;
end;

procedure TComercioExteriorV11_Receptor_Domicilio.Set_NumeroInterior(Value: UnicodeString);
begin
  SetAttribute('NumeroInterior', Value);
end;

function TComercioExteriorV11_Receptor_Domicilio.Get_Colonia: UnicodeString;
begin
  Result := AttributeNodes['Colonia'].Text;
end;

procedure TComercioExteriorV11_Receptor_Domicilio.Set_Colonia(Value: UnicodeString);
begin
  SetAttribute('Colonia', Value);
end;

function TComercioExteriorV11_Receptor_Domicilio.Get_Localidad: UnicodeString;
begin
  Result := AttributeNodes['Localidad'].Text;
end;

procedure TComercioExteriorV11_Receptor_Domicilio.Set_Localidad(Value: UnicodeString);
begin
  SetAttribute('Localidad', Value);
end;

function TComercioExteriorV11_Receptor_Domicilio.Get_Referencia: UnicodeString;
begin
  Result := AttributeNodes['Referencia'].Text;
end;

procedure TComercioExteriorV11_Receptor_Domicilio.Set_Referencia(Value: UnicodeString);
begin
  SetAttribute('Referencia', Value);
end;

function TComercioExteriorV11_Receptor_Domicilio.Get_Municipio: UnicodeString;
begin
  Result := AttributeNodes['Municipio'].Text;
end;

procedure TComercioExteriorV11_Receptor_Domicilio.Set_Municipio(Value: UnicodeString);
begin
  SetAttribute('Municipio', Value);
end;

function TComercioExteriorV11_Receptor_Domicilio.Get_Estado: UnicodeString;
begin
  Result := AttributeNodes['Estado'].Text;
end;

procedure TComercioExteriorV11_Receptor_Domicilio.Set_Estado(Value: UnicodeString);
begin
  SetAttribute('Estado', Value);
end;

function TComercioExteriorV11_Receptor_Domicilio.Get_Pais: UnicodeString;
begin
  Result := AttributeNodes['Pais'].Text;
end;

procedure TComercioExteriorV11_Receptor_Domicilio.Set_Pais(Value: UnicodeString);
begin
  SetAttribute('Pais', Value);
end;

function TComercioExteriorV11_Receptor_Domicilio.Get_CodigoPostal: UnicodeString;
begin
  Result := AttributeNodes['CodigoPostal'].Text;
end;

procedure TComercioExteriorV11_Receptor_Domicilio.Set_CodigoPostal(Value: UnicodeString);
begin
  SetAttribute('CodigoPostal', Value);
end;

{ TComercioExteriorV11_Destinatario }

procedure TComercioExteriorV11_Destinatario.AfterConstruction;
begin
  RegisterChildNode('Domicilio', TComercioExteriorV11_Destinatario_Domicilio);
  ItemTag := 'Domicilio';
  ItemInterface := IComercioExteriorV11_Destinatario_Domicilio;
  inherited;
end;

function TComercioExteriorV11_Destinatario.Get_NumRegIdTrib: UnicodeString;
begin
  Result := AttributeNodes['NumRegIdTrib'].Text;
end;

procedure TComercioExteriorV11_Destinatario.Set_NumRegIdTrib(Value: UnicodeString);
begin
  SetAttribute('NumRegIdTrib', Value);
end;

function TComercioExteriorV11_Destinatario.Get_Nombre: UnicodeString;
begin
  Result := AttributeNodes['Nombre'].Text;
end;

procedure TComercioExteriorV11_Destinatario.Set_Nombre(Value: UnicodeString);
begin
  SetAttribute('Nombre', Value);
end;

function TComercioExteriorV11_Destinatario.Get_Domicilio(Index: Integer): IComercioExteriorV11_Destinatario_Domicilio;
begin
  Result := List[Index] as IComercioExteriorV11_Destinatario_Domicilio;
end;

function TComercioExteriorV11_Destinatario.Add: IComercioExteriorV11_Destinatario_Domicilio;
begin
  Result := AddItem(-1) as IComercioExteriorV11_Destinatario_Domicilio;
end;

function TComercioExteriorV11_Destinatario.Insert(const Index: Integer): IComercioExteriorV11_Destinatario_Domicilio;
begin
  Result := AddItem(Index) as IComercioExteriorV11_Destinatario_Domicilio;
end;

{ TComercioExteriorV11_DestinatarioList }

function TComercioExteriorV11_DestinatarioList.Add: IComercioExteriorV11_Destinatario;
begin
  Result := AddItem(-1) as IComercioExteriorV11_Destinatario;
end;

function TComercioExteriorV11_DestinatarioList.Insert(const Index: Integer): IComercioExteriorV11_Destinatario;
begin
  Result := AddItem(Index) as IComercioExteriorV11_Destinatario;
end;

function TComercioExteriorV11_DestinatarioList.Get_Item(Index: Integer): IComercioExteriorV11_Destinatario;
begin
  Result := List[Index] as IComercioExteriorV11_Destinatario;
end;

{ TComercioExteriorV11_Destinatario_Domicilio }

function TComercioExteriorV11_Destinatario_Domicilio.Get_Calle: UnicodeString;
begin
  Result := AttributeNodes['Calle'].Text;
end;

procedure TComercioExteriorV11_Destinatario_Domicilio.Set_Calle(Value: UnicodeString);
begin
  SetAttribute('Calle', Value);
end;

function TComercioExteriorV11_Destinatario_Domicilio.Get_NumeroExterior: UnicodeString;
begin
  Result := AttributeNodes['NumeroExterior'].Text;
end;

procedure TComercioExteriorV11_Destinatario_Domicilio.Set_NumeroExterior(Value: UnicodeString);
begin
  SetAttribute('NumeroExterior', Value);
end;

function TComercioExteriorV11_Destinatario_Domicilio.Get_NumeroInterior: UnicodeString;
begin
  Result := AttributeNodes['NumeroInterior'].Text;
end;

procedure TComercioExteriorV11_Destinatario_Domicilio.Set_NumeroInterior(Value: UnicodeString);
begin
  SetAttribute('NumeroInterior', Value);
end;

function TComercioExteriorV11_Destinatario_Domicilio.Get_Colonia: UnicodeString;
begin
  Result := AttributeNodes['Colonia'].Text;
end;

procedure TComercioExteriorV11_Destinatario_Domicilio.Set_Colonia(Value: UnicodeString);
begin
  SetAttribute('Colonia', Value);
end;

function TComercioExteriorV11_Destinatario_Domicilio.Get_Localidad: UnicodeString;
begin
  Result := AttributeNodes['Localidad'].Text;
end;

procedure TComercioExteriorV11_Destinatario_Domicilio.Set_Localidad(Value: UnicodeString);
begin
  SetAttribute('Localidad', Value);
end;

function TComercioExteriorV11_Destinatario_Domicilio.Get_Referencia: UnicodeString;
begin
  Result := AttributeNodes['Referencia'].Text;
end;

procedure TComercioExteriorV11_Destinatario_Domicilio.Set_Referencia(Value: UnicodeString);
begin
  SetAttribute('Referencia', Value);
end;

function TComercioExteriorV11_Destinatario_Domicilio.Get_Municipio: UnicodeString;
begin
  Result := AttributeNodes['Municipio'].Text;
end;

procedure TComercioExteriorV11_Destinatario_Domicilio.Set_Municipio(Value: UnicodeString);
begin
  SetAttribute('Municipio', Value);
end;

function TComercioExteriorV11_Destinatario_Domicilio.Get_Estado: UnicodeString;
begin
  Result := AttributeNodes['Estado'].Text;
end;

procedure TComercioExteriorV11_Destinatario_Domicilio.Set_Estado(Value: UnicodeString);
begin
  SetAttribute('Estado', Value);
end;

function TComercioExteriorV11_Destinatario_Domicilio.Get_Pais: UnicodeString;
begin
  Result := AttributeNodes['Pais'].Text;
end;

procedure TComercioExteriorV11_Destinatario_Domicilio.Set_Pais(Value: UnicodeString);
begin
  SetAttribute('Pais', Value);
end;

function TComercioExteriorV11_Destinatario_Domicilio.Get_CodigoPostal: UnicodeString;
begin
  Result := AttributeNodes['CodigoPostal'].Text;
end;

procedure TComercioExteriorV11_Destinatario_Domicilio.Set_CodigoPostal(Value: UnicodeString);
begin
  SetAttribute('CodigoPostal', Value);
end;

{ TComercioExteriorV11_Mercancias }

procedure TComercioExteriorV11_Mercancias.AfterConstruction;
begin
  RegisterChildNode('Mercancia', TComercioExteriorV11_Mercancias_Mercancia);
  ItemTag := 'Mercancia';
  ItemInterface := IComercioExteriorV11_Mercancias_Mercancia;
  inherited;
end;

function TComercioExteriorV11_Mercancias.Get_Mercancia(Index: Integer): IComercioExteriorV11_Mercancias_Mercancia;
begin
  Result := List[Index] as IComercioExteriorV11_Mercancias_Mercancia;
end;

function TComercioExteriorV11_Mercancias.Add: IComercioExteriorV11_Mercancias_Mercancia;
begin
  Result := AddItem(-1) as IComercioExteriorV11_Mercancias_Mercancia;
end;

function TComercioExteriorV11_Mercancias.Insert(const Index: Integer): IComercioExteriorV11_Mercancias_Mercancia;
begin
  Result := AddItem(Index) as IComercioExteriorV11_Mercancias_Mercancia;
end;

{ TComercioExteriorV11_Mercancias_Mercancia }

procedure TComercioExteriorV11_Mercancias_Mercancia.AfterConstruction;
begin
  RegisterChildNode('DescripcionesEspecificas', TComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas);
  ItemTag := 'DescripcionesEspecificas';
  ItemInterface := IComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas;
  inherited;
end;

function TComercioExteriorV11_Mercancias_Mercancia.Get_NoIdentificacion: UnicodeString;
begin
  Result := AttributeNodes['NoIdentificacion'].Text;
end;

procedure TComercioExteriorV11_Mercancias_Mercancia.Set_NoIdentificacion(Value: UnicodeString);
begin
  SetAttribute('NoIdentificacion', Value);
end;

function TComercioExteriorV11_Mercancias_Mercancia.Get_FraccionArancelaria: UnicodeString;
begin
  Result := AttributeNodes['FraccionArancelaria'].Text;
end;

procedure TComercioExteriorV11_Mercancias_Mercancia.Set_FraccionArancelaria(Value: UnicodeString);
begin
  SetAttribute('FraccionArancelaria', Value);
end;

function TComercioExteriorV11_Mercancias_Mercancia.Get_CantidadAduana: UnicodeString;
begin
  Result := AttributeNodes['CantidadAduana'].Text;
end;

procedure TComercioExteriorV11_Mercancias_Mercancia.Set_CantidadAduana(Value: UnicodeString);
begin
  SetAttribute('CantidadAduana', Value);
end;

function TComercioExteriorV11_Mercancias_Mercancia.Get_UnidadAduana: UnicodeString;
begin
  Result := AttributeNodes['UnidadAduana'].Text;
end;

procedure TComercioExteriorV11_Mercancias_Mercancia.Set_UnidadAduana(Value: UnicodeString);
begin
  SetAttribute('UnidadAduana', Value);
end;

function TComercioExteriorV11_Mercancias_Mercancia.Get_ValorUnitarioAduana: UnicodeString;
begin
  Result := AttributeNodes['ValorUnitarioAduana'].Text;
end;

procedure TComercioExteriorV11_Mercancias_Mercancia.Set_ValorUnitarioAduana(Value: UnicodeString);
begin
  SetAttribute('ValorUnitarioAduana', Value);
end;

function TComercioExteriorV11_Mercancias_Mercancia.Get_ValorDolares: UnicodeString;
begin
  Result := AttributeNodes['ValorDolares'].Text;
end;

procedure TComercioExteriorV11_Mercancias_Mercancia.Set_ValorDolares(Value: UnicodeString);
begin
  SetAttribute('ValorDolares', Value);
end;

function TComercioExteriorV11_Mercancias_Mercancia.Get_DescripcionesEspecificas(Index: Integer): IComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas;
begin
  Result := List[Index] as IComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas;
end;

function TComercioExteriorV11_Mercancias_Mercancia.Add: IComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas;
begin
  Result := AddItem(-1) as IComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas;
end;

function TComercioExteriorV11_Mercancias_Mercancia.Insert(const Index: Integer): IComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas;
begin
  Result := AddItem(Index) as IComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas;
end;

{ TComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas }

function TComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas.Get_Marca: UnicodeString;
begin
  Result := AttributeNodes['Marca'].Text;
end;

procedure TComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas.Set_Marca(Value: UnicodeString);
begin
  SetAttribute('Marca', Value);
end;

function TComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas.Get_Modelo: UnicodeString;
begin
  Result := AttributeNodes['Modelo'].Text;
end;

procedure TComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas.Set_Modelo(Value: UnicodeString);
begin
  SetAttribute('Modelo', Value);
end;

function TComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas.Get_SubModelo: UnicodeString;
begin
  Result := AttributeNodes['SubModelo'].Text;
end;

procedure TComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas.Set_SubModelo(Value: UnicodeString);
begin
  SetAttribute('SubModelo', Value);
end;

function TComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas.Get_NumeroSerie: UnicodeString;
begin
  Result := AttributeNodes['NumeroSerie'].Text;
end;

procedure TComercioExteriorV11_Mercancias_Mercancia_DescripcionesEspecificas.Set_NumeroSerie(Value: UnicodeString);
begin
  SetAttribute('NumeroSerie', Value);
end;

end.
