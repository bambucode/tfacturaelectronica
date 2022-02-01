
{*********************************************************************************************}
{                                                                                             }
{                                      XML Data Binding                                       }
{                                                                                             }
{         Generated on: 25/01/2022 10:16:57 a. m.                                             }
{       Generated from: C:\Delphi\tfacturaelectronica\Schemas\Cancelaciones\cancelacion.xsd   }
{   Settings stored in: C:\Delphi\tfacturaelectronica\Schemas\Cancelaciones\cancelacion.xdb   }
{                                                                                             }
{*********************************************************************************************}

unit Facturacion.CancelaCFD;

interface

uses Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type

{ Forward Decls }

  ICancelaCFD = interface;
  ICancelaCFD_Folios = interface;
  ICancelaCFD_FoliosList = interface;
  ICancelaCFD_Folios_Folio = interface;
  ICancelaCFDSignatureType_signature = interface;
  ICancelaCFDSignedInfoType_signature = interface;
  ICancelaCFDCanonicalizationMethodType_signature = interface;
  ICancelaCFDSignatureMethodType_signature = interface;
  ICancelaCFDReferenceType_signature = interface;
  ICancelaCFDReferenceType_signatureList = interface;
  ICancelaCFDTransformsType_signature = interface;
  ICancelaCFDTransformType_signature = interface;
  ICancelaCFDDigestMethodType_signature = interface;
  ICancelaCFDSignatureValueType_signature = interface;
  ICancelaCFDKeyInfoType_signature = interface;
  ICancelaCFDKeyValueType_signature = interface;
  ICancelaCFDKeyValueType_signatureList = interface;
  ICancelaCFDDSAKeyValueType_signature = interface;
  ICancelaCFDRSAKeyValueType_signature = interface;
  ICancelaCFDRetrievalMethodType_signature = interface;
  ICancelaCFDRetrievalMethodType_signatureList = interface;
  ICancelaCFDX509DataType_signature = interface;
  ICancelaCFDX509DataType_signatureList = interface;
  ICancelaCFDX509IssuerSerialType_signature = interface;
  ICancelaCFDX509IssuerSerialType_signatureList = interface;
  ICancelaCFDPGPDataType_signature = interface;
  ICancelaCFDPGPDataType_signatureList = interface;
  ICancelaCFDSPKIDataType_signature = interface;
  ICancelaCFDSPKIDataType_signatureList = interface;
  ICancelaCFDObjectType_signature = interface;
  ICancelaCFDObjectType_signatureList = interface;
  ICancelaCFDString_List = interface;
  ICancelaCFDBase64BinaryList = interface;

{ ICancelaCFD }

  ICancelaCFD = interface(IXMLNode)
    ['{8B94A74C-5364-4164-987F-3487C548F885}']
    { Property Accessors }
    function Get_RfcEmisor: UnicodeString;
    function Get_Fecha: UnicodeString;
    function Get_Folios: ICancelaCFD_FoliosList;
    function Get_Signature: ICancelaCFDSignatureType_signature;
    procedure Set_RfcEmisor(Value: UnicodeString);
    procedure Set_Fecha(Value: UnicodeString);
    { Methods & Properties }
    property RfcEmisor: UnicodeString read Get_RfcEmisor write Set_RfcEmisor;
    property Fecha: UnicodeString read Get_Fecha write Set_Fecha;
    property Folios: ICancelaCFD_FoliosList read Get_Folios;
    property Signature: ICancelaCFDSignatureType_signature read Get_Signature;
  end;

{ ICancelaCFD_Folios }

  ICancelaCFD_Folios = interface(IXMLNode)
    ['{CC4E6320-0736-4E58-A9DD-388618693DB0}']
    { Property Accessors }
    function Get_Folio: ICancelaCFD_Folios_Folio;
    { Methods & Properties }
    property Folio: ICancelaCFD_Folios_Folio read Get_Folio;
  end;

{ ICancelaCFD_FoliosList }

  ICancelaCFD_FoliosList = interface(IXMLNodeCollection)
    ['{1431889D-353B-4069-98CF-EC3CF6EFF372}']
    { Methods & Properties }
    function Add: ICancelaCFD_Folios;
    function Insert(const Index: Integer): ICancelaCFD_Folios;

    function Get_Item(Index: Integer): ICancelaCFD_Folios;
    property Items[Index: Integer]: ICancelaCFD_Folios read Get_Item; default;
  end;

{ ICancelaCFD_Folios_Folio }

  ICancelaCFD_Folios_Folio = interface(IXMLNode)
    ['{ECD4BC2D-1360-4E83-9852-0DBA4B7480FB}']
    { Property Accessors }
    function Get_UUID: UnicodeString;
    function Get_Motivo: UnicodeString;
    function Get_FolioSustitucion: UnicodeString;
    procedure Set_UUID(Value: UnicodeString);
    procedure Set_Motivo(Value: UnicodeString);
    procedure Set_FolioSustitucion(Value: UnicodeString);
    { Methods & Properties }
    property UUID: UnicodeString read Get_UUID write Set_UUID;
    property Motivo: UnicodeString read Get_Motivo write Set_Motivo;
    property FolioSustitucion: UnicodeString read Get_FolioSustitucion write Set_FolioSustitucion;
  end;

{ ICancelaCFDSignatureType_signature }

  ICancelaCFDSignatureType_signature = interface(IXMLNode)
    ['{A4F7D6B6-95DF-4261-B07D-10E3B5FDC4F4}']
    { Property Accessors }
    function Get_Id: UnicodeString;
    function Get_SignedInfo: ICancelaCFDSignedInfoType_signature;
    function Get_SignatureValue: ICancelaCFDSignatureValueType_signature;
    function Get_KeyInfo: ICancelaCFDKeyInfoType_signature;
    function Get_Object_: ICancelaCFDObjectType_signatureList;
    procedure Set_Id(Value: UnicodeString);
    { Methods & Properties }
    property Id: UnicodeString read Get_Id write Set_Id;
    property SignedInfo: ICancelaCFDSignedInfoType_signature read Get_SignedInfo;
    property SignatureValue: ICancelaCFDSignatureValueType_signature read Get_SignatureValue;
    property KeyInfo: ICancelaCFDKeyInfoType_signature read Get_KeyInfo;
    property Object_: ICancelaCFDObjectType_signatureList read Get_Object_;
  end;

{ ICancelaCFDSignedInfoType_signature }

  ICancelaCFDSignedInfoType_signature = interface(IXMLNode)
    ['{8AD553CB-8735-4A51-A5AB-3825F984FD0E}']
    { Property Accessors }
    function Get_Id: UnicodeString;
    function Get_CanonicalizationMethod: ICancelaCFDCanonicalizationMethodType_signature;
    function Get_SignatureMethod: ICancelaCFDSignatureMethodType_signature;
    function Get_Reference: ICancelaCFDReferenceType_signatureList;
    procedure Set_Id(Value: UnicodeString);
    { Methods & Properties }
    property Id: UnicodeString read Get_Id write Set_Id;
    property CanonicalizationMethod: ICancelaCFDCanonicalizationMethodType_signature read Get_CanonicalizationMethod;
    property SignatureMethod: ICancelaCFDSignatureMethodType_signature read Get_SignatureMethod;
    property Reference: ICancelaCFDReferenceType_signatureList read Get_Reference;
  end;

{ ICancelaCFDCanonicalizationMethodType_signature }

  ICancelaCFDCanonicalizationMethodType_signature = interface(IXMLNode)
    ['{1837D17C-1EA3-46B6-B467-7B32F1268059}']
    { Property Accessors }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
    { Methods & Properties }
    property Algorithm: UnicodeString read Get_Algorithm write Set_Algorithm;
  end;

{ ICancelaCFDSignatureMethodType_signature }

  ICancelaCFDSignatureMethodType_signature = interface(IXMLNode)
    ['{42917D62-66ED-4A30-89F7-3994C607022F}']
    { Property Accessors }
    function Get_Algorithm: UnicodeString;
    function Get_HMACOutputLength: Integer;
    procedure Set_Algorithm(Value: UnicodeString);
    procedure Set_HMACOutputLength(Value: Integer);
    { Methods & Properties }
    property Algorithm: UnicodeString read Get_Algorithm write Set_Algorithm;
    property HMACOutputLength: Integer read Get_HMACOutputLength write Set_HMACOutputLength;
  end;

{ ICancelaCFDReferenceType_signature }

  ICancelaCFDReferenceType_signature = interface(IXMLNode)
    ['{B963F91D-C9FB-40E9-909C-90382F142F9E}']
    { Property Accessors }
    function Get_Id: UnicodeString;
    function Get_URI: UnicodeString;
    function Get_Type_: UnicodeString;
    function Get_Transforms: ICancelaCFDTransformsType_signature;
    function Get_DigestMethod: ICancelaCFDDigestMethodType_signature;
    function Get_DigestValue: UnicodeString;
    procedure Set_Id(Value: UnicodeString);
    procedure Set_URI(Value: UnicodeString);
    procedure Set_Type_(Value: UnicodeString);
    procedure Set_DigestValue(Value: UnicodeString);
    { Methods & Properties }
    property Id: UnicodeString read Get_Id write Set_Id;
    property URI: UnicodeString read Get_URI write Set_URI;
    property Type_: UnicodeString read Get_Type_ write Set_Type_;
    property Transforms: ICancelaCFDTransformsType_signature read Get_Transforms;
    property DigestMethod: ICancelaCFDDigestMethodType_signature read Get_DigestMethod;
    property DigestValue: UnicodeString read Get_DigestValue write Set_DigestValue;
  end;

{ ICancelaCFDReferenceType_signatureList }

  ICancelaCFDReferenceType_signatureList = interface(IXMLNodeCollection)
    ['{6DD62822-AC1E-4707-A3A4-D7E06E2E7C73}']
    { Methods & Properties }
    function Add: ICancelaCFDReferenceType_signature;
    function Insert(const Index: Integer): ICancelaCFDReferenceType_signature;

    function Get_Item(Index: Integer): ICancelaCFDReferenceType_signature;
    property Items[Index: Integer]: ICancelaCFDReferenceType_signature read Get_Item; default;
  end;

