/// <summary>
/// Page DependencyGraphSetup_ANJ (ID 80800).
/// </summary>
page 80800 DependencyGraphSetup_ANJ
{
    ApplicationArea = All;
    Caption = 'Dependency Graph Setup', comment = 'ESP="Configuración del gráfico de dependencia"';
    PageType = Card;
    SourceTable = DependencyGraphSetup_ANJ;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Auth)
            {
                Caption = 'App registrations - Azure', comment = 'ESP="Registros de aplicaciones - Azure"';

                field(ClientID; Rec.ClientID)
                {
                    ToolTip = 'Specifies the value of the Client ID field.', Comment = 'ESP="Especifica el valor del campo Id. de cliente"';
                }
                field(Secret; Rec.Secret)
                {
                    ExtendedDatatype = Masked;
                    ToolTip = 'Specifies the value of the Secret field.', Comment = 'ESP="Especifica el valor del campo Secreto"';
                }
            }
            group(Figure)
            {
                Caption = 'App shapes inside the diagram', comment = 'ESP="Figuras de las app dentro del diagrama"';

                field(ScopePTEFigure; Rec.ScopePTEFigure)
                {
                    ToolTip = 'Specifies the value of the Scope PTE Figure field.', Comment = 'ESP="Especifica el valor del campo Figura Ext. PTE"';
                }
                field(ScopeGlobalFigure; Rec.ScopeGlobalFigure)
                {
                    ToolTip = 'Specifies the value of the Scope Global Figure field.', Comment = 'ESP="Especifica el valor del campo Figura Ext. Global"';
                }
                field(ScopeDevFigure; Rec.ScopeDevFigure)
                {
                    ToolTip = 'Specifies the value of the Scope Dev Figure field.', Comment = 'ESP="Especifica el valor del campo Figura Ext. Dev"';
                }
            }
            group(Include)
            {
                Caption = 'Include when generating the graph', comment = 'ESP="Incluir al generar el gráfico"';

                field(IncludeMicrosoftApps; Rec.IncludeMicrosoftApps)
                {
                    Caption = 'Microsoft Apps', Comment = 'ESP="Aplicaciones de Microsoft"';
                    ToolTip = 'Specifies the value of the Include Microsoft Apps field.', Comment = 'ESP="Especifica el valor del campo Incluir aplicaciones de Microsoft"';
                }
                field(IncludeLinkText; Rec.IncludeLinkText)
                {
                    Caption = 'Link text between dependencies', Comment = 'ESP="Texto de enlace entre dependencias"';
                    ToolTip = 'Specifies the value of the Include Link text field.', Comment = 'ESP="Especifica el valor del campo Incluir Texto de enlace entre dependencias"';
                }
            }
            group(FillTables)
            {
                Caption = 'Fill tables', comment = 'ESP="Rellenar tablas"';

                field(FillingProcessingTables; Rec.FillingProcessingTables)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Filling Processing Tables field.', Comment = 'ESP="Especifica el valor del campo Rellenar tablas de procesamiento"';
                }
            }
            group(LastGeneration)
            {
                Caption = 'Last time it was generated', comment = 'ESP="Última vez que se generó"';

                group(Tables)
                {
                    Caption = 'Tables to customize the graph', comment = 'ESP="Tablas para personalizar el gráfico"';

                    field(DateLastGeneration; Rec.DateLastGeneration)
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Date Last Generation field.', Comment = 'ESP="Especifica el valor del campo Fecha Última vez que se generó"';
                    }
                    field(TimeLastGeneration; Rec.TimeLastGeneration)
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Time Last Generation field.', Comment = 'ESP="Especifica el valor del campo Hora Última vez que se generó"';
                    }
                }
                group(Markdown)
                {
                    Caption = 'Dependency graph', comment = 'ESP="Gráfico de dependencia"';

                    field(DateLastGenerationMarkdown; Rec.DateLastGenerationMarkdown)
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Date Last Generation field.', Comment = 'ESP="Especifica el valor del campo Fecha última generación"';
                    }
                    field(TimeLastGenerationMarkdown; Rec.TimeLastGenerationMarkdown)
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Time Last Generation field.', Comment = 'ESP="Especifica el valor del campo Hora última generación"';
                    }
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Extensions)
            {
                ApplicationArea = All;
                Caption = 'Dependency Graph', comment = 'ESP="Gráfico de dependencia"';
                Image = Table;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page ShowInGraph_ANJ;
                ToolTip = 'Executes the Show In Graph action.', Comment = 'ESP="Ejecuta la acción Mostrar en gráfico"';
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.GetInstance();
    end;
}