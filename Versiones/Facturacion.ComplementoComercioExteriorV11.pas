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

  IComercioExteriorV11 = interface;
  IComercioExterior_EmisorV11 = interface;
  IComercioExterior_Emisor_DomicilioV11 = interface;
  IComercioExterior_PropietarioV11 = interface;
  IComercioExterior_PropietarioV11List = interface;
  IComercioExterior_ReceptorV11 = interface;
  IComercioExterior_Receptor_DomicilioV11 = interface;
  IComercioExterior_DestinatarioV11 = interface;
  IComercioExterior_DestinatarioV11List = interface;
  IComercioExterior_Destinatario_DomicilioV11 = interface;
  IComercioExterior_MercanciasV11 = interface;
  IComercioExterior_Mercancias_MercanciaV11 = interface;
  IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11 = interface;

{ IComercioExteriorV11 }

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
    function Get_Emisor: IComercioExterior_EmisorV11;
    function Get_Propietario: IComercioExterior_PropietarioV11List;
    function Get_Receptor: IComercioExterior_ReceptorV11;
    function Get_Destinatario: IComercioExterior_DestinatarioV11List;
    function Get_Mercancias: IComercioExterior_MercanciasV11;
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
    property Emisor: IComercioExterior_EmisorV11 read Get_Emisor;
    property Propietario: IComercioExterior_PropietarioV11List read Get_Propietario;
    property Receptor: IComercioExterior_ReceptorV11 read Get_Receptor;
    property Destinatario: IComercioExterior_DestinatarioV11List read Get_Destinatario;
    property Mercancias: IComercioExterior_MercanciasV11 read Get_Mercancias;
  end;

{ IComercioExterior_EmisorV11 }

  IComercioExterior_EmisorV11 = interface(IXMLNode)
    ['{5E7EF1CD-2292-407C-B06A-7F3BBBE0C3D9}']
    { Property Accessors }
    function Get_Curp: UnicodeString;
    function Get_Domicilio: IComercioExterior_Emisor_DomicilioV11;
    procedure Set_Curp(Value: UnicodeString);
    { Methods & Properties }
    property Curp: UnicodeString read Get_Curp write Set_Curp;
    property Domicilio: IComercioExterior_Emisor_DomicilioV11 read Get_Domicilio;
  end;

{ IComercioExterior_Emisor_DomicilioV11 }

  IComercioExterior_Emisor_DomicilioV11 = interface(IXMLNode)
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

{ IComercioExterior_PropietarioV11 }

  IComercioExterior_PropietarioV11 = interface(IXMLNode)
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

{ IComercioExterior_PropietarioV11List }

  IComercioExterior_PropietarioV11List = interface(IXMLNodeCollection)
    ['{87EFC71C-A1AC-44C3-AAF1-C3271951DCA0}']
    { Methods & Properties }
    function Add: IComercioExterior_PropietarioV11;
    function Insert(const Index: Integer): IComercioExterior_PropietarioV11;

    function Get_Item(Index: Integer): IComercioExterior_PropietarioV11;
    property Items[Index: Integer]: IComercioExterior_PropietarioV11 read Get_Item; default;
  end;

{ IComercioExterior_ReceptorV11 }

  IComercioExterior_ReceptorV11 = interface(IXMLNode)
    ['{3AEB4BBB-A3D7-459B-9D32-79BEB996E9D7}']
    { Property Accessors }
    function Get_NumRegIdTrib: UnicodeString;
    function Get_Domicilio: IComercioExterior_Receptor_DomicilioV11;
    procedure Set_NumRegIdTrib(Value: UnicodeString);
    { Methods & Properties }
    property NumRegIdTrib: UnicodeString read Get_NumRegIdTrib write Set_NumRegIdTrib;
    property Domicilio: IComercioExterior_Receptor_DomicilioV11 read Get_Domicilio;
  end;

{ IComercioExterior_Receptor_DomicilioV11 }

  IComercioExterior_Receptor_DomicilioV11 = interface(IXMLNode)
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

{ IComercioExterior_DestinatarioV11 }

  IComercioExterior_DestinatarioV11 = interface(IXMLNodeCollection)
    ['{8ED925B3-087B-4333-B175-88DBA526F622}']
    { Property Accessors }
    function Get_NumRegIdTrib: UnicodeString;
    function Get_Nombre: UnicodeString;
    function Get_Domicilio(Index: Integer): IComercioExterior_Destinatario_DomicilioV11;
    procedure Set_NumRegIdTrib(Value: UnicodeString);
    procedure Set_Nombre(Value: UnicodeString);
    { Methods & Properties }
    function Add: IComercioExterior_Destinatario_DomicilioV11;
    function Insert(const Index: Integer): IComercioExterior_Destinatario_DomicilioV11;
    property NumRegIdTrib: UnicodeString read Get_NumRegIdTrib write Set_NumRegIdTrib;
    property Nombre: UnicodeString read Get_Nombre write Set_Nombre;
    property Domicilio[Index: Integer]: IComercioExterior_Destinatario_DomicilioV11 read Get_Domicilio; default;
  end;