{ ICancelaCFDTransformsType_signature }

  ICancelaCFDTransformsType_signature = interface(IXMLNodeCollection)
    ['{EF7E01B8-8E51-4AEF-97DD-6CF47327F128}']
    { Property Accessors }
    function Get_Transform(Index: Integer): ICancelaCFDTransformType_signature;
    { Methods & Properties }
    function Add: ICancelaCFDTransformType_signature;
    function Insert(const Index: Integer): ICancelaCFDTransformType_signature;
    property Transform[Index: Integer]: ICancelaCFDTransformType_signature read Get_Transform; default;
  end;

{ ICancelaCFDTransformType_signature }

  ICancelaCFDTransformType_signature = interface(IXMLNodeCollection)
    ['{B32317EE-6F7A-49CD-9BD0-D14368079D13}']
    { Property Accessors }
    function Get_Algorithm: UnicodeString;
    function Get_XPath(Index: Integer): UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
    { Methods & Properties }
    function Add(const XPath: UnicodeString): IXMLNode;
    function Insert(const Index: Integer; const XPath: UnicodeString): IXMLNode;
    property Algorithm: UnicodeString read Get_Algorithm write Set_Algorithm;
    property XPath[Index: Integer]: UnicodeString read Get_XPath; default;
  end;

{ ICancelaCFDDigestMethodType_signature }

  ICancelaCFDDigestMethodType_signature = interface(IXMLNode)
    ['{7AB0F241-A395-4ED2-B6D2-2B5CB364275F}']
    { Property Accessors }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
    { Methods & Properties }
    property Algorithm: UnicodeString read Get_Algorithm write Set_Algorithm;
  end;

{ ICancelaCFDSignatureValueType_signature }

  ICancelaCFDSignatureValueType_signature = interface(IXMLNode)
    ['{077FDB59-6C00-4B2E-9628-02DCD2B0A1C0}']
    { Property Accessors }
    function Get_Id: UnicodeString;
    procedure Set_Id(Value: UnicodeString);
    { Methods & Properties }
    property Id: UnicodeString read Get_Id write Set_Id;
  end;

{ ICancelaCFDKeyInfoType_signature }

  ICancelaCFDKeyInfoType_signature = interface(IXMLNode)
    ['{8313D316-E9D4-4412-91CB-90EE748F0E3B}']
    { Property Accessors }
    function Get_Id: UnicodeString;
    function Get_KeyName: ICancelaCFDString_List;
    function Get_KeyValue: ICancelaCFDKeyValueType_signatureList;
    function Get_RetrievalMethod: ICancelaCFDRetrievalMethodType_signatureList;
    function Get_X509Data: ICancelaCFDX509DataType_signatureList;
    function Get_PGPData: ICancelaCFDPGPDataType_signatureList;
    function Get_SPKIData: ICancelaCFDSPKIDataType_signatureList;
    function Get_MgmtData: ICancelaCFDString_List;
    procedure Set_Id(Value: UnicodeString);
    { Methods & Properties }
    property Id: UnicodeString read Get_Id write Set_Id;
    property KeyName: ICancelaCFDString_List read Get_KeyName;
    property KeyValue: ICancelaCFDKeyValueType_signatureList read Get_KeyValue;
    property RetrievalMethod: ICancelaCFDRetrievalMethodType_signatureList read Get_RetrievalMethod;
    property X509Data: ICancelaCFDX509DataType_signatureList read Get_X509Data;
    property PGPData: ICancelaCFDPGPDataType_signatureList read Get_PGPData;
    property SPKIData: ICancelaCFDSPKIDataType_signatureList read Get_SPKIData;
    property MgmtData: ICancelaCFDString_List read Get_MgmtData;
  end;

{ ICancelaCFDKeyValueType_signature }

  ICancelaCFDKeyValueType_signature = interface(IXMLNode)
    ['{23C8706A-0ADA-4337-8A36-5E7017071F6D}']
    { Property Accessors }
    function Get_DSAKeyValue: ICancelaCFDDSAKeyValueType_signature;
    function Get_RSAKeyValue: ICancelaCFDRSAKeyValueType_signature;
    { Methods & Properties }
    property DSAKeyValue: ICancelaCFDDSAKeyValueType_signature read Get_DSAKeyValue;
    property RSAKeyValue: ICancelaCFDRSAKeyValueType_signature read Get_RSAKeyValue;
  end;

{ ICancelaCFDKeyValueType_signatureList }

  ICancelaCFDKeyValueType_signatureList = interface(IXMLNodeCollection)
    ['{D6BA0801-C9CD-4E3A-9EEA-1435885417FC}']
    { Methods & Properties }
    function Add: ICancelaCFDKeyValueType_signature;
    function Insert(const Index: Integer): ICancelaCFDKeyValueType_signature;

    function Get_Item(Index: Integer): ICancelaCFDKeyValueType_signature;
    property Items[Index: Integer]: ICancelaCFDKeyValueType_signature read Get_Item; default;
  end;

{ ICancelaCFDDSAKeyValueType_signature }

  ICancelaCFDDSAKeyValueType_signature = interface(IXMLNode)
    ['{9BCAB910-F7B3-4085-ABC7-8790C97B946F}']
    { Property Accessors }
    function Get_P: UnicodeString;
    function Get_Q: UnicodeString;
    function Get_G: UnicodeString;
    function Get_Y: UnicodeString;
    function Get_J: UnicodeString;
    function Get_Seed: UnicodeString;
    function Get_PgenCounter: UnicodeString;
    procedure Set_P(Value: UnicodeString);
    procedure Set_Q(Value: UnicodeString);
    procedure Set_G(Value: UnicodeString);
    procedure Set_Y(Value: UnicodeString);
    procedure Set_J(Value: UnicodeString);
    procedure Set_Seed(Value: UnicodeString);
    procedure Set_PgenCounter(Value: UnicodeString);
    { Methods & Properties }
    property P: UnicodeString read Get_P write Set_P;
    property Q: UnicodeString read Get_Q write Set_Q;
    property G: UnicodeString read Get_G write Set_G;
    property Y: UnicodeString read Get_Y write Set_Y;
    property J: UnicodeString read Get_J write Set_J;
    property Seed: UnicodeString read Get_Seed write Set_Seed;
    property PgenCounter: UnicodeString read Get_PgenCounter write Set_PgenCounter;
  end;

{ ICancelaCFDRSAKeyValueType_signature }

  ICancelaCFDRSAKeyValueType_signature = interface(IXMLNode)
    ['{669E4B6F-7360-48A1-BB7F-E89838FB97EC}']
    { Property Accessors }
    function Get_Modulus: UnicodeString;
    function Get_Exponent: UnicodeString;
    procedure Set_Modulus(Value: UnicodeString);
    procedure Set_Exponent(Value: UnicodeString);
    { Methods & Properties }
    property Modulus: UnicodeString read Get_Modulus write Set_Modulus;
    property Exponent: UnicodeString read Get_Exponent write Set_Exponent;
  end;

{ ICancelaCFDRetrievalMethodType_signature }

  ICancelaCFDRetrievalMethodType_signature = interface(IXMLNode)
    ['{5AFE90F5-017C-4F7F-825D-B698D2D85442}']
    { Property Accessors }
    function Get_URI: UnicodeString;
    function Get_Type_: UnicodeString;
    function Get_Transforms: ICancelaCFDTransformsType_signature;
    procedure Set_URI(Value: UnicodeString);
    procedure Set_Type_(Value: UnicodeString);
    { Methods & Properties }
    property URI: UnicodeString read Get_URI write Set_URI;
    property Type_: UnicodeString read Get_Type_ write Set_Type_;
    property Transforms: ICancelaCFDTransformsType_signature read Get_Transforms;
  end;

{ ICancelaCFDRetrievalMethodType_signatureList }

  ICancelaCFDRetrievalMethodType_signatureList = interface(IXMLNodeCollection)
    ['{C3257E3A-A232-4C55-8CC2-4DEDF44D4251}']
    { Methods & Properties }
    function Add: ICancelaCFDRetrievalMethodType_signature;
    function Insert(const Index: Integer): ICancelaCFDRetrievalMethodType_signature;

    function Get_Item(Index: Integer): ICancelaCFDRetrievalMethodType_signature;
    property Items[Index: Integer]: ICancelaCFDRetrievalMethodType_signature read Get_Item; default;
  end;

{ ICancelaCFDX509DataType_signature }

  ICancelaCFDX509DataType_signature = interface(IXMLNode)
    ['{8F972AF7-C708-4431-9057-001ACD31A5D5}']
    { Property Accessors }
    function Get_X509IssuerSerial: ICancelaCFDX509IssuerSerialType_signatureList;
    function Get_X509SKI: ICancelaCFDBase64BinaryList;
    function Get_X509SubjectName: ICancelaCFDString_List;
    function Get_X509Certificate: ICancelaCFDBase64BinaryList;
    function Get_X509CRL: ICancelaCFDBase64BinaryList;
    { Methods & Properties }
    property X509IssuerSerial: ICancelaCFDX509IssuerSerialType_signatureList read Get_X509IssuerSerial;
    property X509SKI: ICancelaCFDBase64BinaryList read Get_X509SKI;
    property X509SubjectName: ICancelaCFDString_List read Get_X509SubjectName;
    property X509Certificate: ICancelaCFDBase64BinaryList read Get_X509Certificate;
    property X509CRL: ICancelaCFDBase64BinaryList read Get_X509CRL;
  end;

{ ICancelaCFDX509DataType_signatureList }

  ICancelaCFDX509DataType_signatureList = interface(IXMLNodeCollection)
    ['{CF52D7FC-4E41-415B-AE85-B20200475A43}']
    { Methods & Properties }
    function Add: ICancelaCFDX509DataType_signature;
    function Insert(const Index: Integer): ICancelaCFDX509DataType_signature;

    function Get_Item(Index: Integer): ICancelaCFDX509DataType_signature;
    property Items[Index: Integer]: ICancelaCFDX509DataType_signature read Get_Item; default;
  end;

