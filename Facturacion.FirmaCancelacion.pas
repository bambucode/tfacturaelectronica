unit Facturacion.FirmaCancelacion;

interface

uses Facturacion.Comprobante,
     Facturacion.OpenSSL;

type

  IFirmaCancelacion = Interface
    ['{B04A4C97-7A97-4F14-A5B1-BAE471250B05}']
    procedure Configurar(const aRutaCertificado, aRutaLlavePrivada, aContresenaLlavePrivada: String);
    function GenerarFirmaCancelacion(const aRFC: String;
                                                   const aFecha: String;
                                                   const aUUID: String;
                                                   const aMotivo: String;
                                                   const aUUIDSustituto: String) : TCadenaUTF8;

  end;


  TFirmaCancelacion = class(TInterfacedObject, IFirmaCancelacion)
  private
    fOpenSSL: IOpenSSL;
    fArchivoCertificado: String;
    function ObtenerDigest(const aXMLCanonizado: TCadenaUTF8) : String;
    function HexStringToBase64(const aHexStr: string): string;
    function ObtenerSignatureValue(const aDigest: String): TCadenaUTF8;
    function String2Hex(const Buffer: AnsiString): string;
    function HexToDecimal(const Hex: string): string;
    function ConvertirSerialCertificado(const aNumeroCertificado: String): String;
  public
    procedure Configurar(const aRutaCertificado, aRutaLlavePrivada, aContresenaLlavePrivada: String);
    function GenerarFirmaCancelacion(const aRFC: String;
                                     const aFecha: String;
                                     const aUUID: String;
                                     const aMotivo: String;
                                     const aUUIDSustituto: String) : TCadenaUTF8;
  end;

implementation

uses Facturacion.CancelaCFD,
     Facturacion.CertificadoDeSellos,
     System.Classes,
     NetEncoding,
     SysUtils;

{ TFirmaCancelacion }

procedure TFirmaCancelacion.Configurar(const aRutaCertificado,
  aRutaLlavePrivada, aContresenaLlavePrivada: String);
begin
  fOpenSSL := TOpenSSL.Create;

  fOpenSSL.AsignarLlavePrivada(aRutaLlavePrivada,
                              aContresenaLlavePrivada);

  fArchivoCertificado := aRutaCertificado;
end;

// Ref: https://stackoverflow.com/questions/28562382/java-vs-delphi-base64-encoding?rq=1
function TFirmaCancelacion.HexStringToBase64(const aHexStr: string): string;
var
  md5bytes: TBytes;
begin
  SetLength(md5Bytes, Length(aHexStr) div 2);
  HexToBin(PChar(aHexStr), Pointer(md5Bytes), Length(md5Bytes));
  // ToDO: Verificar compatibilidad con otras ediciones de Delphi
  Result := TNetEncoding.Base64.EncodeBytesToString(md5Bytes);
end;

// Credito:
// https://stackoverflow.com/questions/47947794/delphi-tokyo-function-string-to-hex-and-hex-to-string
function TFirmaCancelacion.String2Hex(const Buffer: AnsiString): string;
begin
  SetLength(Result, Length(Buffer) * 2);
  BinToHex(PAnsiChar(Buffer), PChar(Result), Length(Buffer));
end;

// Credito:
// https://stackoverflow.com/questions/16965915/convert-a-big-hex-number-string-format-to-a-decimal-number-string-format-w
function TFirmaCancelacion.HexToDecimal(const Hex: string): string;
var
  dec: TList;
  I: Integer;
  carry: Cardinal;
  c: Char;
  val: Integer;
begin
  Result := '';
  dec := TList.Create;
  try
    dec.Add(Pointer(0));          // decimal result

    for c in Hex do begin
      carry := StrToInt('$' + c); // initially holds decimal value of current hex digit;
                                  // subsequently holds carry-over for multiplication
      for I := 0 to dec.Count -1 do begin
        val := Integer(dec[I]) * 16 + carry;
        dec[I] := Pointer(Integer(val mod 10));
        carry := val div 10;
      end;

      while carry > 0 do begin
        dec.Add(Pointer(Integer(carry mod 10)));
        carry := carry div 10;
      end;
    end;

    for I := 0 to dec.Count -1 do begin
      val := Integer(dec[I]);
      Result := IntToStr(val) + Result;
    end;
  finally
    dec.Free;
  end;
end;

function TFirmaCancelacion.ConvertirSerialCertificado(const aNumeroCertificado: String): String;
var
  certificadoHex : String;
begin
  certificadoHex := String2Hex(aNumeroCertificado);
  // Ahora convertimos el Hex a Decimal
  Result := HexToDecimal(certificadoHex);
end;

function TFirmaCancelacion.ObtenerDigest(const aXMLCanonizado: TCadenaUTF8): String;
var
  sha1str: String;
begin
  Assert(fOpenSSL <> nil, 'La instancia fOpenSSL no debio ser nula');

  // Primero calculamos el SHA1 del XML canonizado
  sha1str := Lowercase(fOpenSSL.CalcularSHA1(aXMLCanonizado));
  // Convertimos la digestion a Hex como Base64
  Result := HexStringToBase64(sha1str);
