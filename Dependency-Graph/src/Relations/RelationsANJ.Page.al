/// <summary>
/// Page Relations_ANJ (ID 80803).
/// </summary>
page 80803 Relations_ANJ
{
    ApplicationArea = All;
    Caption = 'Relations', comment = 'ESP="Relaciones"';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = Relations_ANJ;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(SourceAppName; Rec.SourceAppName)
                {
                    ToolTip = 'Specifies the value of the Source App Name field.', Comment = 'ESP="Especifica el valor del campo Nombre de la aplicación origen"';
                }
                field(LinkText; Rec.LinkText)
                {
                    ToolTip = 'Specifies the value of the Link Text field.', Comment = 'ESP="Especifica el valor del campo Texto de enlace"';

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field(DestinationAppName; Rec.DestinationAppName)
                {
                    ToolTip = 'Specifies the value of the Destination App Name field.', Comment = 'ESP="Especifica el valor del campo Nombre de la aplicación destino"';
                }
                field(ShowInGraph; Rec.ShowInGraph)
                {
                    ToolTip = 'Specifies the value of the Show In Graph field.', Comment = 'ESP="Especifica el valor del campo Mostrar en gráfico"';

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
            }
        }
    }
}