{ ICancelaCFDX509IssuerSerialType_signature }

  ICancelaCFDX509IssuerSerialType_signature = interface(IXMLNode)
    ['{755A271F-7533-4038-8831-E5210CC40A3C}']
    { Property Accessors }
    function Get_X509IssuerName: UnicodeString;
    function Get_X509SerialNumber: String;
    procedure Set_X509IssuerName(Value: UnicodeString);
    procedure Set_X509SerialNumber(Value: String);
    { Methods & Properties }
    property X509IssuerName: UnicodeString read Get_X509IssuerName write Set_X509IssuerName;
    property X509SerialNumber: String read Get_X509SerialNumber write Set_X509SerialNumber;
  end;

{ ICancelaCFDX509IssuerSerialType_signatureList }

  ICancelaCFDX509IssuerSerialType_signatureList = interface(IXMLNodeCollection)
    ['{456F26A9-5E89-4ADD-A1E4-EAAE96A623FD}']
    { Methods & Properties }
    function Add: ICancelaCFDX509IssuerSerialType_signature;
    function Insert(const Index: Integer): ICancelaCFDX509IssuerSerialType_signature;

    function Get_Item(Index: Integer): ICancelaCFDX509IssuerSerialType_signature;
    property Items[Index: Integer]: ICancelaCFDX509IssuerSerialType_signature read Get_Item; default;
  end;

{ ICancelaCFDPGPDataType_signature }

  ICancelaCFDPGPDataType_signature = interface(IXMLNode)
    ['{3596C409-0816-4117-9476-802082999830}']
    { Property Accessors }
    function Get_PGPKeyID: UnicodeString;
    function Get_PGPKeyPacket: UnicodeString;
    procedure Set_PGPKeyID(Value: UnicodeString);
    procedure Set_PGPKeyPacket(Value: UnicodeString);
    { Methods & Properties }
    property PGPKeyID: UnicodeString read Get_PGPKeyID write Set_PGPKeyID;
    property PGPKeyPacket: UnicodeString read Get_PGPKeyPacket write Set_PGPKeyPacket;
  end;

{ ICancelaCFDPGPDataType_signatureList }

  ICancelaCFDPGPDataType_signatureList = interface(IXMLNodeCollection)
    ['{A693A2B7-B945-4DA2-8DD0-1AED6EB4B4A7}']
    { Methods & Properties }
    function Add: ICancelaCFDPGPDataType_signature;
    function Insert(const Index: Integer): ICancelaCFDPGPDataType_signature;

    function Get_Item(Index: Integer): ICancelaCFDPGPDataType_signature;
    property Items[Index: Integer]: ICancelaCFDPGPDataType_signature read Get_Item; default;
  end;

{ ICancelaCFDSPKIDataType_signature }

  ICancelaCFDSPKIDataType_signature = interface(IXMLNodeCollection)
    ['{0D7405A2-EE1F-4091-BEB3-D70A31F9F268}']
    { Property Accessors }
    function Get_SPKISexp(Index: Integer): UnicodeString;
    { Methods & Properties }
    function Add(const SPKISexp: UnicodeString): IXMLNode;
    function Insert(const Index: Integer; const SPKISexp: UnicodeString): IXMLNode;
    property SPKISexp[Index: Integer]: UnicodeString read Get_SPKISexp; default;
  end;

{ ICancelaCFDSPKIDataType_signatureList }

  ICancelaCFDSPKIDataType_signatureList = interface(IXMLNodeCollection)
    ['{23BAB739-BC46-4A44-AE32-4419A3DBA6EA}']
    { Methods & Properties }
    function Add: ICancelaCFDSPKIDataType_signature;
    function Insert(const Index: Integer): ICancelaCFDSPKIDataType_signature;

    function Get_Item(Index: Integer): ICancelaCFDSPKIDataType_signature;
    property Items[Index: Integer]: ICancelaCFDSPKIDataType_signature read Get_Item; default;
  end;

{ ICancelaCFDObjectType_signature }

  ICancelaCFDObjectType_signature = interface(IXMLNode)
    ['{C34B4E9A-5793-4CA6-82C3-691CD6397516}']
    { Property Accessors }
    function Get_Id: UnicodeString;
    function Get_MimeType: UnicodeString;
    function Get_Encoding: UnicodeString;
    procedure Set_Id(Value: UnicodeString);
    procedure Set_MimeType(Value: UnicodeString);
    procedure Set_Encoding(Value: UnicodeString);
    { Methods & Properties }
    property Id: UnicodeString read Get_Id write Set_Id;
    property MimeType: UnicodeString read Get_MimeType write Set_MimeType;
    property Encoding: UnicodeString read Get_Encoding write Set_Encoding;
  end;

{ ICancelaCFDObjectType_signatureList }

  ICancelaCFDObjectType_signatureList = interface(IXMLNodeCollection)
    ['{7D4BF271-F30B-4511-AFEB-EAC5734D8EB8}']
    { Methods & Properties }
    function Add: ICancelaCFDObjectType_signature;
    function Insert(const Index: Integer): ICancelaCFDObjectType_signature;

    function Get_Item(Index: Integer): ICancelaCFDObjectType_signature;
    property Items[Index: Integer]: ICancelaCFDObjectType_signature read Get_Item; default;
  end;

{ ICancelaCFDString_List }

  ICancelaCFDString_List = interface(IXMLNodeCollection)
    ['{81787333-67AC-4853-9BBD-05814B714388}']
    { Methods & Properties }
    function Add(const Value: UnicodeString): IXMLNode;
    function Insert(const Index: Integer; const Value: UnicodeString): IXMLNode;

    function Get_Item(Index: Integer): UnicodeString;
    property Items[Index: Integer]: UnicodeString read Get_Item; default;
  end;

{ ICancelaCFDBase64BinaryList }

  ICancelaCFDBase64BinaryList = interface(IXMLNodeCollection)
    ['{A2180F28-B966-4391-9363-702FBEFDE277}']
    { Methods & Properties }
    function Add(const Value: UnicodeString): IXMLNode;
    function Insert(const Index: Integer; const Value: UnicodeString): IXMLNode;

    function Get_Item(Index: Integer): UnicodeString;
    property Items[Index: Integer]: UnicodeString read Get_Item; default;
  end;

{ Forward Decls }

  TCancelaCFD = class;
  TCancelaCFD_Folios = class;
  TCancelaCFD_FoliosList = class;
  TCancelaCFD_Folios_Folio = class;
  TCancelaCFDSignatureType_signature = class;
  TCancelaCFDSignedInfoType_signature = class;
  TCancelaCFDCanonicalizationMethodType_signature = class;
  TCancelaCFDSignatureMethodType_signature = class;
  TCancelaCFDReferenceType_signature = class;
  TCancelaCFDReferenceType_signatureList = class;
  TCancelaCFDTransformsType_signature = class;
  TCancelaCFDTransformType_signature = class;
  TCancelaCFDDigestMethodType_signature = class;
  TCancelaCFDSignatureValueType_signature = class;
  TCancelaCFDKeyInfoType_signature = class;
  TCancelaCFDKeyValueType_signature = class;
  TCancelaCFDKeyValueType_signatureList = class;
  TCancelaCFDDSAKeyValueType_signature = class;
  TCancelaCFDRSAKeyValueType_signature = class;
  TCancelaCFDRetrievalMethodType_signature = class;
  TCancelaCFDRetrievalMethodType_signatureList = class;
  TCancelaCFDX509DataType_signature = class;
  TCancelaCFDX509DataType_signatureList = class;
  TCancelaCFDX509IssuerSerialType_signature = class;
  TCancelaCFDX509IssuerSerialType_signatureList = class;
  TCancelaCFDPGPDataType_signature = class;
  TCancelaCFDPGPDataType_signatureList = class;
  TCancelaCFDSPKIDataType_signature = class;
  TCancelaCFDSPKIDataType_signatureList = class;
  TCancelaCFDObjectType_signature = class;
  TCancelaCFDObjectType_signatureList = class;
  TCancelaCFDString_List = class;
  TCancelaCFDBase64BinaryList = class;

{ TCancelaCFD }

  TCancelaCFD = class(TXMLNode, ICancelaCFD)
  private
    FFolios: ICancelaCFD_FoliosList;
  protected
    { ICancelaCFD }
    function Get_RfcEmisor: UnicodeString;
    function Get_Fecha: UnicodeString;
    function Get_Folios: ICancelaCFD_FoliosList;
    function Get_Signature: ICancelaCFDSignatureType_signature;
    procedure Set_RfcEmisor(Value: UnicodeString);
    procedure Set_Fecha(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TCancelaCFD_Folios }

  TCancelaCFD_Folios = class(TXMLNode, ICancelaCFD_Folios)
  protected
    { ICancelaCFD_Folios }
    function Get_Folio: ICancelaCFD_Folios_Folio;
  public
    procedure AfterConstruction; override;
  end;

{ TCancelaCFD_FoliosList }

  TCancelaCFD_FoliosList = class(TXMLNodeCollection, ICancelaCFD_FoliosList)
  protected
    { ICancelaCFD_FoliosList }
    function Add: ICancelaCFD_Folios;
    function Insert(const Index: Integer): ICancelaCFD_Folios;

    function Get_Item(Index: Integer): ICancelaCFD_Folios;
  end;

{ TCancelaCFD_Folios_Folio }

  TCancelaCFD_Folios_Folio = class(TXMLNode, ICancelaCFD_Folios_Folio)
  protected
    { ICancelaCFD_Folios_Folio }
    function Get_UUID: UnicodeString;
    function Get_Motivo: UnicodeString;
    function Get_FolioSustitucion: UnicodeString;
    procedure Set_UUID(Value: UnicodeString);
    procedure Set_Motivo(Value: UnicodeString);
    procedure Set_FolioSustitucion(Value: UnicodeString);
  end;

