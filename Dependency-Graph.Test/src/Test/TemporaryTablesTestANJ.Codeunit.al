/// <summary>
/// Codeunit "TemporaryTablesTest_ANJ" (ID 99992).
/// </summary>
codeunit 99992 TemporaryTablesTest_ANJ
{
    Access = Public;
    Subtype = Test;
    TestPermissions = Disabled;

    [Test]
    procedure GenerateFigures();
    var
        ExtensionRecords: Integer;
        RelationsRecords: Integer;
        ExpectedMarkdownMermaidText: Text;
        ExpectedMarkdownText: Text;
        MarkdownMermaidText: Text;
        MarkdownText: Text;
    begin
        // [Scenario] 
        // A single test is carried out with the entire cycle. 

        // [Given] Setup: 
        InitializeDependencyGraphSetup();

        // [When] Exercise: 
        DependencyGraphFacade.GenerateAllTables(true);
        ExtensionRecords := GetExtensionRecords();
        RelationsRecords := GetRelationsRecords();

        GetMarkdownTexts(MarkdownText, MarkdownMermaidText);
        ExpectedMarkdownText := ExpectedValues.GetExpectedMarkdownText();
        ExpectedMarkdownMermaidText := ExpectedValues.GetExpectedMarkdownMermaidText();
        // [Then] Verify: 
        LibraryAssert.AreEqual(ExtensionRecords, 2, StrSubstNo(DiferentNumberErr, Format(Database::Extensions_ANJ)));
        LibraryAssert.AreEqual(RelationsRecords, 1, StrSubstNo(DiferentNumberErr, Format(Database::Relations_ANJ)));
        LibraryAssert.AreEqual(MarkdownText, ExpectedMarkdownText, MarkdownTextErr);
        LibraryAssert.AreEqual(MarkdownMermaidText, ExpectedMarkdownMermaidText, MarkdownTextErr);
    end;

    /// <summary>
    /// InitializeDependencyGraphSetup
    /// </summary>
    local procedure InitializeDependencyGraphSetup()
    var
        DependencyGraphSetup: Record DependencyGraphSetup_ANJ;
    begin
        DependencyGraphSetup.GetInstance();
        DependencyGraphSetup.Validate(ScopePTEFigure, Enum::GeometricFigure_ANJ::SquareRectangle);
        DependencyGraphSetup.Validate(FillingProcessingTables, Enum::FillingProcessingTables_ANJ::Mock_ANJ);
        DependencyGraphSetup.Modify(true);
    end;

    /// <summary>
    /// GetExtensionRecords.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    local procedure GetExtensionRecords(): Integer
    var
        Extensions: Record Extensions_ANJ;
    begin
        exit(Extensions.Count());
    end;

    /// <summary>
    /// GetRelationsRecords.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    local procedure GetRelationsRecords(): Integer
    var
        Relations: Record Relations_ANJ;
    begin
        exit(Relations.Count());
    end;

    /// <summary>
    /// GetMarkdownTexts.
    /// </summary>
    /// <param name="MarkdownText">VAR Text.</param>
    /// <param name="MarkdownMermaidText">VAR Text.</param>
    local procedure GetMarkdownTexts(var MarkdownText: Text; var MarkdownMermaidText: Text)
    var
        DependencyGraphSetup: Record DependencyGraphSetup_ANJ;
    begin
        DependencyGraphFacade.GenerateGraph();
        MarkdownText := DependencyGraphFacade.GetMarkdownText(DependencyGraphSetup.FieldNo(Markdown));
        MarkdownMermaidText := DependencyGraphFacade.GetMarkdownText(DependencyGraphSetup.FieldNo(MarkdownMermaid));
    end;

    var
        DependencyGraphFacade: Codeunit DependencyGraphFacade_ANJ;
        ExpectedValues: Codeunit ExpectedValues_ANJ;
        LibraryAssert: Codeunit "Library Assert";
        DiferentNumberErr: Label 'Diferent number of records in table %1 than expected';
        MarkdownTextErr: Label 'Markdown text is different than expected';
}