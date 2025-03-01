/// <summary>
/// Codeunit GenerateFigure_ANJ (ID 80804).
/// </summary>
namespace ANJ.Tools.Graph;
codeunit 80804 GenerateFigure_ANJ
{
    Access = Public;

    /// <summary>
    /// Generate.
    /// </summary>
    /// <param name="ExtensionScope">Enum ExtensionScope_ANJ.</param>
    /// <param name="Identity">Text.</param>
    /// <param name="AppName">Text.</param>
    /// <returns>Return variable ReturnText of type Text.</returns>
    internal procedure Generate(ExtensionScope: Enum ExtensionScope_ANJ; Identity: Text; AppName: Text) ReturnText: Text
    var
        IsHandled: Boolean;
    begin
        OnBeforeGenerate(ExtensionScope, Identity, AppName, IsHandled);
        ReturnText := DoGenerate(ExtensionScope, Identity, AppName, IsHandled);
        OnAfterGenerate(ReturnText);
    end;

    /// <summary>
    /// DoGenerate.
    /// </summary>
    /// <param name="ExtensionScope">Enum ExtensionScope_ANJ.</param>
    /// <param name="Identity">Text.</param>
    /// <param name="AppName">Text.</param>
    /// <param name="IsHandled">Boolean.</param>
    /// <returns>Return value of type Text.</returns>
    local procedure DoGenerate(ExtensionScope: Enum ExtensionScope_ANJ; Identity: Text; AppName: Text; IsHandled: Boolean): Text
    begin
        if IsHandled then
            exit;

        exit(GenerateFullFigure(ExtensionScope, Identity, AppName));
    end;

    /// <summary>
    /// GenerateFullFigure.
    /// </summary>
    /// <param name="ExtensionScope">Enum ExtensionScope_ANJ.</param>
    /// <param name="Identity">Text.</param>
    /// <param name="AppName">Text.</param>
    /// <returns>Return value of type Text.</returns>
    local procedure GenerateFullFigure(ExtensionScope: Enum ExtensionScope_ANJ; Identity: Text; AppName: Text): Text
    var
        FigureInGraph: Interface IFigureInGraph_ANJ;
    begin
        FigureInGraph := GetGeometricFigure(ExtensionScope);
        RemoveDisallowedCharacters(AppName);
        exit(FigureInGraph.GenerateFigureText(Identity, AppName));
    end;

    /// <summary>
    /// RemoveDisallowedCharacters.
    /// </summary>
    /// <param name="AppName">VAR Text.</param>
    local procedure RemoveDisallowedCharacters(var AppName: Text)
    begin
        AppName := AppName.Replace('-', '');
        AppName := AppName.Replace('(', '');
        AppName := AppName.Replace(')', '');
        AppName := AppName.Replace('{', '');
        AppName := AppName.Replace('}', '');
        AppName := AppName.Replace('[', '');
        AppName := AppName.Replace(']', '');
    end;

    /// <summary>
    /// GetGeometricFigure.
    /// </summary>
    /// <param name="ExtensionScope">Enum ExtensionScope_ANJ.</param>
    /// <returns>Return variable GeometricFigure of type Enum GeometricFigure_ANJ.</returns>
    local procedure GetGeometricFigure(ExtensionScope: Enum ExtensionScope_ANJ) GeometricFigure: Enum GeometricFigure_ANJ
    var
        DependencyGraphSetup: Record DependencyGraphSetup_ANJ;
    begin
        DependencyGraphSetup.SetLoadFields(ScopePTEFigure, ScopeGlobalFigure, ScopeDevFigure);
        DependencyGraphSetup.GetInstance();

        case ExtensionScope of
            ExtensionScope::PTE:
                GeometricFigure := DependencyGraphSetup.ScopePTEFigure;
            ExtensionScope::Global:
                GeometricFigure := DependencyGraphSetup.ScopeGlobalFigure;
            ExtensionScope::Dev:
                GeometricFigure := DependencyGraphSetup.ScopeDevFigure;
        end;
    end;

    /// <summary>
    /// OnBeforeGenerate
    /// </summary>
    /// <param name="ExtensionScope"></param>
    /// <param name="Identity"></param>
    /// <param name="AppName"></param>
    /// <param name="IsHandled"></param>
    [IntegrationEvent(false, false)]
    local procedure OnBeforeGenerate(ExtensionScope: Enum ExtensionScope_ANJ; Identity: Text; AppName: Text; var IsHandled: Boolean)
    begin
    end;

    /// <summary>
    /// OnAfterGenerate.
    /// </summary>
    /// <param name="ReturnText">VAR Text.</param>
    [IntegrationEvent(false, false)]
    local procedure OnAfterGenerate(var ReturnText: Text)
    begin
    end;
}