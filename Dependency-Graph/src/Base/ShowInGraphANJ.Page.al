/// <summary>
/// Page "ShowInGraph_ANJ" (ID 80802).
/// </summary>
page 80802 ShowInGraph_ANJ
{
    ApplicationArea = All;
    Caption = 'Show In Graph', comment = 'ESP="Mostrar en gráfico"';
    PageType = Document;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            part(Extensions_ANJ; Extensions_ANJ)
            {
            }
            part(Relations_ANJ; Relations_ANJ)
            {
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(GenTables)
            {
                ApplicationArea = All;
                Caption = 'Generate Tables', comment = 'ESP="Generar tablas"';
                Image = Table;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Executes the Generate Tables action.', Comment = 'ESP="Ejecuta la acción Generar tablas"';

                trigger OnAction()
                begin
                    GenerateTables.Generate(false);
                end;
            }
        }
    }

    var
        GenerateTables: Codeunit GenerateTables_ANJ;
}