{ TXMLSignatureType_signature }

  TCancelaCFDSignatureType_signature = class(TXMLNode, ICancelaCFDSignatureType_signature)
  private
    FObject_: ICancelaCFDObjectType_signatureList;
  protected
    { ICancelaCFDSignatureType_signature }
    function Get_Id: UnicodeString;
    function Get_SignedInfo: ICancelaCFDSignedInfoType_signature;
    function Get_SignatureValue: ICancelaCFDSignatureValueType_signature;
    function Get_KeyInfo: ICancelaCFDKeyInfoType_signature;
    function Get_Object_: ICancelaCFDObjectType_signatureList;
    procedure Set_Id(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSignedInfoType_signature }

  TCancelaCFDSignedInfoType_signature = class(TXMLNode, ICancelaCFDSignedInfoType_signature)
  private
    FReference: ICancelaCFDReferenceType_signatureList;
  protected
    { ICancelaCFDSignedInfoType_signature }
    function Get_Id: UnicodeString;
    function Get_CanonicalizationMethod: ICancelaCFDCanonicalizationMethodType_signature;
    function Get_SignatureMethod: ICancelaCFDSignatureMethodType_signature;
    function Get_Reference: ICancelaCFDReferenceType_signatureList;
    procedure Set_Id(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TCancelaCFDCanonicalizationMethodType_signature }

  TCancelaCFDCanonicalizationMethodType_signature = class(TXMLNode, ICancelaCFDCanonicalizationMethodType_signature)
  protected
    { ICancelaCFDCanonicalizationMethodType_signature }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
  end;

{ TCancelaCFDSignatureMethodType_signature }

  TCancelaCFDSignatureMethodType_signature = class(TXMLNode, ICancelaCFDSignatureMethodType_signature)
  protected
    { ICancelaCFDSignatureMethodType_signature }
    function Get_Algorithm: UnicodeString;
    function Get_HMACOutputLength: Integer;
    procedure Set_Algorithm(Value: UnicodeString);
    procedure Set_HMACOutputLength(Value: Integer);
  end;

{ TCancelaCFDReferenceType_signature }

  TCancelaCFDReferenceType_signature = class(TXMLNode, ICancelaCFDReferenceType_signature)
  protected
    { ICancelaCFDReferenceType_signature }
    function Get_Id: UnicodeString;
    function Get_URI: UnicodeString;
    function Get_Type_: UnicodeString;
    function Get_Transforms: ICancelaCFDTransformsType_signature;
    function Get_DigestMethod: ICancelaCFDDigestMethodType_signature;
    function Get_DigestValue: UnicodeString;
    procedure Set_Id(Value: UnicodeString);
    procedure Set_URI(Value: UnicodeString);
    procedure Set_Type_(Value: UnicodeString);
    procedure Set_DigestValue(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TCancelaCFDReferenceType_signatureList }

  TCancelaCFDReferenceType_signatureList = class(TXMLNodeCollection, ICancelaCFDReferenceType_signatureList)
  protected
    { ICancelaCFDReferenceType_signatureList }
    function Add: ICancelaCFDReferenceType_signature;
    function Insert(const Index: Integer): ICancelaCFDReferenceType_signature;

    function Get_Item(Index: Integer): ICancelaCFDReferenceType_signature;
  end;

{ TCancelaCFDTransformsType_signature }

  TCancelaCFDTransformsType_signature = class(TXMLNodeCollection, ICancelaCFDTransformsType_signature)
  protected
    { ICancelaCFDTransformsType_signature }
    function Get_Transform(Index: Integer): ICancelaCFDTransformType_signature;
    function Add: ICancelaCFDTransformType_signature;
    function Insert(const Index: Integer): ICancelaCFDTransformType_signature;
  public
    procedure AfterConstruction; override;
  end;

{ TCancelaCFDTransformType_signature }

  TCancelaCFDTransformType_signature = class(TXMLNodeCollection, ICancelaCFDTransformType_signature)
  protected
    { ICancelaCFDTransformType_signature }
    function Get_Algorithm: UnicodeString;
    function Get_XPath(Index: Integer): UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
    function Add(const XPath: UnicodeString): IXMLNode;
    function Insert(const Index: Integer; const XPath: UnicodeString): IXMLNode;
  public
    procedure AfterConstruction; override;
  end;

{ TCancelaCFDDigestMethodType_signature }

  TCancelaCFDDigestMethodType_signature = class(TXMLNode, ICancelaCFDDigestMethodType_signature)
  protected
    { ICancelaCFDDigestMethodType_signature }
    function Get_Algorithm: UnicodeString;
    procedure Set_Algorithm(Value: UnicodeString);
  end;

{ TCancelaCFDSignatureValueType_signature }

  TCancelaCFDSignatureValueType_signature = class(TXMLNode, ICancelaCFDSignatureValueType_signature)
  protected
    { ICancelaCFDSignatureValueType_signature }
    function Get_Id: UnicodeString;
    procedure Set_Id(Value: UnicodeString);
  end;

{ TCancelaCFDKeyInfoType_signature }

  TCancelaCFDKeyInfoType_signature = class(TXMLNode, ICancelaCFDKeyInfoType_signature)
  private
    FKeyName: ICancelaCFDString_List;
    FKeyValue: ICancelaCFDKeyValueType_signatureList;
    FRetrievalMethod: ICancelaCFDRetrievalMethodType_signatureList;
    FX509Data: ICancelaCFDX509DataType_signatureList;
    FPGPData: ICancelaCFDPGPDataType_signatureList;
    FSPKIData: ICancelaCFDSPKIDataType_signatureList;
    FMgmtData: ICancelaCFDString_List;
  protected
    { ICancelaCFDKeyInfoType_signature }
    function Get_Id: UnicodeString;
    function Get_KeyName: ICancelaCFDString_List;
    function Get_KeyValue: ICancelaCFDKeyValueType_signatureList;
    function Get_RetrievalMethod: ICancelaCFDRetrievalMethodType_signatureList;
    function Get_X509Data: ICancelaCFDX509DataType_signatureList;
    function Get_PGPData: ICancelaCFDPGPDataType_signatureList;
    function Get_SPKIData: ICancelaCFDSPKIDataType_signatureList;
    function Get_MgmtData: ICancelaCFDString_List;
    procedure Set_Id(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TCancelaCFDKeyValueType_signature }

  TCancelaCFDKeyValueType_signature = class(TXMLNode, ICancelaCFDKeyValueType_signature)
  protected
    { ICancelaCFDKeyValueType_signature }
    function Get_DSAKeyValue: ICancelaCFDDSAKeyValueType_signature;
    function Get_RSAKeyValue: ICancelaCFDRSAKeyValueType_signature;
  public
    procedure AfterConstruction; override;
  end;

{ TCancelaCFDKeyValueType_signatureList }

  TCancelaCFDKeyValueType_signatureList = class(TXMLNodeCollection, ICancelaCFDKeyValueType_signatureList)
  protected
    { ICancelaCFDKeyValueType_signatureList }
    function Add: ICancelaCFDKeyValueType_signature;
    function Insert(const Index: Integer): ICancelaCFDKeyValueType_signature;

    function Get_Item(Index: Integer): ICancelaCFDKeyValueType_signature;
  end;

{ TCancelaCFDDSAKeyValueType_signature }

  TCancelaCFDDSAKeyValueType_signature = class(TXMLNode, ICancelaCFDDSAKeyValueType_signature)
  protected
    { ICancelaCFDDSAKeyValueType_signature }
    function Get_P: UnicodeString;
    function Get_Q: UnicodeString;
    function Get_G: UnicodeString;
    function Get_Y: UnicodeString;
    function Get_J: UnicodeString;
    function Get_Seed: UnicodeString;
    function Get_PgenCounter: UnicodeString;
    procedure Set_P(Value: UnicodeString);
    procedure Set_Q(Value: UnicodeString);
    procedure Set_G(Value: UnicodeString);
    procedure Set_Y(Value: UnicodeString);
    procedure Set_J(Value: UnicodeString);
    procedure Set_Seed(Value: UnicodeString);
    procedure Set_PgenCounter(Value: UnicodeString);
  end;

{ TCancelaCFDRSAKeyValueType_signature }

  TCancelaCFDRSAKeyValueType_signature = class(TXMLNode, ICancelaCFDRSAKeyValueType_signature)
  protected
    { ICancelaCFDRSAKeyValueType_signature }
    function Get_Modulus: UnicodeString;
    function Get_Exponent: UnicodeString;
    procedure Set_Modulus(Value: UnicodeString);
    procedure Set_Exponent(Value: UnicodeString);
  end;

{ TCancelaCFDRetrievalMethodType_signature }

  TCancelaCFDRetrievalMethodType_signature = class(TXMLNode, ICancelaCFDRetrievalMethodType_signature)
  protected
    { ICancelaCFDRetrievalMethodType_signature }
    function Get_URI: UnicodeString;
    function Get_Type_: UnicodeString;
    function Get_Transforms: ICancelaCFDTransformsType_signature;
    procedure Set_URI(Value: UnicodeString);
    procedure Set_Type_(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TCancelaCFDRetrievalMethodType_signatureList }

  TCancelaCFDRetrievalMethodType_signatureList = class(TXMLNodeCollection, ICancelaCFDRetrievalMethodType_signatureList)
  protected
    { ICancelaCFDRetrievalMethodType_signatureList }
    function Add: ICancelaCFDRetrievalMethodType_signature;
    function Insert(const Index: Integer): ICancelaCFDRetrievalMethodType_signature;

    function Get_Item(Index: Integer): ICancelaCFDRetrievalMethodType_signature;
  end;

{ TCancelaCFDX509DataType_signature }

  TCancelaCFDX509DataType_signature = class(TXMLNode, ICancelaCFDX509DataType_signature)
  private
    FX509IssuerSerial: ICancelaCFDX509IssuerSerialType_signatureList;
    FX509SKI: ICancelaCFDBase64BinaryList;
    FX509SubjectName: ICancelaCFDString_List;
    FX509Certificate: ICancelaCFDBase64BinaryList;
    FX509CRL: ICancelaCFDBase64BinaryList;
  protected
    { ICancelaCFDX509DataType_signature }
    function Get_X509IssuerSerial: ICancelaCFDX509IssuerSerialType_signatureList;
    function Get_X509SKI: ICancelaCFDBase64BinaryList;
    function Get_X509SubjectName: ICancelaCFDString_List;
    function Get_X509Certificate: ICancelaCFDBase64BinaryList;
    function Get_X509CRL: ICancelaCFDBase64BinaryList;
  public
    procedure AfterConstruction; override;
  end;

