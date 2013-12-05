
{***********************************************}
{                                               }
{               XML Data Binding                }
{                                               }
{         Generated on: 12/4/2013 11:17:39 AM   }
{       Generated from: D:\resp.xml             }
{                                               }
{***********************************************}

unit FECancelaComercioDigital;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IFEXMLAcuseType = interface;
  IXMLFoliosType = interface;
  IXMLSignatureType = interface;
  IXMLSignedInfoType = interface;
  IXMLCanonicalizationMethodType = interface;
  IXMLSignatureMethodType = interface;
  IXMLReferenceType = interface;
  IXMLTransformsType = interface;
  IXMLTransformType = interface;
  IXMLDigestMethodType = interface;
  IXMLKeyInfoType = interface;
  IXMLKeyValueType = interface;
  IXMLRSAKeyValueType = interface;

{ IFEXMLAcuseType }

  IFEXMLAcuseType = interface(IXMLNode)
    ['{480A1A45-772C-40A7-A0F8-E5A0504140F9}']
    { Property Accessors }
    function Get_RfcEmisor: Integer;
    function Get_Fecha: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function Get_Folios: IXMLFoliosType;
    function Get_Signature: IXMLSignatureType;
    procedure Set_RfcEmisor(Value: Integer);
    procedure Set_Fecha(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    { Methods & Properties }
    property RfcEmisor: Integer read Get_RfcEmisor write Set_RfcEmisor;
    property Fecha: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read Get_Fecha write Set_Fecha;
    property Folios: IXMLFoliosType read Get_Folios;
    property Signature: IXMLSignatureType read Get_Signature;
  end;

{ IXMLFoliosType }

  IXMLFoliosType = interface(IXMLNode)
    ['{E0D9E76D-A4F6-488E-BCD2-AA6B7F2A6A6F}']
    { Property Accessors }
    function Get_Xmlns: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function Get_UUID: Integer;
    function Get_EstatusUUID: Integer;
    procedure Set_Xmlns(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure Set_UUID(Value: Integer);
    procedure Set_EstatusUUID(Value: Integer);
    { Methods & Properties }
    property Xmlns: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read Get_Xmlns write Set_Xmlns;
    property UUID: Integer read Get_UUID write Set_UUID;
    property EstatusUUID: Integer read Get_EstatusUUID write Set_EstatusUUID;
  end;

{ IXMLSignatureType }

  IXMLSignatureType = interface(IXMLNode)
    ['{80CEB6B9-BA77-4C56-A1B6-A152D54A0B9E}']
    { Property Accessors }
    function Get_Id: Integer;
    function Get_Xmlns: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function Get_SignedInfo: IXMLSignedInfoType;
    function Get_SignatureValue: Integer;
    function Get_KeyInfo: IXMLKeyInfoType;
    procedure Set_Id(Value: Integer);
    procedure Set_Xmlns(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure Set_SignatureValue(Value: Integer);
    { Methods & Properties }
    property Id: Integer read Get_Id write Set_Id;
    property Xmlns: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read Get_Xmlns write Set_Xmlns;
    property SignedInfo: IXMLSignedInfoType read Get_SignedInfo;
    property SignatureValue: Integer read Get_SignatureValue write Set_SignatureValue;
    property KeyInfo: IXMLKeyInfoType read Get_KeyInfo;
  end;

{ IXMLSignedInfoType }

  IXMLSignedInfoType = interface(IXMLNode)
    ['{0D195FFF-6B9B-42AA-89D9-7A6131067ED9}']
    { Property Accessors }
    function Get_CanonicalizationMethod: IXMLCanonicalizationMethodType;
    function Get_SignatureMethod: IXMLSignatureMethodType;
    function Get_Reference: IXMLReferenceType;
    { Methods & Properties }
    property CanonicalizationMethod: IXMLCanonicalizationMethodType read Get_CanonicalizationMethod;
    property SignatureMethod: IXMLSignatureMethodType read Get_SignatureMethod;
    property Reference: IXMLReferenceType read Get_Reference;
  end;

{ IXMLCanonicalizationMethodType }

  IXMLCanonicalizationMethodType = interface(IXMLNode)
    ['{D098F7D9-1A28-4E0E-84C0-A9C19945F29C}']
    { Property Accessors }
    function Get_Algorithm: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    procedure Set_Algorithm(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    { Methods & Properties }
    property Algorithm: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLSignatureMethodType }

  IXMLSignatureMethodType = interface(IXMLNode)
    ['{20EA54B9-74C7-45F0-882A-D4B865FEF0FC}']
    { Property Accessors }
    function Get_Algorithm: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    procedure Set_Algorithm(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    { Methods & Properties }
    property Algorithm: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLReferenceType }

  IXMLReferenceType = interface(IXMLNode)
    ['{5AD6FC62-F57C-453D-BCFF-7A4992B61053}']
    { Property Accessors }
    function Get_URI: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function Get_Transforms: IXMLTransformsType;
    function Get_DigestMethod: IXMLDigestMethodType;
    function Get_DigestValue: Integer;
    procedure Set_URI(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure Set_DigestValue(Value: Integer);
    { Methods & Properties }
    property URI: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read Get_URI write Set_URI;
    property Transforms: IXMLTransformsType read Get_Transforms;
    property DigestMethod: IXMLDigestMethodType read Get_DigestMethod;
    property DigestValue: Integer read Get_DigestValue write Set_DigestValue;
  end;

{ IXMLTransformsType }

  IXMLTransformsType = interface(IXMLNode)
    ['{22595F56-4F46-4C47-A78C-651B57FF5E32}']
    { Property Accessors }
    function Get_Transform: IXMLTransformType;
    { Methods & Properties }
    property Transform: IXMLTransformType read Get_Transform;
  end;

{ IXMLTransformType }

  IXMLTransformType = interface(IXMLNode)
    ['{79B150E5-E28E-455C-88CB-12D5768CCC8C}']
    { Property Accessors }
    function Get_Algorithm: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function Get_XPath: Integer;
    procedure Set_Algorithm(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure Set_XPath(Value: Integer);
    { Methods & Properties }
    property Algorithm: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read Get_Algorithm write Set_Algorithm;
    property XPath: Integer read Get_XPath write Set_XPath;
  end;

{ IXMLDigestMethodType }

  IXMLDigestMethodType = interface(IXMLNode)
    ['{16C8BDA2-0330-4EAB-9952-578491328EFF}']
    { Property Accessors }
    function Get_Algorithm: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    procedure Set_Algorithm(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    { Methods & Properties }
    property Algorithm: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND} read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLKeyInfoType }

  IXMLKeyInfoType = interface(IXMLNode)
    ['{A32F8624-4610-4281-B8B5-27CCA3773AC8}']
    { Property Accessors }
    function Get_KeyName: Integer;
    function Get_KeyValue: IXMLKeyValueType;
    procedure Set_KeyName(Value: Integer);
    { Methods & Properties }
    property KeyName: Integer read Get_KeyName write Set_KeyName;
    property KeyValue: IXMLKeyValueType read Get_KeyValue;
  end;

{ IXMLKeyValueType }

  IXMLKeyValueType = interface(IXMLNode)
    ['{9073E7B4-4304-47ED-9A45-C5CBA3835CA8}']
    { Property Accessors }
    function Get_RSAKeyValue: IXMLRSAKeyValueType;
    { Methods & Properties }
    property RSAKeyValue: IXMLRSAKeyValueType read Get_RSAKeyValue;
  end;

{ IXMLRSAKeyValueType }

  IXMLRSAKeyValueType = interface(IXMLNode)
    ['{973C7CB1-62E3-4DD5-81A9-CBB6A2B16B1C}']
    { Property Accessors }
    function Get_Modulus: Integer;
    function Get_Exponent: Integer;
    procedure Set_Modulus(Value: Integer);
    procedure Set_Exponent(Value: Integer);
    { Methods & Properties }
    property Modulus: Integer read Get_Modulus write Set_Modulus;
    property Exponent: Integer read Get_Exponent write Set_Exponent;
  end;

{ Forward Decls }

  TXMLIFEXMLAcuseType = class;
  TXMLFoliosType = class;
  TXMLSignatureType = class;
  TXMLSignedInfoType = class;
  TXMLCanonicalizationMethodType = class;
  TXMLSignatureMethodType = class;
  TXMLReferenceType = class;
  TXMLTransformsType = class;
  TXMLTransformType = class;
  TXMLDigestMethodType = class;
  TXMLKeyInfoType = class;
  TXMLKeyValueType = class;
  TXMLRSAKeyValueType = class;

{ TXMLIFEXMLAcuseType }

  TXMLIFEXMLAcuseType = class(TXMLNode, IFEXMLAcuseType)
  protected
    { IFEXMLAcuseType }
    function Get_RfcEmisor: Integer;
    function Get_Fecha: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function Get_Folios: IXMLFoliosType;
    function Get_Signature: IXMLSignatureType;
    procedure Set_RfcEmisor(Value: Integer);
    procedure Set_Fecha(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
  public
    procedure AfterConstruction; override;
  end;

{ TXMLFoliosType }

  TXMLFoliosType = class(TXMLNode, IXMLFoliosType)
  protected
    { IXMLFoliosType }
    function Get_Xmlns: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function Get_UUID: Integer;
    function Get_EstatusUUID: Integer;
    procedure Set_Xmlns(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure Set_UUID(Value: Integer);
    procedure Set_EstatusUUID(Value: Integer);
  end;

{ TXMLSignatureType }

  TXMLSignatureType = class(TXMLNode, IXMLSignatureType)
  protected
    { IXMLSignatureType }
    function Get_Id: Integer;
    function Get_Xmlns: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function Get_SignedInfo: IXMLSignedInfoType;
    function Get_SignatureValue: Integer;
    function Get_KeyInfo: IXMLKeyInfoType;
    procedure Set_Id(Value: Integer);
    procedure Set_Xmlns(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure Set_SignatureValue(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSignedInfoType }

  TXMLSignedInfoType = class(TXMLNode, IXMLSignedInfoType)
  protected
    { IXMLSignedInfoType }
    function Get_CanonicalizationMethod: IXMLCanonicalizationMethodType;
    function Get_SignatureMethod: IXMLSignatureMethodType;
    function Get_Reference: IXMLReferenceType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCanonicalizationMethodType }

  TXMLCanonicalizationMethodType = class(TXMLNode, IXMLCanonicalizationMethodType)
  protected
    { IXMLCanonicalizationMethodType }
    function Get_Algorithm: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    procedure Set_Algorithm(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
  end;

{ TXMLSignatureMethodType }

  TXMLSignatureMethodType = class(TXMLNode, IXMLSignatureMethodType)
  protected
    { IXMLSignatureMethodType }
    function Get_Algorithm: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    procedure Set_Algorithm(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
  end;

{ TXMLReferenceType }

  TXMLReferenceType = class(TXMLNode, IXMLReferenceType)
  protected
    { IXMLReferenceType }
    function Get_URI: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function Get_Transforms: IXMLTransformsType;
    function Get_DigestMethod: IXMLDigestMethodType;
    function Get_DigestValue: Integer;
    procedure Set_URI(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure Set_DigestValue(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTransformsType }

  TXMLTransformsType = class(TXMLNode, IXMLTransformsType)
  protected
    { IXMLTransformsType }
    function Get_Transform: IXMLTransformType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTransformType }

  TXMLTransformType = class(TXMLNode, IXMLTransformType)
  protected
    { IXMLTransformType }
    function Get_Algorithm: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    function Get_XPath: Integer;
    procedure Set_Algorithm(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
    procedure Set_XPath(Value: Integer);
  end;

{ TXMLDigestMethodType }

  TXMLDigestMethodType = class(TXMLNode, IXMLDigestMethodType)
  protected
    { IXMLDigestMethodType }
    function Get_Algorithm: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
    procedure Set_Algorithm(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
  end;

{ TXMLKeyInfoType }

  TXMLKeyInfoType = class(TXMLNode, IXMLKeyInfoType)
  protected
    { IXMLKeyInfoType }
    function Get_KeyName: Integer;
    function Get_KeyValue: IXMLKeyValueType;
    procedure Set_KeyName(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLKeyValueType }

  TXMLKeyValueType = class(TXMLNode, IXMLKeyValueType)
  protected
    { IXMLKeyValueType }
    function Get_RSAKeyValue: IXMLRSAKeyValueType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRSAKeyValueType }

  TXMLRSAKeyValueType = class(TXMLNode, IXMLRSAKeyValueType)
  protected
    { IXMLRSAKeyValueType }
    function Get_Modulus: Integer;
    function Get_Exponent: Integer;
    procedure Set_Modulus(Value: Integer);
    procedure Set_Exponent(Value: Integer);
  end;

{ Global Functions }

function GetAcuse(Doc: IXMLDocument): IFEXMLAcuseType;
function LoadAcuse(const FileName: string): IFEXMLAcuseType;
function NewAcuse: IFEXMLAcuseType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetAcuse(Doc: IXMLDocument): IFEXMLAcuseType;
begin
  Result := Doc.GetDocBinding('Acuse', TXMLIFEXMLAcuseType, TargetNamespace) as IFEXMLAcuseType;
end;

function LoadAcuse(const FileName: string): IFEXMLAcuseType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Acuse', TXMLIFEXMLAcuseType, TargetNamespace) as IFEXMLAcuseType;
end;

function NewAcuse: IFEXMLAcuseType;
begin
  Result := NewXMLDocument.GetDocBinding('Acuse', TXMLIFEXMLAcuseType, TargetNamespace) as IFEXMLAcuseType;
end;

{ TXMLIFEXMLAcuseType }

procedure TXMLIFEXMLAcuseType.AfterConstruction;
begin
  RegisterChildNode('Folios', TXMLFoliosType);
  RegisterChildNode('Signature', TXMLSignatureType);
  inherited;
end;

function TXMLIFEXMLAcuseType.Get_RfcEmisor: Integer;
begin
  Result := AttributeNodes['RfcEmisor'].NodeValue;
end;

procedure TXMLIFEXMLAcuseType.Set_RfcEmisor(Value: Integer);
begin
  SetAttribute('RfcEmisor', Value);
end;

function TXMLIFEXMLAcuseType.Get_Fecha: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['Fecha'].Text;
end;

procedure TXMLIFEXMLAcuseType.Set_Fecha(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('Fecha', Value);
end;

function TXMLIFEXMLAcuseType.Get_Folios: IXMLFoliosType;
begin
  Result := ChildNodes['Folios'] as IXMLFoliosType;
end;

function TXMLIFEXMLAcuseType.Get_Signature: IXMLSignatureType;
begin
  Result := ChildNodes['Signature'] as IXMLSignatureType;
end;

{ TXMLFoliosType }

function TXMLFoliosType.Get_Xmlns: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['xmlns'].Text;
end;

procedure TXMLFoliosType.Set_Xmlns(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('xmlns', Value);
end;

function TXMLFoliosType.Get_UUID: Integer;
begin
  Result := ChildNodes['UUID'].NodeValue;
end;

procedure TXMLFoliosType.Set_UUID(Value: Integer);
begin
  ChildNodes['UUID'].NodeValue := Value;
end;

function TXMLFoliosType.Get_EstatusUUID: Integer;
begin
  Result := ChildNodes['EstatusUUID'].NodeValue;
end;

procedure TXMLFoliosType.Set_EstatusUUID(Value: Integer);
begin
  ChildNodes['EstatusUUID'].NodeValue := Value;
end;

{ TXMLSignatureType }

procedure TXMLSignatureType.AfterConstruction;
begin
  RegisterChildNode('SignedInfo', TXMLSignedInfoType);
  RegisterChildNode('KeyInfo', TXMLKeyInfoType);
  inherited;
end;

function TXMLSignatureType.Get_Id: Integer;
begin
  Result := AttributeNodes['Id'].NodeValue;
end;

procedure TXMLSignatureType.Set_Id(Value: Integer);
begin
  SetAttribute('Id', Value);
end;

function TXMLSignatureType.Get_Xmlns: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['xmlns'].Text;
end;

procedure TXMLSignatureType.Set_Xmlns(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('xmlns', Value);
end;

function TXMLSignatureType.Get_SignedInfo: IXMLSignedInfoType;
begin
  Result := ChildNodes['SignedInfo'] as IXMLSignedInfoType;
end;

function TXMLSignatureType.Get_SignatureValue: Integer;
begin
  Result := ChildNodes['SignatureValue'].NodeValue;
end;

procedure TXMLSignatureType.Set_SignatureValue(Value: Integer);
begin
  ChildNodes['SignatureValue'].NodeValue := Value;
end;

function TXMLSignatureType.Get_KeyInfo: IXMLKeyInfoType;
begin
  Result := ChildNodes['KeyInfo'] as IXMLKeyInfoType;
end;

{ TXMLSignedInfoType }

procedure TXMLSignedInfoType.AfterConstruction;
begin
  RegisterChildNode('CanonicalizationMethod', TXMLCanonicalizationMethodType);
  RegisterChildNode('SignatureMethod', TXMLSignatureMethodType);
  RegisterChildNode('Reference', TXMLReferenceType);
  inherited;
end;

function TXMLSignedInfoType.Get_CanonicalizationMethod: IXMLCanonicalizationMethodType;
begin
  Result := ChildNodes['CanonicalizationMethod'] as IXMLCanonicalizationMethodType;
end;

function TXMLSignedInfoType.Get_SignatureMethod: IXMLSignatureMethodType;
begin
  Result := ChildNodes['SignatureMethod'] as IXMLSignatureMethodType;
end;

function TXMLSignedInfoType.Get_Reference: IXMLReferenceType;
begin
  Result := ChildNodes['Reference'] as IXMLReferenceType;
end;

{ TXMLCanonicalizationMethodType }

function TXMLCanonicalizationMethodType.Get_Algorithm: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['Algorithm'].Text;
end;

procedure TXMLCanonicalizationMethodType.Set_Algorithm(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('Algorithm', Value);
end;

{ TXMLSignatureMethodType }

function TXMLSignatureMethodType.Get_Algorithm: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['Algorithm'].Text;
end;

procedure TXMLSignatureMethodType.Set_Algorithm(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('Algorithm', Value);
end;

{ TXMLReferenceType }

procedure TXMLReferenceType.AfterConstruction;
begin
  RegisterChildNode('Transforms', TXMLTransformsType);
  RegisterChildNode('DigestMethod', TXMLDigestMethodType);
  inherited;
end;

function TXMLReferenceType.Get_URI: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['URI'].Text;
end;

procedure TXMLReferenceType.Set_URI(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('URI', Value);
end;

function TXMLReferenceType.Get_Transforms: IXMLTransformsType;
begin
  Result := ChildNodes['Transforms'] as IXMLTransformsType;
end;

function TXMLReferenceType.Get_DigestMethod: IXMLDigestMethodType;
begin
  Result := ChildNodes['DigestMethod'] as IXMLDigestMethodType;
end;

function TXMLReferenceType.Get_DigestValue: Integer;
begin
  Result := ChildNodes['DigestValue'].NodeValue;
end;

procedure TXMLReferenceType.Set_DigestValue(Value: Integer);
begin
  ChildNodes['DigestValue'].NodeValue := Value;
end;

{ TXMLTransformsType }

procedure TXMLTransformsType.AfterConstruction;
begin
  RegisterChildNode('Transform', TXMLTransformType);
  inherited;
end;

function TXMLTransformsType.Get_Transform: IXMLTransformType;
begin
  Result := ChildNodes['Transform'] as IXMLTransformType;
end;

{ TXMLTransformType }

function TXMLTransformType.Get_Algorithm: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['Algorithm'].Text;
end;

procedure TXMLTransformType.Set_Algorithm(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('Algorithm', Value);
end;

function TXMLTransformType.Get_XPath: Integer;
begin
  Result := ChildNodes['XPath'].NodeValue;
end;

procedure TXMLTransformType.Set_XPath(Value: Integer);
begin
  ChildNodes['XPath'].NodeValue := Value;
end;

{ TXMLDigestMethodType }

function TXMLDigestMethodType.Get_Algorithm: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND};
begin
  Result := AttributeNodes['Algorithm'].Text;
end;

procedure TXMLDigestMethodType.Set_Algorithm(Value: {$IF Compilerversion >= 20}  UnicodeString {$ELSE} UTF8String {$IFEND});
begin
  SetAttribute('Algorithm', Value);
end;

{ TXMLKeyInfoType }

procedure TXMLKeyInfoType.AfterConstruction;
begin
  RegisterChildNode('KeyValue', TXMLKeyValueType);
  inherited;
end;

function TXMLKeyInfoType.Get_KeyName: Integer;
begin
  Result := ChildNodes['KeyName'].NodeValue;
end;

procedure TXMLKeyInfoType.Set_KeyName(Value: Integer);
begin
  ChildNodes['KeyName'].NodeValue := Value;
end;

function TXMLKeyInfoType.Get_KeyValue: IXMLKeyValueType;
begin
  Result := ChildNodes['KeyValue'] as IXMLKeyValueType;
end;

{ TXMLKeyValueType }

procedure TXMLKeyValueType.AfterConstruction;
begin
  RegisterChildNode('RSAKeyValue', TXMLRSAKeyValueType);
  inherited;
end;

function TXMLKeyValueType.Get_RSAKeyValue: IXMLRSAKeyValueType;
begin
  Result := ChildNodes['RSAKeyValue'] as IXMLRSAKeyValueType;
end;

{ TXMLRSAKeyValueType }

function TXMLRSAKeyValueType.Get_Modulus: Integer;
begin
  Result := ChildNodes['Modulus'].NodeValue;
end;

procedure TXMLRSAKeyValueType.Set_Modulus(Value: Integer);
begin
  ChildNodes['Modulus'].NodeValue := Value;
end;

function TXMLRSAKeyValueType.Get_Exponent: Integer;
begin
  Result := ChildNodes['Exponent'].NodeValue;
end;

procedure TXMLRSAKeyValueType.Set_Exponent(Value: Integer);
begin
  ChildNodes['Exponent'].NodeValue := Value;
end;

end.