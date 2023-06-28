/// <summary>
/// Table "Extensions_ANJ" (ID 80801).
/// </summary>
table 80801 Extensions_ANJ
{
    Access = Public;
    Caption = 'Extensions', comment = 'ESP="Extensiones"';
    DataClassification = CustomerContent;
    DrillDownPageId = Extensions_ANJ;
    LookupPageId = Extensions_ANJ;

    fields
    {
        field(1; AppID; Guid)
        {
            Caption = 'App ID', comment = 'ESP="ID de la aplicación"';
        }
        field(2; DisplayName; Text[2048])
        {
            Caption = 'Display Name', comment = 'ESP="Nombre para mostrar"';
        }
        field(3; Publisher; Text[2048])
        {
            Caption = 'Publisher', comment = 'ESP="Publicado"';
        }
        field(4; IsInstalled; Boolean)
        {
            Caption = 'Is Installed', comment = 'ESP="Instalado"';
        }
        field(5; PublishedAs; Enum ExtensionScope_ANJ)
        {
            Caption = 'Published As', comment = 'ESP="Publicado como"';
        }
        field(6; Identity; Text[2048])
        {
            Caption = 'Identity', comment = 'ESP="Identidad"';
        }
    }
    keys
    {
        key(Key1; AppID)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; DisplayName, Publisher, PublishedAs)
        {
        }
        fieldgroup(Brick; DisplayName, Publisher, PublishedAs)
        {
        }
    }
}