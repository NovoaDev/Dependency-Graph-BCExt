/// <summary>
/// Page Extensions_ANJ (ID 80801).
/// </summary>
page 80801 Extensions_ANJ
{
    ApplicationArea = All;
    Caption = 'Extensions', comment = 'ESP="Extensiones"';
    Editable = false;
    PageType = List;
    SourceTable = Extensions_ANJ;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(AppID; Rec.AppID)
                {
                    ToolTip = 'Specifies the value of the App ID field.', Comment = 'ESP="Especifica el valor del campo ID de la aplicación"';
                }
                field(DisplayName; Rec.DisplayName)
                {
                    ToolTip = 'Specifies the value of the Display Name field.', Comment = 'ESP="Especifica el valor del campo Nombre para mostrar"';
                }
                field(Publisher; Rec.Publisher)
                {
                    ToolTip = 'Specifies the value of the Publisher field.', Comment = 'ESP="Especifica el valor del campo Publicado"';
                }
                field(PublishedAs; Rec.PublishedAs)
                {
                    ToolTip = 'Specifies the value of the Published As field.', Comment = 'ESP="Especifica el valor del campo Publicado como"';
                }
                field(IsInstalled; Rec.IsInstalled)
                {
                    ToolTip = 'Specifies the value of the Is Installed field.', Comment = 'ESP="Especifica el valor del campo Instalado"';
                }
                field(Identity; Rec.Identity)
                {
                    ToolTip = 'Specifies the value of the Identity field.', Comment = 'ESP="Especifica el valor del campo Identidad"';
                }
            }
        }
    }
}
