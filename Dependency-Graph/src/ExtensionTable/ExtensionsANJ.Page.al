/// <summary>
/// Page Extensions_ANJ (ID 80801).
/// </summary>
page 80801 Extensions_ANJ
{
    ApplicationArea = All;
    Caption = 'Extensions';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = Extensions_ANJ;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(DisplayName; Rec.DisplayName)
                {
                    ToolTip = 'Specifies the value of the Display Name field.';

                    trigger OnValidate()
                    begin
                        DoGenerateRelationsTable();
                    end;
                }
                field(Publisher; Rec.Publisher)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Publisher field.';
                }
                field(PublishedAs; Rec.PublishedAs)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Published As field.';
                }
                field(ShowInGraph; Rec.ShowInGraph)
                {
                    ToolTip = 'Specifies the value of the ShowInGraph field.';

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