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
            action(GenerateMarkdown)
            {
                ApplicationArea = All;
                Caption = 'Display dependency graph', comment = 'ESP="Visualizar gráfico de dependencia"';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Executes the Display dependency graph action.', Comment = 'ESP="Ejecuta la acción Visualizar gráfico de dependencia"';

                trigger OnAction()
                begin
                    MarkdownMgmt.GenerateGraph(false);
                    Page.Run(Page::MarkdownViewer_ANJ);
                end;
            }
            action(DownloadMarkdown)
            {
                ApplicationArea = All;
                Caption = 'Download Markdown as .md', comment = 'ESP="Descargar Markdown como un .md"';
                Image = Download;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Executes the Download Markdown as .md action.', Comment = 'ESP="Ejecuta la acción Descargar Markdown como un .md"';

                trigger OnAction()
                begin
                    MarkdownMgmt.GenerateGraph(true);
                    MarkdownMgmt.DownloadMarkdown();
                end;
            }
        }
    }

    var
        GenerateTables: Codeunit GenerateTables_ANJ;
        MarkdownMgmt: Codeunit MarkdownMgmt_ANJ;
}