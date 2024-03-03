/// <summary>
/// Codeunit "WSAndMDInfoImp_ANJ" (ID 80812) implements Interface FillingProcessingTables_ANJ.
/// </summary>
namespace ANJ.Tools.Graph;
codeunit 80812 WSAndMDInfoImp_ANJ implements FillingProcessingTables_ANJ
{
    Access = Internal;

    /// <summary>
    /// GetExtensions.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetExtensions(): Text
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
    local procedure GetAccessToken(): Text
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
        exit(JSONMethods.GetJsonValue(AccessTokenLbl, ResponseText));
    end;

    /// <summary>
    /// GetRequestAccessTokenContent.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    local procedure GetRequestAccessTokenContent(): Text
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
    local procedure GetAccessTokenAPIUrl(): Text
    begin
        exit(StrSubstNo(AccessTokenUrlLbl, GetTenantId()));
    end;

    /// <summary>
    /// GetTenantId.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    local procedure GetTenantId(): Text
    begin
        exit(AzureADTenant.GetAadTenantId());
    end;

    /// <summary>
    /// DoGetExtensions.
    /// </summary>
    /// <param name="AccessToken">Text.</param>
    /// <returns>Return value of type Text.</returns>
    local procedure DoGetExtensions(AccessToken: Text): Text
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
    local procedure GetExtensionsAPIUrl(): Text
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
    local procedure GetEnvironmentName(): Text
    var
        EnvironmentInformation: Codeunit "Environment Information";
    begin
        exit(EnvironmentInformation.GetEnvironmentName());
    end;

    /// <summary>
    /// GetCompanyId.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    local procedure GetCompanyId(): Text
    var
        Company: Record Company;
    begin
        Company.SetLoadFields(Id);
        Company.Get(CompanyName());

        exit(Format(Company.Id, 0, 4).ToLower());
    end;

    /// <summary>
    /// GetResponseMessageText.
    /// </summary>
    /// <param name="ResponseHttpResponseMessage">VAR HttpResponseMessage.</param>
    /// <param name="ResponseText">VAR Text.</param>
    local procedure GetResponseMessageText(var ResponseHttpResponseMessage: HttpResponseMessage; var ResponseText: Text)
    begin
        ResponseHttpResponseMessage.Content().ReadAs(ResponseText);
        if not ResponseHttpResponseMessage.IsSuccessStatusCode() then
            Error(WSStatusCodeErr, ResponseHttpResponseMessage.HttpStatusCode(), ResponseText);
    end;

    /// <summary>
    /// GetRelations.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetRelations() JsonText: Text
    var
        Extensions: Record Extensions_ANJ;
        RelationsArry: JsonArray;
    begin
        Extensions.SetLoadFields(AppID);
        Extensions.SetRange(ShowInGraph, true);
        if Extensions.FindSet(false) then
            repeat
                CheckDependencies(Extensions.AppID, RelationsArry);
            until Extensions.Next() = 0;
        RelationsArry.WriteTo(JsonText);
    end;

    /// <summary>
    /// CheckDependencies.
    /// </summary>
    /// <param name="AppId">Guid.</param>
    /// <param name="RelationsArry">VAR JsonArray.</param>
    local procedure CheckDependencies(AppId: Guid; var RelationsArry: JsonArray)
    var
        DestinationAppID: Guid;
        ModuleDependencyInfoList: List of [ModuleDependencyInfo];
        SingleModuleDependencyInfo: ModuleDependencyInfo;
        AuxModuleInfo: ModuleInfo;
    begin
        if not NavApp.GetModuleInfo(AppId, AuxModuleInfo) then
            exit;

        ModuleDependencyInfoList := AuxModuleInfo.Dependencies;

        foreach SingleModuleDependencyInfo in ModuleDependencyInfoList do begin
            DestinationAppID := SingleModuleDependencyInfo.Id;
            if CheckDestinationAppIDShowInGraph(DestinationAppID) then
                AddNewRelationToJsonArry(RelationsArry, AppId, DestinationAppID);
        end;
    end;

    /// <summary>
    /// AddNewRelationToJsonArry.
    /// </summary>
    /// <param name="RelationsArry">VAR JsonArray.</param>
    /// <param name="SourceAppID">Guid.</param>
    /// <param name="DestinationAppID">Guid.</param>
    local procedure AddNewRelationToJsonArry(var RelationsArry: JsonArray; SourceAppID: Guid; DestinationAppID: Guid)
    var
        RelationJsonObject: JsonObject;
    begin
        RelationJsonObject.Add(SourceAppIDLbl, SourceAppID);
        RelationJsonObject.Add(DestinationAppIDLbl, DestinationAppID);

        RelationsArry.Add(RelationJsonObject);
    end;

    /// <summary>
    /// CheckDestinationAppIDShowInGraph.
    /// </summary>
    /// <param name="AppID">Guid.</param>
    /// <returns>Return value of type Boolean.</returns>
    local procedure CheckDestinationAppIDShowInGraph(AppID: Guid): Boolean
    var
        Extensions: Record Extensions_ANJ;
    begin
        Extensions.SetRange(AppID, AppID);
        Extensions.SetRange(ShowInGraph, true);
        exit(not Extensions.IsEmpty());
    end;

    var
        AzureADTenant: Codeunit "Azure AD Tenant";
        JSONMethods: Codeunit JSONMethods_ANJ;
        AccessTokenLbl: Label 'access_token';
        AccessTokenUrlLbl: Label 'https://login.microsoftonline.com/%1/oauth2/v2.0/token';
        AuthorizationLbl: Label 'Authorization';
        AuthorizationValueLbl: Label 'Bearer %1';
        ClientIdLbl: Label '&client_id=%1';
        ClientSecretLbl: Label '&client_secret=%1';
        ContentTypeLbl: Label 'Content-Type';
        DestinationAppIDLbl: Label 'DestinationAppID';
        ExtensionsUrlLbl: Label 'https://api.businesscentral.dynamics.com/v2.0/%1/api/microsoft/automation/v2.0/companies(%2)/extensions';
        FilterMSAppsLbl: Label '?$filter=publisher ne ';
        GrantTypeLbl: Label 'grant_type=client_credentials';
        ScopeLbl: Label '&scope=https://api.businesscentral.dynamics.com/.default';
        SourceAppIDLbl: Label 'SourceAppID';
        UnableToCommunicateWSErr: Label 'Unable to communicate with the web service.';
        UrlencodedLbl: Label 'application/x-www-form-urlencoded';
        WSStatusCodeErr: Label 'Error - Status code: %1  Description: %2';
}