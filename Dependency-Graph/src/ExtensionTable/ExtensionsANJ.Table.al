/// <summary>
/// Table "Extensions_ANJ" (ID 80801).
/// </summary>
table 80801 Extensions_ANJ
{
    Access = Public;
    Caption = 'Extensions';
    DataClassification = CustomerContent;
    DrillDownPageId = Extensions_ANJ;
    LookupPageId = Extensions_ANJ;

    fields
    {
        field(1; AppID; Guid)
        {
            Caption = 'App ID';
        }
        field(2; Name; Text[2048])
        {
            Caption = 'Name';
        }
        field(3; DisplayName; Text[2048])
        {
            Caption = 'Display Name';

            trigger OnValidate()
            begin
                UpdateFigure();
            end;
        }
        field(4; Publisher; Text[2048])
        {
            Caption = 'Publisher';
        }
        field(5; PublishedAs; Enum ExtensionScope_ANJ)
        {
            Caption = 'Published As';
        }
        field(6; Identity; Text[2048])
        {
            Caption = 'Identity';

            trigger OnValidate()
            begin
                UpdateFigure();
            end;
        }
        field(7; ShowInGraph; Boolean)
        {
            Caption = 'Show In Graph';
        }
        field(8; Figure; Text[2048])
        {
            Caption = 'Figure';
        }
        field(9; HasStartRelationships; Boolean)
        {
            CalcFormula = exist(Relations_ANJ where(SourceAppID = field(AppID)));
            Caption = 'Has Relationships';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; HasRelationships; Boolean)
        {
            CalcFormula = exist(Relations_ANJ where(DestinationAppID = field(AppID)));
            Caption = 'Has Relationships';
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