{ TCancelaCFDX509DataType_signatureList }

  TCancelaCFDX509DataType_signatureList = class(TXMLNodeCollection, ICancelaCFDX509DataType_signatureList)
  protected
    { ICancelaCFDX509DataType_signatureList }
    function Add: ICancelaCFDX509DataType_signature;
    function Insert(const Index: Integer): ICancelaCFDX509DataType_signature;

    function Get_Item(Index: Integer): ICancelaCFDX509DataType_signature;
  end;

{ TCancelaCFDX509IssuerSerialType_signature }

  TCancelaCFDX509IssuerSerialType_signature = class(TXMLNode, ICancelaCFDX509IssuerSerialType_signature)
  protected
    { ICancelaCFDX509IssuerSerialType_signature }
    function Get_X509IssuerName: UnicodeString;
    function Get_X509SerialNumber: String;
    procedure Set_X509IssuerName(Value: UnicodeString);
    procedure Set_X509SerialNumber(Value: String);
  end;

{ TCancelaCFDX509IssuerSerialType_signatureList }

  TCancelaCFDX509IssuerSerialType_signatureList = class(TXMLNodeCollection, ICancelaCFDX509IssuerSerialType_signatureList)
  protected
    { ICancelaCFDX509IssuerSerialType_signatureList }
    function Add: ICancelaCFDX509IssuerSerialType_signature;
    function Insert(const Index: Integer): ICancelaCFDX509IssuerSerialType_signature;

    function Get_Item(Index: Integer): ICancelaCFDX509IssuerSerialType_signature;
  end;

{ TCancelaCFDPGPDataType_signature }

  TCancelaCFDPGPDataType_signature = class(TXMLNode, ICancelaCFDPGPDataType_signature)
  protected
    { ICancelaCFDPGPDataType_signature }
    function Get_PGPKeyID: UnicodeString;
    function Get_PGPKeyPacket: UnicodeString;
    procedure Set_PGPKeyID(Value: UnicodeString);
    procedure Set_PGPKeyPacket(Value: UnicodeString);
  end;

{ TCancelaCFDPGPDataType_signatureList }

  TCancelaCFDPGPDataType_signatureList = class(TXMLNodeCollection, ICancelaCFDPGPDataType_signatureList)
  protected
    { ICancelaCFDPGPDataType_signatureList }
    function Add: ICancelaCFDPGPDataType_signature;
    function Insert(const Index: Integer): ICancelaCFDPGPDataType_signature;

    function Get_Item(Index: Integer): ICancelaCFDPGPDataType_signature;
  end;

{ TCancelaCFDSPKIDataType_signature }

  TCancelaCFDSPKIDataType_signature = class(TXMLNodeCollection, ICancelaCFDSPKIDataType_signature)
  protected
    { ICancelaCFDSPKIDataType_signature }
    function Get_SPKISexp(Index: Integer): UnicodeString;
    function Add(const SPKISexp: UnicodeString): IXMLNode;
    function Insert(const Index: Integer; const SPKISexp: UnicodeString): IXMLNode;
  public
    procedure AfterConstruction; override;
  end;

{ TCancelaCFDSPKIDataType_signatureList }

  TCancelaCFDSPKIDataType_signatureList = class(TXMLNodeCollection, ICancelaCFDSPKIDataType_signatureList)
  protected
    { ICancelaCFDSPKIDataType_signatureList }
    function Add: ICancelaCFDSPKIDataType_signature;
    function Insert(const Index: Integer): ICancelaCFDSPKIDataType_signature;

    function Get_Item(Index: Integer): ICancelaCFDSPKIDataType_signature;
  end;

{ TCancelaCFDObjectType_signature }

  TCancelaCFDObjectType_signature = class(TXMLNode, ICancelaCFDObjectType_signature)
  protected
    { ICancelaCFDObjectType_signature }
    function Get_Id: UnicodeString;
    function Get_MimeType: UnicodeString;
    function Get_Encoding: UnicodeString;
    procedure Set_Id(Value: UnicodeString);
    procedure Set_MimeType(Value: UnicodeString);
    procedure Set_Encoding(Value: UnicodeString);
  end;

{ TCancelaCFDObjectType_signatureList }

  TCancelaCFDObjectType_signatureList = class(TXMLNodeCollection, ICancelaCFDObjectType_signatureList)
  protected
    { ICancelaCFDObjectType_signatureList }
    function Add: ICancelaCFDObjectType_signature;
    function Insert(const Index: Integer): ICancelaCFDObjectType_signature;

    function Get_Item(Index: Integer): ICancelaCFDObjectType_signature;
  end;

{ TCancelaCFDString_List }

  TCancelaCFDString_List = class(TXMLNodeCollection, ICancelaCFDString_List)
  protected
    { ICancelaCFDString_List }
    function Add(const Value: UnicodeString): IXMLNode;
    function Insert(const Index: Integer; const Value: UnicodeString): IXMLNode;

    function Get_Item(Index: Integer): UnicodeString;
  end;

{ TCancelaCFDBase64BinaryList }

  TCancelaCFDBase64BinaryList = class(TXMLNodeCollection, ICancelaCFDBase64BinaryList)
  protected
    { ICancelaCFDBase64BinaryList }
    function Add(const Value: UnicodeString): IXMLNode;
    function Insert(const Index: Integer; const Value: UnicodeString): IXMLNode;

    function Get_Item(Index: Integer): UnicodeString;
  end;

{ Global Functions }

function GetCancelaCFD(Doc: IXMLDocument): ICancelaCFD;
function LoadCancelaCFD(const FileName: string): ICancelaCFD;
function NewCancelaCFD: ICancelaCFD;

const
  TargetNamespace = 'http://cancelacfd.sat.gob.mx';

implementation

uses Xml.xmlutil,
     SysUtils;

const
  _NODO_XSI = 'xmlns:xsi';
  _NODO_XSD = 'xmlns:xsd';

{ Global Functions }

function GetCancelaCFD(Doc: IXMLDocument): ICancelaCFD;
begin
  Result := Doc.GetDocBinding('Cancelacion', TCancelaCFD, TargetNamespace) as ICancelaCFD;
end;

function LoadCancelaCFD(const FileName: string): ICancelaCFD;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Cancelacion', TCancelaCFD, TargetNamespace) as ICancelaCFD;
end;

function NewCancelaCFD: ICancelaCFD;
begin
  Result := NewXMLDocument.GetDocBinding('Cancelacion', TCancelaCFD, TargetNamespace) as ICancelaCFD;

  if (Result.AttributeNodes.FindNode(_NODO_XSD) = nil) then
      Result.SetAttribute(_NODO_XSD,
                          'http://www.w3.org/2001/XMLSchema');

  if (Result.AttributeNodes.FindNode(_NODO_XSI) = nil) then
      Result.SetAttribute(_NODO_XSI,
                          'http://www.w3.org/2001/XMLSchema-instance');

  Result.OwnerDocument.Options := Result.OwnerDocument.Options - [doNodeAutoIndent];
  Result.OwnerDocument.ParseOptions := Result.OwnerDocument.ParseOptions - [poPreserveWhiteSpace];
end;

{ TCancelaCFD }

procedure TCancelaCFD.AfterConstruction;
begin
  RegisterChildNode('Folios', TCancelaCFD_Folios);
  RegisterChildNode('Signature', TCancelaCFDSignatureType_signature);
  FFolios := CreateCollection(TCancelaCFD_FoliosList, ICancelaCFD_Folios, 'Folios') as ICancelaCFD_FoliosList;
  inherited;
end;

function TCancelaCFD.Get_RfcEmisor: UnicodeString;
begin
  Result := AttributeNodes['RfcEmisor'].Text;
end;

procedure TCancelaCFD.Set_RfcEmisor(Value: UnicodeString);
begin
  SetAttribute('RfcEmisor', Value);
end;

function TCancelaCFD.Get_Fecha: UnicodeString;
begin
  Result := AttributeNodes['Fecha'].Text;
end;

procedure TCancelaCFD.Set_Fecha(Value: UnicodeString);
begin
  SetAttribute('Fecha', Value);
end;

function TCancelaCFD.Get_Folios: ICancelaCFD_FoliosList;
begin
  Result := FFolios;
end;

function TCancelaCFD.Get_Signature: ICancelaCFDSignatureType_signature;
var
  nodo: IXMLNode;
  signatureNode: ICancelaCFDSignatureType_signature;
begin
  nodo := ChildNodes['Signature'];
  if Supports(nodo, ICancelaCFDSignatureType_signature, signatureNode) then
  begin
    Result := signatureNode;
    //Result.SetAttribute('xmlns', 'http://www.w3.org/2000/09/xmldsig#');
  end;

  //Result := ChildNodes.FindNode('Signature', 'http://www.w3.org/2000/09/xmldsig#') as ICancelaCFDSignatureType_signature;
  //Result := ChildNodes['Signature'] as ICancelaCFDSignatureType_signature;
end;

{ TCancelaCFD_Folios }

procedure TCancelaCFD_Folios.AfterConstruction;
begin
  RegisterChildNode('Folio', TCancelaCFD_Folios_Folio);
  inherited;
end;

function TCancelaCFD_Folios.Get_Folio: ICancelaCFD_Folios_Folio;
begin
  Result := ChildNodes['Folio'] as ICancelaCFD_Folios_Folio;
end;

{ TCancelaCFD_FoliosList }

function TCancelaCFD_FoliosList.Add: ICancelaCFD_Folios;
begin
  Result := AddItem(-1) as ICancelaCFD_Folios;
end;

function TCancelaCFD_FoliosList.Insert(const Index: Integer): ICancelaCFD_Folios;
begin
  Result := AddItem(Index) as ICancelaCFD_Folios;
end;

function TCancelaCFD_FoliosList.Get_Item(Index: Integer): ICancelaCFD_Folios;
begin
  Result := List[Index] as ICancelaCFD_Folios;
end;

{ TCancelaCFD_Folios_Folio }

function TCancelaCFD_Folios_Folio.Get_UUID: UnicodeString;
begin
  Result := AttributeNodes['UUID'].Text;
end;

procedure TCancelaCFD_Folios_Folio.Set_UUID(Value: UnicodeString);
begin
  SetAttribute('UUID', Value);
end;

