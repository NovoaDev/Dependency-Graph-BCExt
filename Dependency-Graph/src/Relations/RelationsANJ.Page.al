/// <summary>
/// Page Relations_ANJ (ID 80803).
/// </summary>
namespace ANJ.Tools.Graph;
page 80803 Relations_ANJ
{
    ApplicationArea = All;
    Caption = 'Relations';
    DeleteAllowed = false;
    Extensible = true;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = Relations_ANJ;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(SourceAppName; Rec.SourceAppName)
                {
                }
                field(LinkText; Rec.LinkText)
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field(DestinationAppName; Rec.DestinationAppName)
                {
                }
                field(ShowInGraph; Rec.ShowInGraph)
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
            }
        }
    }
}