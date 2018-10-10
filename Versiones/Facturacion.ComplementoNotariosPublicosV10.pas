{***********************************************************}
{                                                           }
{       TFacturaElectronica                                 }
{                                                           }
{       Copyright (C) 2018 Bambu Code SA de CV              }
{       Soporte del Complemento Notarios Público 1.0        }
{                                                           }
{***********************************************************}

{****************************************************************************************************************}
{                                                                                                                }
{                                          XML Data Binding                                                      }
{                                                                                                                }
{         Generated on: 28/09/2018 03:01:42 p.m.                                                                 }
{       Generated from: http://www.sat.gob.mx/sitio_internet/cfd/Notarios públicos/notariospublicos.xsd          }
{                                                                                                                }
{****************************************************************************************************************}

unit Facturacion.ComplementoNotariosPublicosV10;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  INotariosPublicosV10 = interface;
  INotariosPublicosV10_DescInmuebles = interface;
  INotariosPublicosV10_DescInmuebles_DescInmueble = interface;
  INotariosPublicosV10_DatosOperacion = interface;
  INotariosPublicosV10_DatosNotario = interface;
  INotariosPublicosV10_DatosEnajenante = interface;
  INotariosPublicosV10_DatosEnajenante_DatosUnEnajenante = interface;
  INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC = interface;
  INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC = interface;
  INotariosPublicosV10_DatosAdquiriente = interface;
  INotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente = interface;
  INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC = interface;
  INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC = interface;

{ INotariosPublicosV10 }

  INotariosPublicosV10 = interface(IXMLNode)
    ['{49F91A64-B69E-4B43-BB1C-5763E26CC10F}']
    { Property Accessors }
    function Get_Version: UnicodeString;
    function Get_DescInmuebles: INotariosPublicosV10_DescInmuebles;
    function Get_DatosOperacion: INotariosPublicosV10_DatosOperacion;
    function Get_DatosNotario: INotariosPublicosV10_DatosNotario;
    function Get_DatosEnajenante: INotariosPublicosV10_DatosEnajenante;
    function Get_DatosAdquiriente: INotariosPublicosV10_DatosAdquiriente;
    procedure Set_Version(Value: UnicodeString);
    { Methods & Properties }
    property Version: UnicodeString read Get_Version write Set_Version;
    property DescInmuebles: INotariosPublicosV10_DescInmuebles read Get_DescInmuebles;
    property DatosOperacion: INotariosPublicosV10_DatosOperacion read Get_DatosOperacion;
    property DatosNotario: INotariosPublicosV10_DatosNotario read Get_DatosNotario;
    property DatosEnajenante: INotariosPublicosV10_DatosEnajenante read Get_DatosEnajenante;
    property DatosAdquiriente: INotariosPublicosV10_DatosAdquiriente read Get_DatosAdquiriente;
  end;

{ INotariosPublicosV10_DescInmuebles }

  INotariosPublicosV10_DescInmuebles = interface(IXMLNodeCollection)
    ['{5011CC59-845F-41D7-918F-9550DE387F57}']
    { Property Accessors }
    function Get_DescInmueble(Index: Integer): INotariosPublicosV10_DescInmuebles_DescInmueble;
    { Methods & Properties }
    function Add: INotariosPublicosV10_DescInmuebles_DescInmueble;
    function Insert(const Index: Integer): INotariosPublicosV10_DescInmuebles_DescInmueble;
    property DescInmueble[Index: Integer]: INotariosPublicosV10_DescInmuebles_DescInmueble read Get_DescInmueble; default;
  end;

{ INotariosPublicosV10_DescInmuebles_DescInmueble }

  INotariosPublicosV10_DescInmuebles_DescInmueble = interface(IXMLNode)
    ['{E8A7C761-18EA-42E0-B4B2-D3A81E1199E0}']
    { Property Accessors }
    function Get_TipoInmueble: UnicodeString;
    function Get_Calle: UnicodeString;
    function Get_NoExterior: UnicodeString;
    function Get_NoInterior: UnicodeString;
    function Get_Colonia: UnicodeString;
    function Get_Localidad: UnicodeString;
    function Get_Referencia: UnicodeString;
    function Get_Municipio: UnicodeString;
    function Get_Estado: UnicodeString;
    function Get_Pais: UnicodeString;
    function Get_CodigoPostal: UnicodeString;
    procedure Set_TipoInmueble(Value: UnicodeString);
    procedure Set_Calle(Value: UnicodeString);
    procedure Set_NoExterior(Value: UnicodeString);
    procedure Set_NoInterior(Value: UnicodeString);
    procedure Set_Colonia(Value: UnicodeString);
    procedure Set_Localidad(Value: UnicodeString);
    procedure Set_Referencia(Value: UnicodeString);
    procedure Set_Municipio(Value: UnicodeString);
    procedure Set_Estado(Value: UnicodeString);
    procedure Set_Pais(Value: UnicodeString);
    procedure Set_CodigoPostal(Value: UnicodeString);
    { Methods & Properties }
    property TipoInmueble: UnicodeString read Get_TipoInmueble write Set_TipoInmueble;
    property Calle: UnicodeString read Get_Calle write Set_Calle;
    property NoExterior: UnicodeString read Get_NoExterior write Set_NoExterior;
    property NoInterior: UnicodeString read Get_NoInterior write Set_NoInterior;
    property Colonia: UnicodeString read Get_Colonia write Set_Colonia;
    property Localidad: UnicodeString read Get_Localidad write Set_Localidad;
    property Referencia: UnicodeString read Get_Referencia write Set_Referencia;
    property Municipio: UnicodeString read Get_Municipio write Set_Municipio;
    property Estado: UnicodeString read Get_Estado write Set_Estado;
    property Pais: UnicodeString read Get_Pais write Set_Pais;
    property CodigoPostal: UnicodeString read Get_CodigoPostal write Set_CodigoPostal;
  end;

{ INotariosPublicosV10_DatosOperacion }

  INotariosPublicosV10_DatosOperacion = interface(IXMLNode)
    ['{7781B603-AD42-4D83-B541-01F12957E931}']
    { Property Accessors }
    function Get_NumInstrumentoNotarial: Integer;
    function Get_FechaInstNotarial: UnicodeString;
    function Get_MontoOperacion: UnicodeString;
    function Get_Subtotal: UnicodeString;
    function Get_IVA: UnicodeString;
    procedure Set_NumInstrumentoNotarial(Value: Integer);
    procedure Set_FechaInstNotarial(Value: UnicodeString);
    procedure Set_MontoOperacion(Value: UnicodeString);
    procedure Set_Subtotal(Value: UnicodeString);
    procedure Set_IVA(Value: UnicodeString);
    { Methods & Properties }
    property NumInstrumentoNotarial: Integer read Get_NumInstrumentoNotarial write Set_NumInstrumentoNotarial;
    property FechaInstNotarial: UnicodeString read Get_FechaInstNotarial write Set_FechaInstNotarial;
    property MontoOperacion: UnicodeString read Get_MontoOperacion write Set_MontoOperacion;
    property Subtotal: UnicodeString read Get_Subtotal write Set_Subtotal;
    property IVA: UnicodeString read Get_IVA write Set_IVA;
  end;

{ INotariosPublicosV10_DatosNotario }

  INotariosPublicosV10_DatosNotario = interface(IXMLNode)
    ['{214706C0-DE2D-4765-B7FD-8134554423BD}']
    { Property Accessors }
    function Get_CURP: UnicodeString;
    function Get_NumNotaria: Integer;
    function Get_EntidadFederativa: UnicodeString;
    function Get_Adscripcion: UnicodeString;
    procedure Set_CURP(Value: UnicodeString);
    procedure Set_NumNotaria(Value: Integer);
    procedure Set_EntidadFederativa(Value: UnicodeString);
    procedure Set_Adscripcion(Value: UnicodeString);
    { Methods & Properties }
    property CURP: UnicodeString read Get_CURP write Set_CURP;
    property NumNotaria: Integer read Get_NumNotaria write Set_NumNotaria;
    property EntidadFederativa: UnicodeString read Get_EntidadFederativa write Set_EntidadFederativa;
    property Adscripcion: UnicodeString read Get_Adscripcion write Set_Adscripcion;
  end;

{ INotariosPublicosV10_DatosEnajenante }

  INotariosPublicosV10_DatosEnajenante = interface(IXMLNode)
    ['{6E259468-DEA7-4C8F-8D2B-AC04420D15A0}']
    { Property Accessors }
    function Get_CoproSocConyugalE: UnicodeString;
    function Get_DatosUnEnajenante: INotariosPublicosV10_DatosEnajenante_DatosUnEnajenante;
    function Get_DatosEnajenantesCopSC: INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC;
    procedure Set_CoproSocConyugalE(Value: UnicodeString);
    { Methods & Properties }
    property CoproSocConyugalE: UnicodeString read Get_CoproSocConyugalE write Set_CoproSocConyugalE;
    property DatosUnEnajenante: INotariosPublicosV10_DatosEnajenante_DatosUnEnajenante read Get_DatosUnEnajenante;
    property DatosEnajenantesCopSC: INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC read Get_DatosEnajenantesCopSC;
  end;

{ INotariosPublicosV10_DatosEnajenante_DatosUnEnajenante }

  INotariosPublicosV10_DatosEnajenante_DatosUnEnajenante = interface(IXMLNode)
    ['{A8B92133-E897-415E-832A-7CE60EE26966}']
    { Property Accessors }
    function Get_Nombre: UnicodeString;
    function Get_ApellidoPaterno: UnicodeString;
    function Get_ApellidoMaterno: UnicodeString;
    function Get_RFC: UnicodeString;
    function Get_CURP: UnicodeString;
    procedure Set_Nombre(Value: UnicodeString);
    procedure Set_ApellidoPaterno(Value: UnicodeString);
    procedure Set_ApellidoMaterno(Value: UnicodeString);
    procedure Set_RFC(Value: UnicodeString);
    procedure Set_CURP(Value: UnicodeString);
    { Methods & Properties }
    property Nombre: UnicodeString read Get_Nombre write Set_Nombre;
    property ApellidoPaterno: UnicodeString read Get_ApellidoPaterno write Set_ApellidoPaterno;
    property ApellidoMaterno: UnicodeString read Get_ApellidoMaterno write Set_ApellidoMaterno;
    property RFC: UnicodeString read Get_RFC write Set_RFC;
    property CURP: UnicodeString read Get_CURP write Set_CURP;
  end;

{ INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC }

  INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC = interface(IXMLNodeCollection)
    ['{4C1EECAA-64B7-4DA0-8BC3-FAEAEED6E4D7}']
    { Property Accessors }
    function Get_DatosEnajenanteCopSC(Index: Integer): INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC;
    { Methods & Properties }
    function Add: INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC;
    function Insert(const Index: Integer): INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC;
    property DatosEnajenanteCopSC[Index: Integer]: INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC read Get_DatosEnajenanteCopSC; default;
  end;

{ INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC }

  INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC = interface(IXMLNode)
    ['{03B4D87F-0801-45FD-822B-7D0813D5869E}']
    { Property Accessors }
    function Get_Nombre: UnicodeString;
    function Get_ApellidoPaterno: UnicodeString;
    function Get_ApellidoMaterno: UnicodeString;
    function Get_RFC: UnicodeString;
    function Get_CURP: UnicodeString;
    function Get_Porcentaje: UnicodeString;
    procedure Set_Nombre(Value: UnicodeString);
    procedure Set_ApellidoPaterno(Value: UnicodeString);
    procedure Set_ApellidoMaterno(Value: UnicodeString);
    procedure Set_RFC(Value: UnicodeString);
    procedure Set_CURP(Value: UnicodeString);
    procedure Set_Porcentaje(Value: UnicodeString);
    { Methods & Properties }
    property Nombre: UnicodeString read Get_Nombre write Set_Nombre;
    property ApellidoPaterno: UnicodeString read Get_ApellidoPaterno write Set_ApellidoPaterno;
    property ApellidoMaterno: UnicodeString read Get_ApellidoMaterno write Set_ApellidoMaterno;
    property RFC: UnicodeString read Get_RFC write Set_RFC;
    property CURP: UnicodeString read Get_CURP write Set_CURP;
    property Porcentaje: UnicodeString read Get_Porcentaje write Set_Porcentaje;
  end;

{ INotariosPublicosV10_DatosAdquiriente }

  INotariosPublicosV10_DatosAdquiriente = interface(IXMLNode)
    ['{79C0033C-828C-41A5-9220-A5FB2837B6D7}']
    { Property Accessors }
    function Get_CoproSocConyugalE: UnicodeString;
    function Get_DatosUnAdquiriente: INotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente;
    function Get_DatosAdquirientesCopSC: INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC;
    procedure Set_CoproSocConyugalE(Value: UnicodeString);
    { Methods & Properties }
    property CoproSocConyugalE: UnicodeString read Get_CoproSocConyugalE write Set_CoproSocConyugalE;
    property DatosUnAdquiriente: INotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente read Get_DatosUnAdquiriente;
    property DatosAdquirientesCopSC: INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC read Get_DatosAdquirientesCopSC;
  end;

{ INotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente }

  INotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente = interface(IXMLNode)
    ['{858E4037-185B-403A-970B-48485C1DF0AE}']
    { Property Accessors }
    function Get_Nombre: UnicodeString;
    function Get_ApellidoPaterno: UnicodeString;
    function Get_ApellidoMaterno: UnicodeString;
    function Get_RFC: UnicodeString;
    function Get_CURP: UnicodeString;
    procedure Set_Nombre(Value: UnicodeString);
    procedure Set_ApellidoPaterno(Value: UnicodeString);
    procedure Set_ApellidoMaterno(Value: UnicodeString);
    procedure Set_RFC(Value: UnicodeString);
    procedure Set_CURP(Value: UnicodeString);
    { Methods & Properties }
    property Nombre: UnicodeString read Get_Nombre write Set_Nombre;
    property ApellidoPaterno: UnicodeString read Get_ApellidoPaterno write Set_ApellidoPaterno;
    property ApellidoMaterno: UnicodeString read Get_ApellidoMaterno write Set_ApellidoMaterno;
    property RFC: UnicodeString read Get_RFC write Set_RFC;
    property CURP: UnicodeString read Get_CURP write Set_CURP;
  end;

{ INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC }

  INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC = interface(IXMLNodeCollection)
    ['{E3616271-5C10-4A31-8074-87A5D4563F25}']
    { Property Accessors }
    function Get_DatosAdquirienteCopSC(Index: Integer): INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC;
    { Methods & Properties }
    function Add: INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC;
    function Insert(const Index: Integer): INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC;
    property DatosAdquirienteCopSC[Index: Integer]: INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC read Get_DatosAdquirienteCopSC; default;
  end;

{ INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC }

  INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC = interface(IXMLNode)
    ['{1396DC62-1C69-449C-B941-312E3B1774B1}']
    { Property Accessors }
    function Get_Nombre: UnicodeString;
    function Get_ApellidoPaterno: UnicodeString;
    function Get_ApellidoMaterno: UnicodeString;
    function Get_RFC: UnicodeString;
    function Get_CURP: UnicodeString;
    function Get_Porcentaje: UnicodeString;
    procedure Set_Nombre(Value: UnicodeString);
    procedure Set_ApellidoPaterno(Value: UnicodeString);
    procedure Set_ApellidoMaterno(Value: UnicodeString);
    procedure Set_RFC(Value: UnicodeString);
    procedure Set_CURP(Value: UnicodeString);
    procedure Set_Porcentaje(Value: UnicodeString);
    { Methods & Properties }
    property Nombre: UnicodeString read Get_Nombre write Set_Nombre;
    property ApellidoPaterno: UnicodeString read Get_ApellidoPaterno write Set_ApellidoPaterno;
    property ApellidoMaterno: UnicodeString read Get_ApellidoMaterno write Set_ApellidoMaterno;
    property RFC: UnicodeString read Get_RFC write Set_RFC;
    property CURP: UnicodeString read Get_CURP write Set_CURP;
    property Porcentaje: UnicodeString read Get_Porcentaje write Set_Porcentaje;
  end;

{ Forward Decls }

  TNotariosPublicosV10 = class;
  TNotariosPublicosV10_DescInmuebles = class;
  TNotariosPublicosV10_DescInmuebles_DescInmueble = class;
  TNotariosPublicosV10_DatosOperacion = class;
  TNotariosPublicosV10_DatosNotario = class;
  TNotariosPublicosV10_DatosEnajenante = class;
  TNotariosPublicosV10_DatosEnajenante_DatosUnEnajenante = class;
  TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC = class;
  TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC = class;
  TNotariosPublicosV10_DatosAdquiriente = class;
  TNotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente = class;
  TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC = class;
  TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC = class;

{ TNotariosPublicosV10 }

  TNotariosPublicosV10 = class(TXMLNode, INotariosPublicosV10)
  protected
    { INotariosPublicosV10 }
    function Get_Version: UnicodeString;
    function Get_DescInmuebles: INotariosPublicosV10_DescInmuebles;
    function Get_DatosOperacion: INotariosPublicosV10_DatosOperacion;
    function Get_DatosNotario: INotariosPublicosV10_DatosNotario;
    function Get_DatosEnajenante: INotariosPublicosV10_DatosEnajenante;
    function Get_DatosAdquiriente: INotariosPublicosV10_DatosAdquiriente;
    procedure Set_Version(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TNotariosPublicosV10_DescInmuebles }

  TNotariosPublicosV10_DescInmuebles = class(TXMLNodeCollection, INotariosPublicosV10_DescInmuebles)
  protected
    { INotariosPublicosV10_DescInmuebles }
    function Get_DescInmueble(Index: Integer): INotariosPublicosV10_DescInmuebles_DescInmueble;
    function Add: INotariosPublicosV10_DescInmuebles_DescInmueble;
    function Insert(const Index: Integer): INotariosPublicosV10_DescInmuebles_DescInmueble;
  public
    procedure AfterConstruction; override;
  end;

{ TNotariosPublicosV10_DescInmuebles_DescInmueble }

  TNotariosPublicosV10_DescInmuebles_DescInmueble = class(TXMLNode, INotariosPublicosV10_DescInmuebles_DescInmueble)
  protected
    { INotariosPublicosV10_DescInmuebles_DescInmueble }
    function Get_TipoInmueble: UnicodeString;
    function Get_Calle: UnicodeString;
    function Get_NoExterior: UnicodeString;
    function Get_NoInterior: UnicodeString;
    function Get_Colonia: UnicodeString;
    function Get_Localidad: UnicodeString;
    function Get_Referencia: UnicodeString;
    function Get_Municipio: UnicodeString;
    function Get_Estado: UnicodeString;
    function Get_Pais: UnicodeString;
    function Get_CodigoPostal: UnicodeString;
    procedure Set_TipoInmueble(Value: UnicodeString);
    procedure Set_Calle(Value: UnicodeString);
    procedure Set_NoExterior(Value: UnicodeString);
    procedure Set_NoInterior(Value: UnicodeString);
    procedure Set_Colonia(Value: UnicodeString);
    procedure Set_Localidad(Value: UnicodeString);
    procedure Set_Referencia(Value: UnicodeString);
    procedure Set_Municipio(Value: UnicodeString);
    procedure Set_Estado(Value: UnicodeString);
    procedure Set_Pais(Value: UnicodeString);
    procedure Set_CodigoPostal(Value: UnicodeString);
  end;

{ TNotariosPublicosV10_DatosOperacion }

  TNotariosPublicosV10_DatosOperacion = class(TXMLNode, INotariosPublicosV10_DatosOperacion)
  protected
    { INotariosPublicosV10_DatosOperacion }
    function Get_NumInstrumentoNotarial: Integer;
    function Get_FechaInstNotarial: UnicodeString;
    function Get_MontoOperacion: UnicodeString;
    function Get_Subtotal: UnicodeString;
    function Get_IVA: UnicodeString;
    procedure Set_NumInstrumentoNotarial(Value: Integer);
    procedure Set_FechaInstNotarial(Value: UnicodeString);
    procedure Set_MontoOperacion(Value: UnicodeString);
    procedure Set_Subtotal(Value: UnicodeString);
    procedure Set_IVA(Value: UnicodeString);
  end;

{ TNotariosPublicosV10_DatosNotario }

  TNotariosPublicosV10_DatosNotario = class(TXMLNode, INotariosPublicosV10_DatosNotario)
  protected
    { INotariosPublicosV10_DatosNotario }
    function Get_CURP: UnicodeString;
    function Get_NumNotaria: Integer;
    function Get_EntidadFederativa: UnicodeString;
    function Get_Adscripcion: UnicodeString;
    procedure Set_CURP(Value: UnicodeString);
    procedure Set_NumNotaria(Value: Integer);
    procedure Set_EntidadFederativa(Value: UnicodeString);
    procedure Set_Adscripcion(Value: UnicodeString);
  end;

{ TNotariosPublicosV10_DatosEnajenante }

  TNotariosPublicosV10_DatosEnajenante = class(TXMLNode, INotariosPublicosV10_DatosEnajenante)
  protected
    { INotariosPublicosV10_DatosEnajenante }
    function Get_CoproSocConyugalE: UnicodeString;
    function Get_DatosUnEnajenante: INotariosPublicosV10_DatosEnajenante_DatosUnEnajenante;
    function Get_DatosEnajenantesCopSC: INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC;
    procedure Set_CoproSocConyugalE(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TNotariosPublicosV10_DatosEnajenante_DatosUnEnajenante }

  TNotariosPublicosV10_DatosEnajenante_DatosUnEnajenante = class(TXMLNode, INotariosPublicosV10_DatosEnajenante_DatosUnEnajenante)
  protected
    { INotariosPublicosV10_DatosEnajenante_DatosUnEnajenante }
    function Get_Nombre: UnicodeString;
    function Get_ApellidoPaterno: UnicodeString;
    function Get_ApellidoMaterno: UnicodeString;
    function Get_RFC: UnicodeString;
    function Get_CURP: UnicodeString;
    procedure Set_Nombre(Value: UnicodeString);
    procedure Set_ApellidoPaterno(Value: UnicodeString);
    procedure Set_ApellidoMaterno(Value: UnicodeString);
    procedure Set_RFC(Value: UnicodeString);
    procedure Set_CURP(Value: UnicodeString);
  end;

{ TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC }

  TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC = class(TXMLNodeCollection, INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC)
  protected
    { INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC }
    function Get_DatosEnajenanteCopSC(Index: Integer): INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC;
    function Add: INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC;
    function Insert(const Index: Integer): INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC;
  public
    procedure AfterConstruction; override;
  end;

{ TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC }

  TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC = class(TXMLNode, INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC)
  protected
    { INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC }
    function Get_Nombre: UnicodeString;
    function Get_ApellidoPaterno: UnicodeString;
    function Get_ApellidoMaterno: UnicodeString;
    function Get_RFC: UnicodeString;
    function Get_CURP: UnicodeString;
    function Get_Porcentaje: UnicodeString;
    procedure Set_Nombre(Value: UnicodeString);
    procedure Set_ApellidoPaterno(Value: UnicodeString);
    procedure Set_ApellidoMaterno(Value: UnicodeString);
    procedure Set_RFC(Value: UnicodeString);
    procedure Set_CURP(Value: UnicodeString);
    procedure Set_Porcentaje(Value: UnicodeString);
  end;

{ TNotariosPublicosV10_DatosAdquiriente }

  TNotariosPublicosV10_DatosAdquiriente = class(TXMLNode, INotariosPublicosV10_DatosAdquiriente)
  protected
    { INotariosPublicosV10_DatosAdquiriente }
    function Get_CoproSocConyugalE: UnicodeString;
    function Get_DatosUnAdquiriente: INotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente;
    function Get_DatosAdquirientesCopSC: INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC;
    procedure Set_CoproSocConyugalE(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TNotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente }

  TNotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente = class(TXMLNode, INotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente)
  protected
    { INotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente }
    function Get_Nombre: UnicodeString;
    function Get_ApellidoPaterno: UnicodeString;
    function Get_ApellidoMaterno: UnicodeString;
    function Get_RFC: UnicodeString;
    function Get_CURP: UnicodeString;
    procedure Set_Nombre(Value: UnicodeString);
    procedure Set_ApellidoPaterno(Value: UnicodeString);
    procedure Set_ApellidoMaterno(Value: UnicodeString);
    procedure Set_RFC(Value: UnicodeString);
    procedure Set_CURP(Value: UnicodeString);
  end;

{ TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC }

  TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC = class(TXMLNodeCollection, INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC)
  protected
    { INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC }
    function Get_DatosAdquirienteCopSC(Index: Integer): INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC;
    function Add: INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC;
    function Insert(const Index: Integer): INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC;
  public
    procedure AfterConstruction; override;
  end;

{ TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC }

  TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC = class(TXMLNode, INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC)
  protected
    { INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC }
    function Get_Nombre: UnicodeString;
    function Get_ApellidoPaterno: UnicodeString;
    function Get_ApellidoMaterno: UnicodeString;
    function Get_RFC: UnicodeString;
    function Get_CURP: UnicodeString;
    function Get_Porcentaje: UnicodeString;
    procedure Set_Nombre(Value: UnicodeString);
    procedure Set_ApellidoPaterno(Value: UnicodeString);
    procedure Set_ApellidoMaterno(Value: UnicodeString);
    procedure Set_RFC(Value: UnicodeString);
    procedure Set_CURP(Value: UnicodeString);
    procedure Set_Porcentaje(Value: UnicodeString);
  end;

{ Global Functions }

function GetNotariosPublicosV10(Doc: IXMLDocument): INotariosPublicosV10;
function LoadNotariosPublicosV10(const FileName: string): INotariosPublicosV10;
function NewNotariosPublicosV10: INotariosPublicosV10;

const
  TargetNamespace = 'http://www.sat.gob.mx/notariospublicos';

implementation

uses xmlutil;

{ Global Functions }

function GetNotariosPublicosV10(Doc: IXMLDocument): INotariosPublicosV10;
begin
  Result := Doc.GetDocBinding('notariospublicos:NotariosPublicos', TNotariosPublicosV10, TargetNamespace) as INotariosPublicosV10;
end;

function LoadNotariosPublicosV10(const FileName: string): INotariosPublicosV10;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('notariospublicos:NotariosPublicos', TNotariosPublicosV10, TargetNamespace) as INotariosPublicosV10;
end;

function NewNotariosPublicosV10: INotariosPublicosV10;
begin
  Result := NewXMLDocument.GetDocBinding('notariospublicos:NotariosPublicos', TNotariosPublicosV10, TargetNamespace) as INotariosPublicosV10;
end;

{ TNotariosPublicosV10 }

procedure TNotariosPublicosV10.AfterConstruction;
begin
  if (Self.AttributeNodes.FindNode('Version') = nil) then
      Self.Set_Version('1.0');
  RegisterChildNode('DescInmuebles', TNotariosPublicosV10_DescInmuebles);
  RegisterChildNode('DatosOperacion', TNotariosPublicosV10_DatosOperacion);
  RegisterChildNode('DatosNotario', TNotariosPublicosV10_DatosNotario);
  RegisterChildNode('DatosEnajenante', TNotariosPublicosV10_DatosEnajenante);
  RegisterChildNode('DatosAdquiriente', TNotariosPublicosV10_DatosAdquiriente);
  inherited;
end;

function TNotariosPublicosV10.Get_Version: UnicodeString;
begin
  Result := AttributeNodes['Version'].Text;
end;

procedure TNotariosPublicosV10.Set_Version(Value: UnicodeString);
begin
  SetAttribute('Version', Value);
end;

function TNotariosPublicosV10.Get_DescInmuebles: INotariosPublicosV10_DescInmuebles;
begin
  Result := ChildNodes['DescInmuebles'] as INotariosPublicosV10_DescInmuebles;
end;

function TNotariosPublicosV10.Get_DatosOperacion: INotariosPublicosV10_DatosOperacion;
begin
  Result := ChildNodes['DatosOperacion'] as INotariosPublicosV10_DatosOperacion;
end;

function TNotariosPublicosV10.Get_DatosNotario: INotariosPublicosV10_DatosNotario;
begin
  Result := ChildNodes['DatosNotario'] as INotariosPublicosV10_DatosNotario;
end;

function TNotariosPublicosV10.Get_DatosEnajenante: INotariosPublicosV10_DatosEnajenante;
begin
  Result := ChildNodes['DatosEnajenante'] as INotariosPublicosV10_DatosEnajenante;
end;

function TNotariosPublicosV10.Get_DatosAdquiriente: INotariosPublicosV10_DatosAdquiriente;
begin
  Result := ChildNodes['DatosAdquiriente'] as INotariosPublicosV10_DatosAdquiriente;
end;

{ TNotariosPublicosV10_DescInmuebles }

procedure TNotariosPublicosV10_DescInmuebles.AfterConstruction;
begin
  RegisterChildNode('DescInmueble', TNotariosPublicosV10_DescInmuebles_DescInmueble);
  ItemTag := 'DescInmueble';
  ItemInterface := INotariosPublicosV10_DescInmuebles_DescInmueble;
  inherited;
end;

function TNotariosPublicosV10_DescInmuebles.Get_DescInmueble(Index: Integer): INotariosPublicosV10_DescInmuebles_DescInmueble;
begin
  Result := List[Index] as INotariosPublicosV10_DescInmuebles_DescInmueble;
end;

function TNotariosPublicosV10_DescInmuebles.Add: INotariosPublicosV10_DescInmuebles_DescInmueble;
begin
  Result := AddItem(-1) as INotariosPublicosV10_DescInmuebles_DescInmueble;
end;

function TNotariosPublicosV10_DescInmuebles.Insert(const Index: Integer): INotariosPublicosV10_DescInmuebles_DescInmueble;
begin
  Result := AddItem(Index) as INotariosPublicosV10_DescInmuebles_DescInmueble;
end;

{ TNotariosPublicosV10_DescInmuebles_DescInmueble }

function TNotariosPublicosV10_DescInmuebles_DescInmueble.Get_TipoInmueble: UnicodeString;
begin
  Result := AttributeNodes['TipoInmueble'].Text;
end;

procedure TNotariosPublicosV10_DescInmuebles_DescInmueble.Set_TipoInmueble(Value: UnicodeString);
begin
  SetAttribute('TipoInmueble', Value);
end;

function TNotariosPublicosV10_DescInmuebles_DescInmueble.Get_Calle: UnicodeString;
begin
  Result := AttributeNodes['Calle'].Text;
end;

procedure TNotariosPublicosV10_DescInmuebles_DescInmueble.Set_Calle(Value: UnicodeString);
begin
  SetAttribute('Calle', Value);
end;

function TNotariosPublicosV10_DescInmuebles_DescInmueble.Get_NoExterior: UnicodeString;
begin
  Result := AttributeNodes['NoExterior'].Text;
end;

procedure TNotariosPublicosV10_DescInmuebles_DescInmueble.Set_NoExterior(Value: UnicodeString);
begin
  SetAttribute('NoExterior', Value);
end;

function TNotariosPublicosV10_DescInmuebles_DescInmueble.Get_NoInterior: UnicodeString;
begin
  Result := AttributeNodes['NoInterior'].Text;
end;

procedure TNotariosPublicosV10_DescInmuebles_DescInmueble.Set_NoInterior(Value: UnicodeString);
begin
  SetAttribute('NoInterior', Value);
end;

function TNotariosPublicosV10_DescInmuebles_DescInmueble.Get_Colonia: UnicodeString;
begin
  Result := AttributeNodes['Colonia'].Text;
end;

procedure TNotariosPublicosV10_DescInmuebles_DescInmueble.Set_Colonia(Value: UnicodeString);
begin
  SetAttribute('Colonia', Value);
end;

function TNotariosPublicosV10_DescInmuebles_DescInmueble.Get_Localidad: UnicodeString;
begin
  Result := AttributeNodes['Localidad'].Text;
end;

procedure TNotariosPublicosV10_DescInmuebles_DescInmueble.Set_Localidad(Value: UnicodeString);
begin
  SetAttribute('Localidad', Value);
end;

function TNotariosPublicosV10_DescInmuebles_DescInmueble.Get_Referencia: UnicodeString;
begin
  Result := AttributeNodes['Referencia'].Text;
end;

procedure TNotariosPublicosV10_DescInmuebles_DescInmueble.Set_Referencia(Value: UnicodeString);
begin
  SetAttribute('Referencia', Value);
end;

function TNotariosPublicosV10_DescInmuebles_DescInmueble.Get_Municipio: UnicodeString;
begin
  Result := AttributeNodes['Municipio'].Text;
end;

procedure TNotariosPublicosV10_DescInmuebles_DescInmueble.Set_Municipio(Value: UnicodeString);
begin
  SetAttribute('Municipio', Value);
end;

function TNotariosPublicosV10_DescInmuebles_DescInmueble.Get_Estado: UnicodeString;
begin
  Result := AttributeNodes['Estado'].Text;
end;

procedure TNotariosPublicosV10_DescInmuebles_DescInmueble.Set_Estado(Value: UnicodeString);
begin
  SetAttribute('Estado', Value);
end;

function TNotariosPublicosV10_DescInmuebles_DescInmueble.Get_Pais: UnicodeString;
begin
  Result := AttributeNodes['Pais'].Text;
end;

procedure TNotariosPublicosV10_DescInmuebles_DescInmueble.Set_Pais(Value: UnicodeString);
begin
  SetAttribute('Pais', Value);
end;

function TNotariosPublicosV10_DescInmuebles_DescInmueble.Get_CodigoPostal: UnicodeString;
begin
  Result := AttributeNodes['CodigoPostal'].Text;
end;

procedure TNotariosPublicosV10_DescInmuebles_DescInmueble.Set_CodigoPostal(Value: UnicodeString);
begin
  SetAttribute('CodigoPostal', Value);
end;

{ TNotariosPublicosV10_DatosOperacion }

function TNotariosPublicosV10_DatosOperacion.Get_NumInstrumentoNotarial: Integer;
begin
  Result := AttributeNodes['NumInstrumentoNotarial'].NodeValue;
end;

procedure TNotariosPublicosV10_DatosOperacion.Set_NumInstrumentoNotarial(Value: Integer);
begin
  SetAttribute('NumInstrumentoNotarial', Value);
end;

function TNotariosPublicosV10_DatosOperacion.Get_FechaInstNotarial: UnicodeString;
begin
  Result := AttributeNodes['FechaInstNotarial'].Text;
end;

procedure TNotariosPublicosV10_DatosOperacion.Set_FechaInstNotarial(Value: UnicodeString);
begin
  SetAttribute('FechaInstNotarial', Value);
end;

function TNotariosPublicosV10_DatosOperacion.Get_MontoOperacion: UnicodeString;
begin
  Result := AttributeNodes['MontoOperacion'].Text;
end;

procedure TNotariosPublicosV10_DatosOperacion.Set_MontoOperacion(Value: UnicodeString);
begin
  SetAttribute('MontoOperacion', Value);
end;

function TNotariosPublicosV10_DatosOperacion.Get_Subtotal: UnicodeString;
begin
  Result := AttributeNodes['Subtotal'].Text;
end;

procedure TNotariosPublicosV10_DatosOperacion.Set_Subtotal(Value: UnicodeString);
begin
  SetAttribute('Subtotal', Value);
end;

function TNotariosPublicosV10_DatosOperacion.Get_IVA: UnicodeString;
begin
  Result := AttributeNodes['IVA'].Text;
end;

procedure TNotariosPublicosV10_DatosOperacion.Set_IVA(Value: UnicodeString);
begin
  SetAttribute('IVA', Value);
end;

{ TNotariosPublicosV10_DatosNotario }

function TNotariosPublicosV10_DatosNotario.Get_CURP: UnicodeString;
begin
  Result := AttributeNodes['CURP'].Text;
end;

procedure TNotariosPublicosV10_DatosNotario.Set_CURP(Value: UnicodeString);
begin
  SetAttribute('CURP', Value);
end;

function TNotariosPublicosV10_DatosNotario.Get_NumNotaria: Integer;
begin
  Result := AttributeNodes['NumNotaria'].NodeValue;
end;

procedure TNotariosPublicosV10_DatosNotario.Set_NumNotaria(Value: Integer);
begin
  SetAttribute('NumNotaria', Value);
end;

function TNotariosPublicosV10_DatosNotario.Get_EntidadFederativa: UnicodeString;
begin
  Result := AttributeNodes['EntidadFederativa'].Text;
end;

procedure TNotariosPublicosV10_DatosNotario.Set_EntidadFederativa(Value: UnicodeString);
begin
  SetAttribute('EntidadFederativa', Value);
end;

function TNotariosPublicosV10_DatosNotario.Get_Adscripcion: UnicodeString;
begin
  Result := AttributeNodes['Adscripcion'].Text;
end;

procedure TNotariosPublicosV10_DatosNotario.Set_Adscripcion(Value: UnicodeString);
begin
  SetAttribute('Adscripcion', Value);
end;

{ TNotariosPublicosV10_DatosEnajenante }

procedure TNotariosPublicosV10_DatosEnajenante.AfterConstruction;
begin
  RegisterChildNode('DatosUnEnajenante', TNotariosPublicosV10_DatosEnajenante_DatosUnEnajenante);
  RegisterChildNode('DatosEnajenantesCopSC', TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC);
  inherited;
end;

function TNotariosPublicosV10_DatosEnajenante.Get_CoproSocConyugalE: UnicodeString;
begin
  Result := AttributeNodes['CoproSocConyugalE'].Text;
end;

procedure TNotariosPublicosV10_DatosEnajenante.Set_CoproSocConyugalE(Value: UnicodeString);
begin
  SetAttribute('CoproSocConyugalE', Value);
end;

function TNotariosPublicosV10_DatosEnajenante.Get_DatosUnEnajenante: INotariosPublicosV10_DatosEnajenante_DatosUnEnajenante;
begin
  Result := ChildNodes['DatosUnEnajenante'] as INotariosPublicosV10_DatosEnajenante_DatosUnEnajenante;
end;

function TNotariosPublicosV10_DatosEnajenante.Get_DatosEnajenantesCopSC: INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC;
begin
  Result := ChildNodes['DatosEnajenantesCopSC'] as INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC;
end;

{ TNotariosPublicosV10_DatosEnajenante_DatosUnEnajenante }

function TNotariosPublicosV10_DatosEnajenante_DatosUnEnajenante.Get_Nombre: UnicodeString;
begin
  Result := AttributeNodes['Nombre'].Text;
end;

procedure TNotariosPublicosV10_DatosEnajenante_DatosUnEnajenante.Set_Nombre(Value: UnicodeString);
begin
  SetAttribute('Nombre', Value);
end;

function TNotariosPublicosV10_DatosEnajenante_DatosUnEnajenante.Get_ApellidoPaterno: UnicodeString;
begin
  Result := AttributeNodes['ApellidoPaterno'].Text;
end;

procedure TNotariosPublicosV10_DatosEnajenante_DatosUnEnajenante.Set_ApellidoPaterno(Value: UnicodeString);
begin
  SetAttribute('ApellidoPaterno', Value);
end;

function TNotariosPublicosV10_DatosEnajenante_DatosUnEnajenante.Get_ApellidoMaterno: UnicodeString;
begin
  Result := AttributeNodes['ApellidoMaterno'].Text;
end;

procedure TNotariosPublicosV10_DatosEnajenante_DatosUnEnajenante.Set_ApellidoMaterno(Value: UnicodeString);
begin
  SetAttribute('ApellidoMaterno', Value);
end;

function TNotariosPublicosV10_DatosEnajenante_DatosUnEnajenante.Get_RFC: UnicodeString;
begin
  Result := AttributeNodes['RFC'].Text;
end;

procedure TNotariosPublicosV10_DatosEnajenante_DatosUnEnajenante.Set_RFC(Value: UnicodeString);
begin
  SetAttribute('RFC', Value);
end;

function TNotariosPublicosV10_DatosEnajenante_DatosUnEnajenante.Get_CURP: UnicodeString;
begin
  Result := AttributeNodes['CURP'].Text;
end;

procedure TNotariosPublicosV10_DatosEnajenante_DatosUnEnajenante.Set_CURP(Value: UnicodeString);
begin
  SetAttribute('CURP', Value);
end;

{ TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC }

procedure TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC.AfterConstruction;
begin
  RegisterChildNode('DatosEnajenanteCopSC', TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC);
  ItemTag := 'DatosEnajenanteCopSC';
  ItemInterface := INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC;
  inherited;
end;

function TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC.Get_DatosEnajenanteCopSC(Index: Integer): INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC;
begin
  Result := List[Index] as INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC;
end;

function TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC.Add: INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC;
begin
  Result := AddItem(-1) as INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC;
end;

function TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC.Insert(const Index: Integer): INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC;
begin
  Result := AddItem(Index) as INotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC;
end;

{ TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC }

function TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC.Get_Nombre: UnicodeString;
begin
  Result := AttributeNodes['Nombre'].Text;
end;

procedure TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC.Set_Nombre(Value: UnicodeString);
begin
  SetAttribute('Nombre', Value);
end;

function TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC.Get_ApellidoPaterno: UnicodeString;
begin
  Result := AttributeNodes['ApellidoPaterno'].Text;
end;

procedure TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC.Set_ApellidoPaterno(Value: UnicodeString);
begin
  SetAttribute('ApellidoPaterno', Value);
end;

function TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC.Get_ApellidoMaterno: UnicodeString;
begin
  Result := AttributeNodes['ApellidoMaterno'].Text;
end;

procedure TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC.Set_ApellidoMaterno(Value: UnicodeString);
begin
  SetAttribute('ApellidoMaterno', Value);
end;

function TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC.Get_RFC: UnicodeString;
begin
  Result := AttributeNodes['RFC'].Text;
end;

procedure TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC.Set_RFC(Value: UnicodeString);
begin
  SetAttribute('RFC', Value);
end;

function TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC.Get_CURP: UnicodeString;
begin
  Result := AttributeNodes['CURP'].Text;
end;

procedure TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC.Set_CURP(Value: UnicodeString);
begin
  SetAttribute('CURP', Value);
end;

function TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC.Get_Porcentaje: UnicodeString;
begin
  Result := AttributeNodes['Porcentaje'].Text;
end;

procedure TNotariosPublicosV10_DatosEnajenante_DatosEnajenantesCopSC_DatosEnajenanteCopSC.Set_Porcentaje(Value: UnicodeString);
begin
  SetAttribute('Porcentaje', Value);
end;

{ TNotariosPublicosV10_DatosAdquiriente }

procedure TNotariosPublicosV10_DatosAdquiriente.AfterConstruction;
begin
  RegisterChildNode('DatosUnAdquiriente', TNotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente);
  RegisterChildNode('DatosAdquirientesCopSC', TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC);
  inherited;
end;

function TNotariosPublicosV10_DatosAdquiriente.Get_CoproSocConyugalE: UnicodeString;
begin
  Result := AttributeNodes['CoproSocConyugalE'].Text;
end;

procedure TNotariosPublicosV10_DatosAdquiriente.Set_CoproSocConyugalE(Value: UnicodeString);
begin
  SetAttribute('CoproSocConyugalE', Value);
end;

function TNotariosPublicosV10_DatosAdquiriente.Get_DatosUnAdquiriente: INotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente;
begin
  Result := ChildNodes['DatosUnAdquiriente'] as INotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente;
end;

function TNotariosPublicosV10_DatosAdquiriente.Get_DatosAdquirientesCopSC: INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC;
begin
  Result := ChildNodes['DatosAdquirientesCopSC'] as INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC;
end;

{ TNotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente }

function TNotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente.Get_Nombre: UnicodeString;
begin
  Result := AttributeNodes['Nombre'].Text;
end;

procedure TNotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente.Set_Nombre(Value: UnicodeString);
begin
  SetAttribute('Nombre', Value);
end;

function TNotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente.Get_ApellidoPaterno: UnicodeString;
begin
  Result := AttributeNodes['ApellidoPaterno'].Text;
end;

procedure TNotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente.Set_ApellidoPaterno(Value: UnicodeString);
begin
  SetAttribute('ApellidoPaterno', Value);
end;

function TNotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente.Get_ApellidoMaterno: UnicodeString;
begin
  Result := AttributeNodes['ApellidoMaterno'].Text;
end;

procedure TNotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente.Set_ApellidoMaterno(Value: UnicodeString);
begin
  SetAttribute('ApellidoMaterno', Value);
end;

function TNotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente.Get_RFC: UnicodeString;
begin
  Result := AttributeNodes['RFC'].Text;
end;

procedure TNotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente.Set_RFC(Value: UnicodeString);
begin
  SetAttribute('RFC', Value);
end;

function TNotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente.Get_CURP: UnicodeString;
begin
  Result := AttributeNodes['CURP'].Text;
end;

procedure TNotariosPublicosV10_DatosAdquiriente_DatosUnAdquiriente.Set_CURP(Value: UnicodeString);
begin
  SetAttribute('CURP', Value);
end;

{ TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC }

procedure TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC.AfterConstruction;
begin
  RegisterChildNode('DatosAdquirienteCopSC', TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC);
  ItemTag := 'DatosAdquirienteCopSC';
  ItemInterface := INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC;
  inherited;
end;

function TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC.Get_DatosAdquirienteCopSC(Index: Integer): INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC;
begin
  Result := List[Index] as INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC;
end;

function TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC.Add: INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC;
begin
  Result := AddItem(-1) as INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC;
end;

function TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC.Insert(const Index: Integer): INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC;
begin
  Result := AddItem(Index) as INotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC;
end;

{ TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC }

function TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC.Get_Nombre: UnicodeString;
begin
  Result := AttributeNodes['Nombre'].Text;
end;

procedure TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC.Set_Nombre(Value: UnicodeString);
begin
  SetAttribute('Nombre', Value);
end;

function TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC.Get_ApellidoPaterno: UnicodeString;
begin
  Result := AttributeNodes['ApellidoPaterno'].Text;
end;

procedure TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC.Set_ApellidoPaterno(Value: UnicodeString);
begin
  SetAttribute('ApellidoPaterno', Value);
end;

function TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC.Get_ApellidoMaterno: UnicodeString;
begin
  Result := AttributeNodes['ApellidoMaterno'].Text;
end;

procedure TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC.Set_ApellidoMaterno(Value: UnicodeString);
begin
  SetAttribute('ApellidoMaterno', Value);
end;

function TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC.Get_RFC: UnicodeString;
begin
  Result := AttributeNodes['RFC'].Text;
end;

procedure TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC.Set_RFC(Value: UnicodeString);
begin
  SetAttribute('RFC', Value);
end;

function TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC.Get_CURP: UnicodeString;
begin
  Result := AttributeNodes['CURP'].Text;
end;

procedure TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC.Set_CURP(Value: UnicodeString);
begin
  SetAttribute('CURP', Value);
end;

function TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC.Get_Porcentaje: UnicodeString;
begin
  Result := AttributeNodes['Porcentaje'].Text;
end;

procedure TNotariosPublicosV10_DatosAdquiriente_DatosAdquirientesCopSC_DatosAdquirienteCopSC.Set_Porcentaje(Value: UnicodeString);
begin
  SetAttribute('Porcentaje', Value);
end;

end.