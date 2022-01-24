page 50109 MyPage
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = 50135;
    Caption = 'myPage';

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(no; rec.no)
                {
                    ApplicationArea = All;

                }
                field(name; rec.name)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    tlvText.Run();
                end;
            }
        }
    }

    var
        myInt: Integer;
        tlvText: Codeunit TLVConverter;
}