{ IComercioExterior_DestinatarioV11List }

  IComercioExterior_DestinatarioV11List = interface(IXMLNodeCollection)
    ['{038C8B96-5628-4437-AB1A-CB1F70F6C17D}']
    { Methods & Properties }
    function Add: IComercioExterior_DestinatarioV11;
    function Insert(const Index: Integer): IComercioExterior_DestinatarioV11;

    function Get_Item(Index: Integer): IComercioExterior_DestinatarioV11;
    property Items[Index: Integer]: IComercioExterior_DestinatarioV11 read Get_Item; default;
  end;

{ IComercioExterior_Destinatario_DomicilioV11 }

  IComercioExterior_Destinatario_DomicilioV11 = interface(IXMLNode)
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

{ IComercioExterior_MercanciasV11 }

  IComercioExterior_MercanciasV11 = interface(IXMLNodeCollection)
    ['{5CD77B30-4A67-4809-A397-60405A5691D8}']
    { Property Accessors }
    function Get_Mercancia(Index: Integer): IComercioExterior_Mercancias_MercanciaV11;
    { Methods & Properties }
    function Add: IComercioExterior_Mercancias_MercanciaV11;
    function Insert(const Index: Integer): IComercioExterior_Mercancias_MercanciaV11;
    property Mercancia[Index: Integer]: IComercioExterior_Mercancias_MercanciaV11 read Get_Mercancia; default;
  end;

{ IComercioExterior_Mercancias_MercanciaV11 }

  IComercioExterior_Mercancias_MercanciaV11 = interface(IXMLNodeCollection)
    ['{ADE4925B-D2EB-4D80-B831-66D75966D1D5}']
    { Property Accessors }
    function Get_NoIdentificacion: UnicodeString;
    function Get_FraccionArancelaria: UnicodeString;
    function Get_CantidadAduana: UnicodeString;
    function Get_UnidadAduana: UnicodeString;
    function Get_ValorUnitarioAduana: UnicodeString;
    function Get_ValorDolares: UnicodeString;
    function Get_DescripcionesEspecificas(Index: Integer): IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11;
    procedure Set_NoIdentificacion(Value: UnicodeString);
    procedure Set_FraccionArancelaria(Value: UnicodeString);
    procedure Set_CantidadAduana(Value: UnicodeString);
    procedure Set_UnidadAduana(Value: UnicodeString);
    procedure Set_ValorUnitarioAduana(Value: UnicodeString);
    procedure Set_ValorDolares(Value: UnicodeString);
    { Methods & Properties }
    function Add: IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11;
    function Insert(const Index: Integer): IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11;
    property NoIdentificacion: UnicodeString read Get_NoIdentificacion write Set_NoIdentificacion;
    property FraccionArancelaria: UnicodeString read Get_FraccionArancelaria write Set_FraccionArancelaria;
    property CantidadAduana: UnicodeString read Get_CantidadAduana write Set_CantidadAduana;
    property UnidadAduana: UnicodeString read Get_UnidadAduana write Set_UnidadAduana;
    property ValorUnitarioAduana: UnicodeString read Get_ValorUnitarioAduana write Set_ValorUnitarioAduana;
    property ValorDolares: UnicodeString read Get_ValorDolares write Set_ValorDolares;
    property DescripcionesEspecificas[Index: Integer]: IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11 read Get_DescripcionesEspecificas; default;
  end;

{ IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11 }

  IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11 = interface(IXMLNode)
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
  TComercioExterior_EmisorV11 = class;
  TComercioExterior_Emisor_DomicilioV11 = class;
  TComercioExterior_PropietarioV11 = class;
  TComercioExterior_PropietarioV11List = class;
  TComercioExterior_ReceptorV11 = class;
  TComercioExterior_Receptor_DomicilioV11 = class;
  TComercioExterior_DestinatarioV11 = class;
  TComercioExterior_DestinatarioV11List = class;
  TComercioExterior_Destinatario_DomicilioV11 = class;
  TComercioExterior_MercanciasV11 = class;
  TComercioExterior_Mercancias_MercanciaV11 = class;
  TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11 = class;

{ TComercioExteriorV11 }

  TComercioExteriorV11 = class(TXMLNode, IComercioExteriorV11)
  private
    FPropietario: IComercioExterior_PropietarioV11List;
    FDestinatario: IComercioExterior_DestinatarioV11List;
  protected
    { IComercioExteriorV11 }
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
    function Get_Emisor: IComercioExterior_EmisorV11;
    function Get_Propietario: IComercioExterior_PropietarioV11List;
    function Get_Receptor: IComercioExterior_ReceptorV11;
    function Get_Destinatario: IComercioExterior_DestinatarioV11List;
    function Get_Mercancias: IComercioExterior_MercanciasV11;
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

