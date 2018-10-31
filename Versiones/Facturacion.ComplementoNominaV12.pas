{***********************************************************}
{                                                           }
{       TFacturaElectronica                                 }
{                                                           }
{       Copyright (C) 2018 Bambu Code SA de CV              }
{       Soporte del Complemento Nómina v1.2                 }
{                                                           }
{***********************************************************}

{****************************************************************************************************************}
{                                                                                                                }
{                                          XML Data Binding                                                      }
{                                                                                                                }
{       Generated on: 27/09/2018 07:02:37 p.m.                                                                   }
{       Generated from: Generated from: http://www.sat.gob.mx/sitio_internet/cfd/nomina12//nomina12.xsd          }
{                                                                                                                }
{****************************************************************************************************************}

unit Facturacion.ComplementoNominaV12;

interface

uses xmldom, XMLDoc, XMLIntf, Facturacion.Comprobante;

type

{ Forward Decls }

  INominaV12 = interface;
  INominaV12_Emisor = interface;
  INominaV12_Emisor_EntidadSNCF = interface;
  INominaV12_Receptor = interface;
  INominaV12_Receptor_SubContratacion = interface;
  INominaV12_Percepciones = interface;
  INominaV12_Percepciones_Percepcion = interface;
  INominaV12_Percepciones_PercepcionList = interface;
  INominaV12_Percepciones_Percepcion_AccionesOTitulos = interface;
  INominaV12_Percepciones_Percepcion_HorasExtra = interface;
  INominaV12_Percepciones_Percepcion_HorasExtraList = interface;
  INominaV12_Percepciones_JubilacionPensionRetiro = interface;
  INominaV12_Percepciones_SeparacionIndemnizacion = interface;
  INominaV12_Deducciones = interface;
  INominaV12_Deducciones_Deduccion = interface;
  INominaV12_OtrosPagos = interface;
  INominaV12_OtrosPagos_OtroPago = interface;
  INominaV12_OtrosPagos_OtroPago_SubsidioAlEmpleo = interface;
  INominaV12_OtrosPagos_OtroPago_CompensacionSaldosAFavor = interface;
  INominaV12_Incapacidades = interface;
  INominaV12_Incapacidades_Incapacidad = interface;

{ INominaV12 }

  INominaV12 = interface(IXMLNode)
    ['{B57CF6BA-80BD-4BC5-B7F4-16B29EBFB8E6}']
    { Property Accessors }
    function Get_Version: UnicodeString;
    function Get_TipoNomina: UnicodeString;
    function Get_FechaPago: UnicodeString;
    function Get_FechaInicialPago: UnicodeString;
    function Get_FechaFinalPago: UnicodeString;
    function Get_NumDiasPagados: UnicodeString;
    function Get_TotalPercepciones: UnicodeString;
    function Get_TotalDeducciones: UnicodeString;
    function Get_TotalOtrosPagos: UnicodeString;
    function Get_Emisor: INominaV12_Emisor;
    function Get_Receptor: INominaV12_Receptor;
    function Get_Percepciones: INominaV12_Percepciones;
    function Get_Deducciones: INominaV12_Deducciones;
    function Get_OtrosPagos: INominaV12_OtrosPagos;
    function Get_Incapacidades: INominaV12_Incapacidades;
    procedure Set_Version(Value: UnicodeString);
    procedure Set_TipoNomina(Value: UnicodeString);
    procedure Set_FechaPago(Value: UnicodeString);
    procedure Set_FechaInicialPago(Value: UnicodeString);
    procedure Set_FechaFinalPago(Value: UnicodeString);
    procedure Set_NumDiasPagados(Value: UnicodeString);
    procedure Set_TotalPercepciones(Value: UnicodeString);
    procedure Set_TotalDeducciones(Value: UnicodeString);
    procedure Set_TotalOtrosPagos(Value: UnicodeString);
    { Methods & Properties }
    property Version: UnicodeString read Get_Version write Set_Version;
    property TipoNomina: UnicodeString read Get_TipoNomina write Set_TipoNomina;
    property FechaPago: UnicodeString read Get_FechaPago write Set_FechaPago;
    property FechaInicialPago: UnicodeString read Get_FechaInicialPago write Set_FechaInicialPago;
    property FechaFinalPago: UnicodeString read Get_FechaFinalPago write Set_FechaFinalPago;
    property NumDiasPagados: UnicodeString read Get_NumDiasPagados write Set_NumDiasPagados;
    property TotalPercepciones: UnicodeString read Get_TotalPercepciones write Set_TotalPercepciones;
    property TotalDeducciones: UnicodeString read Get_TotalDeducciones write Set_TotalDeducciones;
    property TotalOtrosPagos: UnicodeString read Get_TotalOtrosPagos write Set_TotalOtrosPagos;
    property Emisor: INominaV12_Emisor read Get_Emisor;
    property Receptor: INominaV12_Receptor read Get_Receptor;
    property Percepciones: INominaV12_Percepciones read Get_Percepciones;
    property Deducciones: INominaV12_Deducciones read Get_Deducciones;
    property OtrosPagos: INominaV12_OtrosPagos read Get_OtrosPagos;
    property Incapacidades: INominaV12_Incapacidades read Get_Incapacidades;
  end;

{ INominaV12_Emisor }

  INominaV12_Emisor = interface(IXMLNode)
    ['{AFB57121-6D51-46B2-9D0F-E295594FFC0C}']
    { Property Accessors }
    function Get_Curp: UnicodeString;
    function Get_RegistroPatronal: UnicodeString;
    function Get_RfcPatronOrigen: UnicodeString;
    function Get_EntidadSNCF: INominaV12_Emisor_EntidadSNCF;
    procedure Set_Curp(Value: UnicodeString);
    procedure Set_RegistroPatronal(Value: UnicodeString);
    procedure Set_RfcPatronOrigen(Value: UnicodeString);
    { Methods & Properties }
    property Curp: UnicodeString read Get_Curp write Set_Curp;
    property RegistroPatronal: UnicodeString read Get_RegistroPatronal write Set_RegistroPatronal;
    property RfcPatronOrigen: UnicodeString read Get_RfcPatronOrigen write Set_RfcPatronOrigen;
    property EntidadSNCF: INominaV12_Emisor_EntidadSNCF read Get_EntidadSNCF;
  end;

{ INominaV12_Emisor_EntidadSNCF }

  INominaV12_Emisor_EntidadSNCF = interface(IXMLNode)
    ['{913BB8A3-4327-4C5C-96A9-08E9B399DB5A}']
    { Property Accessors }
    function Get_OrigenRecurso: UnicodeString;
    function Get_MontoRecursoPropio: UnicodeString;
    procedure Set_OrigenRecurso(Value: UnicodeString);
    procedure Set_MontoRecursoPropio(Value: UnicodeString);
    { Methods & Properties }
    property OrigenRecurso: UnicodeString read Get_OrigenRecurso write Set_OrigenRecurso;
    property MontoRecursoPropio: UnicodeString read Get_MontoRecursoPropio write Set_MontoRecursoPropio;
  end;

{ INominaV12_Receptor }

  INominaV12_Receptor = interface(IXMLNodeCollection)
    ['{5F44EF0B-A4B9-4799-97E2-2EC8C990D8A0}']
    { Property Accessors }
    function Get_Curp: UnicodeString;
    function Get_NumSeguridadSocial: UnicodeString;
    function Get_FechaInicioRelLaboral: UnicodeString;
    function Get_Antigüedad: UnicodeString;
    function Get_TipoContrato: UnicodeString;
    function Get_Sindicalizado: UnicodeString;
    function Get_TipoJornada: UnicodeString;
    function Get_TipoRegimen: UnicodeString;
    function Get_NumEmpleado: UnicodeString;
    function Get_Departamento: UnicodeString;
    function Get_Puesto: UnicodeString;
    function Get_RiesgoPuesto: UnicodeString;
    function Get_PeriodicidadPago: UnicodeString;
    function Get_Banco: UnicodeString;
    function Get_CuentaBancaria: Integer;
    function Get_SalarioBaseCotApor: UnicodeString;
    function Get_SalarioDiarioIntegrado: UnicodeString;
    function Get_ClaveEntFed: UnicodeString;
    function Get_SubContratacion(Index: Integer): INominaV12_Receptor_SubContratacion;
    procedure Set_Curp(Value: UnicodeString);
    procedure Set_NumSeguridadSocial(Value: UnicodeString);
    procedure Set_FechaInicioRelLaboral(Value: UnicodeString);
    procedure Set_Antigüedad(Value: UnicodeString);
    procedure Set_TipoContrato(Value: UnicodeString);
    procedure Set_Sindicalizado(Value: UnicodeString);
    procedure Set_TipoJornada(Value: UnicodeString);
    procedure Set_TipoRegimen(Value: UnicodeString);
    procedure Set_NumEmpleado(Value: UnicodeString);
    procedure Set_Departamento(Value: UnicodeString);
    procedure Set_Puesto(Value: UnicodeString);
    procedure Set_RiesgoPuesto(Value: UnicodeString);
    procedure Set_PeriodicidadPago(Value: UnicodeString);
    procedure Set_Banco(Value: UnicodeString);
    procedure Set_CuentaBancaria(Value: Integer);
    procedure Set_SalarioBaseCotApor(Value: UnicodeString);
    procedure Set_SalarioDiarioIntegrado(Value: UnicodeString);
    procedure Set_ClaveEntFed(Value: UnicodeString);
    { Methods & Properties }
    function Add: INominaV12_Receptor_SubContratacion;
    function Insert(const Index: Integer): INominaV12_Receptor_SubContratacion;
    property Curp: UnicodeString read Get_Curp write Set_Curp;
    property NumSeguridadSocial: UnicodeString read Get_NumSeguridadSocial write Set_NumSeguridadSocial;
    property FechaInicioRelLaboral: UnicodeString read Get_FechaInicioRelLaboral write Set_FechaInicioRelLaboral;
    property Antigüedad: UnicodeString read Get_Antigüedad write Set_Antigüedad;
    property TipoContrato: UnicodeString read Get_TipoContrato write Set_TipoContrato;
    property Sindicalizado: UnicodeString read Get_Sindicalizado write Set_Sindicalizado;
    property TipoJornada: UnicodeString read Get_TipoJornada write Set_TipoJornada;
    property TipoRegimen: UnicodeString read Get_TipoRegimen write Set_TipoRegimen;
    property NumEmpleado: UnicodeString read Get_NumEmpleado write Set_NumEmpleado;
    property Departamento: UnicodeString read Get_Departamento write Set_Departamento;
    property Puesto: UnicodeString read Get_Puesto write Set_Puesto;
    property RiesgoPuesto: UnicodeString read Get_RiesgoPuesto write Set_RiesgoPuesto;
    property PeriodicidadPago: UnicodeString read Get_PeriodicidadPago write Set_PeriodicidadPago;
    property Banco: UnicodeString read Get_Banco write Set_Banco;
    property CuentaBancaria: Integer read Get_CuentaBancaria write Set_CuentaBancaria;
    property SalarioBaseCotApor: UnicodeString read Get_SalarioBaseCotApor write Set_SalarioBaseCotApor;
    property SalarioDiarioIntegrado: UnicodeString read Get_SalarioDiarioIntegrado write Set_SalarioDiarioIntegrado;
    property ClaveEntFed: UnicodeString read Get_ClaveEntFed write Set_ClaveEntFed;
    property SubContratacion[Index: Integer]: INominaV12_Receptor_SubContratacion read Get_SubContratacion; default;
  end;

{ INominaV12_Receptor_SubContratacion }

  INominaV12_Receptor_SubContratacion = interface(IXMLNode)
    ['{C9EB23E2-2817-4D0E-8E07-0B7B9A3BDD5E}']
    { Property Accessors }
    function Get_RfcLabora: UnicodeString;
    function Get_PorcentajeTiempo: UnicodeString;
    procedure Set_RfcLabora(Value: UnicodeString);
    procedure Set_PorcentajeTiempo(Value: UnicodeString);
    { Methods & Properties }
    property RfcLabora: UnicodeString read Get_RfcLabora write Set_RfcLabora;
    property PorcentajeTiempo: UnicodeString read Get_PorcentajeTiempo write Set_PorcentajeTiempo;
  end;

{ INominaV12_Percepciones }

  INominaV12_Percepciones = interface(IXMLNode)
    ['{88862A46-A30D-4159-8397-8BD1B6EC3CE1}']
    { Property Accessors }
    function Get_TotalSueldos: UnicodeString;
    function Get_TotalSeparacionIndemnizacion: UnicodeString;
    function Get_TotalJubilacionPensionRetiro: UnicodeString;
    function Get_TotalGravado: UnicodeString;
    function Get_TotalExento: UnicodeString;
    function Get_Percepcion: INominaV12_Percepciones_PercepcionList;
    function Get_JubilacionPensionRetiro: INominaV12_Percepciones_JubilacionPensionRetiro;
    function Get_SeparacionIndemnizacion: INominaV12_Percepciones_SeparacionIndemnizacion;
    procedure Set_TotalSueldos(Value: UnicodeString);
    procedure Set_TotalSeparacionIndemnizacion(Value: UnicodeString);
    procedure Set_TotalJubilacionPensionRetiro(Value: UnicodeString);
    procedure Set_TotalGravado(Value: UnicodeString);
    procedure Set_TotalExento(Value: UnicodeString);
    { Methods & Properties }
    property TotalSueldos: UnicodeString read Get_TotalSueldos write Set_TotalSueldos;
    property TotalSeparacionIndemnizacion: UnicodeString read Get_TotalSeparacionIndemnizacion write Set_TotalSeparacionIndemnizacion;
    property TotalJubilacionPensionRetiro: UnicodeString read Get_TotalJubilacionPensionRetiro write Set_TotalJubilacionPensionRetiro;
    property TotalGravado: UnicodeString read Get_TotalGravado write Set_TotalGravado;
    property TotalExento: UnicodeString read Get_TotalExento write Set_TotalExento;
    property Percepcion: INominaV12_Percepciones_PercepcionList read Get_Percepcion;
    property JubilacionPensionRetiro: INominaV12_Percepciones_JubilacionPensionRetiro read Get_JubilacionPensionRetiro;
    property SeparacionIndemnizacion: INominaV12_Percepciones_SeparacionIndemnizacion read Get_SeparacionIndemnizacion;
  end;

{ INominaV12_Percepciones_Percepcion }

  INominaV12_Percepciones_Percepcion = interface(IXMLNode)
    ['{B66DA2FA-5F4F-44B0-A25C-2F35A26B6656}']
    { Property Accessors }
    function Get_TipoPercepcion: UnicodeString;
    function Get_Clave: UnicodeString;
    function Get_Concepto: UnicodeString;
    function Get_ImporteGravado: UnicodeString;
    function Get_ImporteExento: UnicodeString;
    function Get_AccionesOTitulos: INominaV12_Percepciones_Percepcion_AccionesOTitulos;
    function Get_HorasExtra: INominaV12_Percepciones_Percepcion_HorasExtraList;
    procedure Set_TipoPercepcion(Value: UnicodeString);
    procedure Set_Clave(Value: UnicodeString);
    procedure Set_Concepto(Value: UnicodeString);
    procedure Set_ImporteGravado(Value: UnicodeString);
    procedure Set_ImporteExento(Value: UnicodeString);
    { Methods & Properties }
    property TipoPercepcion: UnicodeString read Get_TipoPercepcion write Set_TipoPercepcion;
    property Clave: UnicodeString read Get_Clave write Set_Clave;
    property Concepto: UnicodeString read Get_Concepto write Set_Concepto;
    property ImporteGravado: UnicodeString read Get_ImporteGravado write Set_ImporteGravado;
    property ImporteExento: UnicodeString read Get_ImporteExento write Set_ImporteExento;
    property AccionesOTitulos: INominaV12_Percepciones_Percepcion_AccionesOTitulos read Get_AccionesOTitulos;
    property HorasExtra: INominaV12_Percepciones_Percepcion_HorasExtraList read Get_HorasExtra;
  end;

{ INominaV12_Percepciones_PercepcionList }

  INominaV12_Percepciones_PercepcionList = interface(IXMLNodeCollection)
    ['{70B16492-1489-4991-BBDD-DD075A37D5EB}']
    { Methods & Properties }
    function Add: INominaV12_Percepciones_Percepcion;
    function Insert(const Index: Integer): INominaV12_Percepciones_Percepcion;

    function Get_Item(Index: Integer): INominaV12_Percepciones_Percepcion;
    property Items[Index: Integer]: INominaV12_Percepciones_Percepcion read Get_Item; default;
  end;

{ INominaV12_Percepciones_Percepcion_AccionesOTitulos }

  INominaV12_Percepciones_Percepcion_AccionesOTitulos = interface(IXMLNode)
    ['{81A96CBC-F873-48AD-99BF-854ED5AE1AAB}']
    { Property Accessors }
    function Get_ValorMercado: UnicodeString;
    function Get_PrecioAlOtorgarse: UnicodeString;
    procedure Set_ValorMercado(Value: UnicodeString);
    procedure Set_PrecioAlOtorgarse(Value: UnicodeString);
    { Methods & Properties }
    property ValorMercado: UnicodeString read Get_ValorMercado write Set_ValorMercado;
    property PrecioAlOtorgarse: UnicodeString read Get_PrecioAlOtorgarse write Set_PrecioAlOtorgarse;
  end;

{ INominaV12_Percepciones_Percepcion_HorasExtra }

  INominaV12_Percepciones_Percepcion_HorasExtra = interface(IXMLNode)
    ['{A4D30274-5E26-4BA8-9B1B-CB80673EEE9C}']
    { Property Accessors }
    function Get_Dias: Integer;
    function Get_TipoHoras: UnicodeString;
    function Get_HorasExtra: Integer;
    function Get_ImportePagado: UnicodeString;
    procedure Set_Dias(Value: Integer);
    procedure Set_TipoHoras(Value: UnicodeString);
    procedure Set_HorasExtra(Value: Integer);
    procedure Set_ImportePagado(Value: UnicodeString);
    { Methods & Properties }
    property Dias: Integer read Get_Dias write Set_Dias;
    property TipoHoras: UnicodeString read Get_TipoHoras write Set_TipoHoras;
    property HorasExtra: Integer read Get_HorasExtra write Set_HorasExtra;
    property ImportePagado: UnicodeString read Get_ImportePagado write Set_ImportePagado;
  end;

{ INominaV12_Percepciones_Percepcion_HorasExtraList }

  INominaV12_Percepciones_Percepcion_HorasExtraList = interface(IXMLNodeCollection)
    ['{D43643A9-3CD0-4DC6-B347-6629077EAB78}']
    { Methods & Properties }
    function Add: INominaV12_Percepciones_Percepcion_HorasExtra;
    function Insert(const Index: Integer): INominaV12_Percepciones_Percepcion_HorasExtra;

    function Get_Item(Index: Integer): INominaV12_Percepciones_Percepcion_HorasExtra;
    property Items[Index: Integer]: INominaV12_Percepciones_Percepcion_HorasExtra read Get_Item; default;
  end;

{ INominaV12_Percepciones_JubilacionPensionRetiro }

  INominaV12_Percepciones_JubilacionPensionRetiro = interface(IXMLNode)
    ['{AAB29F15-6E43-46A2-911A-24C2EEF780B4}']
    { Property Accessors }
    function Get_TotalUnaExhibicion: UnicodeString;
    function Get_TotalParcialidad: UnicodeString;
    function Get_MontoDiario: UnicodeString;
    function Get_IngresoAcumulable: UnicodeString;
    function Get_IngresoNoAcumulable: UnicodeString;
    procedure Set_TotalUnaExhibicion(Value: UnicodeString);
    procedure Set_TotalParcialidad(Value: UnicodeString);
    procedure Set_MontoDiario(Value: UnicodeString);
    procedure Set_IngresoAcumulable(Value: UnicodeString);
    procedure Set_IngresoNoAcumulable(Value: UnicodeString);
    { Methods & Properties }
    property TotalUnaExhibicion: UnicodeString read Get_TotalUnaExhibicion write Set_TotalUnaExhibicion;
    property TotalParcialidad: UnicodeString read Get_TotalParcialidad write Set_TotalParcialidad;
    property MontoDiario: UnicodeString read Get_MontoDiario write Set_MontoDiario;
    property IngresoAcumulable: UnicodeString read Get_IngresoAcumulable write Set_IngresoAcumulable;
    property IngresoNoAcumulable: UnicodeString read Get_IngresoNoAcumulable write Set_IngresoNoAcumulable;
  end;

{ INominaV12_Percepciones_SeparacionIndemnizacion }

  INominaV12_Percepciones_SeparacionIndemnizacion = interface(IXMLNode)
    ['{383692BE-4254-4E43-8F01-4C1037E8D909}']
    { Property Accessors }
    function Get_TotalPagado: UnicodeString;
    function Get_NumAñosServicio: Integer;
    function Get_UltimoSueldoMensOrd: UnicodeString;
    function Get_IngresoAcumulable: UnicodeString;
    function Get_IngresoNoAcumulable: UnicodeString;
    procedure Set_TotalPagado(Value: UnicodeString);
    procedure Set_NumAñosServicio(Value: Integer);
    procedure Set_UltimoSueldoMensOrd(Value: UnicodeString);
    procedure Set_IngresoAcumulable(Value: UnicodeString);
    procedure Set_IngresoNoAcumulable(Value: UnicodeString);
    { Methods & Properties }
    property TotalPagado: UnicodeString read Get_TotalPagado write Set_TotalPagado;
    property NumAñosServicio: Integer read Get_NumAñosServicio write Set_NumAñosServicio;
    property UltimoSueldoMensOrd: UnicodeString read Get_UltimoSueldoMensOrd write Set_UltimoSueldoMensOrd;
    property IngresoAcumulable: UnicodeString read Get_IngresoAcumulable write Set_IngresoAcumulable;
    property IngresoNoAcumulable: UnicodeString read Get_IngresoNoAcumulable write Set_IngresoNoAcumulable;
  end;

{ INominaV12_Deducciones }

  INominaV12_Deducciones = interface(IXMLNodeCollection)
    ['{85E49BDB-D063-4339-83E4-2516AAD57C97}']
    { Property Accessors }
    function Get_TotalOtrasDeducciones: UnicodeString;
    function Get_TotalImpuestosRetenidos: UnicodeString;
    function Get_Deduccion(Index: Integer): INominaV12_Deducciones_Deduccion;
    procedure Set_TotalOtrasDeducciones(Value: UnicodeString);
    procedure Set_TotalImpuestosRetenidos(Value: UnicodeString);
    { Methods & Properties }
    function Add: INominaV12_Deducciones_Deduccion;
    function Insert(const Index: Integer): INominaV12_Deducciones_Deduccion;
    property TotalOtrasDeducciones: UnicodeString read Get_TotalOtrasDeducciones write Set_TotalOtrasDeducciones;
    property TotalImpuestosRetenidos: UnicodeString read Get_TotalImpuestosRetenidos write Set_TotalImpuestosRetenidos;
    property Deduccion[Index: Integer]: INominaV12_Deducciones_Deduccion read Get_Deduccion; default;
  end;

{ INominaV12_Deducciones_Deduccion }

  INominaV12_Deducciones_Deduccion = interface(IXMLNode)
    ['{00D3784D-30AC-4F18-8AEC-30EA97EBB91B}']
    { Property Accessors }
    function Get_TipoDeduccion: UnicodeString;
    function Get_Clave: UnicodeString;
    function Get_Concepto: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_TipoDeduccion(Value: UnicodeString);
    procedure Set_Clave(Value: UnicodeString);
    procedure Set_Concepto(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
    { Methods & Properties }
    property TipoDeduccion: UnicodeString read Get_TipoDeduccion write Set_TipoDeduccion;
    property Clave: UnicodeString read Get_Clave write Set_Clave;
    property Concepto: UnicodeString read Get_Concepto write Set_Concepto;
    property Importe: UnicodeString read Get_Importe write Set_Importe;
  end;

{ INominaV12_OtrosPagos }

  INominaV12_OtrosPagos = interface(IXMLNodeCollection)
    ['{13CA74E3-6DA4-4C60-A017-3E9DD4D4A0F8}']
    { Property Accessors }
    function Get_OtroPago(Index: Integer): INominaV12_OtrosPagos_OtroPago;
    { Methods & Properties }
    function Add: INominaV12_OtrosPagos_OtroPago;
    function Insert(const Index: Integer): INominaV12_OtrosPagos_OtroPago;
    property OtroPago[Index: Integer]: INominaV12_OtrosPagos_OtroPago read Get_OtroPago; default;
  end;

{ INominaV12_OtrosPagos_OtroPago }

  INominaV12_OtrosPagos_OtroPago = interface(IXMLNode)
    ['{93B46248-EE51-49FD-BAE2-EF840D28E90F}']
    { Property Accessors }
    function Get_TipoOtroPago: UnicodeString;
    function Get_Clave: UnicodeString;
    function Get_Concepto: UnicodeString;
    function Get_Importe: UnicodeString;
    function Get_SubsidioAlEmpleo: INominaV12_OtrosPagos_OtroPago_SubsidioAlEmpleo;
    function Get_CompensacionSaldosAFavor: INominaV12_OtrosPagos_OtroPago_CompensacionSaldosAFavor;
    procedure Set_TipoOtroPago(Value: UnicodeString);
    procedure Set_Clave(Value: UnicodeString);
    procedure Set_Concepto(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
    { Methods & Properties }
    property TipoOtroPago: UnicodeString read Get_TipoOtroPago write Set_TipoOtroPago;
    property Clave: UnicodeString read Get_Clave write Set_Clave;
    property Concepto: UnicodeString read Get_Concepto write Set_Concepto;
    property Importe: UnicodeString read Get_Importe write Set_Importe;
    property SubsidioAlEmpleo: INominaV12_OtrosPagos_OtroPago_SubsidioAlEmpleo read Get_SubsidioAlEmpleo;
    property CompensacionSaldosAFavor: INominaV12_OtrosPagos_OtroPago_CompensacionSaldosAFavor read Get_CompensacionSaldosAFavor;
  end;

{ INominaV12_OtrosPagos_OtroPago_SubsidioAlEmpleo }

  INominaV12_OtrosPagos_OtroPago_SubsidioAlEmpleo = interface(IXMLNode)
    ['{6D3B6965-0B84-4286-B816-3F0F4A51344B}']
    { Property Accessors }
    function Get_SubsidioCausado: UnicodeString;
    procedure Set_SubsidioCausado(Value: UnicodeString);
    { Methods & Properties }
    property SubsidioCausado: UnicodeString read Get_SubsidioCausado write Set_SubsidioCausado;
  end;

{ INominaV12_OtrosPagos_OtroPago_CompensacionSaldosAFavor }

  INominaV12_OtrosPagos_OtroPago_CompensacionSaldosAFavor = interface(IXMLNode)
    ['{FBB0EC9D-79D5-413C-828D-588D281C3C8A}']
    { Property Accessors }
    function Get_SaldoAFavor: UnicodeString;
    function Get_Año: SmallInt;
    function Get_RemanenteSalFav: UnicodeString;
    procedure Set_SaldoAFavor(Value: UnicodeString);
    procedure Set_Año(Value: SmallInt);
    procedure Set_RemanenteSalFav(Value: UnicodeString);
    { Methods & Properties }
    property SaldoAFavor: UnicodeString read Get_SaldoAFavor write Set_SaldoAFavor;
    property Año: SmallInt read Get_Año write Set_Año;
    property RemanenteSalFav: UnicodeString read Get_RemanenteSalFav write Set_RemanenteSalFav;
  end;

{ INominaV12_Incapacidades }

  INominaV12_Incapacidades = interface(IXMLNodeCollection)
    ['{B95384AA-49E0-418F-919C-CAB0ED616D20}']
    { Property Accessors }
    function Get_Incapacidad(Index: Integer): INominaV12_Incapacidades_Incapacidad;
    { Methods & Properties }
    function Add: INominaV12_Incapacidades_Incapacidad;
    function Insert(const Index: Integer): INominaV12_Incapacidades_Incapacidad;
    property Incapacidad[Index: Integer]: INominaV12_Incapacidades_Incapacidad read Get_Incapacidad; default;
  end;

{ INominaV12_Incapacidades_Incapacidad }

  INominaV12_Incapacidades_Incapacidad = interface(IXMLNode)
    ['{107DCD66-796A-4330-8739-AC09431AC3B7}']
    { Property Accessors }
    function Get_DiasIncapacidad: Integer;
    function Get_TipoIncapacidad: UnicodeString;
    function Get_ImporteMonetario: UnicodeString;
    procedure Set_DiasIncapacidad(Value: Integer);
    procedure Set_TipoIncapacidad(Value: UnicodeString);
    procedure Set_ImporteMonetario(Value: UnicodeString);
    { Methods & Properties }
    property DiasIncapacidad: Integer read Get_DiasIncapacidad write Set_DiasIncapacidad;
    property TipoIncapacidad: UnicodeString read Get_TipoIncapacidad write Set_TipoIncapacidad;
    property ImporteMonetario: UnicodeString read Get_ImporteMonetario write Set_ImporteMonetario;
  end;

{ Forward Decls }

  TNominaV12 = class;
  TNominaV12_Emisor = class;
  TNominaV12_Emisor_EntidadSNCF = class;
  TNominaV12_Receptor = class;
  TNominaV12_Receptor_SubContratacion = class;
  TNominaV12_Percepciones = class;
  TNominaV12_Percepciones_Percepcion = class;
  TNominaV12_Percepciones_PercepcionList = class;
  TNominaV12_Percepciones_Percepcion_AccionesOTitulos = class;
  TNominaV12_Percepciones_Percepcion_HorasExtra = class;
  TNominaV12_Percepciones_Percepcion_HorasExtraList = class;
  TNominaV12_Percepciones_JubilacionPensionRetiro = class;
  TNominaV12_Percepciones_SeparacionIndemnizacion = class;
  TNominaV12_Deducciones = class;
  TNominaV12_Deducciones_Deduccion = class;
  TNominaV12_OtrosPagos = class;
  TNominaV12_OtrosPagos_OtroPago = class;
  TNominaV12_OtrosPagos_OtroPago_SubsidioAlEmpleo = class;
  TNominaV12_OtrosPagos_OtroPago_CompensacionSaldosAFavor = class;
  TNominaV12_Incapacidades = class;
  TNominaV12_Incapacidades_Incapacidad = class;

{ TNominaV12 }

  TNominaV12 = class(TXMLNode, INominaV12)
  protected
    { INominaV12 }
    function Get_Version: UnicodeString;
    function Get_TipoNomina: UnicodeString;
    function Get_FechaPago: UnicodeString;
    function Get_FechaInicialPago: UnicodeString;
    function Get_FechaFinalPago: UnicodeString;
    function Get_NumDiasPagados: UnicodeString;
    function Get_TotalPercepciones: UnicodeString;
    function Get_TotalDeducciones: UnicodeString;
    function Get_TotalOtrosPagos: UnicodeString;
    function Get_Emisor: INominaV12_Emisor;
    function Get_Receptor: INominaV12_Receptor;
    function Get_Percepciones: INominaV12_Percepciones;
    function Get_Deducciones: INominaV12_Deducciones;
    function Get_OtrosPagos: INominaV12_OtrosPagos;
    function Get_Incapacidades: INominaV12_Incapacidades;
    procedure Set_Version(Value: UnicodeString);
    procedure Set_TipoNomina(Value: UnicodeString);
    procedure Set_FechaPago(Value: UnicodeString);
    procedure Set_FechaInicialPago(Value: UnicodeString);
    procedure Set_FechaFinalPago(Value: UnicodeString);
    procedure Set_NumDiasPagados(Value: UnicodeString);
    procedure Set_TotalPercepciones(Value: UnicodeString);
    procedure Set_TotalDeducciones(Value: UnicodeString);
    procedure Set_TotalOtrosPagos(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TNominaV12_Emisor }

  TNominaV12_Emisor = class(TXMLNode, INominaV12_Emisor)
  protected
    { INominaV12_Emisor }
    function Get_Curp: UnicodeString;
    function Get_RegistroPatronal: UnicodeString;
    function Get_RfcPatronOrigen: UnicodeString;
    function Get_EntidadSNCF: INominaV12_Emisor_EntidadSNCF;
    procedure Set_Curp(Value: UnicodeString);
    procedure Set_RegistroPatronal(Value: UnicodeString);
    procedure Set_RfcPatronOrigen(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TNominaV12_Emisor_EntidadSNCF }

  TNominaV12_Emisor_EntidadSNCF = class(TXMLNode, INominaV12_Emisor_EntidadSNCF)
  protected
    { INominaV12_Emisor_EntidadSNCF }
    function Get_OrigenRecurso: UnicodeString;
    function Get_MontoRecursoPropio: UnicodeString;
    procedure Set_OrigenRecurso(Value: UnicodeString);
    procedure Set_MontoRecursoPropio(Value: UnicodeString);
  end;

{ TNominaV12_Receptor }

  TNominaV12_Receptor = class(TXMLNodeCollection, INominaV12_Receptor)
  protected
    { INominaV12_Receptor }
    function Get_Curp: UnicodeString;
    function Get_NumSeguridadSocial: UnicodeString;
    function Get_FechaInicioRelLaboral: UnicodeString;
    function Get_Antigüedad: UnicodeString;
    function Get_TipoContrato: UnicodeString;
    function Get_Sindicalizado: UnicodeString;
    function Get_TipoJornada: UnicodeString;
    function Get_TipoRegimen: UnicodeString;
    function Get_NumEmpleado: UnicodeString;
    function Get_Departamento: UnicodeString;
    function Get_Puesto: UnicodeString;
    function Get_RiesgoPuesto: UnicodeString;
    function Get_PeriodicidadPago: UnicodeString;
    function Get_Banco: UnicodeString;
    function Get_CuentaBancaria: Integer;
    function Get_SalarioBaseCotApor: UnicodeString;
    function Get_SalarioDiarioIntegrado: UnicodeString;
    function Get_ClaveEntFed: UnicodeString;
    function Get_SubContratacion(Index: Integer): INominaV12_Receptor_SubContratacion;
    procedure Set_Curp(Value: UnicodeString);
    procedure Set_NumSeguridadSocial(Value: UnicodeString);
    procedure Set_FechaInicioRelLaboral(Value: UnicodeString);
    procedure Set_Antigüedad(Value: UnicodeString);
    procedure Set_TipoContrato(Value: UnicodeString);
    procedure Set_Sindicalizado(Value: UnicodeString);
    procedure Set_TipoJornada(Value: UnicodeString);
    procedure Set_TipoRegimen(Value: UnicodeString);
    procedure Set_NumEmpleado(Value: UnicodeString);
    procedure Set_Departamento(Value: UnicodeString);
    procedure Set_Puesto(Value: UnicodeString);
    procedure Set_RiesgoPuesto(Value: UnicodeString);
    procedure Set_PeriodicidadPago(Value: UnicodeString);
    procedure Set_Banco(Value: UnicodeString);
    procedure Set_CuentaBancaria(Value: Integer);
    procedure Set_SalarioBaseCotApor(Value: UnicodeString);
    procedure Set_SalarioDiarioIntegrado(Value: UnicodeString);
    procedure Set_ClaveEntFed(Value: UnicodeString);
    function Add: INominaV12_Receptor_SubContratacion;
    function Insert(const Index: Integer): INominaV12_Receptor_SubContratacion;
  public
    procedure AfterConstruction; override;
  end;

{ TNominaV12_Receptor_SubContratacion }

  TNominaV12_Receptor_SubContratacion = class(TXMLNode, INominaV12_Receptor_SubContratacion)
  protected
    { INominaV12_Receptor_SubContratacion }
    function Get_RfcLabora: UnicodeString;
    function Get_PorcentajeTiempo: UnicodeString;
    procedure Set_RfcLabora(Value: UnicodeString);
    procedure Set_PorcentajeTiempo(Value: UnicodeString);
  end;

{ TNominaV12_Percepciones }

  TNominaV12_Percepciones = class(TXMLNode, INominaV12_Percepciones)
  private
    FPercepcion: INominaV12_Percepciones_PercepcionList;
  protected
    { INominaV12_Percepciones }
    function Get_TotalSueldos: UnicodeString;
    function Get_TotalSeparacionIndemnizacion: UnicodeString;
    function Get_TotalJubilacionPensionRetiro: UnicodeString;
    function Get_TotalGravado: UnicodeString;
    function Get_TotalExento: UnicodeString;
    function Get_Percepcion: INominaV12_Percepciones_PercepcionList;
    function Get_JubilacionPensionRetiro: INominaV12_Percepciones_JubilacionPensionRetiro;
    function Get_SeparacionIndemnizacion: INominaV12_Percepciones_SeparacionIndemnizacion;
    procedure Set_TotalSueldos(Value: UnicodeString);
    procedure Set_TotalSeparacionIndemnizacion(Value: UnicodeString);
    procedure Set_TotalJubilacionPensionRetiro(Value: UnicodeString);
    procedure Set_TotalGravado(Value: UnicodeString);
    procedure Set_TotalExento(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TNominaV12_Percepciones_Percepcion }

  TNominaV12_Percepciones_Percepcion = class(TXMLNode, INominaV12_Percepciones_Percepcion)
  private
    FHorasExtra: INominaV12_Percepciones_Percepcion_HorasExtraList;
  protected
    { INominaV12_Percepciones_Percepcion }
    function Get_TipoPercepcion: UnicodeString;
    function Get_Clave: UnicodeString;
    function Get_Concepto: UnicodeString;
    function Get_ImporteGravado: UnicodeString;
    function Get_ImporteExento: UnicodeString;
    function Get_AccionesOTitulos: INominaV12_Percepciones_Percepcion_AccionesOTitulos;
    function Get_HorasExtra: INominaV12_Percepciones_Percepcion_HorasExtraList;
    procedure Set_TipoPercepcion(Value: UnicodeString);
    procedure Set_Clave(Value: UnicodeString);
    procedure Set_Concepto(Value: UnicodeString);
    procedure Set_ImporteGravado(Value: UnicodeString);
    procedure Set_ImporteExento(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TNominaV12_Percepciones_PercepcionList }

  TNominaV12_Percepciones_PercepcionList = class(TXMLNodeCollection, INominaV12_Percepciones_PercepcionList)
  protected
    { INominaV12_Percepciones_PercepcionList }
    function Add: INominaV12_Percepciones_Percepcion;
    function Insert(const Index: Integer): INominaV12_Percepciones_Percepcion;

    function Get_Item(Index: Integer): INominaV12_Percepciones_Percepcion;
  end;

{ TNominaV12_Percepciones_Percepcion_AccionesOTitulos }

  TNominaV12_Percepciones_Percepcion_AccionesOTitulos = class(TXMLNode, INominaV12_Percepciones_Percepcion_AccionesOTitulos)
  protected
    { INominaV12_Percepciones_Percepcion_AccionesOTitulos }
    function Get_ValorMercado: UnicodeString;
    function Get_PrecioAlOtorgarse: UnicodeString;
    procedure Set_ValorMercado(Value: UnicodeString);
    procedure Set_PrecioAlOtorgarse(Value: UnicodeString);
  end;

{ TNominaV12_Percepciones_Percepcion_HorasExtra }

  TNominaV12_Percepciones_Percepcion_HorasExtra = class(TXMLNode, INominaV12_Percepciones_Percepcion_HorasExtra)
  protected
    { INominaV12_Percepciones_Percepcion_HorasExtra }
    function Get_Dias: Integer;
    function Get_TipoHoras: UnicodeString;
    function Get_HorasExtra: Integer;
    function Get_ImportePagado: UnicodeString;
    procedure Set_Dias(Value: Integer);
    procedure Set_TipoHoras(Value: UnicodeString);
    procedure Set_HorasExtra(Value: Integer);
    procedure Set_ImportePagado(Value: UnicodeString);
  end;

{ TNominaV12_Percepciones_Percepcion_HorasExtraList }

  TNominaV12_Percepciones_Percepcion_HorasExtraList = class(TXMLNodeCollection, INominaV12_Percepciones_Percepcion_HorasExtraList)
  protected
    { INominaV12_Percepciones_Percepcion_HorasExtraList }
    function Add: INominaV12_Percepciones_Percepcion_HorasExtra;
    function Insert(const Index: Integer): INominaV12_Percepciones_Percepcion_HorasExtra;

    function Get_Item(Index: Integer): INominaV12_Percepciones_Percepcion_HorasExtra;
  end;

{ TNominaV12_Percepciones_JubilacionPensionRetiro }

  TNominaV12_Percepciones_JubilacionPensionRetiro = class(TXMLNode, INominaV12_Percepciones_JubilacionPensionRetiro)
  protected
    { INominaV12_Percepciones_JubilacionPensionRetiro }
    function Get_TotalUnaExhibicion: UnicodeString;
    function Get_TotalParcialidad: UnicodeString;
    function Get_MontoDiario: UnicodeString;
    function Get_IngresoAcumulable: UnicodeString;
    function Get_IngresoNoAcumulable: UnicodeString;
    procedure Set_TotalUnaExhibicion(Value: UnicodeString);
    procedure Set_TotalParcialidad(Value: UnicodeString);
    procedure Set_MontoDiario(Value: UnicodeString);
    procedure Set_IngresoAcumulable(Value: UnicodeString);
    procedure Set_IngresoNoAcumulable(Value: UnicodeString);
  end;

{ TNominaV12_Percepciones_SeparacionIndemnizacion }

  TNominaV12_Percepciones_SeparacionIndemnizacion = class(TXMLNode, INominaV12_Percepciones_SeparacionIndemnizacion)
  protected
    { INominaV12_Percepciones_SeparacionIndemnizacion }
    function Get_TotalPagado: UnicodeString;
    function Get_NumAñosServicio: Integer;
    function Get_UltimoSueldoMensOrd: UnicodeString;
    function Get_IngresoAcumulable: UnicodeString;
    function Get_IngresoNoAcumulable: UnicodeString;
    procedure Set_TotalPagado(Value: UnicodeString);
    procedure Set_NumAñosServicio(Value: Integer);
    procedure Set_UltimoSueldoMensOrd(Value: UnicodeString);
    procedure Set_IngresoAcumulable(Value: UnicodeString);
    procedure Set_IngresoNoAcumulable(Value: UnicodeString);
  end;

{ TNominaV12_Deducciones }

  TNominaV12_Deducciones = class(TXMLNodeCollection, INominaV12_Deducciones)
  protected
    { INominaV12_Deducciones }
    function Get_TotalOtrasDeducciones: UnicodeString;
    function Get_TotalImpuestosRetenidos: UnicodeString;
    function Get_Deduccion(Index: Integer): INominaV12_Deducciones_Deduccion;
    procedure Set_TotalOtrasDeducciones(Value: UnicodeString);
    procedure Set_TotalImpuestosRetenidos(Value: UnicodeString);
    function Add: INominaV12_Deducciones_Deduccion;
    function Insert(const Index: Integer): INominaV12_Deducciones_Deduccion;
  public
    procedure AfterConstruction; override;
  end;

{ TNominaV12_Deducciones_Deduccion }

  TNominaV12_Deducciones_Deduccion = class(TXMLNode, INominaV12_Deducciones_Deduccion)
  protected
    { INominaV12_Deducciones_Deduccion }
    function Get_TipoDeduccion: UnicodeString;
    function Get_Clave: UnicodeString;
    function Get_Concepto: UnicodeString;
    function Get_Importe: UnicodeString;
    procedure Set_TipoDeduccion(Value: UnicodeString);
    procedure Set_Clave(Value: UnicodeString);
    procedure Set_Concepto(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
  end;

{ TNominaV12_OtrosPagos }

  TNominaV12_OtrosPagos = class(TXMLNodeCollection, INominaV12_OtrosPagos)
  protected
    { INominaV12_OtrosPagos }
    function Get_OtroPago(Index: Integer): INominaV12_OtrosPagos_OtroPago;
    function Add: INominaV12_OtrosPagos_OtroPago;
    function Insert(const Index: Integer): INominaV12_OtrosPagos_OtroPago;
  public
    procedure AfterConstruction; override;
  end;

{ TNominaV12_OtrosPagos_OtroPago }

  TNominaV12_OtrosPagos_OtroPago = class(TXMLNode, INominaV12_OtrosPagos_OtroPago)
  protected
    { INominaV12_OtrosPagos_OtroPago }
    function Get_TipoOtroPago: UnicodeString;
    function Get_Clave: UnicodeString;
    function Get_Concepto: UnicodeString;
    function Get_Importe: UnicodeString;
    function Get_SubsidioAlEmpleo: INominaV12_OtrosPagos_OtroPago_SubsidioAlEmpleo;
    function Get_CompensacionSaldosAFavor: INominaV12_OtrosPagos_OtroPago_CompensacionSaldosAFavor;
    procedure Set_TipoOtroPago(Value: UnicodeString);
    procedure Set_Clave(Value: UnicodeString);
    procedure Set_Concepto(Value: UnicodeString);
    procedure Set_Importe(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TNominaV12_OtrosPagos_OtroPago_SubsidioAlEmpleo }

  TNominaV12_OtrosPagos_OtroPago_SubsidioAlEmpleo = class(TXMLNode, INominaV12_OtrosPagos_OtroPago_SubsidioAlEmpleo)
  protected
    { INominaV12_OtrosPagos_OtroPago_SubsidioAlEmpleo }
    function Get_SubsidioCausado: UnicodeString;
    procedure Set_SubsidioCausado(Value: UnicodeString);
  end;

{ TNominaV12_OtrosPagos_OtroPago_CompensacionSaldosAFavor }

  TNominaV12_OtrosPagos_OtroPago_CompensacionSaldosAFavor = class(TXMLNode, INominaV12_OtrosPagos_OtroPago_CompensacionSaldosAFavor)
  protected
    { INominaV12_OtrosPagos_OtroPago_CompensacionSaldosAFavor }
    function Get_SaldoAFavor: UnicodeString;
    function Get_Año: SmallInt;
    function Get_RemanenteSalFav: UnicodeString;
    procedure Set_SaldoAFavor(Value: UnicodeString);
    procedure Set_Año(Value: SmallInt);
    procedure Set_RemanenteSalFav(Value: UnicodeString);
  end;

{ TNominaV12_Incapacidades }

  TNominaV12_Incapacidades = class(TXMLNodeCollection, INominaV12_Incapacidades)
  protected
    { INominaV12_Incapacidades }
    function Get_Incapacidad(Index: Integer): INominaV12_Incapacidades_Incapacidad;
    function Add: INominaV12_Incapacidades_Incapacidad;
    function Insert(const Index: Integer): INominaV12_Incapacidades_Incapacidad;
  public
    procedure AfterConstruction; override;
  end;

{ TNominaV12_Incapacidades_Incapacidad }

  TNominaV12_Incapacidades_Incapacidad = class(TXMLNode, INominaV12_Incapacidades_Incapacidad)
  protected
    { INominaV12_Incapacidades_Incapacidad }
    function Get_DiasIncapacidad: Integer;
    function Get_TipoIncapacidad: UnicodeString;
    function Get_ImporteMonetario: UnicodeString;
    procedure Set_DiasIncapacidad(Value: Integer);
    procedure Set_TipoIncapacidad(Value: UnicodeString);
    procedure Set_ImporteMonetario(Value: UnicodeString);
  end;

{ Global Functions }

function GetNominaV12(Doc: IXMLDocument): INominaV12;
function LoadNominaV12(const FileName: string): INominaV12;
function NewNominaV12: INominaV12;

const
  TargetNamespace = 'http://www.sat.gob.mx/nomina12';

implementation

uses xmlutil;

{ Global Functions }

function GetNominaV12(Doc: IXMLDocument): INominaV12;
begin
  Result := Doc.GetDocBinding('nomina12:Nomina', TNominaV12, TargetNamespace) as INominaV12;
end;

function LoadNominaV12(const FileName: string): INominaV12;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('nomina12:Nomina', TNominaV12, TargetNamespace) as INominaV12;
end;

function NewNominaV12: INominaV12;
begin
  Result := NewXMLDocument.GetDocBinding('nomina12:Nomina', TNominaV12, TargetNamespace) as INominaV12;
end;

{ TNominaV12 }

procedure TNominaV12.AfterConstruction;
begin
  if (Self.AttributeNodes.FindNode('Version') = nil) then
      Self.Set_Version('1.2');
  RegisterChildNode('Emisor', TNominaV12_Emisor);
  RegisterChildNode('Receptor', TNominaV12_Receptor);
  RegisterChildNode('Percepciones', TNominaV12_Percepciones);
  RegisterChildNode('Deducciones', TNominaV12_Deducciones);
  RegisterChildNode('OtrosPagos', TNominaV12_OtrosPagos);
  RegisterChildNode('Incapacidades', TNominaV12_Incapacidades);
  inherited;
end;

function TNominaV12.Get_Version: UnicodeString;
begin
  Result := AttributeNodes['Version'].Text;
end;

procedure TNominaV12.Set_Version(Value: UnicodeString);
begin
  SetAttribute('Version', Value);
end;

function TNominaV12.Get_TipoNomina: UnicodeString;
begin
  Result := AttributeNodes['TipoNomina'].Text;
end;

procedure TNominaV12.Set_TipoNomina(Value: UnicodeString);
begin
  SetAttribute('TipoNomina', Value);
end;

function TNominaV12.Get_FechaPago: UnicodeString;
begin
  Result := AttributeNodes['FechaPago'].Text;
end;

procedure TNominaV12.Set_FechaPago(Value: UnicodeString);
begin
  SetAttribute('FechaPago', Value);
end;

function TNominaV12.Get_FechaInicialPago: UnicodeString;
begin
  Result := AttributeNodes['FechaInicialPago'].Text;
end;

procedure TNominaV12.Set_FechaInicialPago(Value: UnicodeString);
begin
  SetAttribute('FechaInicialPago', Value);
end;

function TNominaV12.Get_FechaFinalPago: UnicodeString;
begin
  Result := AttributeNodes['FechaFinalPago'].Text;
end;

procedure TNominaV12.Set_FechaFinalPago(Value: UnicodeString);
begin
  SetAttribute('FechaFinalPago', Value);
end;

function TNominaV12.Get_NumDiasPagados: UnicodeString;
begin
  Result := AttributeNodes['NumDiasPagados'].Text;
end;

procedure TNominaV12.Set_NumDiasPagados(Value: UnicodeString);
begin
  SetAttribute('NumDiasPagados', Value);
end;

function TNominaV12.Get_TotalPercepciones: UnicodeString;
begin
  Result := AttributeNodes['TotalPercepciones'].Text;
end;

procedure TNominaV12.Set_TotalPercepciones(Value: UnicodeString);
begin
  SetAttribute('TotalPercepciones', Value);
end;

function TNominaV12.Get_TotalDeducciones: UnicodeString;
begin
  Result := AttributeNodes['TotalDeducciones'].Text;
end;

procedure TNominaV12.Set_TotalDeducciones(Value: UnicodeString);
begin
  SetAttribute('TotalDeducciones', Value);
end;

function TNominaV12.Get_TotalOtrosPagos: UnicodeString;
begin
  Result := AttributeNodes['TotalOtrosPagos'].Text;
end;

procedure TNominaV12.Set_TotalOtrosPagos(Value: UnicodeString);
begin
  SetAttribute('TotalOtrosPagos', Value);
end;

function TNominaV12.Get_Emisor: INominaV12_Emisor;
begin
  Result := ChildNodes['Emisor'] as INominaV12_Emisor;
end;

function TNominaV12.Get_Receptor: INominaV12_Receptor;
begin
  Result := ChildNodes['Receptor'] as INominaV12_Receptor;
end;

function TNominaV12.Get_Percepciones: INominaV12_Percepciones;
begin
  Result := ChildNodes['Percepciones'] as INominaV12_Percepciones;
end;

function TNominaV12.Get_Deducciones: INominaV12_Deducciones;
begin
  Result := ChildNodes['Deducciones'] as INominaV12_Deducciones;
end;

function TNominaV12.Get_OtrosPagos: INominaV12_OtrosPagos;
begin
  Result := ChildNodes['OtrosPagos'] as INominaV12_OtrosPagos;
end;

function TNominaV12.Get_Incapacidades: INominaV12_Incapacidades;
begin
  Result := ChildNodes['Incapacidades'] as INominaV12_Incapacidades;
end;

{ TNominaV12_Emisor }

procedure TNominaV12_Emisor.AfterConstruction;
begin
  RegisterChildNode('EntidadSNCF', TNominaV12_Emisor_EntidadSNCF);
  inherited;
end;

function TNominaV12_Emisor.Get_Curp: UnicodeString;
begin
  Result := AttributeNodes['Curp'].Text;
end;

procedure TNominaV12_Emisor.Set_Curp(Value: UnicodeString);
begin
  SetAttribute('Curp', Value);
end;

function TNominaV12_Emisor.Get_RegistroPatronal: UnicodeString;
begin
  Result := AttributeNodes['RegistroPatronal'].Text;
end;

procedure TNominaV12_Emisor.Set_RegistroPatronal(Value: UnicodeString);
begin
  SetAttribute('RegistroPatronal', Value);
end;

function TNominaV12_Emisor.Get_RfcPatronOrigen: UnicodeString;
begin
  Result := AttributeNodes['RfcPatronOrigen'].Text;
end;

procedure TNominaV12_Emisor.Set_RfcPatronOrigen(Value: UnicodeString);
begin
  SetAttribute('RfcPatronOrigen', Value);
end;

function TNominaV12_Emisor.Get_EntidadSNCF: INominaV12_Emisor_EntidadSNCF;
begin
  Result := ChildNodes['EntidadSNCF'] as INominaV12_Emisor_EntidadSNCF;
end;

{ TNominaV12_Emisor_EntidadSNCF }

function TNominaV12_Emisor_EntidadSNCF.Get_OrigenRecurso: UnicodeString;
begin
  Result := AttributeNodes['OrigenRecurso'].Text;
end;

procedure TNominaV12_Emisor_EntidadSNCF.Set_OrigenRecurso(Value: UnicodeString);
begin
  SetAttribute('OrigenRecurso', Value);
end;

function TNominaV12_Emisor_EntidadSNCF.Get_MontoRecursoPropio: UnicodeString;
begin
  Result := AttributeNodes['MontoRecursoPropio'].Text;
end;

procedure TNominaV12_Emisor_EntidadSNCF.Set_MontoRecursoPropio(Value: UnicodeString);
begin
  SetAttribute('MontoRecursoPropio', Value);
end;

{ TNominaV12_Receptor }

procedure TNominaV12_Receptor.AfterConstruction;
begin
  RegisterChildNode('SubContratacion', TNominaV12_Receptor_SubContratacion);
  ItemTag := 'SubContratacion';
  ItemInterface := INominaV12_Receptor_SubContratacion;
  inherited;
end;

function TNominaV12_Receptor.Get_Curp: UnicodeString;
begin
  Result := AttributeNodes['Curp'].Text;
end;

procedure TNominaV12_Receptor.Set_Curp(Value: UnicodeString);
begin
  SetAttribute('Curp', Value);
end;

function TNominaV12_Receptor.Get_NumSeguridadSocial: UnicodeString;
begin
  Result := AttributeNodes['NumSeguridadSocial'].Text;
end;

procedure TNominaV12_Receptor.Set_NumSeguridadSocial(Value: UnicodeString);
begin
  SetAttribute('NumSeguridadSocial', Value);
end;

function TNominaV12_Receptor.Get_FechaInicioRelLaboral: UnicodeString;
begin
  Result := AttributeNodes['FechaInicioRelLaboral'].Text;
end;

procedure TNominaV12_Receptor.Set_FechaInicioRelLaboral(Value: UnicodeString);
begin
  SetAttribute('FechaInicioRelLaboral', Value);
end;

function TNominaV12_Receptor.Get_Antigüedad: UnicodeString;
begin
  Result := AttributeNodes['Antigüedad'].Text;
end;

procedure TNominaV12_Receptor.Set_Antigüedad(Value: UnicodeString);
begin
  SetAttribute('Antigüedad', Value);
end;

function TNominaV12_Receptor.Get_TipoContrato: UnicodeString;
begin
  Result := AttributeNodes['TipoContrato'].Text;
end;

procedure TNominaV12_Receptor.Set_TipoContrato(Value: UnicodeString);
begin
  SetAttribute('TipoContrato', Value);
end;

function TNominaV12_Receptor.Get_Sindicalizado: UnicodeString;
begin
  Result := AttributeNodes['Sindicalizado'].Text;
end;

procedure TNominaV12_Receptor.Set_Sindicalizado(Value: UnicodeString);
begin
  SetAttribute('Sindicalizado', Value);
end;

function TNominaV12_Receptor.Get_TipoJornada: UnicodeString;
begin
  Result := AttributeNodes['TipoJornada'].Text;
end;

procedure TNominaV12_Receptor.Set_TipoJornada(Value: UnicodeString);
begin
  SetAttribute('TipoJornada', Value);
end;

function TNominaV12_Receptor.Get_TipoRegimen: UnicodeString;
begin
  Result := AttributeNodes['TipoRegimen'].Text;
end;

procedure TNominaV12_Receptor.Set_TipoRegimen(Value: UnicodeString);
begin
  SetAttribute('TipoRegimen', Value);
end;

function TNominaV12_Receptor.Get_NumEmpleado: UnicodeString;
begin
  Result := AttributeNodes['NumEmpleado'].Text;
end;

procedure TNominaV12_Receptor.Set_NumEmpleado(Value: UnicodeString);
begin
  SetAttribute('NumEmpleado', Value);
end;

function TNominaV12_Receptor.Get_Departamento: UnicodeString;
begin
  Result := AttributeNodes['Departamento'].Text;
end;

procedure TNominaV12_Receptor.Set_Departamento(Value: UnicodeString);
begin
  SetAttribute('Departamento', Value);
end;

function TNominaV12_Receptor.Get_Puesto: UnicodeString;
begin
  Result := AttributeNodes['Puesto'].Text;
end;

procedure TNominaV12_Receptor.Set_Puesto(Value: UnicodeString);
begin
  SetAttribute('Puesto', Value);
end;

function TNominaV12_Receptor.Get_RiesgoPuesto: UnicodeString;
begin
  Result := AttributeNodes['RiesgoPuesto'].Text;
end;

procedure TNominaV12_Receptor.Set_RiesgoPuesto(Value: UnicodeString);
begin
  SetAttribute('RiesgoPuesto', Value);
end;

function TNominaV12_Receptor.Get_PeriodicidadPago: UnicodeString;
begin
  Result := AttributeNodes['PeriodicidadPago'].Text;
end;

procedure TNominaV12_Receptor.Set_PeriodicidadPago(Value: UnicodeString);
begin
  SetAttribute('PeriodicidadPago', Value);
end;

function TNominaV12_Receptor.Get_Banco: UnicodeString;
begin
  Result := AttributeNodes['Banco'].Text;
end;

procedure TNominaV12_Receptor.Set_Banco(Value: UnicodeString);
begin
  SetAttribute('Banco', Value);
end;

function TNominaV12_Receptor.Get_CuentaBancaria: Integer;
begin
  Result := AttributeNodes['CuentaBancaria'].NodeValue;
end;

procedure TNominaV12_Receptor.Set_CuentaBancaria(Value: Integer);
begin
  SetAttribute('CuentaBancaria', Value);
end;

function TNominaV12_Receptor.Get_SalarioBaseCotApor: UnicodeString;
begin
  Result := AttributeNodes['SalarioBaseCotApor'].Text;
end;

procedure TNominaV12_Receptor.Set_SalarioBaseCotApor(Value: UnicodeString);
begin
  SetAttribute('SalarioBaseCotApor', Value);
end;

function TNominaV12_Receptor.Get_SalarioDiarioIntegrado: UnicodeString;
begin
  Result := AttributeNodes['SalarioDiarioIntegrado'].Text;
end;

procedure TNominaV12_Receptor.Set_SalarioDiarioIntegrado(Value: UnicodeString);
begin
  SetAttribute('SalarioDiarioIntegrado', Value);
end;

function TNominaV12_Receptor.Get_ClaveEntFed: UnicodeString;
begin
  Result := AttributeNodes['ClaveEntFed'].Text;
end;

procedure TNominaV12_Receptor.Set_ClaveEntFed(Value: UnicodeString);
begin
  SetAttribute('ClaveEntFed', Value);
end;

function TNominaV12_Receptor.Get_SubContratacion(Index: Integer): INominaV12_Receptor_SubContratacion;
begin
  Result := List[Index] as INominaV12_Receptor_SubContratacion;
end;

function TNominaV12_Receptor.Add: INominaV12_Receptor_SubContratacion;
begin
  Result := AddItem(-1) as INominaV12_Receptor_SubContratacion;
end;

function TNominaV12_Receptor.Insert(const Index: Integer): INominaV12_Receptor_SubContratacion;
begin
  Result := AddItem(Index) as INominaV12_Receptor_SubContratacion;
end;

{ TNominaV12_Receptor_SubContratacion }

function TNominaV12_Receptor_SubContratacion.Get_RfcLabora: UnicodeString;
begin
  Result := AttributeNodes['RfcLabora'].Text;
end;

procedure TNominaV12_Receptor_SubContratacion.Set_RfcLabora(Value: UnicodeString);
begin
  SetAttribute('RfcLabora', Value);
end;

function TNominaV12_Receptor_SubContratacion.Get_PorcentajeTiempo: UnicodeString;
begin
  Result := AttributeNodes['PorcentajeTiempo'].Text;
end;

procedure TNominaV12_Receptor_SubContratacion.Set_PorcentajeTiempo(Value: UnicodeString);
begin
  SetAttribute('PorcentajeTiempo', Value);
end;

{ TNominaV12_Percepciones }

procedure TNominaV12_Percepciones.AfterConstruction;
begin
  RegisterChildNode('Percepcion', TNominaV12_Percepciones_Percepcion);
  RegisterChildNode('JubilacionPensionRetiro', TNominaV12_Percepciones_JubilacionPensionRetiro);
  RegisterChildNode('SeparacionIndemnizacion', TNominaV12_Percepciones_SeparacionIndemnizacion);
  FPercepcion := CreateCollection(TNominaV12_Percepciones_PercepcionList, INominaV12_Percepciones_Percepcion, 'Percepcion') as INominaV12_Percepciones_PercepcionList;
  inherited;
end;

function TNominaV12_Percepciones.Get_TotalSueldos: UnicodeString;
begin
  Result := AttributeNodes['TotalSueldos'].Text;
end;

procedure TNominaV12_Percepciones.Set_TotalSueldos(Value: UnicodeString);
begin
  SetAttribute('TotalSueldos', Value);
end;

function TNominaV12_Percepciones.Get_TotalSeparacionIndemnizacion: UnicodeString;
begin
  Result := AttributeNodes['TotalSeparacionIndemnizacion'].Text;
end;

procedure TNominaV12_Percepciones.Set_TotalSeparacionIndemnizacion(Value: UnicodeString);
begin
  SetAttribute('TotalSeparacionIndemnizacion', Value);
end;

function TNominaV12_Percepciones.Get_TotalJubilacionPensionRetiro: UnicodeString;
begin
  Result := AttributeNodes['TotalJubilacionPensionRetiro'].Text;
end;

procedure TNominaV12_Percepciones.Set_TotalJubilacionPensionRetiro(Value: UnicodeString);
begin
  SetAttribute('TotalJubilacionPensionRetiro', Value);
end;

function TNominaV12_Percepciones.Get_TotalGravado: UnicodeString;
begin
  Result := AttributeNodes['TotalGravado'].Text;
end;

procedure TNominaV12_Percepciones.Set_TotalGravado(Value: UnicodeString);
begin
  SetAttribute('TotalGravado', Value);
end;

function TNominaV12_Percepciones.Get_TotalExento: UnicodeString;
begin
  Result := AttributeNodes['TotalExento'].Text;
end;

procedure TNominaV12_Percepciones.Set_TotalExento(Value: UnicodeString);
begin
  SetAttribute('TotalExento', Value);
end;

function TNominaV12_Percepciones.Get_Percepcion: INominaV12_Percepciones_PercepcionList;
begin
  Result := FPercepcion;
end;

function TNominaV12_Percepciones.Get_JubilacionPensionRetiro: INominaV12_Percepciones_JubilacionPensionRetiro;
begin
  Result := ChildNodes['JubilacionPensionRetiro'] as INominaV12_Percepciones_JubilacionPensionRetiro;
end;

function TNominaV12_Percepciones.Get_SeparacionIndemnizacion: INominaV12_Percepciones_SeparacionIndemnizacion;
begin
  Result := ChildNodes['SeparacionIndemnizacion'] as INominaV12_Percepciones_SeparacionIndemnizacion;
end;

{ TNominaV12_Percepciones_Percepcion }

procedure TNominaV12_Percepciones_Percepcion.AfterConstruction;
begin
  RegisterChildNode('AccionesOTitulos', TNominaV12_Percepciones_Percepcion_AccionesOTitulos);
  RegisterChildNode('HorasExtra', TNominaV12_Percepciones_Percepcion_HorasExtra);
  FHorasExtra := CreateCollection(TNominaV12_Percepciones_Percepcion_HorasExtraList, INominaV12_Percepciones_Percepcion_HorasExtra, 'HorasExtra') as INominaV12_Percepciones_Percepcion_HorasExtraList;
  inherited;
end;

function TNominaV12_Percepciones_Percepcion.Get_TipoPercepcion: UnicodeString;
begin
  Result := AttributeNodes['TipoPercepcion'].Text;
end;

procedure TNominaV12_Percepciones_Percepcion.Set_TipoPercepcion(Value: UnicodeString);
begin
  SetAttribute('TipoPercepcion', Value);
end;

function TNominaV12_Percepciones_Percepcion.Get_Clave: UnicodeString;
begin
  Result := AttributeNodes['Clave'].Text;
end;

procedure TNominaV12_Percepciones_Percepcion.Set_Clave(Value: UnicodeString);
begin
  SetAttribute('Clave', Value);
end;

function TNominaV12_Percepciones_Percepcion.Get_Concepto: UnicodeString;
begin
  Result := AttributeNodes['Concepto'].Text;
end;

procedure TNominaV12_Percepciones_Percepcion.Set_Concepto(Value: UnicodeString);
begin
  SetAttribute('Concepto', Value);
end;

function TNominaV12_Percepciones_Percepcion.Get_ImporteGravado: UnicodeString;
begin
  Result := AttributeNodes['ImporteGravado'].Text;
end;

procedure TNominaV12_Percepciones_Percepcion.Set_ImporteGravado(Value: UnicodeString);
begin
  SetAttribute('ImporteGravado', Value);
end;

function TNominaV12_Percepciones_Percepcion.Get_ImporteExento: UnicodeString;
begin
  Result := AttributeNodes['ImporteExento'].Text;
end;

procedure TNominaV12_Percepciones_Percepcion.Set_ImporteExento(Value: UnicodeString);
begin
  SetAttribute('ImporteExento', Value);
end;

function TNominaV12_Percepciones_Percepcion.Get_AccionesOTitulos: INominaV12_Percepciones_Percepcion_AccionesOTitulos;
begin
  Result := ChildNodes['AccionesOTitulos'] as INominaV12_Percepciones_Percepcion_AccionesOTitulos;
end;

function TNominaV12_Percepciones_Percepcion.Get_HorasExtra: INominaV12_Percepciones_Percepcion_HorasExtraList;
begin
  Result := FHorasExtra;
end;

{ TNominaV12_Percepciones_PercepcionList }

function TNominaV12_Percepciones_PercepcionList.Add: INominaV12_Percepciones_Percepcion;
begin
  Result := AddItem(-1) as INominaV12_Percepciones_Percepcion;
end;

function TNominaV12_Percepciones_PercepcionList.Insert(const Index: Integer): INominaV12_Percepciones_Percepcion;
begin
  Result := AddItem(Index) as INominaV12_Percepciones_Percepcion;
end;

function TNominaV12_Percepciones_PercepcionList.Get_Item(Index: Integer): INominaV12_Percepciones_Percepcion;
begin
  Result := List[Index] as INominaV12_Percepciones_Percepcion;
end;

{ TNominaV12_Percepciones_Percepcion_AccionesOTitulos }

function TNominaV12_Percepciones_Percepcion_AccionesOTitulos.Get_ValorMercado: UnicodeString;
begin
  Result := AttributeNodes['ValorMercado'].Text;
end;

procedure TNominaV12_Percepciones_Percepcion_AccionesOTitulos.Set_ValorMercado(Value: UnicodeString);
begin
  SetAttribute('ValorMercado', Value);
end;

function TNominaV12_Percepciones_Percepcion_AccionesOTitulos.Get_PrecioAlOtorgarse: UnicodeString;
begin
  Result := AttributeNodes['PrecioAlOtorgarse'].Text;
end;

procedure TNominaV12_Percepciones_Percepcion_AccionesOTitulos.Set_PrecioAlOtorgarse(Value: UnicodeString);
begin
  SetAttribute('PrecioAlOtorgarse', Value);
end;

{ TNominaV12_Percepciones_Percepcion_HorasExtra }

function TNominaV12_Percepciones_Percepcion_HorasExtra.Get_Dias: Integer;
begin
  Result := AttributeNodes['Dias'].NodeValue;
end;

procedure TNominaV12_Percepciones_Percepcion_HorasExtra.Set_Dias(Value: Integer);
begin
  SetAttribute('Dias', Value);
end;

function TNominaV12_Percepciones_Percepcion_HorasExtra.Get_TipoHoras: UnicodeString;
begin
  Result := AttributeNodes['TipoHoras'].Text;
end;

procedure TNominaV12_Percepciones_Percepcion_HorasExtra.Set_TipoHoras(Value: UnicodeString);
begin
  SetAttribute('TipoHoras', Value);
end;

function TNominaV12_Percepciones_Percepcion_HorasExtra.Get_HorasExtra: Integer;
begin
  Result := AttributeNodes['HorasExtra'].NodeValue;
end;

procedure TNominaV12_Percepciones_Percepcion_HorasExtra.Set_HorasExtra(Value: Integer);
begin
  SetAttribute('HorasExtra', Value);
end;

function TNominaV12_Percepciones_Percepcion_HorasExtra.Get_ImportePagado: UnicodeString;
begin
  Result := AttributeNodes['ImportePagado'].Text;
end;

procedure TNominaV12_Percepciones_Percepcion_HorasExtra.Set_ImportePagado(Value: UnicodeString);
begin
  SetAttribute('ImportePagado', Value);
end;

{ TNominaV12_Percepciones_Percepcion_HorasExtraList }

function TNominaV12_Percepciones_Percepcion_HorasExtraList.Add: INominaV12_Percepciones_Percepcion_HorasExtra;
begin
  Result := AddItem(-1) as INominaV12_Percepciones_Percepcion_HorasExtra;
end;

function TNominaV12_Percepciones_Percepcion_HorasExtraList.Insert(const Index: Integer): INominaV12_Percepciones_Percepcion_HorasExtra;
begin
  Result := AddItem(Index) as INominaV12_Percepciones_Percepcion_HorasExtra;
end;

function TNominaV12_Percepciones_Percepcion_HorasExtraList.Get_Item(Index: Integer): INominaV12_Percepciones_Percepcion_HorasExtra;
begin
  Result := List[Index] as INominaV12_Percepciones_Percepcion_HorasExtra;
end;

{ TNominaV12_Percepciones_JubilacionPensionRetiro }

function TNominaV12_Percepciones_JubilacionPensionRetiro.Get_TotalUnaExhibicion: UnicodeString;
begin
  Result := AttributeNodes['TotalUnaExhibicion'].Text;
end;

procedure TNominaV12_Percepciones_JubilacionPensionRetiro.Set_TotalUnaExhibicion(Value: UnicodeString);
begin
  SetAttribute('TotalUnaExhibicion', Value);
end;

function TNominaV12_Percepciones_JubilacionPensionRetiro.Get_TotalParcialidad: UnicodeString;
begin
  Result := AttributeNodes['TotalParcialidad'].Text;
end;

procedure TNominaV12_Percepciones_JubilacionPensionRetiro.Set_TotalParcialidad(Value: UnicodeString);
begin
  SetAttribute('TotalParcialidad', Value);
end;

function TNominaV12_Percepciones_JubilacionPensionRetiro.Get_MontoDiario: UnicodeString;
begin
  Result := AttributeNodes['MontoDiario'].Text;
end;

procedure TNominaV12_Percepciones_JubilacionPensionRetiro.Set_MontoDiario(Value: UnicodeString);
begin
  SetAttribute('MontoDiario', Value);
end;

function TNominaV12_Percepciones_JubilacionPensionRetiro.Get_IngresoAcumulable: UnicodeString;
begin
  Result := AttributeNodes['IngresoAcumulable'].Text;
end;

procedure TNominaV12_Percepciones_JubilacionPensionRetiro.Set_IngresoAcumulable(Value: UnicodeString);
begin
  SetAttribute('IngresoAcumulable', Value);
end;

function TNominaV12_Percepciones_JubilacionPensionRetiro.Get_IngresoNoAcumulable: UnicodeString;
begin
  Result := AttributeNodes['IngresoNoAcumulable'].Text;
end;

procedure TNominaV12_Percepciones_JubilacionPensionRetiro.Set_IngresoNoAcumulable(Value: UnicodeString);
begin
  SetAttribute('IngresoNoAcumulable', Value);
end;

{ TNominaV12_Percepciones_SeparacionIndemnizacion }

function TNominaV12_Percepciones_SeparacionIndemnizacion.Get_TotalPagado: UnicodeString;
begin
  Result := AttributeNodes['TotalPagado'].Text;
end;

procedure TNominaV12_Percepciones_SeparacionIndemnizacion.Set_TotalPagado(Value: UnicodeString);
begin
  SetAttribute('TotalPagado', Value);
end;

function TNominaV12_Percepciones_SeparacionIndemnizacion.Get_NumAñosServicio: Integer;
begin
  Result := AttributeNodes['NumAñosServicio'].NodeValue;
end;

procedure TNominaV12_Percepciones_SeparacionIndemnizacion.Set_NumAñosServicio(Value: Integer);
begin
  SetAttribute('NumAñosServicio', Value);
end;

function TNominaV12_Percepciones_SeparacionIndemnizacion.Get_UltimoSueldoMensOrd: UnicodeString;
begin
  Result := AttributeNodes['UltimoSueldoMensOrd'].Text;
end;

procedure TNominaV12_Percepciones_SeparacionIndemnizacion.Set_UltimoSueldoMensOrd(Value: UnicodeString);
begin
  SetAttribute('UltimoSueldoMensOrd', Value);
end;

function TNominaV12_Percepciones_SeparacionIndemnizacion.Get_IngresoAcumulable: UnicodeString;
begin
  Result := AttributeNodes['IngresoAcumulable'].Text;
end;

procedure TNominaV12_Percepciones_SeparacionIndemnizacion.Set_IngresoAcumulable(Value: UnicodeString);
begin
  SetAttribute('IngresoAcumulable', Value);
end;

function TNominaV12_Percepciones_SeparacionIndemnizacion.Get_IngresoNoAcumulable: UnicodeString;
begin
  Result := AttributeNodes['IngresoNoAcumulable'].Text;
end;

procedure TNominaV12_Percepciones_SeparacionIndemnizacion.Set_IngresoNoAcumulable(Value: UnicodeString);
begin
  SetAttribute('IngresoNoAcumulable', Value);
end;

{ TNominaV12_Deducciones }

procedure TNominaV12_Deducciones.AfterConstruction;
begin
  RegisterChildNode('Deduccion', TNominaV12_Deducciones_Deduccion);
  ItemTag := 'Deduccion';
  ItemInterface := INominaV12_Deducciones_Deduccion;
  inherited;
end;

function TNominaV12_Deducciones.Get_TotalOtrasDeducciones: UnicodeString;
begin
  Result := AttributeNodes['TotalOtrasDeducciones'].Text;
end;

procedure TNominaV12_Deducciones.Set_TotalOtrasDeducciones(Value: UnicodeString);
begin
  SetAttribute('TotalOtrasDeducciones', Value);
end;

function TNominaV12_Deducciones.Get_TotalImpuestosRetenidos: UnicodeString;
begin
  Result := AttributeNodes['TotalImpuestosRetenidos'].Text;
end;

procedure TNominaV12_Deducciones.Set_TotalImpuestosRetenidos(Value: UnicodeString);
begin
  SetAttribute('TotalImpuestosRetenidos', Value);
end;

function TNominaV12_Deducciones.Get_Deduccion(Index: Integer): INominaV12_Deducciones_Deduccion;
begin
  Result := List[Index] as INominaV12_Deducciones_Deduccion;
end;

function TNominaV12_Deducciones.Add: INominaV12_Deducciones_Deduccion;
begin
  Result := AddItem(-1) as INominaV12_Deducciones_Deduccion;
end;

function TNominaV12_Deducciones.Insert(const Index: Integer): INominaV12_Deducciones_Deduccion;
begin
  Result := AddItem(Index) as INominaV12_Deducciones_Deduccion;
end;

{ TNominaV12_Deducciones_Deduccion }

function TNominaV12_Deducciones_Deduccion.Get_TipoDeduccion: UnicodeString;
begin
  Result := AttributeNodes['TipoDeduccion'].Text;
end;

procedure TNominaV12_Deducciones_Deduccion.Set_TipoDeduccion(Value: UnicodeString);
begin
  SetAttribute('TipoDeduccion', Value);
end;

function TNominaV12_Deducciones_Deduccion.Get_Clave: UnicodeString;
begin
  Result := AttributeNodes['Clave'].Text;
end;

procedure TNominaV12_Deducciones_Deduccion.Set_Clave(Value: UnicodeString);
begin
  SetAttribute('Clave', Value);
end;

function TNominaV12_Deducciones_Deduccion.Get_Concepto: UnicodeString;
begin
  Result := AttributeNodes['Concepto'].Text;
end;

procedure TNominaV12_Deducciones_Deduccion.Set_Concepto(Value: UnicodeString);
begin
  SetAttribute('Concepto', Value);
end;

function TNominaV12_Deducciones_Deduccion.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['Importe'].Text;
end;

procedure TNominaV12_Deducciones_Deduccion.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('Importe', Value);
end;

{ TNominaV12_OtrosPagos }

procedure TNominaV12_OtrosPagos.AfterConstruction;
begin
  RegisterChildNode('OtroPago', TNominaV12_OtrosPagos_OtroPago);
  ItemTag := 'OtroPago';
  ItemInterface := INominaV12_OtrosPagos_OtroPago;
  inherited;
end;

function TNominaV12_OtrosPagos.Get_OtroPago(Index: Integer): INominaV12_OtrosPagos_OtroPago;
begin
  Result := List[Index] as INominaV12_OtrosPagos_OtroPago;
end;

function TNominaV12_OtrosPagos.Add: INominaV12_OtrosPagos_OtroPago;
begin
  Result := AddItem(-1) as INominaV12_OtrosPagos_OtroPago;
end;

function TNominaV12_OtrosPagos.Insert(const Index: Integer): INominaV12_OtrosPagos_OtroPago;
begin
  Result := AddItem(Index) as INominaV12_OtrosPagos_OtroPago;
end;

{ TNominaV12_OtrosPagos_OtroPago }

procedure TNominaV12_OtrosPagos_OtroPago.AfterConstruction;
begin
  RegisterChildNode('SubsidioAlEmpleo', TNominaV12_OtrosPagos_OtroPago_SubsidioAlEmpleo);
  RegisterChildNode('CompensacionSaldosAFavor', TNominaV12_OtrosPagos_OtroPago_CompensacionSaldosAFavor);
  inherited;
end;

function TNominaV12_OtrosPagos_OtroPago.Get_TipoOtroPago: UnicodeString;
begin
  Result := AttributeNodes['TipoOtroPago'].Text;
end;

procedure TNominaV12_OtrosPagos_OtroPago.Set_TipoOtroPago(Value: UnicodeString);
begin
  SetAttribute('TipoOtroPago', Value);
end;

function TNominaV12_OtrosPagos_OtroPago.Get_Clave: UnicodeString;
begin
  Result := AttributeNodes['Clave'].Text;
end;

procedure TNominaV12_OtrosPagos_OtroPago.Set_Clave(Value: UnicodeString);
begin
  SetAttribute('Clave', Value);
end;

function TNominaV12_OtrosPagos_OtroPago.Get_Concepto: UnicodeString;
begin
  Result := AttributeNodes['Concepto'].Text;
end;

procedure TNominaV12_OtrosPagos_OtroPago.Set_Concepto(Value: UnicodeString);
begin
  SetAttribute('Concepto', Value);
end;

function TNominaV12_OtrosPagos_OtroPago.Get_Importe: UnicodeString;
begin
  Result := AttributeNodes['Importe'].Text;
end;

procedure TNominaV12_OtrosPagos_OtroPago.Set_Importe(Value: UnicodeString);
begin
  SetAttribute('Importe', Value);
end;

function TNominaV12_OtrosPagos_OtroPago.Get_SubsidioAlEmpleo: INominaV12_OtrosPagos_OtroPago_SubsidioAlEmpleo;
begin
  Result := ChildNodes['SubsidioAlEmpleo'] as INominaV12_OtrosPagos_OtroPago_SubsidioAlEmpleo;
end;

function TNominaV12_OtrosPagos_OtroPago.Get_CompensacionSaldosAFavor: INominaV12_OtrosPagos_OtroPago_CompensacionSaldosAFavor;
begin
  Result := ChildNodes['CompensacionSaldosAFavor'] as INominaV12_OtrosPagos_OtroPago_CompensacionSaldosAFavor;
end;

{ TNominaV12_OtrosPagos_OtroPago_SubsidioAlEmpleo }

function TNominaV12_OtrosPagos_OtroPago_SubsidioAlEmpleo.Get_SubsidioCausado: UnicodeString;
begin
  Result := AttributeNodes['SubsidioCausado'].Text;
end;

procedure TNominaV12_OtrosPagos_OtroPago_SubsidioAlEmpleo.Set_SubsidioCausado(Value: UnicodeString);
begin
  SetAttribute('SubsidioCausado', Value);
end;

{ TNominaV12_OtrosPagos_OtroPago_CompensacionSaldosAFavor }

function TNominaV12_OtrosPagos_OtroPago_CompensacionSaldosAFavor.Get_SaldoAFavor: UnicodeString;
begin
  Result := AttributeNodes['SaldoAFavor'].Text;
end;

procedure TNominaV12_OtrosPagos_OtroPago_CompensacionSaldosAFavor.Set_SaldoAFavor(Value: UnicodeString);
begin
  SetAttribute('SaldoAFavor', Value);
end;

function TNominaV12_OtrosPagos_OtroPago_CompensacionSaldosAFavor.Get_Año: SmallInt;
begin
  Result := AttributeNodes['Año'].NodeValue;
end;

procedure TNominaV12_OtrosPagos_OtroPago_CompensacionSaldosAFavor.Set_Año(Value: SmallInt);
begin
  SetAttribute('Año', Value);
end;

function TNominaV12_OtrosPagos_OtroPago_CompensacionSaldosAFavor.Get_RemanenteSalFav: UnicodeString;
begin
  Result := AttributeNodes['RemanenteSalFav'].Text;
end;

procedure TNominaV12_OtrosPagos_OtroPago_CompensacionSaldosAFavor.Set_RemanenteSalFav(Value: UnicodeString);
begin
  SetAttribute('RemanenteSalFav', Value);
end;

{ TNominaV12_Incapacidades }

procedure TNominaV12_Incapacidades.AfterConstruction;
begin
  RegisterChildNode('Incapacidad', TNominaV12_Incapacidades_Incapacidad);
  ItemTag := 'Incapacidad';
  ItemInterface := INominaV12_Incapacidades_Incapacidad;
  inherited;
end;

function TNominaV12_Incapacidades.Get_Incapacidad(Index: Integer): INominaV12_Incapacidades_Incapacidad;
begin
  Result := List[Index] as INominaV12_Incapacidades_Incapacidad;
end;

function TNominaV12_Incapacidades.Add: INominaV12_Incapacidades_Incapacidad;
begin
  Result := AddItem(-1) as INominaV12_Incapacidades_Incapacidad;
end;

function TNominaV12_Incapacidades.Insert(const Index: Integer): INominaV12_Incapacidades_Incapacidad;
begin
  Result := AddItem(Index) as INominaV12_Incapacidades_Incapacidad;
end;

{ TNominaV12_Incapacidades_Incapacidad }

function TNominaV12_Incapacidades_Incapacidad.Get_DiasIncapacidad: Integer;
begin
  Result := AttributeNodes['DiasIncapacidad'].NodeValue;
end;

procedure TNominaV12_Incapacidades_Incapacidad.Set_DiasIncapacidad(Value: Integer);
begin
  SetAttribute('DiasIncapacidad', Value);
end;

function TNominaV12_Incapacidades_Incapacidad.Get_TipoIncapacidad: UnicodeString;
begin
  Result := AttributeNodes['TipoIncapacidad'].Text;
end;

procedure TNominaV12_Incapacidades_Incapacidad.Set_TipoIncapacidad(Value: UnicodeString);
begin
  SetAttribute('TipoIncapacidad', Value);
end;

function TNominaV12_Incapacidades_Incapacidad.Get_ImporteMonetario: UnicodeString;
begin
  Result := AttributeNodes['ImporteMonetario'].Text;
end;

procedure TNominaV12_Incapacidades_Incapacidad.Set_ImporteMonetario(Value: UnicodeString);
begin
  SetAttribute('ImporteMonetario', Value);
end;

end.