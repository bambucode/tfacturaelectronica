unit uPrin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Facturacion.ComprobanteV33,
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
  Facturacion.Helper,
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
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
    admonFacturas: IAdministradorFacturas;
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
  rutaArchivo, claveProd, noIdent, cant, claveUnidad, Unidad, Desc, valorUnitario, importe, descuento: string;
  comprobante: IComprobanteFiscal;
  facturaCFDIv33: IComprobanteFiscalV33;
  I: Integer;
  concepto: IComprobanteFiscalV33_Conceptos_Concepto;
begin
  if Not dlgOpenAbrir.Execute then
    Exit;

  rutaArchivo := dlgOpenAbrir.FileName;
  comprobante := admonFacturas.LeerDesdeArchivo(rutaArchivo);

  edtVersion.Text := comprobante.Version;
  mmoXML.Text     := FormatXMLData(comprobante.XML);

  if Not Supports(comprobante, IComprobanteFiscalv33, facturaCFDIv33) then
  begin
    ShowMessage('El comprobante leido no fue un Comprobante Fiscal v33');
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
  end;
end;

end.
