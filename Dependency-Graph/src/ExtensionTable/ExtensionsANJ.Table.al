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
        field(2; Name; Text[2048])
        {
            Caption = 'Name', comment = 'ESP="Nombre"';
        }
        field(3; DisplayName; Text[2048])
        {
            Caption = 'Display Name', comment = 'ESP="Nombre para mostrar"';

            trigger OnValidate()
            begin
                UpdateFigure();
            end;
        }
        field(4; Publisher; Text[2048])
        {
            Caption = 'Publisher', comment = 'ESP="Publicado"';
        }
        field(5; PublishedAs; Enum ExtensionScope_ANJ)
        {
            Caption = 'Published As', comment = 'ESP="Publicado como"';
        }
        field(6; Identity; Text[2048])
        {
            Caption = 'Identity', comment = 'ESP="Identidad"';

            trigger OnValidate()
            begin
                UpdateFigure();
            end;
        }
        field(7; ShowInGraph; Boolean)
        {
            Caption = 'Show In Graph', comment = 'ESP="Mostrar en gráfico"';
        }
        field(8; Figure; Text[2048])
        {
            Caption = 'Figure', comment = 'ESP="Figura"';
        }
        field(9; HasStartRelationships; Boolean)
        {
            CalcFormula = exist(Relations_ANJ where(SourceAppID = field(AppID)));
            Caption = 'Has Relationships', comment = 'ESP="Tiene relaciones"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; HasRelationships; Boolean)
        {
            CalcFormula = exist(Relations_ANJ where(DestinationAppID = field(AppID)));
            Caption = 'Has Relationships', comment = 'ESP="Tiene relaciones"';
            Editable = false;
            FieldClass = FlowField;
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

    /// <summary>
    /// UpdateFigure
    /// </summary>
    internal procedure UpdateFigure()
    begin
        Validate(Figure, DependencyGraphFacade.GenerateFigures(PublishedAs, Identity, DisplayName));
    end;

    /// <summary>
    /// UpdateRelationTable.
    /// </summary>
    internal procedure UpdateRelationTable()
    begin
        DependencyGraphFacade.CleanRelationsTable();
        DependencyGraphFacade.GenerateRelationTable();
    end;

    var
        DependencyGraphFacade: Codeunit DependencyGraphFacade_ANJ;
}