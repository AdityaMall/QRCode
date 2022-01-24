table 50135 codeUniteTest
{
    DataClassification = ToBeClassified;
    Caption = 'codeUniteTest';

    fields
    {
        field(1; no; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
        }
        field(2; name; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
        }
    }

    var
        myInt: Integer;


    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}