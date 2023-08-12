/// <summary>
/// Codeunit "JSONMethods_ANJ" (ID 80813).
/// </summary>
codeunit 80813 JSONMethods_ANJ
{
    Access = Internal;

    /// <summary>
    /// PopulateJsonValue.
    /// </summary>
    /// <param name="JsonKey">Text.</param>
    /// <param name="ResponseText">Text.</param>
    /// <returns>Return value of type Boolean.</returns>
    internal procedure GetJsonValue(JsonKey: Text; ResponseText: Text): Text;
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

    var
        ReadingJsonErr: Label 'Error reading JSON response.';
}