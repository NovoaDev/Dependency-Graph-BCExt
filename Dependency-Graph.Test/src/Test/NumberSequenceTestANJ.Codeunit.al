/// <summary>
/// Codeunit NumberSequenceTest_ANJ (ID 99990).
/// </summary>
namespace ANJ.Tools.Graph;
codeunit 99990 NumberSequenceTest_ANJ
{
    Access = Public;
    Subtype = Test;

    /// <summary>
    /// TestNumberSequence.
    /// </summary>
    [Test]
    procedure TestNumberSequence()
    var
        FirstRequest: Text;
        SecondRequest: Text;
        ThirdRequest: Text;
    begin
        // [Scenario] 
        // Verify that it is initialized and a number series is created correctly.

        // [Given] Setup: 
        LibraryLowerPermissions.SetO365BusFull();

        // [When] Exercise: 
        CheckInitializeAndCreateSomeNumberSeries(FirstRequest, SecondRequest, ThirdRequest);

        // [Then] Verify: 
        LibraryAssert.AreEqual(FirstRequest, FirstRequestLbl, NumberSequenceErr);
        LibraryAssert.AreEqual(SecondRequest, SecondRequestLbl, NumberSequenceErr);
        LibraryAssert.AreEqual(ThirdRequest, ThirdRequestLbl, NumberSequenceErr);
    end;

    /// <summary>
    /// CheckInitializeAndCreateSomeNumberSeries.
    /// </summary>
    /// <param name="FirstRequest">VAR Text.</param>
    /// <param name="SecondRequest">VAR Text.</param>
    /// <param name="ThirdRequest">VAR Text.</param>
    local procedure CheckInitializeAndCreateSomeNumberSeries(var FirstRequest: Text; var SecondRequest: Text; var ThirdRequest: Text)
    begin
        DependencyGraphFacadeANJ.InitializeNumberSequence();
        FirstRequest := DependencyGraphFacadeANJ.GetNextNumberSequence();
        SecondRequest := DependencyGraphFacadeANJ.GetNextNumberSequence();
        ThirdRequest := DependencyGraphFacadeANJ.GetNextNumberSequence();
    end;

    var
        DependencyGraphFacadeANJ: Codeunit DependencyGraphFacade_ANJ;
        LibraryLowerPermissions: Codeunit "Library - Lower Permissions";
        LibraryAssert: Codeunit System.TestLibraries.Utilities."Library Assert";
        FirstRequestLbl: Label 'E1';
        NumberSequenceErr: Label 'The number secuence does not correspond to the expected one';
        SecondRequestLbl: Label 'E2';
        ThirdRequestLbl: Label 'E3';
}