/// <summary>
/// Table Relations_ANJ (ID 80802).
/// </summary>
namespace ANJ.Tools.Graph;
table 80802 Relations_ANJ
{
    Access = Public;
    Caption = 'Relations';
    DataClassification = CustomerContent;
    DrillDownPageId = Relations_ANJ;
    LookupPageId = Relations_ANJ;

    fields
    {
        field(1; RelationNo; Integer)
        {
            AllowInCustomizations = Never;
            Caption = 'Relation No.';
        }
        field(2; SourceAppID; Guid)
        {
            AllowInCustomizations = Never;
            Caption = 'Source App ID';
        }
        field(3; SourceAppName; Text[2048])
        {
            CalcFormula = lookup(Extensions_ANJ.DisplayName where(AppID = field(SourceAppID)));
            Caption = 'Source App Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; DestinationAppID; Guid)
        {
            AllowInCustomizations = Never;
            Caption = 'Destination App ID';
        }
        field(5; DestinationAppName; Text[2048])
        {
            CalcFormula = lookup(Extensions_ANJ.DisplayName where(AppID = field(DestinationAppID)));
            Caption = 'Destination App Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; LinkText; Text[2048])
        {
            Caption = 'Link Text';
        }
        field(7; ShowInGraph; Boolean)
        {
            Caption = 'Show In Graph';
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