function TCancelaCFD_Folios_Folio.Get_Motivo: UnicodeString;
begin
  Result := AttributeNodes['Motivo'].Text;
end;

procedure TCancelaCFD_Folios_Folio.Set_Motivo(Value: UnicodeString);
begin
  SetAttribute('Motivo', Value);
end;

function TCancelaCFD_Folios_Folio.Get_FolioSustitucion: UnicodeString;
begin
  Result := AttributeNodes['FolioSustitucion'].Text;
end;

procedure TCancelaCFD_Folios_Folio.Set_FolioSustitucion(Value: UnicodeString);
begin
  SetAttribute('FolioSustitucion', Value);
end;

{ TCancelaCFDSignatureType_signature }

procedure TCancelaCFDSignatureType_signature.AfterConstruction;
begin
  RegisterChildNode('SignedInfo', TCancelaCFDSignedInfoType_signature);
  RegisterChildNode('SignatureValue', TCancelaCFDSignatureValueType_signature);
  RegisterChildNode('KeyInfo', TCancelaCFDKeyInfoType_signature);
  RegisterChildNode('Object', TCancelaCFDObjectType_signature);
  FObject_ := CreateCollection(TCancelaCFDObjectType_signatureList, ICancelaCFDObjectType_signature, 'Object') as ICancelaCFDObjectType_signatureList;
  inherited;
end;

function TCancelaCFDSignatureType_signature.Get_Id: UnicodeString;
begin
  Result := AttributeNodes['Id'].Text;
end;

procedure TCancelaCFDSignatureType_signature.Set_Id(Value: UnicodeString);
begin
  SetAttribute('Id', Value);
end;

function TCancelaCFDSignatureType_signature.Get_SignedInfo: ICancelaCFDSignedInfoType_signature;
begin
  Result := ChildNodes['SignedInfo'] as ICancelaCFDSignedInfoType_signature;


end;

function TCancelaCFDSignatureType_signature.Get_SignatureValue: ICancelaCFDSignatureValueType_signature;
begin
  Result := ChildNodes['SignatureValue'] as ICancelaCFDSignatureValueType_signature;
end;

function TCancelaCFDSignatureType_signature.Get_KeyInfo: ICancelaCFDKeyInfoType_signature;
begin
  Result := ChildNodes['KeyInfo'] as ICancelaCFDKeyInfoType_signature;
end;

function TCancelaCFDSignatureType_signature.Get_Object_: ICancelaCFDObjectType_signatureList;
begin
  Result := FObject_;
end;

{ TCancelaCFDSignedInfoType_signature }

procedure TCancelaCFDSignedInfoType_signature.AfterConstruction;
begin
  RegisterChildNode('CanonicalizationMethod', TCancelaCFDCanonicalizationMethodType_signature);
  RegisterChildNode('SignatureMethod', TCancelaCFDSignatureMethodType_signature);
  RegisterChildNode('Reference', TCancelaCFDReferenceType_signature);
  FReference := CreateCollection(TCancelaCFDReferenceType_signatureList, ICancelaCFDReferenceType_signature, 'Reference') as ICancelaCFDReferenceType_signatureList;
  inherited;
end;

function TCancelaCFDSignedInfoType_signature.Get_Id: UnicodeString;
begin
  Result := AttributeNodes['Id'].Text;
end;

procedure TCancelaCFDSignedInfoType_signature.Set_Id(Value: UnicodeString);
begin
  SetAttribute('Id', Value);
end;

function TCancelaCFDSignedInfoType_signature.Get_CanonicalizationMethod: ICancelaCFDCanonicalizationMethodType_signature;
begin
  Result := ChildNodes['CanonicalizationMethod'] as ICancelaCFDCanonicalizationMethodType_signature;
end;

function TCancelaCFDSignedInfoType_signature.Get_SignatureMethod: ICancelaCFDSignatureMethodType_signature;
begin
  Result := ChildNodes['SignatureMethod'] as ICancelaCFDSignatureMethodType_signature;
end;

function TCancelaCFDSignedInfoType_signature.Get_Reference: ICancelaCFDReferenceType_signatureList;
begin
  Result := FReference;
end;

{ TCancelaCFDCanonicalizationMethodType_signature }

function TCancelaCFDCanonicalizationMethodType_signature.Get_Algorithm: UnicodeString;
begin
  Result := AttributeNodes['Algorithm'].Text;
end;

procedure TCancelaCFDCanonicalizationMethodType_signature.Set_Algorithm(Value: UnicodeString);
begin
  SetAttribute('Algorithm', Value);
end;

{ TCancelaCFDSignatureMethodType_signature }

function TCancelaCFDSignatureMethodType_signature.Get_Algorithm: UnicodeString;
begin
  Result := AttributeNodes['Algorithm'].Text;
end;

procedure TCancelaCFDSignatureMethodType_signature.Set_Algorithm(Value: UnicodeString);
begin
  SetAttribute('Algorithm', Value);
end;

function TCancelaCFDSignatureMethodType_signature.Get_HMACOutputLength: Integer;
begin
  Result := ChildNodes['HMACOutputLength'].NodeValue;
end;

procedure TCancelaCFDSignatureMethodType_signature.Set_HMACOutputLength(Value: Integer);
begin
  ChildNodes['HMACOutputLength'].NodeValue := Value;
end;

{ TCancelaCFDReferenceType_signature }

procedure TCancelaCFDReferenceType_signature.AfterConstruction;
begin
  RegisterChildNode('Transforms', TCancelaCFDTransformsType_signature);
  RegisterChildNode('DigestMethod', TCancelaCFDDigestMethodType_signature);
  inherited;
end;

function TCancelaCFDReferenceType_signature.Get_Id: UnicodeString;
begin
  Result := AttributeNodes['Id'].Text;
end;

procedure TCancelaCFDReferenceType_signature.Set_Id(Value: UnicodeString);
begin
  SetAttribute('Id', Value);
end;

function TCancelaCFDReferenceType_signature.Get_URI: UnicodeString;
begin
  Result := AttributeNodes['URI'].Text;
end;

procedure TCancelaCFDReferenceType_signature.Set_URI(Value: UnicodeString);
begin
  SetAttribute('URI', Value);
end;

function TCancelaCFDReferenceType_signature.Get_Type_: UnicodeString;
begin
  Result := AttributeNodes['Type'].Text;
end;

procedure TCancelaCFDReferenceType_signature.Set_Type_(Value: UnicodeString);
begin
  SetAttribute('Type', Value);
end;

function TCancelaCFDReferenceType_signature.Get_Transforms: ICancelaCFDTransformsType_signature;
begin
  Result := ChildNodes['Transforms'] as ICancelaCFDTransformsType_signature;
end;

function TCancelaCFDReferenceType_signature.Get_DigestMethod: ICancelaCFDDigestMethodType_signature;
begin
  Result := ChildNodes['DigestMethod'] as ICancelaCFDDigestMethodType_signature;
end;

function TCancelaCFDReferenceType_signature.Get_DigestValue: UnicodeString;
begin
  Result := ChildNodes['DigestValue'].Text;
end;

procedure TCancelaCFDReferenceType_signature.Set_DigestValue(Value: UnicodeString);
begin
  ChildNodes['DigestValue'].NodeValue := Value;
end;

{ TCancelaCFDReferenceType_signatureList }

function TCancelaCFDReferenceType_signatureList.Add: ICancelaCFDReferenceType_signature;
begin
  Result := AddItem(-1) as ICancelaCFDReferenceType_signature;
end;

function TCancelaCFDReferenceType_signatureList.Insert(const Index: Integer): ICancelaCFDReferenceType_signature;
begin
  Result := AddItem(Index) as ICancelaCFDReferenceType_signature;
end;

function TCancelaCFDReferenceType_signatureList.Get_Item(Index: Integer): ICancelaCFDReferenceType_signature;
begin
  Result := List[Index] as ICancelaCFDReferenceType_signature;
end;

{ TCancelaCFDTransformsType_signature }

procedure TCancelaCFDTransformsType_signature.AfterConstruction;
begin
  RegisterChildNode('Transform', TCancelaCFDTransformType_signature);
  ItemTag := 'Transform';
  ItemInterface := ICancelaCFDTransformType_signature;
  inherited;
end;

function TCancelaCFDTransformsType_signature.Get_Transform(Index: Integer): ICancelaCFDTransformType_signature;
begin
  Result := List[Index] as ICancelaCFDTransformType_signature;
end;

function TCancelaCFDTransformsType_signature.Add: ICancelaCFDTransformType_signature;
begin
  Result := AddItem(-1) as ICancelaCFDTransformType_signature;
end;

function TCancelaCFDTransformsType_signature.Insert(const Index: Integer): ICancelaCFDTransformType_signature;
begin
  Result := AddItem(Index) as ICancelaCFDTransformType_signature;
end;

{ TCancelaCFDTransformType_signature }

procedure TCancelaCFDTransformType_signature.AfterConstruction;
begin
  ItemTag := 'XPath';
  ItemInterface := IXMLNode;
  inherited;
end;

function TCancelaCFDTransformType_signature.Get_Algorithm: UnicodeString;
begin
  Result := AttributeNodes['Algorithm'].Text;
end;

procedure TCancelaCFDTransformType_signature.Set_Algorithm(Value: UnicodeString);
begin
  SetAttribute('Algorithm', Value);
end;

function TCancelaCFDTransformType_signature.Get_XPath(Index: Integer): UnicodeString;
begin
  Result := List[Index].Text;
end;

function TCancelaCFDTransformType_signature.Add(const XPath: UnicodeString): IXMLNode;
begin
  Result := AddItem(-1);
  Result.NodeValue := XPath;
end;

function TCancelaCFDTransformType_signature.Insert(const Index: Integer; const XPath: UnicodeString): IXMLNode;
begin
  Result := AddItem(Index);
  Result.NodeValue := XPath;
end;

{ TCancelaCFDDigestMethodType_signature }

function TCancelaCFDDigestMethodType_signature.Get_Algorithm: UnicodeString;
begin
  Result := AttributeNodes['Algorithm'].Text;
end;

procedure TCancelaCFDDigestMethodType_signature.Set_Algorithm(Value: UnicodeString);
begin
  SetAttribute('Algorithm', Value);