{ TComercioExterior_EmisorV11 }

  TComercioExterior_EmisorV11 = class(TXMLNode, IComercioExterior_EmisorV11)
  protected
    { IComercioExterior_EmisorV11 }
    function Get_Curp: UnicodeString;
    function Get_Domicilio: IComercioExterior_Emisor_DomicilioV11;
    procedure Set_Curp(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TComercioExterior_Emisor_DomicilioV11 }

  TComercioExterior_Emisor_DomicilioV11 = class(TXMLNode, IComercioExterior_Emisor_DomicilioV11)
  protected
    { IComercioExterior_Emisor_DomicilioV11 }
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

{ TComercioExterior_PropietarioV11 }

  TComercioExterior_PropietarioV11 = class(TXMLNode, IComercioExterior_PropietarioV11)
  protected
    { IComercioExterior_PropietarioV11 }
    function Get_NumRegIdTrib: UnicodeString;
    function Get_ResidenciaFiscal: UnicodeString;
    procedure Set_NumRegIdTrib(Value: UnicodeString);
    procedure Set_ResidenciaFiscal(Value: UnicodeString);
  end;

{ TComercioExterior_PropietarioV11List }

  TComercioExterior_PropietarioV11List = class(TXMLNodeCollection, IComercioExterior_PropietarioV11List)
  protected
    { IComercioExterior_PropietarioV11List }
    function Add: IComercioExterior_PropietarioV11;
    function Insert(const Index: Integer): IComercioExterior_PropietarioV11;

    function Get_Item(Index: Integer): IComercioExterior_PropietarioV11;
  end;

{ TComercioExterior_ReceptorV11 }

  TComercioExterior_ReceptorV11 = class(TXMLNode, IComercioExterior_ReceptorV11)
  protected
    { IComercioExterior_ReceptorV11 }
    function Get_NumRegIdTrib: UnicodeString;
    function Get_Domicilio: IComercioExterior_Receptor_DomicilioV11;
    procedure Set_NumRegIdTrib(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TComercioExterior_Receptor_DomicilioV11 }

  TComercioExterior_Receptor_DomicilioV11 = class(TXMLNode, IComercioExterior_Receptor_DomicilioV11)
  protected
    { IComercioExterior_Receptor_DomicilioV11 }
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

{ TComercioExterior_DestinatarioV11 }

  TComercioExterior_DestinatarioV11 = class(TXMLNodeCollection, IComercioExterior_DestinatarioV11)
  protected
    { IComercioExterior_DestinatarioV11 }
    function Get_NumRegIdTrib: UnicodeString;
    function Get_Nombre: UnicodeString;
    function Get_Domicilio(Index: Integer): IComercioExterior_Destinatario_DomicilioV11;
    procedure Set_NumRegIdTrib(Value: UnicodeString);
    procedure Set_Nombre(Value: UnicodeString);
    function Add: IComercioExterior_Destinatario_DomicilioV11;
    function Insert(const Index: Integer): IComercioExterior_Destinatario_DomicilioV11;
  public
    procedure AfterConstruction; override;
  end;

{ TComercioExterior_DestinatarioV11List }

  TComercioExterior_DestinatarioV11List = class(TXMLNodeCollection, IComercioExterior_DestinatarioV11List)
  protected
    { IComercioExterior_DestinatarioV11List }
    function Add: IComercioExterior_DestinatarioV11;
    function Insert(const Index: Integer): IComercioExterior_DestinatarioV11;

    function Get_Item(Index: Integer): IComercioExterior_DestinatarioV11;
  end;

{ TComercioExterior_Destinatario_DomicilioV11 }

  TComercioExterior_Destinatario_DomicilioV11 = class(TXMLNode, IComercioExterior_Destinatario_DomicilioV11)
  protected
    { IComercioExterior_Destinatario_DomicilioV11 }
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

{ TComercioExterior_MercanciasV11 }

  TComercioExterior_MercanciasV11 = class(TXMLNodeCollection, IComercioExterior_MercanciasV11)
  protected
    { IComercioExterior_MercanciasV11 }
    function Get_Mercancia(Index: Integer): IComercioExterior_Mercancias_MercanciaV11;
    function Add: IComercioExterior_Mercancias_MercanciaV11;
    function Insert(const Index: Integer): IComercioExterior_Mercancias_MercanciaV11;
  public
    procedure AfterConstruction; override;
  end;

