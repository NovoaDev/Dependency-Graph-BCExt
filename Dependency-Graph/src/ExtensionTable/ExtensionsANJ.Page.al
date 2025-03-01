/// <summary>
/// Page Extensions_ANJ (ID 80801).
/// </summary>
namespace ANJ.Tools.Graph;
page 80801 Extensions_ANJ
{
    ApplicationArea = All;
    Caption = 'Extensions';
    DeleteAllowed = false;
    Extensible = true;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = Extensions_ANJ;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    Editable = false;
                }
                field(DisplayName; Rec.DisplayName)
                {
                    trigger OnValidate()
                    begin
                        DoGenerateRelationsTable();
                    end;
                }
                field(Publisher; Rec.Publisher)
                {
                    Editable = false;
                }
                field(PublishedAs; Rec.PublishedAs)
                {
                    Editable = false;
                }
                field(ShowInGraph; Rec.ShowInGraph)
                {

                    trigger OnValidate()
                    begin
                        DoGenerateRelationsTable();
                    end;
                }
            }
        }
    }

    /// <summary>
    /// DoGenerateRelationsTable.
    /// </summary>
    local procedure DoGenerateRelationsTable()
    begin
        CurrPage.SaveRecord();
        Rec.UpdateRelationTable();
        CurrPage.Update(false);
    end;
}