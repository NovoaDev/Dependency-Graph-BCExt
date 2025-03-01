/// <summary>
/// Table "Extensions_ANJ" (ID 80801).
/// </summary>
namespace ANJ.Tools.Graph;
table 80801 Extensions_ANJ
{
    Access = Public;
    Caption = 'Extensions';
    DataClassification = CustomerContent;
    DrillDownPageId = Extensions_ANJ;
    Extensible = true;
    LookupPageId = Extensions_ANJ;

    fields
    {
        field(1; AppID; Guid)
        {
            AllowInCustomizations = Never;
            Caption = 'App ID';
        }
        field(2; Name; Text[2048])
        {
            Caption = 'Name';
            ToolTip = 'Specifies the value of the Name field.';
        }
        field(3; DisplayName; Text[2048])
        {
            Caption = 'Display Name';
            ToolTip = 'Specifies the value of the Display Name field.';

            trigger OnValidate()
            begin
                UpdateFigure();
            end;
        }
        field(4; Publisher; Text[2048])
        {
            Caption = 'Publisher';
            ToolTip = 'Specifies the value of the Publisher field.';
        }
        field(5; PublishedAs; Enum ExtensionScope_ANJ)
        {
            Caption = 'Published As';
            InitValue = PTE;
            ToolTip = 'Specifies the value of the Published As field.';
        }
        field(6; Identity; Text[2048])
        {
            AllowInCustomizations = Never;
            Caption = 'Identity';

            trigger OnValidate()
            begin
                UpdateFigure();
            end;
        }
        field(7; ShowInGraph; Boolean)
        {
            Caption = 'Show In Graph';
            ToolTip = 'Specifies the value of the ShowInGraph field.';
        }
        field(8; Figure; Text[2048])
        {
            AllowInCustomizations = Never;
            Caption = 'Figure';
        }
        field(9; HasStartRelationships; Boolean)
        {
            AllowInCustomizations = Never;
            CalcFormula = exist(Relations_ANJ where(SourceAppID = field(AppID)));
            Caption = 'Has Relationships';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; HasRelationships; Boolean)
        {
            AllowInCustomizations = Never;
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
    local procedure UpdateFigure()
    begin
        Validate(Figure, CopyStr(DependencyGraphFacade.GenerateFigures(PublishedAs, Identity, DisplayName), 1, 2048));
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