end;

{ TCancelaCFDSignatureValueType_signature }

function TCancelaCFDSignatureValueType_signature.Get_Id: UnicodeString;
begin
  Result := AttributeNodes['Id'].Text;
end;

procedure TCancelaCFDSignatureValueType_signature.Set_Id(Value: UnicodeString);
begin
  SetAttribute('Id', Value);
end;

{ TCancelaCFDKeyInfoType_signature }

procedure TCancelaCFDKeyInfoType_signature.AfterConstruction;
begin
  RegisterChildNode('KeyValue', TCancelaCFDKeyValueType_signature);
  RegisterChildNode('RetrievalMethod', TCancelaCFDRetrievalMethodType_signature);
  RegisterChildNode('X509Data', TCancelaCFDX509DataType_signature);
  RegisterChildNode('PGPData', TCancelaCFDPGPDataType_signature);
  RegisterChildNode('SPKIData', TCancelaCFDSPKIDataType_signature);
  FKeyName := CreateCollection(TCancelaCFDString_List, IXMLNode, 'KeyName') as ICancelaCFDString_List;
  FKeyValue := CreateCollection(TCancelaCFDKeyValueType_signatureList, ICancelaCFDKeyValueType_signature, 'KeyValue') as ICancelaCFDKeyValueType_signatureList;
  FRetrievalMethod := CreateCollection(TCancelaCFDRetrievalMethodType_signatureList, ICancelaCFDRetrievalMethodType_signature, 'RetrievalMethod') as ICancelaCFDRetrievalMethodType_signatureList;
  FX509Data := CreateCollection(TCancelaCFDX509DataType_signatureList, ICancelaCFDX509DataType_signature, 'X509Data') as ICancelaCFDX509DataType_signatureList;
  FPGPData := CreateCollection(TCancelaCFDPGPDataType_signatureList, ICancelaCFDPGPDataType_signature, 'PGPData') as ICancelaCFDPGPDataType_signatureList;
  FSPKIData := CreateCollection(TCancelaCFDSPKIDataType_signatureList, ICancelaCFDSPKIDataType_signature, 'SPKIData') as ICancelaCFDSPKIDataType_signatureList;
  FMgmtData := CreateCollection(TCancelaCFDString_List, IXMLNode, 'MgmtData') as ICancelaCFDString_List;
  inherited;
end;

function TCancelaCFDKeyInfoType_signature.Get_Id: UnicodeString;
begin
  Result := AttributeNodes['Id'].Text;
end;

procedure TCancelaCFDKeyInfoType_signature.Set_Id(Value: UnicodeString);
begin
  SetAttribute('Id', Value);
end;

function TCancelaCFDKeyInfoType_signature.Get_KeyName: ICancelaCFDString_List;
begin
  Result := FKeyName;
end;

function TCancelaCFDKeyInfoType_signature.Get_KeyValue: ICancelaCFDKeyValueType_signatureList;
begin
  Result := FKeyValue;
end;

function TCancelaCFDKeyInfoType_signature.Get_RetrievalMethod: ICancelaCFDRetrievalMethodType_signatureList;
begin
  Result := FRetrievalMethod;
end;

function TCancelaCFDKeyInfoType_signature.Get_X509Data: ICancelaCFDX509DataType_signatureList;
begin
  Result := FX509Data;
end;

function TCancelaCFDKeyInfoType_signature.Get_PGPData: ICancelaCFDPGPDataType_signatureList;
begin
  Result := FPGPData;
end;

function TCancelaCFDKeyInfoType_signature.Get_SPKIData: ICancelaCFDSPKIDataType_signatureList;
begin
  Result := FSPKIData;
end;

function TCancelaCFDKeyInfoType_signature.Get_MgmtData: ICancelaCFDString_List;
begin
  Result := FMgmtData;
end;

{ TCancelaCFDKeyValueType_signature }

procedure TCancelaCFDKeyValueType_signature.AfterConstruction;
begin
  RegisterChildNode('DSAKeyValue', TCancelaCFDDSAKeyValueType_signature);
  RegisterChildNode('RSAKeyValue', TCancelaCFDRSAKeyValueType_signature);
  inherited;
end;

function TCancelaCFDKeyValueType_signature.Get_DSAKeyValue: ICancelaCFDDSAKeyValueType_signature;
begin
  Result := ChildNodes['DSAKeyValue'] as ICancelaCFDDSAKeyValueType_signature;
end;

function TCancelaCFDKeyValueType_signature.Get_RSAKeyValue: ICancelaCFDRSAKeyValueType_signature;
begin
  Result := ChildNodes['RSAKeyValue'] as ICancelaCFDRSAKeyValueType_signature;
end;

{ TCancelaCFDKeyValueType_signatureList }

function TCancelaCFDKeyValueType_signatureList.Add: ICancelaCFDKeyValueType_signature;
begin
  Result := AddItem(-1) as ICancelaCFDKeyValueType_signature;
end;

function TCancelaCFDKeyValueType_signatureList.Insert(const Index: Integer): ICancelaCFDKeyValueType_signature;
begin
  Result := AddItem(Index) as ICancelaCFDKeyValueType_signature;
end;

function TCancelaCFDKeyValueType_signatureList.Get_Item(Index: Integer): ICancelaCFDKeyValueType_signature;
begin
  Result := List[Index] as ICancelaCFDKeyValueType_signature;
end;

{ TCancelaCFDDSAKeyValueType_signature }

function TCancelaCFDDSAKeyValueType_signature.Get_P: UnicodeString;
begin
  Result := ChildNodes[WideString('P')].Text;
end;

procedure TCancelaCFDDSAKeyValueType_signature.Set_P(Value: UnicodeString);
begin
  ChildNodes[WideString('P')].NodeValue := Value;
end;

function TCancelaCFDDSAKeyValueType_signature.Get_Q: UnicodeString;
begin
  Result := ChildNodes[WideString('Q')].Text;
end;

procedure TCancelaCFDDSAKeyValueType_signature.Set_Q(Value: UnicodeString);
begin
  ChildNodes[WideString('Q')].NodeValue := Value;
end;

function TCancelaCFDDSAKeyValueType_signature.Get_G: UnicodeString;
begin
  Result := ChildNodes[WideString('G')].Text;
end;

procedure TCancelaCFDDSAKeyValueType_signature.Set_G(Value: UnicodeString);
begin
  ChildNodes[WideString('G')].NodeValue := Value;
end;

function TCancelaCFDDSAKeyValueType_signature.Get_Y: UnicodeString;
begin
  Result := ChildNodes[WideString('Y')].Text;
end;

procedure TCancelaCFDDSAKeyValueType_signature.Set_Y(Value: UnicodeString);
begin
  ChildNodes[WideString('Y')].NodeValue := Value;
end;

function TCancelaCFDDSAKeyValueType_signature.Get_J: UnicodeString;
begin
  Result := ChildNodes[WideString('J')].Text;
end;

procedure TCancelaCFDDSAKeyValueType_signature.Set_J(Value: UnicodeString);
begin
  ChildNodes[WideString('J')].NodeValue := Value;
end;

function TCancelaCFDDSAKeyValueType_signature.Get_Seed: UnicodeString;
begin
  Result := ChildNodes['Seed'].Text;
end;

procedure TCancelaCFDDSAKeyValueType_signature.Set_Seed(Value: UnicodeString);
begin
  ChildNodes['Seed'].NodeValue := Value;
end;

function TCancelaCFDDSAKeyValueType_signature.Get_PgenCounter: UnicodeString;
begin
  Result := ChildNodes['PgenCounter'].Text;
end;

procedure TCancelaCFDDSAKeyValueType_signature.Set_PgenCounter(Value: UnicodeString);
begin
  ChildNodes['PgenCounter'].NodeValue := Value;
end;

{ TCancelaCFDRSAKeyValueType_signature }

function TCancelaCFDRSAKeyValueType_signature.Get_Modulus: UnicodeString;
begin
  Result := ChildNodes['Modulus'].Text;
end;

procedure TCancelaCFDRSAKeyValueType_signature.Set_Modulus(Value: UnicodeString);
begin
  ChildNodes['Modulus'].NodeValue := Value;
end;

function TCancelaCFDRSAKeyValueType_signature.Get_Exponent: UnicodeString;
begin
  Result := ChildNodes['Exponent'].Text;
end;

procedure TCancelaCFDRSAKeyValueType_signature.Set_Exponent(Value: UnicodeString);
begin
  ChildNodes['Exponent'].NodeValue := Value;
end;

{ TCancelaCFDRetrievalMethodType_signature }

procedure TCancelaCFDRetrievalMethodType_signature.AfterConstruction;
begin
  RegisterChildNode('Transforms', TCancelaCFDTransformsType_signature);
  inherited;
end;

function TCancelaCFDRetrievalMethodType_signature.Get_URI: UnicodeString;
begin
  Result := AttributeNodes['URI'].Text;
end;

procedure TCancelaCFDRetrievalMethodType_signature.Set_URI(Value: UnicodeString);
begin
  SetAttribute('URI', Value);
end;

function TCancelaCFDRetrievalMethodType_signature.Get_Type_: UnicodeString;
begin
  Result := AttributeNodes['Type'].Text;
end;

procedure TCancelaCFDRetrievalMethodType_signature.Set_Type_(Value: UnicodeString);
begin
  SetAttribute('Type', Value);
end;

function TCancelaCFDRetrievalMethodType_signature.Get_Transforms: ICancelaCFDTransformsType_signature;
begin
  Result := ChildNodes['Transforms'] as ICancelaCFDTransformsType_signature;
end;

{ TCancelaCFDRetrievalMethodType_signatureList }

function TCancelaCFDRetrievalMethodType_signatureList.Add: ICancelaCFDRetrievalMethodType_signature;
begin
  Result := AddItem(-1) as ICancelaCFDRetrievalMethodType_signature;
end;

function TCancelaCFDRetrievalMethodType_signatureList.Insert(const Index: Integer): ICancelaCFDRetrievalMethodType_signature;
begin
  Result := AddItem(Index) as ICancelaCFDRetrievalMethodType_signature;
end;

