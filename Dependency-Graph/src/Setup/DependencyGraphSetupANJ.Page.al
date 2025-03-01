/// <summary>
/// Page DependencyGraphSetup_ANJ (ID 80800).
/// </summary>
namespace ANJ.Tools.Graph;
page 80800 DependencyGraphSetup_ANJ
{
    ApplicationArea = All;
    Caption = 'Dependency Graph Setup';
    Extensible = true;
    PageType = Card;
    SourceTable = DependencyGraphSetup_ANJ;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(Auth)
            {
                Caption = 'App registrations - Azure';

                field(ClientID; Rec.ClientID)
                {
                }
                field(Secret; Rec.Secret)
                {
                    ExtendedDatatype = Masked;
                }
            }
            group(Figure)
            {
                Caption = 'App shapes inside the diagram';

                field(ScopePTEFigure; Rec.ScopePTEFigure)
                {
                }
                field(ScopeGlobalFigure; Rec.ScopeGlobalFigure)
                {
                }
                field(ScopeDevFigure; Rec.ScopeDevFigure)
                {
                }
            }
            group(Include)
            {
                Caption = 'Include when generating the graph';

                field(IncludeMicrosoftApps; Rec.IncludeMicrosoftApps)
                {
                    Caption = 'Microsoft Apps';
                }
                field(IncludeLinkText; Rec.IncludeLinkText)
                {
                    Caption = 'Link text between dependencies';
                }
            }
            group(FillTables)
            {
                Caption = 'Fill tables';

                field(FillingProcessingTables; Rec.FillingProcessingTables)
                {
                    Editable = false;
                }
            }
            group(LastGeneration)
            {
                Caption = 'Last time it was generated';

                group(Tables)
                {
                    Caption = 'Tables to customize the graph';

                    field(DateLastGeneration; Rec.DateLastGeneration)
                    {
                        Editable = false;
                    }
                    field(TimeLastGeneration; Rec.TimeLastGeneration)
                    {
                        Editable = false;
                    }
                }
                group(Markdown)
                {
                    Caption = 'Dependency graph';

                    field(DateLastGenerationMarkdown; Rec.DateLastGenerationMarkdown)
                    {
                        Editable = false;
                    }
                    field(TimeLastGenerationMarkdown; Rec.TimeLastGenerationMarkdown)
                    {
                        Editable = false;
                    }
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Extensions)
            {
                ApplicationArea = All;
                Caption = 'Dependency Graph';
                Image = Table;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page ShowInGraph_ANJ;
                ToolTip = 'Executes the Show In Graph action.';
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.GetInstance();
    end;
}