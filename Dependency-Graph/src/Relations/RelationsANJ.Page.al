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
                    ToolTip = 'Specifies the value of the Source App Name field.';
                }
                field(LinkText; Rec.LinkText)
                {
                    ToolTip = 'Specifies the value of the Link Text field.';

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field(DestinationAppName; Rec.DestinationAppName)
                {
                    ToolTip = 'Specifies the value of the Destination App Name field.';
                }
                field(ShowInGraph; Rec.ShowInGraph)
                {
                    ToolTip = 'Specifies the value of the Show In Graph field.';

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
            }
        }
    }
}