{ TComercioExterior_Mercancias_MercanciaV11 }

  TComercioExterior_Mercancias_MercanciaV11 = class(TXMLNodeCollection, IComercioExterior_Mercancias_MercanciaV11)
  protected
    { IComercioExterior_Mercancias_MercanciaV11 }
    function Get_NoIdentificacion: UnicodeString;
    function Get_FraccionArancelaria: UnicodeString;
    function Get_CantidadAduana: UnicodeString;
    function Get_UnidadAduana: UnicodeString;
    function Get_ValorUnitarioAduana: UnicodeString;
    function Get_ValorDolares: UnicodeString;
    function Get_DescripcionesEspecificas(Index: Integer): IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11;
    procedure Set_NoIdentificacion(Value: UnicodeString);
    procedure Set_FraccionArancelaria(Value: UnicodeString);
    procedure Set_CantidadAduana(Value: UnicodeString);
    procedure Set_UnidadAduana(Value: UnicodeString);
    procedure Set_ValorUnitarioAduana(Value: UnicodeString);
    procedure Set_ValorDolares(Value: UnicodeString);
    function Add: IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11;
    function Insert(const Index: Integer): IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11;
  public
    procedure AfterConstruction; override;
  end;

{ TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11 }

  TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11 = class(TXMLNode, IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11)
  protected
    { IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11 }
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

{ TComercioExteriorV11 }

procedure TComercioExteriorV11.AfterConstruction;
begin
  if (Self.AttributeNodes.FindNode('Version') = nil) then
      Self.Set_Version('1.1');
  RegisterChildNode('Emisor', TComercioExterior_EmisorV11);
  RegisterChildNode('Propietario', TComercioExterior_PropietarioV11);
  RegisterChildNode('Receptor', TComercioExterior_ReceptorV11);
  RegisterChildNode('Destinatario', TComercioExterior_DestinatarioV11);
  RegisterChildNode('Mercancias', TComercioExterior_MercanciasV11);
  FPropietario := CreateCollection(TComercioExterior_PropietarioV11List, IComercioExterior_PropietarioV11, 'Propietario') as IComercioExterior_PropietarioV11List;
  FDestinatario := CreateCollection(TComercioExterior_DestinatarioV11List, IComercioExterior_DestinatarioV11, 'Destinatario') as IComercioExterior_DestinatarioV11List;
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

function TComercioExteriorV11.Get_Emisor: IComercioExterior_EmisorV11;
begin
  Result := ChildNodes['Emisor'] as IComercioExterior_EmisorV11;
end;

function TComercioExteriorV11.Get_Propietario: IComercioExterior_PropietarioV11List;
begin
  Result := FPropietario;
end;

function TComercioExteriorV11.Get_Receptor: IComercioExterior_ReceptorV11;
begin
  Result := ChildNodes['Receptor'] as IComercioExterior_ReceptorV11;
end;

function TComercioExteriorV11.Get_Destinatario: IComercioExterior_DestinatarioV11List;
begin
  Result := FDestinatario;
end;

function TComercioExteriorV11.Get_Mercancias: IComercioExterior_MercanciasV11;
begin
  Result := ChildNodes['Mercancias'] as IComercioExterior_MercanciasV11;
end;

{ TComercioExterior_EmisorV11 }

procedure TComercioExterior_EmisorV11.AfterConstruction;
begin
  RegisterChildNode('Domicilio', TComercioExterior_Emisor_DomicilioV11);
  inherited;
end;

function TComercioExterior_EmisorV11.Get_Curp: UnicodeString;
begin
  Result := AttributeNodes['Curp'].Text;
end;

procedure TComercioExterior_EmisorV11.Set_Curp(Value: UnicodeString);
begin
  SetAttribute('Curp', Value);
end;

function TComercioExterior_EmisorV11.Get_Domicilio: IComercioExterior_Emisor_DomicilioV11;
begin
  Result := ChildNodes['Domicilio'] as IComercioExterior_Emisor_DomicilioV11;
end;

{ TComercioExterior_Emisor_DomicilioV11 }

function TComercioExterior_Emisor_DomicilioV11.Get_Calle: UnicodeString;
begin
  Result := AttributeNodes['Calle'].Text;
end;

procedure TComercioExterior_Emisor_DomicilioV11.Set_Calle(Value: UnicodeString);
begin
  SetAttribute('Calle', Value);
end;

function TComercioExterior_Emisor_DomicilioV11.Get_NumeroExterior: UnicodeString;
begin
  Result := AttributeNodes['NumeroExterior'].Text;
end;

procedure TComercioExterior_Emisor_DomicilioV11.Set_NumeroExterior(Value: UnicodeString);
begin
  SetAttribute('NumeroExterior', Value);
end;

function TComercioExterior_Emisor_DomicilioV11.Get_NumeroInterior: UnicodeString;
begin
  Result := AttributeNodes['NumeroInterior'].Text;
end;

procedure TComercioExterior_Emisor_DomicilioV11.Set_NumeroInterior(Value: UnicodeString);
begin
  SetAttribute('NumeroInterior', Value);
