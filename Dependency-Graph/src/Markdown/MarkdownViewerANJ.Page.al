/// <summary>
/// Page "MarkdownViewer_ANJ" (ID 80804).
/// </summary>
page 80804 MarkdownViewer_ANJ
{
    ApplicationArea = All;
    Caption = 'Markdown Viewer', comment = 'ESP="Markdown Viewer"';
    PageType = CardPart;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            usercontrol(MarkdownViewer_ANJ; MarkdownViewer_ANJ)
            {
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(GenerateMarkdown)
            {
                ApplicationArea = All;
                Caption = 'Display dependency graph', comment = 'ESP="Visualizar gráfico de dependencia"';
                Image = View;
                ToolTip = 'Executes the Display dependency graph action.', Comment = 'ESP="Ejecuta la acción Visualizar gráfico de dependencia"';

                trigger OnAction()
                begin
                    Page.Run(Page::MarkdownViewerFull_ANJ);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.MarkdownViewer_ANJ.Draw(Markdown);
    end;
    /// <summary>
    /// Draw.
    /// </summary>
    /// <param name="AuxMarkdown">Text.</param>
    internal procedure SetMarkdown(AuxMarkdown: Text)
    begin
        Markdown := AuxMarkdown;
    end;

    var
        Markdown: Text;
}