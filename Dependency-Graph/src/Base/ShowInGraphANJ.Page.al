/// <summary>
/// Page "ShowInGraph_ANJ" (ID 80802).
/// </summary>
namespace ANJ.Tools.Graph;
page 80802 ShowInGraph_ANJ
{
    ApplicationArea = All;
    Caption = 'Show In Dependency Graph';
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
                Caption = 'Generate data';
                Image = NewSparkle;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Executes the Generate data action.';

                trigger OnAction()
                begin
                    DependencyGraphFacade.GenerateAllTables(false);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        DependencyGraphSetup: Record DependencyGraphSetup_ANJ;
    begin
        DependencyGraphFacade.GenerateGraph();
        CurrPage.MarkdownFactbox_ANJ.Page.SetMarkdownText(DependencyGraphFacade.GetMarkdownText(DependencyGraphSetup.FieldNo(Markdown)));
        CurrPage.MarkdownViewer_ANJ.Page.SetMarkdown(DependencyGraphFacade.GetMarkdownText(DependencyGraphSetup.FieldNo(MarkdownMermaid)));
    end;

    var
        DependencyGraphFacade: Codeunit DependencyGraphFacade_ANJ;
}