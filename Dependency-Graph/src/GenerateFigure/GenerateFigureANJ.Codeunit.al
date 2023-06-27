/// <summary>
/// Codeunit Name Meth (ID 80804).
/// </summary>
codeunit 80804 GenerateFigure_ANJ
{
    Access = Public;

    /// <summary>
    /// Generate.
    /// </summary>
    /// <param name="ExtensionScope">Enum ExtensionScope_ANJ.</param>
    /// <param name="Identity">Text.</param>
    /// <param name="AppName">Text.</param>
    /// <param name="FirstTime">Boolean.</param>
    /// <returns>Return variable ReturnText of type Text.</returns>
    internal procedure Generate(ExtensionScope: Enum ExtensionScope_ANJ; Identity: Text; AppName: Text; FirstTime: Boolean) ReturnText: Text;
    var
        IsHandled: Boolean;
    begin
        OnBeforeGenerate(ExtensionScope, Identity, AppName, FirstTime, IsHandled);
        ReturnText := DoGenerate(ExtensionScope, Identity, AppName, FirstTime, IsHandled);
        OnAfterGenerate(ReturnText);
    end;

    /// <summary>
    /// DoGenerate.
    /// </summary>
    /// <param name="ExtensionScope">Enum ExtensionScope_ANJ.</param>
    /// <param name="Identity">Text.</param>
    /// <param name="AppName">Text.</param>
    /// <param name="FirstTime">Boolean.</param>
    /// <param name="IsHandled">Boolean.</param>
    /// <returns>Return value of type Text.</returns>
    local procedure DoGenerate(ExtensionScope: Enum ExtensionScope_ANJ; Identity: Text; AppName: Text; FirstTime: Boolean; IsHandled: Boolean): Text;
    begin
        if IsHandled then
            exit;

        if FirstTime then
            exit(GenerateFullFigure(ExtensionScope, Identity, AppName));

        exit(Identity);
    end;

    /// <summary>
    /// GenerateFullFigure.
    /// </summary>
    /// <param name="ExtensionScope">Enum ExtensionScope_ANJ.</param>
    /// <param name="Identity">Text.</param>
    /// <param name="AppName">Text.</param>
    /// <returns>Return value of type Text.</returns>
    local procedure GenerateFullFigure(ExtensionScope: Enum ExtensionScope_ANJ; Identity: Text; AppName: Text): Text;
    var
        FigureInGraph: Interface FigureInGraph_ANJ;
    begin
        FigureInGraph := GetGeometricFigure(ExtensionScope);
        exit(FigureInGraph.GenerateFigureText(Identity, AppName));
    end;

    /// <summary>
    /// GetGeometricFigure.
    /// </summary>
    /// <param name="ExtensionScope">Enum ExtensionScope_ANJ.</param>
    /// <returns>Return variable GeometricFigure of type Enum GeometricFigure_ANJ.</returns>
    local procedure GetGeometricFigure(ExtensionScope: Enum ExtensionScope_ANJ) GeometricFigure: Enum GeometricFigure_ANJ;
    var
        DependencyGraphSetup: Record DependencyGraphSetup_ANJ;
    begin
        DependencyGraphSetup.SetLoadFields();
        case ExtensionScope of
            ExtensionScope::PTE:
                GeometricFigure := DependencyGraphSetup.ScopePTEFigure;
            ExtensionScope::Global:
                GeometricFigure := DependencyGraphSetup.ScopeGlobalFigure;
            ExtensionScope::Dev:
                GeometricFigure := DependencyGraphSetup.ScopeDevFigure;
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGenerate(ExtensionScope: Enum ExtensionScope_ANJ; Identity: Text; AppName: Text; FirstTime: Boolean; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGenerate(var ReturnText: Text);
    begin
    end;
}