end;

function TComercioExterior_Emisor_DomicilioV11.Get_Colonia: UnicodeString;
begin
  Result := AttributeNodes['Colonia'].Text;
end;

procedure TComercioExterior_Emisor_DomicilioV11.Set_Colonia(Value: UnicodeString);
begin
  SetAttribute('Colonia', Value);
end;

function TComercioExterior_Emisor_DomicilioV11.Get_Localidad: UnicodeString;
begin
  Result := AttributeNodes['Localidad'].Text;
end;

procedure TComercioExterior_Emisor_DomicilioV11.Set_Localidad(Value: UnicodeString);
begin
  SetAttribute('Localidad', Value);
end;

function TComercioExterior_Emisor_DomicilioV11.Get_Referencia: UnicodeString;
begin
  Result := AttributeNodes['Referencia'].Text;
end;

procedure TComercioExterior_Emisor_DomicilioV11.Set_Referencia(Value: UnicodeString);
begin
  SetAttribute('Referencia', Value);
end;

function TComercioExterior_Emisor_DomicilioV11.Get_Municipio: UnicodeString;
begin
  Result := AttributeNodes['Municipio'].Text;
end;

procedure TComercioExterior_Emisor_DomicilioV11.Set_Municipio(Value: UnicodeString);
begin
  SetAttribute('Municipio', Value);
end;

function TComercioExterior_Emisor_DomicilioV11.Get_Estado: UnicodeString;
begin
  Result := AttributeNodes['Estado'].Text;
end;

procedure TComercioExterior_Emisor_DomicilioV11.Set_Estado(Value: UnicodeString);
begin
  SetAttribute('Estado', Value);
end;

function TComercioExterior_Emisor_DomicilioV11.Get_Pais: UnicodeString;
begin
  Result := AttributeNodes['Pais'].Text;
end;

procedure TComercioExterior_Emisor_DomicilioV11.Set_Pais(Value: UnicodeString);
begin
  SetAttribute('Pais', Value);
end;

function TComercioExterior_Emisor_DomicilioV11.Get_CodigoPostal: UnicodeString;
begin
  Result := AttributeNodes['CodigoPostal'].Text;
end;

procedure TComercioExterior_Emisor_DomicilioV11.Set_CodigoPostal(Value: UnicodeString);
begin
  SetAttribute('CodigoPostal', Value);
end;

{ TComercioExterior_PropietarioV11 }

function TComercioExterior_PropietarioV11.Get_NumRegIdTrib: UnicodeString;
begin
  Result := AttributeNodes['NumRegIdTrib'].Text;
end;

procedure TComercioExterior_PropietarioV11.Set_NumRegIdTrib(Value: UnicodeString);
begin
  SetAttribute('NumRegIdTrib', Value);
end;

function TComercioExterior_PropietarioV11.Get_ResidenciaFiscal: UnicodeString;
begin
  Result := AttributeNodes['ResidenciaFiscal'].Text;
end;

procedure TComercioExterior_PropietarioV11.Set_ResidenciaFiscal(Value: UnicodeString);
begin
  SetAttribute('ResidenciaFiscal', Value);
end;

{ TComercioExterior_PropietarioV11List }

function TComercioExterior_PropietarioV11List.Add: IComercioExterior_PropietarioV11;
begin
  Result := AddItem(-1) as IComercioExterior_PropietarioV11;
end;

function TComercioExterior_PropietarioV11List.Insert(const Index: Integer): IComercioExterior_PropietarioV11;
begin
  Result := AddItem(Index) as IComercioExterior_PropietarioV11;
end;

function TComercioExterior_PropietarioV11List.Get_Item(Index: Integer): IComercioExterior_PropietarioV11;
begin
  Result := List[Index] as IComercioExterior_PropietarioV11;
end;

{ TComercioExterior_ReceptorV11 }

procedure TComercioExterior_ReceptorV11.AfterConstruction;
begin
  RegisterChildNode('Domicilio', TComercioExterior_Receptor_DomicilioV11);
  inherited;
end;

function TComercioExterior_ReceptorV11.Get_NumRegIdTrib: UnicodeString;
begin
  Result := AttributeNodes['NumRegIdTrib'].Text;
end;

procedure TComercioExterior_ReceptorV11.Set_NumRegIdTrib(Value: UnicodeString);
begin
  SetAttribute('NumRegIdTrib', Value);
end;

function TComercioExterior_ReceptorV11.Get_Domicilio: IComercioExterior_Receptor_DomicilioV11;
begin
  Result := ChildNodes['Domicilio'] as IComercioExterior_Receptor_DomicilioV11;
end;

{ TComercioExterior_Receptor_DomicilioV11 }

function TComercioExterior_Receptor_DomicilioV11.Get_Calle: UnicodeString;
begin
  Result := AttributeNodes['Calle'].Text;
