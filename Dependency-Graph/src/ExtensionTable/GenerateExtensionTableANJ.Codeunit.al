/// <summary>
/// Codeunit "GenerateExtensionTable_ANJ" (ID 80805).
/// </summary>
codeunit 80805 GenerateExtensionTable_ANJ
{
    Access = Public;

    /// <summary>
    /// Generate.
    /// </summary>
    internal procedure Generate();
    var
        Extensions: Record Extensions_ANJ;
        IsHandled: Boolean;
    begin
        OnBeforeGenerateExtensionTable(Extensions, IsHandled);
        DoGenerateExtensionTable(Extensions, IsHandled);
        OnAfterGenerateExtensionTable(Extensions);
    end;

    /// <summary>
    /// DoGenerateExtensionTable.
    /// </summary>
    /// <param name="Extensions">VAR Record Extensions_ANJ.</param>
    /// <param name="IsHandled">Boolean.</param>
    local procedure DoGenerateExtensionTable(var Extensions: Record Extensions_ANJ; IsHandled: Boolean);
    var
        ResponseText: Text;
    begin
        if IsHandled then
            exit;

        CleanTable(Extensions);
        ResponseText := GetExtensions();
        if ResponseText <> '' then
            PopulateResponse(ResponseText);

        UpdateSetupTable();
        ShowMessage();
    end;

    /// <summary>
    /// CleanTable.
    /// </summary>
    /// <param name="Extensions">VAR Record Extensions_ANJ.</param>
    local procedure CleanTable(var Extensions: Record Extensions_ANJ);
    begin
        if not Extensions.IsEmpty() then
            Extensions.DeleteAll(true);
    end;

    /// <summary>
    /// GetExtensions.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    local procedure GetExtensions(): Text;
    var
        AccessToken: Text;
    begin
        AccessToken := GetAccessToken();
        if AccessToken = '' then
            Error(UnableToCommunicateWSErr);

        exit(DoGetExtensions(AccessToken));
    end;

    /// <summary>
    /// GetAccessToken.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    local procedure GetAccessToken(): Text;
    var
        AuxHttpClient: HttpClient;
        RequestHttpContent: HttpContent;
        Headers: HttpHeaders;
        ResponseHttpResponseMessage: HttpResponseMessage;
        ResponseText: Text;
    begin
        RequestHttpContent.WriteFrom(GetRequestAccessTokenContent());
        RequestHttpContent.GetHeaders(Headers);
        Headers.Remove(ContentTypeLbl);
        Headers.Add(ContentTypeLbl, UrlencodedLbl);

        if not AuxHttpClient.Post(GetAccessTokenAPIUrl(), RequestHttpContent, ResponseHttpResponseMessage) then
            Error(UnableToCommunicateWSErr);

        GetResponseMessageText(ResponseHttpResponseMessage, ResponseText);
        exit(PopulateJsonValue(AccessTokenLbl, ResponseText));
    end;

    /// <summary>
    /// GetRequestAccessTokenContent.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    local procedure GetRequestAccessTokenContent(): Text;
    var
        DependencyGraphSetup: Record DependencyGraphSetup_ANJ;
        ContentTextBuilder: TextBuilder;
    begin
        DependencyGraphSetup.SetLoadFields(ClientID, Secret);
        DependencyGraphSetup.GetInstance();

        ContentTextBuilder.AppendLine(GrantTypeLbl);
        ContentTextBuilder.AppendLine(StrSubstNo(ClientIdLbl, DependencyGraphSetup.ClientID));
        ContentTextBuilder.AppendLine(StrSubstNo(ClientSecretLbl, DependencyGraphSetup.Secret));
        ContentTextBuilder.AppendLine(ScopeLbl);
        exit(ContentTextBuilder.ToText());
    end;

    /// <summary>
    /// GetAccessTokenAPIUrl.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    local procedure GetAccessTokenAPIUrl(): Text;
    begin
        exit(StrSubstNo(AccessTokenUrlLbl, GetTenantId()));
    end;

    /// <summary>
    /// GetTenantId.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    local procedure GetTenantId(): Text;
    begin
        exit(AzureADTenant.GetAadTenantId());
    end;

    /// <summary>
    /// PopulateJsonValue.
    /// </summary>
    /// <param name="JsonKey">Text.</param>
    /// <param name="ResponseText">Text.</param>
    /// <returns>Return value of type Boolean.</returns>
    local procedure PopulateJsonValue(JsonKey: Text; ResponseText: Text): Text;
    var
        AuxJsonObject: JsonObject;
        AuxJsonToken: JsonToken;
        JsonText: Text;
    begin
        if not AuxJsonObject.ReadFrom(ResponseText) then
            Error(ReadingJsonErr);

        if not AuxJsonObject.Get(JsonKey, AuxJsonToken) then
            Error(ReadingJsonErr);

        if (not AuxJsonToken.IsValue()) and (not AuxJsonToken.IsArray()) then
            Error(ReadingJsonErr);

        if AuxJsonToken.IsValue() then
            JsonText := AuxJsonToken.AsValue().AsText()
        else
            AuxJsonToken.AsArray().WriteTo(JsonText);

        exit(JsonText.Trim());
    end;

    /// <summary>
    /// DoGetExtensions.
    /// </summary>
    /// <param name="AccessToken">Text.</param>
    /// <returns>Return value of type Text.</returns>
    local procedure DoGetExtensions(AccessToken: Text): Text;
    var
        AuxHttpClient: HttpClient;
        ResponseHttpResponseMessage: HttpResponseMessage;
        ResponseText: Text;
    begin
        AuxHttpClient.DefaultRequestHeaders().Add(AuthorizationLbl, StrSubstNo(AuthorizationValueLbl, AccessToken));

        if not AuxHttpClient.Get(GetExtensionsAPIUrl(), ResponseHttpResponseMessage) then
            Error(UnableToCommunicateWSErr);

        GetResponseMessageText(ResponseHttpResponseMessage, ResponseText);
        exit(ResponseText);
    end;

    /// <summary>
    /// GetExtensionsAPIUrl.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    local procedure GetExtensionsAPIUrl(): Text;
    var
        DependencyGraphSetup: Record DependencyGraphSetup_ANJ;
        ExtensionsUrl: Text;
    begin
        DependencyGraphSetup.SetLoadFields(IncludeMicrosoftApps);
        DependencyGraphSetup.GetInstance();

        ExtensionsUrl := StrSubstNo(ExtensionsUrlLbl, GetEnvironmentName(), GetCompanyId());
        if not DependencyGraphSetup.IncludeMicrosoftApps then
            ExtensionsUrl += FilterMSAppsLbl + '''Microsoft''';
        // Hardcode of value 'Microsoft' because the single-quote escaping gives error when generating translations with the third-party extension.

        exit(ExtensionsUrl);
    end;

    /// <summary>
    /// GetEnvironmentName.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    local procedure GetEnvironmentName(): Text;
    var
        EnvironmentInformation: Codeunit "Environment Information";
    begin
        exit(EnvironmentInformation.GetEnvironmentName());
    end;

    /// <summary>
    /// GetCompanyId.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    local procedure GetCompanyId(): Text;
    var
        Company: Record Company;
    begin
        Company.SetLoadFields(Id);
        Company.Get(CompanyName());

        exit(Format(Company.Id, 0, 4).ToLower());
    end;

    /// <summary>
    /// /// GetResponseMessageText.
    /// </summary>
    /// <param name="ResponseHttpResponseMessage">VAR HttpResponseMessage.</param>
    /// <param name="ResponseText">VAR Text.</param>
    local procedure GetResponseMessageText(var ResponseHttpResponseMessage: HttpResponseMessage; var ResponseText: Text);
    begin
        ResponseHttpResponseMessage.Content().ReadAs(ResponseText);
        if not ResponseHttpResponseMessage.IsSuccessStatusCode() then
            Error(WSStatusCodeErr, ResponseHttpResponseMessage.HttpStatusCode(), ResponseText);
    end;

    /// <summary>
    /// PopulateResponse.
    /// </summary>
    /// <param name="ResponseText">Text.</param>
    local procedure PopulateResponse(ResponseText: Text);
    var
        ResponseJsonArray: JsonArray;
        SingleJsonObject: JsonToken;
        JsonValueArry: Text;
    begin
        JsonValueArry := PopulateJsonValue(ValueJsonArryLbl, ResponseText);
        if not ResponseJsonArray.ReadFrom(JsonValueArry) then
            Error(ReadingJsonErr);

        NumberSequenceMgmt.Initialize();
        foreach SingleJsonObject in ResponseJsonArray do
            InsertTableLines(SingleJsonObject);
    end;

    /// <summary>
    /// OnBeforeGenerateExtensionTable.
    /// </summary>
    /// <param name="SingleJsonObject">JsonToken.</param>
    local procedure InsertTableLines(SingleJsonObject: JsonToken);
    var
        Extensions: Record Extensions_ANJ;
        AppID: Guid;
        AuxiliaryText: Text;
        Name: Text;
    begin
        if not SingleJsonObject.WriteTo(AuxiliaryText) then
            Error(ReadingJsonErr);

        if PopulateJsonValue(IsInstalledLbl, AuxiliaryText) = FalseLbl then
            exit;

        AppID := PopulateJsonValue(PackageIdLbl, AuxiliaryText);

        Extensions.Init();
        Extensions.Validate(AppID, AppID);
        Extensions.Insert(true);
        Name := PopulateJsonValue(DisplayNameLbl, AuxiliaryText);
        Extensions.Validate(Name, Name);
        Extensions.Validate(DisplayName, Name);
        Extensions.Validate(Publisher, PopulateJsonValue(PublisherLbl, AuxiliaryText));

        case PopulateJsonValue(PublishedAsLbl, AuxiliaryText) of
            Format(Enum::ExtensionScope_ANJ::PTE):
                Extensions.Validate(PublishedAs, Enum::ExtensionScope_ANJ::PTE);
            Format(Enum::ExtensionScope_ANJ::Global):
                Extensions.Validate(PublishedAs, Enum::ExtensionScope_ANJ::Global);
            Format(Enum::ExtensionScope_ANJ::Dev):
                Extensions.Validate(PublishedAs, Enum::ExtensionScope_ANJ::Dev);
        end;

        Extensions.Validate(Identity, NumberSequenceMgmt.GetNextNo());
        Extensions.Modify(true);
    end;

    /// <summary>
    /// UpdateSetupTable.
    /// </summary>
    local procedure UpdateSetupTable();
    var
        DependencyGraphSetup: Record DependencyGraphSetup_ANJ;
    begin
        DependencyGraphSetup.GetInstance();
        DependencyGraphSetup.Validate(DateLastGeneration, Today());
        DependencyGraphSetup.Validate(TimeLastGeneration, Time());
        DependencyGraphSetup.Modify(true);
    end;

    /// <summary>
    /// ShowMessage.
    /// </summary>
    local procedure ShowMessage();
    begin
        if GuiAllowed() then
            Message(ProcessFinishMsg);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGenerateExtensionTable(Extensions: Record Extensions_ANJ; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGenerateExtensionTable(Extensions: Record Extensions_ANJ);
    begin
    end;

    var
        AzureADTenant: Codeunit "Azure AD Tenant";
        NumberSequenceMgmt: Codeunit NumberSequenceMgmt_ANJ;
        AccessTokenLbl: Label 'access_token';
        AccessTokenUrlLbl: Label 'https://login.microsoftonline.com/%1/oauth2/v2.0/token';
        AuthorizationLbl: Label 'Authorization';
        AuthorizationValueLbl: Label 'Bearer %1';
        ClientIdLbl: Label '&client_id=%1';
        ClientSecretLbl: Label '&client_secret=%1';
        ContentTypeLbl: Label 'Content-Type';
        DisplayNameLbl: Label 'displayName';
        ExtensionsUrlLbl: Label 'https://api.businesscentral.dynamics.com/v2.0/%1/api/microsoft/automation/v2.0/companies(%2)/extensions';
        FalseLbl: Label 'false';
        FilterMSAppsLbl: Label '?$filter=publisher ne ';
        GrantTypeLbl: Label 'grant_type=client_credentials';
        IsInstalledLbl: Label 'isInstalled';
        PackageIdLbl: Label 'packageId';
        ProcessFinishMsg: Label 'The tables have been updated correctly.', comment = 'ESP="Las tablas se han actualizado correctamente."';
        PublishedAsLbl: Label 'publishedAs';
        PublisherLbl: Label 'publisher';
        ReadingJsonErr: Label 'Error reading JSON response.', comment = 'ESP="Error al leer la respuesta JSON."';
        ScopeLbl: Label '&scope=https://api.businesscentral.dynamics.com/.default';
        UnableToCommunicateWSErr: Label 'Unable to communicate with the web service.', comment = 'ESP="No se puede comunicar con el servicio web."';
        UrlencodedLbl: Label 'application/x-www-form-urlencoded';
        ValueJsonArryLbl: Label 'value';
        WSStatusCodeErr: Label 'Error - Status code: %1  Description: %2', comment = 'ESP="Error - Código: %1  Descripción: %2"';
}