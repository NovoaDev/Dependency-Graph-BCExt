/// <summary>
/// Codeunit "GenerateFiguresTest_ANJ" (ID 99991).
/// </summary>
codeunit 99991 GenerateFiguresTest_ANJ
{
    Access = Public;
    Subtype = Test;
    TestPermissions = Disabled;

    /// <summary>
    /// GenerateFigures.
    /// </summary>
    [Test]
    procedure GenerateFigures();
    var
        ScopeDevFigure: Text;
        ScopeGlobalFigure: Text;
        ScopePTEFigure: Text;
    begin
        // [Scenario] 
        // Verify that the figures are being generated according to each of the extension scopes.

        // [Given] Setup: 
        InitializeDependencyGraphSetup();

        // [When] Exercise: 
        GetFigureText(ScopeDevFigure, ScopeGlobalFigure, ScopePTEFigure);

        // [Then] Verify: 
        LibraryAssert.AreEqual(ScopePTEFigure, StrSubstNo(SquareRectangleFigureLbl, IdentityLbl, AppNameLbl), GenerateFigureErr);
        LibraryAssert.AreEqual(ScopeGlobalFigure, StrSubstNo(CircleFigureLbl, IdentityLbl, AppNameLbl), GenerateFigureErr);
        LibraryAssert.AreEqual(ScopeDevFigure, StrSubstNo(RhombusFigureLbl, IdentityLbl, AppNameLbl), GenerateFigureErr);
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
        DependencyGraphSetup.Validate(ScopeGlobalFigure, Enum::GeometricFigure_ANJ::Circle);
        DependencyGraphSetup.Validate(ScopeDevFigure, Enum::GeometricFigure_ANJ::Rhombus);
        DependencyGraphSetup.Modify(true);
    end;

    /// <summary>
    /// GetFigureText.
    /// </summary>
    /// <param name="ScopeDevFigure">VAR Text.</param>
    /// <param name="ScopeGlobalFigure">VAR Text.</param>
    /// <param name="ScopePTEFigure">VAR Text.</param>
    local procedure GetFigureText(var ScopeDevFigure: Text; var ScopeGlobalFigure: Text; var ScopePTEFigure: Text)
    begin
        ScopePTEFigure := DependencyGraphFacadeANJ.GenerateFigures(Enum::ExtensionScope_ANJ::PTE, IdentityLbl, AppNameLbl);
        ScopeGlobalFigure := DependencyGraphFacadeANJ.GenerateFigures(Enum::ExtensionScope_ANJ::Global, IdentityLbl, AppNameLbl);
        ScopeDevFigure := DependencyGraphFacadeANJ.GenerateFigures(Enum::ExtensionScope_ANJ::Dev, IdentityLbl, AppNameLbl);
    end;

    var
        DependencyGraphFacadeANJ: Codeunit DependencyGraphFacade_ANJ;
        LibraryAssert: Codeunit "Library Assert";
        AppNameLbl: Label 'App';
        CircleFigureLbl: Label '%1((%2))';
        GenerateFigureErr: Label 'Error generating figures.';
        IdentityLbl: Label 'E1';
        RhombusFigureLbl: Label '%1{%2}';
        SquareRectangleFigureLbl: Label '%1[%2]';
}