function TCancelaCFDRetrievalMethodType_signatureList.Get_Item(Index: Integer): ICancelaCFDRetrievalMethodType_signature;
begin
  Result := List[Index] as ICancelaCFDRetrievalMethodType_signature;
end;

{ TCancelaCFDX509DataType_signature }

procedure TCancelaCFDX509DataType_signature.AfterConstruction;
begin
  RegisterChildNode('X509IssuerSerial', TCancelaCFDX509IssuerSerialType_signature);
  FX509IssuerSerial := CreateCollection(TCancelaCFDX509IssuerSerialType_signatureList, ICancelaCFDX509IssuerSerialType_signature, 'X509IssuerSerial') as ICancelaCFDX509IssuerSerialType_signatureList;
  FX509SKI := CreateCollection(TCancelaCFDBase64BinaryList, IXMLNode, 'X509SKI') as ICancelaCFDBase64BinaryList;
  FX509SubjectName := CreateCollection(TCancelaCFDString_List, IXMLNode, 'X509SubjectName') as ICancelaCFDString_List;
  FX509Certificate := CreateCollection(TCancelaCFDBase64BinaryList, IXMLNode, 'X509Certificate') as ICancelaCFDBase64BinaryList;
  FX509CRL := CreateCollection(TCancelaCFDBase64BinaryList, IXMLNode, 'X509CRL') as ICancelaCFDBase64BinaryList;
  inherited;
end;

function TCancelaCFDX509DataType_signature.Get_X509IssuerSerial: ICancelaCFDX509IssuerSerialType_signatureList;
begin
  Result := FX509IssuerSerial;
end;

function TCancelaCFDX509DataType_signature.Get_X509SKI: ICancelaCFDBase64BinaryList;
begin
  Result := FX509SKI;
end;

function TCancelaCFDX509DataType_signature.Get_X509SubjectName: ICancelaCFDString_List;
begin
  Result := FX509SubjectName;
end;

function TCancelaCFDX509DataType_signature.Get_X509Certificate: ICancelaCFDBase64BinaryList;
begin
  Result := FX509Certificate;
end;

function TCancelaCFDX509DataType_signature.Get_X509CRL: ICancelaCFDBase64BinaryList;
begin
  Result := FX509CRL;
end;

{ TCancelaCFDX509DataType_signatureList }

function TCancelaCFDX509DataType_signatureList.Add: ICancelaCFDX509DataType_signature;
begin
  Result := AddItem(-1) as ICancelaCFDX509DataType_signature;
end;

function TCancelaCFDX509DataType_signatureList.Insert(const Index: Integer): ICancelaCFDX509DataType_signature;
begin
  Result := AddItem(Index) as ICancelaCFDX509DataType_signature;
end;

function TCancelaCFDX509DataType_signatureList.Get_Item(Index: Integer): ICancelaCFDX509DataType_signature;
begin
  Result := List[Index] as ICancelaCFDX509DataType_signature;
end;

{ TCancelaCFDX509IssuerSerialType_signature }

function TCancelaCFDX509IssuerSerialType_signature.Get_X509IssuerName: UnicodeString;
begin
  Result := ChildNodes['X509IssuerName'].Text;
end;

procedure TCancelaCFDX509IssuerSerialType_signature.Set_X509IssuerName(Value: UnicodeString);
begin
  ChildNodes['X509IssuerName'].NodeValue := Value;
end;

function TCancelaCFDX509IssuerSerialType_signature.Get_X509SerialNumber: String;
begin
  Result := ChildNodes['X509SerialNumber'].NodeValue;
end;

procedure TCancelaCFDX509IssuerSerialType_signature.Set_X509SerialNumber(Value: String);
begin
  ChildNodes['X509SerialNumber'].NodeValue := Value;
end;

{ TCancelaCFDX509IssuerSerialType_signatureList }

function TCancelaCFDX509IssuerSerialType_signatureList.Add: ICancelaCFDX509IssuerSerialType_signature;
begin
  Result := AddItem(-1) as ICancelaCFDX509IssuerSerialType_signature;
end;

function TCancelaCFDX509IssuerSerialType_signatureList.Insert(const Index: Integer): ICancelaCFDX509IssuerSerialType_signature;
begin
  Result := AddItem(Index) as ICancelaCFDX509IssuerSerialType_signature;
end;

function TCancelaCFDX509IssuerSerialType_signatureList.Get_Item(Index: Integer): ICancelaCFDX509IssuerSerialType_signature;
begin
  Result := List[Index] as ICancelaCFDX509IssuerSerialType_signature;
end;

{ TCancelaCFDPGPDataType_signature }

function TCancelaCFDPGPDataType_signature.Get_PGPKeyID: UnicodeString;
begin
  Result := ChildNodes['PGPKeyID'].Text;
end;

procedure TCancelaCFDPGPDataType_signature.Set_PGPKeyID(Value: UnicodeString);
begin
  ChildNodes['PGPKeyID'].NodeValue := Value;
end;

function TCancelaCFDPGPDataType_signature.Get_PGPKeyPacket: UnicodeString;
begin
  Result := ChildNodes['PGPKeyPacket'].Text;
end;

procedure TCancelaCFDPGPDataType_signature.Set_PGPKeyPacket(Value: UnicodeString);
begin
  ChildNodes['PGPKeyPacket'].NodeValue := Value;
end;

{ TCancelaCFDPGPDataType_signatureList }

function TCancelaCFDPGPDataType_signatureList.Add: ICancelaCFDPGPDataType_signature;
begin
  Result := AddItem(-1) as ICancelaCFDPGPDataType_signature;
end;

function TCancelaCFDPGPDataType_signatureList.Insert(const Index: Integer): ICancelaCFDPGPDataType_signature;
begin
  Result := AddItem(Index) as ICancelaCFDPGPDataType_signature;
end;

function TCancelaCFDPGPDataType_signatureList.Get_Item(Index: Integer): ICancelaCFDPGPDataType_signature;
begin
  Result := List[Index] as ICancelaCFDPGPDataType_signature;
end;

{ TCancelaCFDSPKIDataType_signature }

procedure TCancelaCFDSPKIDataType_signature.AfterConstruction;
begin
  ItemTag := 'SPKISexp';
  ItemInterface := IXMLNode;
  inherited;
end;

function TCancelaCFDSPKIDataType_signature.Get_SPKISexp(Index: Integer): UnicodeString;
begin
  Result := List[Index].Text;
end;

function TCancelaCFDSPKIDataType_signature.Add(const SPKISexp: UnicodeString): IXMLNode;
begin
  Result := AddItem(-1);
  Result.NodeValue := SPKISexp;
end;

function TCancelaCFDSPKIDataType_signature.Insert(const Index: Integer; const SPKISexp: UnicodeString): IXMLNode;
begin
  Result := AddItem(Index);
  Result.NodeValue := SPKISexp;
end;

{ TCancelaCFDSPKIDataType_signatureList }

function TCancelaCFDSPKIDataType_signatureList.Add: ICancelaCFDSPKIDataType_signature;
begin
  Result := AddItem(-1) as ICancelaCFDSPKIDataType_signature;
end;

function TCancelaCFDSPKIDataType_signatureList.Insert(const Index: Integer): ICancelaCFDSPKIDataType_signature;
begin
  Result := AddItem(Index) as ICancelaCFDSPKIDataType_signature;
end;

function TCancelaCFDSPKIDataType_signatureList.Get_Item(Index: Integer): ICancelaCFDSPKIDataType_signature;
begin
  Result := List[Index] as ICancelaCFDSPKIDataType_signature;
end;

{ TCancelaCFDObjectType_signature }

function TCancelaCFDObjectType_signature.Get_Id: UnicodeString;
begin
  Result := AttributeNodes['Id'].Text;
end;

procedure TCancelaCFDObjectType_signature.Set_Id(Value: UnicodeString);
begin
  SetAttribute('Id', Value);
end;

function TCancelaCFDObjectType_signature.Get_MimeType: UnicodeString;
begin
  Result := AttributeNodes['MimeType'].Text;
end;

procedure TCancelaCFDObjectType_signature.Set_MimeType(Value: UnicodeString);
begin
  SetAttribute('MimeType', Value);
end;

function TCancelaCFDObjectType_signature.Get_Encoding: UnicodeString;
begin
  Result := AttributeNodes['Encoding'].Text;
end;

procedure TCancelaCFDObjectType_signature.Set_Encoding(Value: UnicodeString);
begin
  SetAttribute('Encoding', Value);
end;

{ TCancelaCFDObjectType_signatureList }

function TCancelaCFDObjectType_signatureList.Add: ICancelaCFDObjectType_signature;
begin
  Result := AddItem(-1) as ICancelaCFDObjectType_signature;
end;

function TCancelaCFDObjectType_signatureList.Insert(const Index: Integer): ICancelaCFDObjectType_signature;
begin
  Result := AddItem(Index) as ICancelaCFDObjectType_signature;
end;

function TCancelaCFDObjectType_signatureList.Get_Item(Index: Integer): ICancelaCFDObjectType_signature;
begin
  Result := List[Index] as ICancelaCFDObjectType_signature;
end;

{ TCancelaCFDString_List }

function TCancelaCFDString_List.Add(const Value: UnicodeString): IXMLNode;
begin
  Result := AddItem(-1);
  Result.NodeValue := Value;
end;

function TCancelaCFDString_List.Insert(const Index: Integer; const Value: UnicodeString): IXMLNode;
begin
  Result := AddItem(Index);
  Result.NodeValue := Value;
end;

function TCancelaCFDString_List.Get_Item(Index: Integer): UnicodeString;
begin
  Result := List[Index].NodeValue;
end;

{ TCancelaCFDBase64BinaryList }

function TCancelaCFDBase64BinaryList.Add(const Value: UnicodeString): IXMLNode;
begin
  Result := AddItem(-1);
  Result.NodeValue := Value;
end;

function TCancelaCFDBase64BinaryList.Insert(const Index: Integer; const Value: UnicodeString): IXMLNode;
begin
  Result := AddItem(Index);
  Result.NodeValue := Value;
end;

function TCancelaCFDBase64BinaryList.Get_Item(Index: Integer): UnicodeString;
begin
  Result := List[Index].NodeValue;
end;

end.