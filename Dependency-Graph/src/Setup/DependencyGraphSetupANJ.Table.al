table 80800 DependencyGraphSetup_ANJ
{
    Access = Internal;
    Caption = 'Dependency Graph Setup', comment = 'ESP="Configuración del gráfico de dependencia"';
    DataClassification = CustomerContent;
    DrillDownPageID = DependencyGraphSetup_ANJ;
    LookupPageID = DependencyGraphSetup_ANJ;

    fields
    {
        field(1; PrimaryKey; Code[10])
        {
            Caption = 'Primary Key', Comment = 'ESP="Clave primaria"';
            NotBlank = false;
        }
        field(2; ClientID; Text[2048])
        {
            Caption = 'Client ID', Comment = 'ESP="Id. de cliente"';
        }
        field(3; Secret; Text[2048])
        {
            Caption = 'Secret', Comment = 'ESP="Secreto"';
        }
        field(4; ScopePTEFigure; Enum GeometricFigure_ANJ)
        {
            Caption = 'PTE Scope', Comment = 'ESP="Scope PTE"';
        }
        field(5; ScopeGlobalFigure; Enum GeometricFigure_ANJ)
        {
            Caption = 'Global Scope', Comment = 'ESP="Scope Global"';
        }
        field(6; ScopeDevFigure; Enum GeometricFigure_ANJ)
        {
            Caption = 'Dev Scope', Comment = 'ESP="Scope Dev"';
        }
        field(7; IncludeMicrosoftApps; Boolean)
        {
            Caption = 'Include Microsoft Apps', Comment = 'ESP="Incluir aplicaciones de Microsoft"';
        }
        field(8; DateLastGeneration; Date)
        {
            Caption = 'Date', Comment = 'ESP="Fecha"';
        }
        field(9; TimeLastGeneration; Time)
        {
            Caption = 'Time', Comment = 'ESP="Hora"';
        }
        field(10; Markdown; Blob)
        {
            Caption = 'Content Text', Comment = 'ESP="Texto de contenido"';
        }
        field(11; Picture; Media)
        {
            Caption = 'Picture', Comment = 'ESP="Imagen"';
        }
        field(12; IncludeLinkText; Boolean)
        {
            Caption = 'Include Link Text', Comment = 'ESP="Incluir texto de enlace"';
        }
        field(13; DateLastGenerationMarkdown; Date)
        {
            Caption = 'Date', Comment = 'ESP="Fecha"';
        }
        field(14; TimeLastGenerationMarkdown; Time)
        {
            Caption = 'Time', Comment = 'ESP="Hora"';
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
    internal procedure SetMarkdown(AuxText: Text);
    var
        AuxOutStream: OutStream;
    begin
        Clear(HasBeenRead);
        Markdown.CreateOutStream(AuxOutStream);
        AuxOutStream.Write(AuxText);
    end;

    /// <summary>
    /// GetInstance.
    /// </summary>
    internal procedure GetInstance();
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