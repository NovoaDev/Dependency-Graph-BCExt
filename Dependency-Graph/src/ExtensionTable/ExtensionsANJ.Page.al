/// <summary>
/// Page Extensions_ANJ (ID 80801).
/// </summary>
page 80801 Extensions_ANJ
{
    ApplicationArea = All;
    Caption = 'Extensions', comment = 'ESP="Extensiones"';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = Extensions_ANJ;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Name field.', Comment = 'ESP="Especifica el valor del campo Nombre"';
                }
                field(DisplayName; Rec.DisplayName)
                {
                    ToolTip = 'Specifies the value of the Display Name field.', Comment = 'ESP="Especifica el valor del campo Nombre para mostrar"';
                }
                field(Publisher; Rec.Publisher)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Publisher field.', Comment = 'ESP="Especifica el valor del campo Publicado"';
                }
                field(PublishedAs; Rec.PublishedAs)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Published As field.', Comment = 'ESP="Especifica el valor del campo Publicado como"';
                }
                field(Identity; Rec.Identity)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Identity field.', Comment = 'ESP="Especifica el valor del campo Identidad"';
                }
                field(ShowInGraph; Rec.ShowInGraph)
                {
                    ToolTip = 'Specifies the value of the ShowInGraph field.', Comment = 'ESP="Especifica el valor del campo Mostrar en gráfico"';
                }
            }
        }
    }
}
