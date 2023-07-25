/// <summary>
/// Codeunit "FillingProTablesMock_ANJ" (ID 99993).
/// </summary>
codeunit 99993 FillingProTablesMock_ANJ implements FillingProcessingTables_ANJ
{
    Access = Internal;

    /// <summary>
    /// GetExtensions.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetExtensions(): Text;
    var
        ExtensionArry: JsonArray;
        AuxJsonObject: JsonObject;
        Extensions: Text;
    begin
        AddNewExtensionToJsonArry(
            ExtensionArry,
            Ext01IDLbl,
            Ext01NameLbl,
            Ext01PublisherLbl,
            ScopeLbl);

        AddNewExtensionToJsonArry(
            ExtensionArry,
            Ext02IDLbl,
            Ext02NameLbl,
            Ext02PublisherLbl,
            ScopeLbl);

        AuxJsonObject.Add(ValueLbl, ExtensionArry);
        AuxJsonObject.WriteTo(Extensions);

        exit(Extensions);
    end;

    /// <summary>
    /// GetRelations.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetRelations(): Text;
    var
        RelationsArry: JsonArray;
        Relations: Text;
    begin
        AddNewRelationToJsonArry(RelationsArry,
        Ext01IDLbl,
        Ext02IDLbl);
        RelationsArry.WriteTo(Relations);

        exit(Relations);
    end;

    /// <summary>
    /// AddNewExtensionToJsonArry.
    /// </summary>
    /// <param name="ExtensionArry">VAR JsonArray.</param>
    /// <param name="PackageId">Text.</param>
    /// <param name="DisplayName">Text.</param>
    /// <param name="Publisher">Text.</param>
    /// <param name="PublishedAs">Text.</param>
    internal procedure AddNewExtensionToJsonArry(
        var ExtensionArry: JsonArray;
        PackageId: Text;
        DisplayName: Text;
        Publisher: Text;
        PublishedAs: Text);
    var
        ExtensionJsonObject: JsonObject;
    begin
        ExtensionJsonObject.Add(IdLbl, PackageId);
        ExtensionJsonObject.Add(PackageIdLbl, PackageId);
        ExtensionJsonObject.Add(DisplayNameLbl, DisplayName);
        ExtensionJsonObject.Add(PublisherLbl, Publisher);
        ExtensionJsonObject.Add(PublishedAsLbl, PublishedAs);
        ExtensionJsonObject.Add(IsInstalledLbl, true);

        ExtensionArry.Add(ExtensionJsonObject);
    end;

    /// <summary>
    /// AddNewRelationToJsonArry.
    /// /// </summary>
    /// <returns>Return variable NewRelationsLine of type Integer.</returns>
    local procedure AddNewRelationToJsonArry(
          var RelationsArry: JsonArray;
          SourceAppID: Guid;
          DestinationAppID: Guid);
    var
        RelationJsonObject: JsonObject;
    begin
        RelationJsonObject.Add(SourceAppIDLbl, SourceAppID);
        RelationJsonObject.Add(DestinationAppIDLbl, DestinationAppID);

        RelationsArry.Add(RelationJsonObject);
    end;

    var
        DestinationAppIDLbl: Label 'DestinationAppID';
        DisplayNameLbl: Label 'displayName';
        Ext01IDLbl: Label 'a1f81352-6244-48a4-96a0-a81c5aaaa581';
        Ext01NameLbl: Label 'Take Order Sample';
        Ext01PublisherLbl: Label 'BusinessCentralDemos';
        Ext02IDLbl: Label '3c9a4c22-42f6-4e8f-8b96-744c7fef331f';
        Ext02NameLbl: Label 'Dependency-Graph';
        Ext02PublisherLbl: Label 'ANJ';
        IdLbl: Label 'id';
        IsInstalledLbl: Label 'isInstalled';
        PackageIdLbl: Label 'packageId';
        PublishedAsLbl: Label 'publishedAs';
        PublisherLbl: Label 'publisher';
        ScopeLbl: Label 'PTE';
        SourceAppIDLbl: Label 'SourceAppID';
        ValueLbl: Label 'value';
}