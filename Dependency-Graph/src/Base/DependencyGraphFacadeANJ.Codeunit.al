/// <summary>
/// Codeunit "DependencyGraphFacade_ANJ" (ID 80810).
/// </summary>
codeunit 80810 DependencyGraphFacade_ANJ
{
    Access = Public;

    #region codeunit 80807 GenerateTables_ANJ
    /// <summary>
    /// GenerateAllTables.
    /// </summary>
    /// <param name="HideDialog">Boolean.</param>
    procedure GenerateAllTables(HideDialog: Boolean);
    begin
        GenerateTables.Generate(HideDialog);
    end;
    #endregion

    #region codeunit 80805 GenerateExtensionTable_ANJ
    /// <summary>
    /// CleanExtensionsTable.
    /// </summary>
    procedure CleanExtensionsTable();
    begin
        GenerateExtensionTable.CleanExtensionsTable();
    end;

    /// <summary>
    /// GenerateExtensionsTable.
    /// </summary>
    procedure GenerateExtensionsTable();
    begin
        GenerateExtensionTable.Generate();
    end;
    #endregion

    #region codeunit 80806 NumberSequenceMgmt_ANJ
    /// <summary>
    /// InitializeNumberSequence
    /// </summary>
    procedure InitializeNumberSequence();
    begin
        NumberSequenceMgmt.Initialize();
    end;

    /// <summary>
    /// GetNextNumberSequence.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetNextNumberSequence(): Text;
    begin
        exit(NumberSequenceMgmt.GetNextNo());
    end;
    #endregion

    #region codeunit 80804 GenerateFigure_ANJ
    /// <summary>
    /// GenerateFigures.
    /// </summary>
    /// <param name="ExtensionScope">Enum ExtensionScope_ANJ.</param>
    /// <param name="Identity">Text.</param>
    /// <param name="AppName">Text.</param>
    /// <returns>Return value of type Text.</returns>
    procedure GenerateFigures(ExtensionScope: Enum ExtensionScope_ANJ; Identity: Text; AppName: Text): Text;
    begin
        exit(GenerateFigure.Generate(ExtensionScope, Identity, AppName));
    end;
    #endregion

    #region codeunit 80809 MarkdownMgmt_ANJ
    /// <summary>
    /// GenerateGraph.
    /// </summary>
    /// <param name="CompleteForMarkdown">Boolean.</param>
    procedure GenerateGraph(CompleteForMarkdown: Boolean);
    begin
        MarkdownMgmt.GenerateGraph(CompleteForMarkdown);
    end;

    /// <summary>
    /// GetMarkdownText.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetMarkdownText(): Text;
    begin
        exit(MarkdownMgmt.GetMarkdown());
    end;
    #endregion

    #region codeunit 80808 GenerateRelationsTable_ANJ
    /// <summary>
    /// CleanExtensionTable.
    /// </summary>
    internal procedure CleanRelationsTable();
    begin
        GenerateRelationsTable.CleanRelationsTable();
    end;

    /// <summary>
    /// GenerateRelationsTable.
    /// </summary>
    internal procedure GenerateRelationTable();
    begin
        GenerateRelationsTable.Generate();
    end;
    #endregion

    var
        GenerateExtensionTable: Codeunit GenerateExtensionTable_ANJ;
        GenerateFigure: Codeunit GenerateFigure_ANJ;
        GenerateRelationsTable: Codeunit GenerateRelationsTable_ANJ;
        GenerateTables: Codeunit GenerateTables_ANJ;
        MarkdownMgmt: Codeunit MarkdownMgmt_ANJ;
        NumberSequenceMgmt: Codeunit NumberSequenceMgmt_ANJ;
}