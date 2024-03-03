/// <summary>
/// Codeunit "DefaultFillProcessTabImp_ANJ" (ID 80815) implements Interface FillingProcessingTables_ANJ.
/// </summary>
namespace ANJ.Tools.Graph;
codeunit 80815 DefaultFillProcessTabImp_ANJ implements FillingProcessingTables_ANJ
{
    Access = Internal;

    procedure GetExtensions(): Text
    begin
        Error(ImpErr);
    end;

    procedure GetRelations() JsonText: Text
    begin
        Error(ImpErr);
    end;

    var
        ImpErr: Label 'An implementation for the generation of related relationship tables must be specified.';

}