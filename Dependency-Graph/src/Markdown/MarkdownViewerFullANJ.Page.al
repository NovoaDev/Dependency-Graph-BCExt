/// <summary>
/// Page "MarkdownViewerFull_ANJ" (ID 80804).
/// </summary>
page 80806 MarkdownViewerFull_ANJ
{
    ApplicationArea = All;
    Caption = 'Markdown Viewer';
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
        CurrPage.MarkdownViewerFS_ANJ.Draw(DependencyGraphFacade.GetMarkdownText(MarkdownMermaidFieldID));
    end;

    var
        DependencyGraphFacade: Codeunit DependencyGraphFacade_ANJ;
}