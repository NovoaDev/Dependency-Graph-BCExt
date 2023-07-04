/// <summary>
/// Page "MarkdownViewerFull_ANJ" (ID 80804).
/// </summary>
page 80806 MarkdownViewerFull_ANJ
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
    var
        MarkdownMermaidFieldID: Integer;
    begin
        MarkdownMermaidFieldID := 15;
        CurrPage.MarkdownViewer_ANJ.Draw(MarkdownMgmt.GetMarkdown(MarkdownMermaidFieldID));
    end;

    var
        MarkdownMgmt: Codeunit MarkdownMgmt_ANJ;
}