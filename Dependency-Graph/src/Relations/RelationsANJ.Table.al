/// <summary>
/// Table Relations_ANJ (ID 80802).
/// </summary>
table 80802 Relations_ANJ
{
    Access = Internal;
    Caption = 'Relations', comment = 'ESP="Relaciones"';
    DataClassification = CustomerContent;
    DrillDownPageId = Relations_ANJ;
    LookupPageId = Relations_ANJ;

    fields
    {
        field(1; RelationNo; Integer)
        {
            Caption = 'Relation No.', comment = 'ESP="Número de relación"';
        }
        field(2; SourceAppID; Guid)
        {
            Caption = 'Source App ID', comment = 'ESP="ID de la aplicación origen"';
        }
        field(3; SourceAppName; Text[2048])
        {
            CalcFormula = lookup(Extensions_ANJ.DisplayName where(AppID = field(SourceAppID)));
            Caption = 'Source App Name', comment = 'ESP="Nombre de la aplicación origen"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; DestinationAppID; Guid)
        {
            Caption = 'Destination App ID', comment = 'ESP="ID de la aplicación destino"';
        }
        field(5; DestinationAppName; Text[2048])
        {
            CalcFormula = lookup(Extensions_ANJ.DisplayName where(AppID = field(DestinationAppID)));
            Caption = 'Destination App Name', comment = 'ESP="Nombre de la aplicación destino"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; LinkText; Text[2048])
        {
            Caption = 'Link Text', Comment = 'ESP="Texto de enlace"';
        }
        field(7; ShowInGraph; Boolean)
        {
            Caption = 'Show In Graph', comment = 'ESP="Mostrar en gráfico"';
        }
    }
    keys
    {
        key(Key1; RelationNo)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; SourceAppName, DestinationAppName)
        {
        }
        fieldgroup(Brick; SourceAppName, DestinationAppName)
        {
        }
    }
}