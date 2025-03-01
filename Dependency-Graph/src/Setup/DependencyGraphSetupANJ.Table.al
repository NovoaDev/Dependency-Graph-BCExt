/// <summary>
/// Table DependencyGraphSetup_ANJ (ID 80800).
/// </summary>
namespace ANJ.Tools.Graph;
table 80800 DependencyGraphSetup_ANJ
{
    Access = Public;
    Caption = 'Dependency Graph Setup';
    DataClassification = CustomerContent;
    DrillDownPageId = DependencyGraphSetup_ANJ;
    Extensible = true;
    LookupPageId = DependencyGraphSetup_ANJ;

    fields
    {
        field(1; PrimaryKey; Code[10])
        {
            AllowInCustomizations = Never;
            Caption = 'Primary Key';
            NotBlank = false;
        }
        field(2; ClientID; Text[2048])
        {
            Caption = 'Client ID';
            ToolTip = 'Specifies the value of the Client ID field.';
        }
        field(3; Secret; Text[2048])
        {
            Caption = 'Secret';
            ToolTip = 'Specifies the value of the Secret field.';
        }
        field(4; ScopePTEFigure; Enum GeometricFigure_ANJ)
        {
            Caption = 'PTE Scope';
            InitValue = SquareRectangle;
            ToolTip = 'Specifies the value of the Scope PTE Figure field.';
        }
        field(5; ScopeGlobalFigure; Enum GeometricFigure_ANJ)
        {
            Caption = 'Global Scope';
            InitValue = SquareRectangle;
            ToolTip = 'Specifies the value of the Scope Global Figure field.';
        }
        field(6; ScopeDevFigure; Enum GeometricFigure_ANJ)
        {
            Caption = 'Dev Scope';
            InitValue = SquareRectangle;
            ToolTip = 'Specifies the value of the Scope Dev Figure field.';
        }
        field(7; IncludeMicrosoftApps; Boolean)
        {
            Caption = 'Include Microsoft Apps';
            ToolTip = 'Specifies the value of the Include Microsoft Apps field.';
        }
        field(8; DateLastGeneration; Date)
        {
            Caption = 'Date';
            ToolTip = 'Specifies the value of the Date Last Generation field.';
        }
        field(9; TimeLastGeneration; Time)
        {
            Caption = 'Time';
            ToolTip = 'Specifies the value of the Time Last Generation field.';
        }
        field(10; Markdown; Blob)
        {
            Caption = 'Content Text';
        }
        field(11; Picture; Media)
        {
            Caption = 'Picture';
        }
        field(12; IncludeLinkText; Boolean)
        {
            Caption = 'Include Link Text';
            ToolTip = 'Specifies the value of the Include Link text field.';
        }
        field(13; DateLastGenerationMarkdown; Date)
        {
            Caption = 'Date';
            ToolTip = 'Specifies the value of the Date Last Generation field.';
        }
        field(14; TimeLastGenerationMarkdown; Time)
        {
            Caption = 'Time';
            ToolTip = 'Specifies the value of the Time Last Generation field.';
        }
        field(15; MarkdownMermaid; Blob)
        {
            Caption = 'Mermaid Content Text';
        }
        field(16; FillingProcessingTables; Enum FillingProcessingTables_ANJ)
        {
            Caption = 'Filling Processing Tables';
            InitValue = WSAndModuleDependencyInfo;
            ToolTip = 'Specifies the value of the Filling Processing Tables field.';
        }
    }
    keys
    {
        key(PK; PrimaryKey)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; ScopePTEFigure, ScopeGlobalFigure, ScopeDevFigure)
        {
        }
        fieldgroup(Brick; ScopePTEFigure, ScopeGlobalFigure, ScopeDevFigure)
        {
        }
    }

    /// <summary>
    /// SetMarkdown.
    /// </summary>
    /// <param name="AuxText">Text.</param>
    /// <param name="FieldNo">Integer.</param>
    internal procedure SetMarkdown(AuxText: Text; FieldNo: Integer)
    var
        AuxOutStream: OutStream;
    begin
        Clear(HasBeenRead);
        case FieldNo of
            FieldNo(Markdown):
                Markdown.CreateOutStream(AuxOutStream);
            FieldNo(MarkdownMermaid):
                MarkdownMermaid.CreateOutStream(AuxOutStream);
        end;
        AuxOutStream.Write(AuxText);
    end;

    /// <summary>
    /// GetInstance.
    /// </summary>
    procedure GetInstance()
    begin
        if HasBeenRead then
            exit;

        if not Get() then begin
            Init();
            Insert(true);
        end;
        HasBeenRead := true;
    end;

    var
        HasBeenRead: Boolean;
}