end;

procedure TComercioExterior_Receptor_DomicilioV11.Set_Calle(Value: UnicodeString);
begin
  SetAttribute('Calle', Value);
end;

function TComercioExterior_Receptor_DomicilioV11.Get_NumeroExterior: UnicodeString;
begin
  Result := AttributeNodes['NumeroExterior'].Text;
end;

procedure TComercioExterior_Receptor_DomicilioV11.Set_NumeroExterior(Value: UnicodeString);
begin
  SetAttribute('NumeroExterior', Value);
end;

function TComercioExterior_Receptor_DomicilioV11.Get_NumeroInterior: UnicodeString;
begin
  Result := AttributeNodes['NumeroInterior'].Text;
end;

procedure TComercioExterior_Receptor_DomicilioV11.Set_NumeroInterior(Value: UnicodeString);
begin
  SetAttribute('NumeroInterior', Value);
end;

function TComercioExterior_Receptor_DomicilioV11.Get_Colonia: UnicodeString;
begin
  Result := AttributeNodes['Colonia'].Text;
end;

procedure TComercioExterior_Receptor_DomicilioV11.Set_Colonia(Value: UnicodeString);
begin
  SetAttribute('Colonia', Value);
end;

function TComercioExterior_Receptor_DomicilioV11.Get_Localidad: UnicodeString;
begin
  Result := AttributeNodes['Localidad'].Text;
end;

procedure TComercioExterior_Receptor_DomicilioV11.Set_Localidad(Value: UnicodeString);
begin
  SetAttribute('Localidad', Value);
end;

function TComercioExterior_Receptor_DomicilioV11.Get_Referencia: UnicodeString;
begin
  Result := AttributeNodes['Referencia'].Text;
end;

procedure TComercioExterior_Receptor_DomicilioV11.Set_Referencia(Value: UnicodeString);
begin
  SetAttribute('Referencia', Value);
end;

function TComercioExterior_Receptor_DomicilioV11.Get_Municipio: UnicodeString;
begin
  Result := AttributeNodes['Municipio'].Text;
end;

procedure TComercioExterior_Receptor_DomicilioV11.Set_Municipio(Value: UnicodeString);
begin
  SetAttribute('Municipio', Value);
end;

function TComercioExterior_Receptor_DomicilioV11.Get_Estado: UnicodeString;
begin
  Result := AttributeNodes['Estado'].Text;
end;

procedure TComercioExterior_Receptor_DomicilioV11.Set_Estado(Value: UnicodeString);
begin
  SetAttribute('Estado', Value);
end;

function TComercioExterior_Receptor_DomicilioV11.Get_Pais: UnicodeString;
begin
  Result := AttributeNodes['Pais'].Text;
end;

procedure TComercioExterior_Receptor_DomicilioV11.Set_Pais(Value: UnicodeString);
begin
  SetAttribute('Pais', Value);
end;

function TComercioExterior_Receptor_DomicilioV11.Get_CodigoPostal: UnicodeString;
begin
  Result := AttributeNodes['CodigoPostal'].Text;
end;

procedure TComercioExterior_Receptor_DomicilioV11.Set_CodigoPostal(Value: UnicodeString);
begin
  SetAttribute('CodigoPostal', Value);
end;

{ TComercioExterior_DestinatarioV11 }

procedure TComercioExterior_DestinatarioV11.AfterConstruction;
begin
  RegisterChildNode('Domicilio', TComercioExterior_Destinatario_DomicilioV11);
  ItemTag := 'Domicilio';
  ItemInterface := IComercioExterior_Destinatario_DomicilioV11;
  inherited;
end;

function TComercioExterior_DestinatarioV11.Get_NumRegIdTrib: UnicodeString;
begin
  Result := AttributeNodes['NumRegIdTrib'].Text;
end;

procedure TComercioExterior_DestinatarioV11.Set_NumRegIdTrib(Value: UnicodeString);
begin
  SetAttribute('NumRegIdTrib', Value);
end;

function TComercioExterior_DestinatarioV11.Get_Nombre: UnicodeString;
begin
  Result := AttributeNodes['Nombre'].Text;
end;

procedure TComercioExterior_DestinatarioV11.Set_Nombre(Value: UnicodeString);
begin
  SetAttribute('Nombre', Value);
end;

function TComercioExterior_DestinatarioV11.Get_Domicilio(Index: Integer): IComercioExterior_Destinatario_DomicilioV11;
begin
  Result := List[Index] as IComercioExterior_Destinatario_DomicilioV11;
end;

function TComercioExterior_DestinatarioV11.Add: IComercioExterior_Destinatario_DomicilioV11;
begin
  Result := AddItem(-1) as IComercioExterior_Destinatario_DomicilioV11;
end;