end;

function TFirmaCancelacion.ObtenerSignatureValue(
  const aDigest: String): TCadenaUTF8;
var
  signatureXML: String;
begin
  Assert(fOpenSSL <> nil, 'La instancia fOpenSSL no debio ser nula');
  // ToDO: Pudieramos intentar generar esta firma usando las clases de Delphi / XSD Data binding
  // si queremos evitar las constantes
  signatureXML := '<SignedInfo xmlns="http://www.w3.org/2000/09/xmldsig#" xmlns:xsd="http://www.w3.org/2001/XMLSchema"'+
                  ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315">'+
                  '</CanonicalizationMethod><SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"></SignatureMethod><Reference URI="">'+
                  '<Transforms><Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"></Transform></Transforms>'+
                  '<DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"></DigestMethod><DigestValue>'+
                  aDigest +
                  '</DigestValue></Reference></SignedInfo>';

  // Mandamos firmar este XML con SHA-1
  Result := fOpenSSL.HacerDigestion(signatureXML, tdSHA1);
end;

function TFirmaCancelacion.GenerarFirmaCancelacion(const aRFC: String;
                                                   const aFecha: String;
                                                   const aUUID: String;
                                                   const aMotivo: String;
                                                   const aUUIDSustituto: String) : TCadenaUTF8;
var
  cancelaCFD: ICancelaCFD;
  folioCancelacion: ICancelaCFD_Folios;
  xmlCanonalizado: TCadenaUTF8;
  digest, signatureValue: String;
  reference: ICancelaCFDReferenceType_signature;
  transforms: ICancelaCFDTransformType_signature;
  x509data: ICancelaCFDX509DataType_signature;
  x509serial: ICancelaCFDX509IssuerSerialType_signature;
  certificado : ICertificadoDeSellos;
begin
  // Para la generacion de la Firma para cancelacion nos basamos en la guia de
  // https://www.cryptosys.net/pki/satcancelcfd.html

  // Generamos el XML de cancelacion
  cancelaCFD := NewCancelaCFD;

  // NOTA: El orden de llenado es importante
  cancelaCFD.Fecha := aFecha;
  cancelaCFD.RfcEmisor := aRFC;
  folioCancelacion := cancelaCFD.Folios.Add;

  if (aUUIDSustituto <> '') then
    folioCancelacion.Folio.FolioSustitucion := aUUIDSustituto;

  folioCancelacion.Folio.Motivo := aMotivo;
  folioCancelacion.Folio.UUID := aUUID;

  // ToDO Pendiente: Canonalizamos el XML de acuerdo al algoritmo C14N
  // http://www.w3.org/TR/xml-c14n

  // HACK temporal para simular C14N:
  xmlCanonalizado := cancelaCFD.XML;
  xmlCanonalizado := StringReplace(xmlCanonalizado, '/>', '></Folio>', [rfReplaceAll]);

  // 2. Generamos el Digest del XML de cancelacion basico
  digest := ObtenerDigest(xmlCanonalizado);

  // 3. Obtenermos el SignatureValue del XML
  signatureValue := ObtenerSignatureValue(digest);

  // 4. Generamos el XML final
  cancelaCFD.Signature.SignedInfo.CanonicalizationMethod.Algorithm := 'http://www.w3.org/TR/2001/REC-xml-c14n-20010315';
  cancelaCFD.Signature.SignedInfo.SignatureMethod.Algorithm := 'http://www.w3.org/2000/09/xmldsig#rsa-sha1';
  reference := cancelaCFD.Signature.SignedInfo.Reference.Add;
  reference.URI := '';
  transforms := reference.Transforms.Add;
  //transform := transforms.Add;
  transforms.Algorithm := 'http://www.w3.org/2000/09/xmldsig#enveloped-signature';
  reference.DigestMethod.Algorithm := 'http://www.w3.org/2000/09/xmldsig#sha1';
  reference.DigestValue := digest;
  cancelaCFD.Signature.SignatureValue.Text := signatureValue;

  //5.Llenamos los datos del certificado
  certificado := TCertificadoDeSellos.Create;
  certificado.Leer(fArchivoCertificado);

  x509data := cancelaCFD.Signature.KeyInfo.X509Data.Add;
  x509serial := x509data.X509IssuerSerial.Add;
  x509serial.X509IssuerName := certificado.EmitidorPor;
  x509serial.X509SerialNumber := ConvertirSerialCertificado(certificado.NoCertificado);
  x509data.X509Certificate.Add(certificado.ContenidoBase64);

  Result := cancelaCFD.XML;

  // HACK: Cambiamos el XMLNS del nodo Signature
  Result := StringReplace(Result, '<Signature>',
                                  '<Signature xmlns="http://www.w3.org/2000/09/xmldsig#" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">',
                                  [rfReplaceAll]);
end;



end.
