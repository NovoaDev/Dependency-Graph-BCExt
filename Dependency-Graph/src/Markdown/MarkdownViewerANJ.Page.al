/// <summary>
/// Page "MarkdownViewer_ANJ" (ID 80804).
/// </summary>
namespace ANJ.Tools.Graph;
page 80804 MarkdownViewer_ANJ
{
    ApplicationArea = All;
    Caption = 'Markdown Viewer';
    Extensible = false;
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
                Caption = 'Display dependency graph';
                Image = View;
                ToolTip = 'Executes the Display dependency graph action.';

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
    /// SetMarkdown.
    /// </summary>
    /// <param name="AuxMarkdown">Text.</param>
    internal procedure SetMarkdown(AuxMarkdown: Text)
    begin
        Markdown := AuxMarkdown;
    end;

    var
        Markdown: Text;
}