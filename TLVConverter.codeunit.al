
codeunit 50123 TLVConverter
{

    trigger OnRun();
    var
        SellerNameBuf: Text;
        vatRegNumBuf: text;
        TimeStampBuf: text;
        InvoiceTotalBuf: text;
        VAtTotal: text;
        SellerOutputBuf: text;
        base64Convert: Codeunit "Base64 Convert";
        base64output: Text;
        hexToString: Text;
        cust: Record Customer;


    begin
        SellerNameBuf := gotTLVforValue(1, 'شركة كلية بيت البترجي للعلومالطبية والتكنولوجيا');
        vatRegNumBuf := gotTLVforValue(2, '300103995200003');
        TimeStampBuf := gotTLVforValue(3, '2021-11-24T12:27:48Z');
        InvoiceTotalBuf := gotTLVforValue(4, '21000.00');
        VAtTotal := gotTLVforValue(5, '3150.00');


        SellerOutputBuf := SellerNameBuf + vatRegNumBuf + TimeStampBuf + InvoiceTotalBuf + VAtTotal;
        Message(SellerOutputBuf);

        base64output := base64Convert.ToBase64(SellerOutputBuf);
        Message(base64output);
    end;


    procedure gotTLVforValue(tagName: Integer; tagValue: Text[500]) "TLV Output": Text[500]
    var
        tagBuffer1: Text;
        tagBuffer2: text;
        Tagbuffer: text;
        HexTagValue: Text;
        valuebuff: Text;
        TagLengthStringBuf: Text;
        language: Codeunit Language;


    begin
        tagBuffer1 := IntToHex(tagName);
        tagBuffer2 := IntToHex(StrLen(tagValue));

        Tagbuffer := tagBuffer1 + tagBuffer2;

        HexTagValue := TagValueTohex(tagValue);

        TagLengthStringBuf := hexToASCII(tagBuffer);
        valuebuff := hexToASCII(HexTagValue);
        Message(tagValue + '  tagValue= %1', HexTagValue);


        "TLV Output" := TagLengthStringBuf + valuebuff;

    end;

    procedure ConvertBase16(theInput: text[512]) theOutput: text[1024]
    var
        aIndex: Integer;
        aInt: Integer;
        aLeft: Integer;
        aRight: Integer;

    begin

        FOR aIndex := 1 TO STRLEN(theInput) DO BEGIN


            aInt := theInput[aIndex];

            aLeft := ROUND(aInt / 16, 1, '<');

            aRight := aInt MOD 16;

            theOutput += HexValue(aLeft) + HexValue(aRight);

        END;
    end;

    procedure HexValue(theValue: Integer): Text[1]
    begin
        CASE theValue OF
            0 .. 9:
                EXIT(FORMAT(theValue));
            10:
                EXIT('A');
            11:
                EXIT('B');
            12:
                EXIT('C');
            13:
                EXIT('D');
            14:
                EXIT('E');
            15:
                EXIT('F');
        END;

    end;

    procedure IntToHex(Value: integer) ReturnValue: text;
    var

        aLeft: Integer;
        aRight: Integer;
    begin

        aLeft := ROUND(Value / 16, 1, '<');
        aRight := Value MOD 16;
        ReturnValue += HexValue(aLeft) + HexValue(aRight);
    end;

    procedure HexToInt(hexStr: Text): Integer
    var
        len, base, decVal, i, j : Integer;
        char: Codeunit Encoding;
        ch: Text;
        ascii: Text;
    begin
        base := 1;
        decVal := 0;
        len := STRLEN(hexStr);

        FOR i := 0 TO len - 1 DO BEGIN
            j := len - i;
            IF (hexStr[j] >= '0') AND (hexStr[j] <= '9') THEN BEGIN
                decVal += (hexStr[j] - 48) * base;
                base := base * 16;
            END ELSE
                IF (hexStr[j] >= 'A') AND (hexStr[j] <= 'F') THEN BEGIN
                    decVal += (hexStr[j] - 55) * base;
                    base := base * 16;
                END;
        END;
        EXIT(decVal);
    end;


    procedure hexToASCII(hex: Text): Text
    var
        ascii: Text;
        i: Integer;
        part: Text;
        intString: Integer;
        ch: text;
        c: Char;

    begin

        FOR i := 1 TO STRLEN(hex) - 1 DO BEGIN
            part := COPYSTR(hex, i, 2);

            intString := HexToInt(part);
            c := intString;
            evaluate(ch, Format(c, 0, '<CHAR>'));
            ascii := ascii + ch;
            i := i + 1;
        END;
        EXIT(ascii);

    end;

    procedure TagValueTohex(value: text): text
    var
        i: Integer;
        aint: Integer;
        ch: Text;
        HexTagValue: Text;
        typehelper: Codeunit 10;

    begin
        FOR i := 1 TO STRLEN(Value) DO BEGIN
            aInt := value[i];
            ch := typehelper.IntToHex(aint);
            HexTagValue := HexTagValue + ch;
            i := i;
        END;
        EXIT(HexTagValue);
    end;


}
