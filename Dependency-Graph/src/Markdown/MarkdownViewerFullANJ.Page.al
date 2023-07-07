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
            usercontrol(MarkdownViewerFS_ANJ; MarkdownViewerFS_ANJ)
            {
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        MarkdownMermaidFieldID: Integer;
    begin
        MarkdownMermaidFieldID := 15;
        CurrPage.MarkdownViewerFS_ANJ.Draw(MarkdownMgmt.GetMarkdown(MarkdownMermaidFieldID));
    end;

    var
        MarkdownMgmt: Codeunit MarkdownMgmt_ANJ;
}