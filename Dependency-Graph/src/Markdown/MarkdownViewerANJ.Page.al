/// <summary>
/// Page "MarkdownViewer_ANJ" (ID 80804).
/// </summary>
page 80804 MarkdownViewer_ANJ
{
    ApplicationArea = All;
    Caption = 'Markdown Viewer', comment = 'ESP="Markdown Viewer"';
    PageType = Card;
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

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.MarkdownViewer_ANJ.Draw(MarkdownMgmt.GetMarkdown());
    end;

    /// <summary>
    /// Draw.
    /// </summary>
    /// <param name="Markdown">Text.</param>
    procedure Draw(Markdown: Text)
    begin
        CurrPage.MarkdownViewer_ANJ.Draw(Markdown);
    end;

    var
        MarkdownMgmt: Codeunit MarkdownMgmt_ANJ;
}