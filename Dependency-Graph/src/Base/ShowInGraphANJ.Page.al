/// <summary>
/// Page "ShowInGraph_ANJ" (ID 80802).
/// </summary>
page 80802 ShowInGraph_ANJ
{
    ApplicationArea = All;
    Caption = 'Show In Dependency Graph', comment = 'ESP="Mostrar en gráfico de dependencia"';
    PageType = Document;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            part(Extensions_ANJ; Extensions_ANJ)
            {
                UpdatePropagation = Both;
            }
            part(Relations_ANJ; Relations_ANJ)
            {
                UpdatePropagation = Both;
            }
        }
        area(FactBoxes)
        {
            part(MarkdownFactbox_ANJ; MarkdownFactbox_ANJ)
            {
            }
            part(MarkdownViewer_ANJ; MarkdownViewer_ANJ)
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
                Caption = 'Generate data', comment = 'ESP="Generar datos"';
                Image = NewSparkle;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Executes the Generate data action.', Comment = 'ESP="Ejecuta la acción Generar datos"';

                trigger OnAction()
                begin
                    GenerateTables.Generate(false);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        DependencyGraphSetup: Record DependencyGraphSetup_ANJ;
    begin
        MarkdownMgmt.GenerateGraph();
        CurrPage.MarkdownFactbox_ANJ.Page.SetMarkdownText(MarkdownMgmt.GetMarkdown(DependencyGraphSetup.FieldNo(Markdown)));
        CurrPage.MarkdownViewer_ANJ.Page.SetMarkdown(MarkdownMgmt.GetMarkdown(DependencyGraphSetup.FieldNo(MarkdownMermaid)));
    end;

    var
        GenerateTables: Codeunit GenerateTables_ANJ;
        MarkdownMgmt: Codeunit MarkdownMgmt_ANJ;
}