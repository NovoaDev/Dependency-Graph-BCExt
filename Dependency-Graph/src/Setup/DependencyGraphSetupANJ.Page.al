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
                Caption = 'Authentication', comment = 'ESP="Autenticación"';

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
                Caption = 'Ext. Figures', comment = 'ESP="Figuras ext."';

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
            group(GraphicGeneration)
            {
                Caption = 'Graphic Generation', comment = 'ESP="Generación de gráfico"';

                group(Include)
                {
                    Caption = 'Include', comment = 'ESP="Incluir"';

                    field(IncludeMicrosoftApps; Rec.IncludeMicrosoftApps)
                    {
                        Caption = 'Microsoft Apps', Comment = 'ESP="Aplicaciones de Microsoft"';
                        ToolTip = 'Specifies the value of the Include Microsoft Apps field.', Comment = 'ESP="Especifica el valor del campo Incluir aplicaciones de Microsoft"';
                    }
                    field(IncludeLinkText; Rec.IncludeLinkText)
                    {
                        Caption = 'Link text', Comment = 'ESP="Texto de enlace"';
                        ToolTip = 'Specifies the value of the Include Link text field.', Comment = 'ESP="Especifica el valor del campo Incluir texto de enlace"';
                    }
                }
                group(LastGeneration)
                {
                    Caption = 'Last Generation', comment = 'ESP="Última generación"';

                    field(DateLastGeneration; Rec.DateLastGeneration)
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Date Last Generation field.', Comment = 'ESP="Especifica el valor del campo Fecha última generación"';
                    }
                    field(TimeLastGeneration; Rec.TimeLastGeneration)
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
                Caption = 'Show In Graph', comment = 'ESP="Mostrar en gráfico"';
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