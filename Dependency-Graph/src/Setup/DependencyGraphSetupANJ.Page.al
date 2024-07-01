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
                    ToolTip = 'Specifies the value of the Client ID field.';
                }
                field(Secret; Rec.Secret)
                {
                    ExtendedDatatype = Masked;
                    ToolTip = 'Specifies the value of the Secret field.';
                }
            }
            group(Figure)
            {
                Caption = 'App shapes inside the diagram';

                field(ScopePTEFigure; Rec.ScopePTEFigure)
                {
                    ToolTip = 'Specifies the value of the Scope PTE Figure field.';
                }
                field(ScopeGlobalFigure; Rec.ScopeGlobalFigure)
                {
                    ToolTip = 'Specifies the value of the Scope Global Figure field.';
                }
                field(ScopeDevFigure; Rec.ScopeDevFigure)
                {
                    ToolTip = 'Specifies the value of the Scope Dev Figure field.';
                }
            }
            group(Include)
            {
                Caption = 'Include when generating the graph';

                field(IncludeMicrosoftApps; Rec.IncludeMicrosoftApps)
                {
                    Caption = 'Microsoft Apps';
                    ToolTip = 'Specifies the value of the Include Microsoft Apps field.';
                }
                field(IncludeLinkText; Rec.IncludeLinkText)
                {
                    Caption = 'Link text between dependencies';
                    ToolTip = 'Specifies the value of the Include Link text field.';
                }
            }
            group(FillTables)
            {
                Caption = 'Fill tables';

                field(FillingProcessingTables; Rec.FillingProcessingTables)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Filling Processing Tables field.';
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
                        ToolTip = 'Specifies the value of the Date Last Generation field.';
                    }
                    field(TimeLastGeneration; Rec.TimeLastGeneration)
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Time Last Generation field.';
                    }
                }
                group(Markdown)
                {
                    Caption = 'Dependency graph';

                    field(DateLastGenerationMarkdown; Rec.DateLastGenerationMarkdown)
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Date Last Generation field.';
                    }
                    field(TimeLastGenerationMarkdown; Rec.TimeLastGenerationMarkdown)
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Time Last Generation field.';
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