function TComercioExterior_DestinatarioV11.Insert(const Index: Integer): IComercioExterior_Destinatario_DomicilioV11;
begin
  Result := AddItem(Index) as IComercioExterior_Destinatario_DomicilioV11;
end;

{ TComercioExterior_DestinatarioV11List }

function TComercioExterior_DestinatarioV11List.Add: IComercioExterior_DestinatarioV11;
begin
  Result := AddItem(-1) as IComercioExterior_DestinatarioV11;
end;

function TComercioExterior_DestinatarioV11List.Insert(const Index: Integer): IComercioExterior_DestinatarioV11;
begin
  Result := AddItem(Index) as IComercioExterior_DestinatarioV11;
end;

function TComercioExterior_DestinatarioV11List.Get_Item(Index: Integer): IComercioExterior_DestinatarioV11;
begin
  Result := List[Index] as IComercioExterior_DestinatarioV11;
end;

{ TComercioExterior_Destinatario_DomicilioV11 }

function TComercioExterior_Destinatario_DomicilioV11.Get_Calle: UnicodeString;
begin
  Result := AttributeNodes['Calle'].Text;
end;

procedure TComercioExterior_Destinatario_DomicilioV11.Set_Calle(Value: UnicodeString);
begin
  SetAttribute('Calle', Value);
end;

function TComercioExterior_Destinatario_DomicilioV11.Get_NumeroExterior: UnicodeString;
begin
  Result := AttributeNodes['NumeroExterior'].Text;
end;

procedure TComercioExterior_Destinatario_DomicilioV11.Set_NumeroExterior(Value: UnicodeString);
begin
  SetAttribute('NumeroExterior', Value);
end;

function TComercioExterior_Destinatario_DomicilioV11.Get_NumeroInterior: UnicodeString;
begin
  Result := AttributeNodes['NumeroInterior'].Text;
end;

procedure TComercioExterior_Destinatario_DomicilioV11.Set_NumeroInterior(Value: UnicodeString);
begin
  SetAttribute('NumeroInterior', Value);
end;

function TComercioExterior_Destinatario_DomicilioV11.Get_Colonia: UnicodeString;
begin
  Result := AttributeNodes['Colonia'].Text;
end;

procedure TComercioExterior_Destinatario_DomicilioV11.Set_Colonia(Value: UnicodeString);
begin
  SetAttribute('Colonia', Value);
end;

function TComercioExterior_Destinatario_DomicilioV11.Get_Localidad: UnicodeString;
begin
  Result := AttributeNodes['Localidad'].Text;
end;

procedure TComercioExterior_Destinatario_DomicilioV11.Set_Localidad(Value: UnicodeString);
begin
  SetAttribute('Localidad', Value);
end;

function TComercioExterior_Destinatario_DomicilioV11.Get_Referencia: UnicodeString;
begin
  Result := AttributeNodes['Referencia'].Text;
end;

procedure TComercioExterior_Destinatario_DomicilioV11.Set_Referencia(Value: UnicodeString);
begin
  SetAttribute('Referencia', Value);
end;

function TComercioExterior_Destinatario_DomicilioV11.Get_Municipio: UnicodeString;
begin
  Result := AttributeNodes['Municipio'].Text;
end;

procedure TComercioExterior_Destinatario_DomicilioV11.Set_Municipio(Value: UnicodeString);
begin
  SetAttribute('Municipio', Value);
end;

function TComercioExterior_Destinatario_DomicilioV11.Get_Estado: UnicodeString;
begin
  Result := AttributeNodes['Estado'].Text;
end;

procedure TComercioExterior_Destinatario_DomicilioV11.Set_Estado(Value: UnicodeString);
begin
  SetAttribute('Estado', Value);
end;

function TComercioExterior_Destinatario_DomicilioV11.Get_Pais: UnicodeString;
begin
  Result := AttributeNodes['Pais'].Text;
end;

procedure TComercioExterior_Destinatario_DomicilioV11.Set_Pais(Value: UnicodeString);
begin
  SetAttribute('Pais', Value);
end;

function TComercioExterior_Destinatario_DomicilioV11.Get_CodigoPostal: UnicodeString;
begin
  Result := AttributeNodes['CodigoPostal'].Text;
end;

procedure TComercioExterior_Destinatario_DomicilioV11.Set_CodigoPostal(Value: UnicodeString);
begin
  SetAttribute('CodigoPostal', Value);
end;

{ TComercioExterior_MercanciasV11 }

procedure TComercioExterior_MercanciasV11.AfterConstruction;
begin
  RegisterChildNode('Mercancia', TComercioExterior_Mercancias_MercanciaV11);
  ItemTag := 'Mercancia';
  ItemInterface := IComercioExterior_Mercancias_MercanciaV11;
  inherited;
end;

