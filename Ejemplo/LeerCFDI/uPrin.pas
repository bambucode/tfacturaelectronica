unit uPrin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Facturacion.ComprobanteV33,
  Facturacion.ComprobanteV32,
  Facturacion.Comprobante,
  Facturacion.Administrador,
  Facturacion.GeneradorCadenaOriginal,
  Facturacion.GeneradorCadenaOrignalV33,
  Facturacion.GeneradorSello,
  Facturacion.OpenSSL,
  Facturacion.GeneradorSelloV33,
  Facturacion.PAC.Ecodex,
  Facturacion.ProveedorAutorizadoCertificacion,
  PAC.Ecodex.ManejadorDeSesion,
  EcodexWsClientes,
  EcodexWsComun,
  EcodexWsSeguridad,
  EcodexWsTimbrado,
  Facturacion.CertificadoDeSellos,
  Facturacion.ImpuestosLocalesV1,
  Facturacion.Helper,
  Xml.XMLIntf,
  Facturacion.ManejadorErroresComunesWebServices;

type

  TfrmPrin = class(TForm)
    btn1: TButton;
    edtVersion: TLabeledEdit;
    mmoConceptos: TMemo;
    edtFolio: TLabeledEdit;
    dlgOpenAbrir: TOpenDialog;
    edtEmisor: TLabeledEdit;
    mmoXML: TMemo;
    chkTieneTimbre: TCheckBox;
    edtUUID: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
    admonFacturas: IAdministradorFacturas;
    procedure LeerCFDIv32(aComprobante: IComprobanteFiscal);
    procedure LeerCFDIv33(aComprobante: IComprobanteFiscal);
    procedure MostrarImpuestosLocales(const aNodoImpuestosLocales: IXMLNode);
  public
    { Public declarations }
  end;

var
  frmPrin: TfrmPrin;

implementation

uses Xml.XMLDoc;
{$R *.dfm}

procedure TfrmPrin.FormCreate(Sender: TObject);
begin
  admonFacturas := TAdministradorFacturas.Create;
end;

procedure TfrmPrin.btn1Click(Sender: TObject);
var
  rutaArchivo: String;
  comprobante: IComprobanteFiscal;
begin
  if Not dlgOpenAbrir.Execute then
    Exit;

  rutaArchivo := dlgOpenAbrir.FileName;
  comprobante := admonFacturas.LeerDesdeArchivo(rutaArchivo);

  edtVersion.Text := comprobante.Version;
  mmoXML.Text     := FormatXMLData(comprobante.XML);

  mmoConceptos.Lines.Clear;
  chkTieneTimbre.Checked := False;

  // Usamos la interfase adecuada segun la version
  if comprobante.Version = '3.3' then
    leerCFDIv33(comprobante);

  if comprobante.Version = '3.2' then
    leerCFDIv32(comprobante);
end;

procedure TfrmPrin.LeerCFDIv33(aComprobante: IComprobanteFiscal);
var
  claveProd, noIdent, cant, claveUnidad, Unidad, Desc, valorUnitario, importe, descuento: string;
  facturaCFDIv33: IComprobanteFiscalV33;
  I: Integer;
  concepto: IComprobanteFiscalV33_Conceptos_Concepto;
  impuestosLocales: IImpuestosLocalesV1;
  nodoImpuestosLocales: IXMLNode;
