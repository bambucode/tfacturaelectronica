object frmPrin: TfrmPrin
  Left = 0
  Top = 0
  Caption = 'Ejemplo Lectura CFDI ...'
  ClientHeight = 526
  ClientWidth = 826
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TButton
    Left = 6
    Top = 12
    Width = 195
    Height = 29
    Caption = 'Leer CFDI ...'
    TabOrder = 0
    OnClick = btn1Click
  end
  object edtVersion: TLabeledEdit
    Left = 8
    Top = 66
    Width = 121
    Height = 21
    EditLabel.Width = 51
    EditLabel.Height = 13
    EditLabel.Caption = 'edtVersion'
    TabOrder = 1
  end
  object mmoConceptos: TMemo
    Left = 8
    Top = 194
    Width = 355
    Height = 247
    TabOrder = 2
  end
  object edtFolio: TLabeledEdit
    Left = 8
    Top = 114
    Width = 121
    Height = 21
    EditLabel.Width = 38
    EditLabel.Height = 13
    EditLabel.Caption = 'edtFolio'
    TabOrder = 3
  end
  object edtEmisor: TLabeledEdit
    Left = 8
    Top = 162
    Width = 319
    Height = 21
    EditLabel.Width = 35
    EditLabel.Height = 13
    EditLabel.Caption = 'Emisor:'
    TabOrder = 4
  end
  object mmoXML: TMemo
    Left = 374
    Top = 8
    Width = 447
    Height = 510
    Color = clBlack
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 5
    WordWrap = False
  end
  object chkTieneTimbre: TCheckBox
    Left = 8
    Top = 447
    Width = 97
    Height = 17
    Caption = #191'Est'#225' timbrada?'
    TabOrder = 6
  end
  object edtUUID: TLabeledEdit
    Left = 12
    Top = 490
    Width = 351
    Height = 21
    EditLabel.Width = 25
    EditLabel.Height = 13
    EditLabel.Caption = 'UUID'
    TabOrder = 7
  end
  object dlgOpenAbrir: TOpenDialog
    Filter = 'Archivos XML|*.xml'
    Title = 'Abrir CFDI'
    Left = 292
    Top = 12
  end
end
