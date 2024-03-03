/// <summary>
/// Codeunit "GenerateExtensionTable_ANJ" (ID 80805).
/// </summary>
namespace ANJ.Tools.Graph;
codeunit 80805 GenerateExtensionTable_ANJ
{
    Access = Public;

    /// <summary>
    /// Generate.
    /// </summary>
    internal procedure Generate()
    var
        Extensions: Record Extensions_ANJ;
        IsHandled: Boolean;
    begin
        OnBeforeGenerateExtensionTable(Extensions, IsHandled);
        DoGenerateExtensionTable(IsHandled);
        OnAfterGenerateExtensionTable(Extensions);
    end;

    /// <summary>
    /// DoGenerateExtensionTable.
    /// </summary>
    /// <param name="IsHandled">Boolean.</param>
    local procedure DoGenerateExtensionTable(IsHandled: Boolean)
    var
        FillingProcessingTables: Interface FillingProcessingTables_ANJ;
        ResponseText: Text;
    begin
        if IsHandled then
            exit;

        DependencyGraphFacade.GetInterfaceFillProcessingTables(FillingProcessingTables);
        ResponseText := FillingProcessingTables.GetExtensions();
        if ResponseText <> '' then
            PopulateResponse(ResponseText);
    end;

    /// <summary>
    /// PopulateResponse.
    /// </summary>
    /// <param name="ResponseText">Text.</param>
    local procedure PopulateResponse(ResponseText: Text)
    var
        ResponseJsonArray: JsonArray;
        SingleJsonObject: JsonToken;
        JsonValueArry: Text;
    begin
        JsonValueArry := JSONMethods.GetJsonValue(ValueJsonArryTok, ResponseText);
        if not ResponseJsonArray.ReadFrom(JsonValueArry) then
            Error(ReadingJsonErr);

        DependencyGraphFacade.InitializeNumberSequence();
        foreach SingleJsonObject in ResponseJsonArray do
            InsertTableLines(SingleJsonObject);
    end;

    /// <summary>
    /// InsertTableLines.
    /// </summary>
    /// <param name="SingleJsonObject">JsonToken.</param>
    local procedure InsertTableLines(SingleJsonObject: JsonToken)
    var
        Extensions: Record Extensions_ANJ;
        AuxiliaryText: Text;
        Name: Text;
    begin
        if not SingleJsonObject.WriteTo(AuxiliaryText) then
            Error(ReadingJsonErr);

        if JSONMethods.GetJsonValue(IsInstalledTok, AuxiliaryText) = FalseTok then
            exit;

        Extensions.Init();
        Extensions.Validate(AppID, JSONMethods.GetJsonValue(IdTok, AuxiliaryText));
        Extensions.Insert(true);
        Name := JSONMethods.GetJsonValue(DisplayNameTok, AuxiliaryText);
        Extensions.Validate(Name, Name);
        Extensions.Validate(DisplayName, Name);
        Extensions.Validate(Publisher, JSONMethods.GetJsonValue(PublisherTok, AuxiliaryText));

        case JSONMethods.GetJsonValue(PublishedAsTok, AuxiliaryText) of
            Format(Enum::ExtensionScope_ANJ::PTE):
                Extensions.Validate(PublishedAs, Enum::ExtensionScope_ANJ::PTE);
            Format(Enum::ExtensionScope_ANJ::Global):
                Extensions.Validate(PublishedAs, Enum::ExtensionScope_ANJ::Global);
            Format(Enum::ExtensionScope_ANJ::Dev):
                Extensions.Validate(PublishedAs, Enum::ExtensionScope_ANJ::Dev);
        end;

        Extensions.Validate(ShowInGraph, true);
        Extensions.Validate(Identity, DependencyGraphFacade.GetNextNumberSequence());
        Extensions.Modify(true);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGenerateExtensionTable(Extensions: Record Extensions_ANJ; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGenerateExtensionTable(Extensions: Record Extensions_ANJ)
    begin
    end;

    var
        DependencyGraphFacade: Codeunit DependencyGraphFacade_ANJ;
        JSONMethods: Codeunit JSONMethods_ANJ;
        DisplayNameTok: Label 'displayName', Locked = true;
        FalseTok: Label 'false', Locked = true;
        IdTok: Label 'id', Locked = true;
        IsInstalledTok: Label 'isInstalled', Locked = true;
        PublishedAsTok: Label 'publishedAs', Locked = true;
        PublisherTok: Label 'publisher', Locked = true;
        ReadingJsonErr: Label 'Error reading JSON response.';
        ValueJsonArryTok: Label 'value', Locked = true;
}