begin

  if Not Supports(aComprobante, IComprobanteFiscalv33, facturaCFDIv33) then
  begin
    ShowMessage('El aComprobante leido no fue un aComprobante Fiscal v33');
    Exit;
  end;

  with facturaCFDIv33 do
  begin
    edtFolio.Text := facturaCFDIv33.Folio;
    edtEmisor.Text := facturaCFDIv33.Emisor.Nombre;

    // Leemos los conceptos y los mostramos en el Memo
    for I := 0 to  facturaCFDIv33.Conceptos.ChildNodes.Count -1  do
    begin
      concepto := facturaCFDIv33.Conceptos.ChildNodes[I] AS IComprobanteFiscalV33_Conceptos_Concepto;
      claveProd := concepto.ClaveProdServ;
      noIdent := concepto.NoIdentificacion;
      cant := concepto.Cantidad;
      claveUnidad := concepto.ClaveUnidad;
      Unidad := concepto.Unidad;
      Desc := concepto.Descripcion;
      valorUnitario := concepto.ValorUnitario;
      importe := concepto.Importe;
      descuento := concepto.Descuento;

      mmoConceptos.Lines.Add(cant + ' x ' + Desc + ' - ' + valorUnitario);
    end;

    if facturaCFDIv33.Complemento.TimbreFiscalDigital <> nil then
    begin
      chkTieneTimbre.Checked := True;
      edtUUID.Text := facturaCFDIv33.Complemento.TimbreFiscalDigital.UUID;
    end;

    // ¿Tiene impuestos locales?
    nodoImpuestosLocales := facturaCFDIv33.Complemento.ChildNodes.FindNode('ImpuestosLocales',
                                                                            Facturacion.ImpuestosLocalesV1.TargetNamespace);
    MostrarImpuestosLocales(nodoImpuestosLocales);
  end;
end;

procedure TfrmPrin.LeerCFDIv32(aComprobante: IComprobanteFiscal);
var
  claveProd, noIdent, cant, claveUnidad, Unidad, Desc, valorUnitario, importe, descuento: string;
  facturaCFDIv32: IComprobanteFiscalV32;
  I: Integer;
  concepto: IComprobanteFiscalV32_Conceptos_Concepto;
  nodoImpuestosLocales: IXMLNode;
begin

  if Not Supports(aComprobante, IComprobanteFiscalv32, facturaCFDIv32) then
  begin
    ShowMessage('El aComprobante leido no fue un aComprobante Fiscal v3.2');
    Exit;
  end;

  with facturaCFDIv32 do
  begin
    edtFolio.Text := facturaCFDIv32.Folio;
    edtEmisor.Text := facturaCFDIv32.Emisor.Nombre;

    // Leemos los conceptos y los mostramos en el Memo
    for I := 0 to  facturaCFDIv32.Conceptos.ChildNodes.Count -1  do
    begin
      concepto := facturaCFDIv32.Conceptos.ChildNodes[I] AS IComprobanteFiscalV32_Conceptos_Concepto;
      noIdent := concepto.NoIdentificacion;
      cant := concepto.Cantidad;
      Unidad := concepto.Unidad;
      Desc := concepto.Descripcion;
      valorUnitario := concepto.ValorUnitario;
      importe := concepto.Importe;

      mmoConceptos.Lines.Add(cant + ' x ' + Desc + ' - ' + valorUnitario);
    end;

    if facturaCFDIv32.Complemento.TimbreFiscalDigital <> nil then
    begin
      chkTieneTimbre.Checked := True;
      edtUUID.Text := facturaCFDIv32.Complemento.TimbreFiscalDigital.UUID;
    end;

    // ¿Tiene impuestos locales?
    nodoImpuestosLocales := facturaCFDIv32.Complemento.ChildNodes.FindNode('ImpuestosLocales',
                                                                            Facturacion.ImpuestosLocalesV1.TargetNamespace);
    MostrarImpuestosLocales(nodoImpuestosLocales);
  end;
end;

procedure TfrmPrin.MostrarImpuestosLocales(const aNodoImpuestosLocales:
    IXMLNode);
var
  impuestosLocales: IImpuestosLocalesV1;
begin
  if aNodoImpuestosLocales <> nil then
  begin
    // Leemos el nodo de impuestos directo desde el XML del CFDI
    impuestosLocales := GetImpuestosLocalesV1(LoadXMLData(aNodoImpuestosLocales.XML));
    mmoConceptos.Lines.Add('----- Impuestos Locales ---------------');
    mmoConceptos.Lines.Add('Total traslados = ' + impuestosLocales.TotaldeTraslados);
    mmoConceptos.Lines.Add('Total retenciones = ' + impuestosLocales.TotaldeRetenciones);
  end;
end;

end.