function TComercioExterior_MercanciasV11.Get_Mercancia(Index: Integer): IComercioExterior_Mercancias_MercanciaV11;
begin
  Result := List[Index] as IComercioExterior_Mercancias_MercanciaV11;
end;

function TComercioExterior_MercanciasV11.Add: IComercioExterior_Mercancias_MercanciaV11;
begin
  Result := AddItem(-1) as IComercioExterior_Mercancias_MercanciaV11;
end;

function TComercioExterior_MercanciasV11.Insert(const Index: Integer): IComercioExterior_Mercancias_MercanciaV11;
begin
  Result := AddItem(Index) as IComercioExterior_Mercancias_MercanciaV11;
end;

{ TComercioExterior_Mercancias_MercanciaV11 }

procedure TComercioExterior_Mercancias_MercanciaV11.AfterConstruction;
begin
  RegisterChildNode('DescripcionesEspecificas', TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11);
  ItemTag := 'DescripcionesEspecificas';
  ItemInterface := IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11;
  inherited;
end;

function TComercioExterior_Mercancias_MercanciaV11.Get_NoIdentificacion: UnicodeString;
begin
  Result := AttributeNodes['NoIdentificacion'].Text;
end;

procedure TComercioExterior_Mercancias_MercanciaV11.Set_NoIdentificacion(Value: UnicodeString);
begin
  SetAttribute('NoIdentificacion', Value);
end;

function TComercioExterior_Mercancias_MercanciaV11.Get_FraccionArancelaria: UnicodeString;
begin
  Result := AttributeNodes['FraccionArancelaria'].Text;
end;

procedure TComercioExterior_Mercancias_MercanciaV11.Set_FraccionArancelaria(Value: UnicodeString);
begin
  SetAttribute('FraccionArancelaria', Value);
end;

function TComercioExterior_Mercancias_MercanciaV11.Get_CantidadAduana: UnicodeString;
begin
  Result := AttributeNodes['CantidadAduana'].Text;
end;

procedure TComercioExterior_Mercancias_MercanciaV11.Set_CantidadAduana(Value: UnicodeString);
begin
  SetAttribute('CantidadAduana', Value);
end;

function TComercioExterior_Mercancias_MercanciaV11.Get_UnidadAduana: UnicodeString;
begin
  Result := AttributeNodes['UnidadAduana'].Text;
end;

procedure TComercioExterior_Mercancias_MercanciaV11.Set_UnidadAduana(Value: UnicodeString);
begin
  SetAttribute('UnidadAduana', Value);
end;

function TComercioExterior_Mercancias_MercanciaV11.Get_ValorUnitarioAduana: UnicodeString;
begin
  Result := AttributeNodes['ValorUnitarioAduana'].Text;
end;

procedure TComercioExterior_Mercancias_MercanciaV11.Set_ValorUnitarioAduana(Value: UnicodeString);
begin
  SetAttribute('ValorUnitarioAduana', Value);
end;

function TComercioExterior_Mercancias_MercanciaV11.Get_ValorDolares: UnicodeString;
begin
  Result := AttributeNodes['ValorDolares'].Text;
end;

procedure TComercioExterior_Mercancias_MercanciaV11.Set_ValorDolares(Value: UnicodeString);
begin
  SetAttribute('ValorDolares', Value);
end;

function TComercioExterior_Mercancias_MercanciaV11.Get_DescripcionesEspecificas(Index: Integer): IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11;
begin
  Result := List[Index] as IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11;
end;

function TComercioExterior_Mercancias_MercanciaV11.Add: IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11;
begin
  Result := AddItem(-1) as IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11;
end;

function TComercioExterior_Mercancias_MercanciaV11.Insert(const Index: Integer): IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11;
begin
  Result := AddItem(Index) as IComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11;
end;

{ TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11 }

function TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11.Get_Marca: UnicodeString;
begin
  Result := AttributeNodes['Marca'].Text;
end;

procedure TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11.Set_Marca(Value: UnicodeString);
begin
  SetAttribute('Marca', Value);
end;

function TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11.Get_Modelo: UnicodeString;
begin
  Result := AttributeNodes['Modelo'].Text;
end;

procedure TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11.Set_Modelo(Value: UnicodeString);
begin
  SetAttribute('Modelo', Value);
end;

function TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11.Get_SubModelo: UnicodeString;
begin
  Result := AttributeNodes['SubModelo'].Text;
end;

procedure TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11.Set_SubModelo(Value: UnicodeString);
begin
  SetAttribute('SubModelo', Value);
end;

function TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11.Get_NumeroSerie: UnicodeString;
begin
  Result := AttributeNodes['NumeroSerie'].Text;
end;

procedure TComercioExterior_Mercancias_Mercancia_DescripcionesEspecificasV11.Set_NumeroSerie(Value: UnicodeString);
begin
  SetAttribute('NumeroSerie', Value);
end;

end.
