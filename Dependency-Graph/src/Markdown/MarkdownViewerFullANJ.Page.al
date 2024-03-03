/// <summary>
/// Page "MarkdownViewerFull_ANJ" (ID 80804).
/// </summary>
namespace ANJ.Tools.Graph;
page 80806 MarkdownViewerFull_ANJ
{
    ApplicationArea = All;
    Caption = 'Markdown Viewer';
    Extensible = false;
    PageType = Card;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            usercontrol(MarkdownViewerFS; MarkdownViewerFS_ANJ)
            {
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        MarkdownMermaidFieldID: Integer;
    begin
        MarkdownMermaidFieldID := 15;
        CurrPage.MarkdownViewerFS.Draw(DependencyGraphFacade.GetMarkdownText(MarkdownMermaidFieldID));
    end;

    var
        DependencyGraphFacade: Codeunit DependencyGraphFacade_ANJ;
}