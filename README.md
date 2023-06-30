# Dependency Graph 
[![in](https://img.shields.io/badge/lang-en-pink.svg)](https://github.com/NovoaDev/Dependency-Graph-BCExt/blob/main/README.md)
[![en](https://img.shields.io/badge/lang-es-black.svg)](https://github.com/NovoaDev/Dependency-Graph-BCExt/blob/main/README.es-ES.md)

Small tool designed to create a graph showing installed extensions and their respective dependencies, all from the **Business Central** environment in which the extension is running. In addition, it allows you to preview and download the generated text to easily add it to the client's documentation in Markdown format. <br> <br>
**PS:** <br>
Although there are numerous more advanced tools available, this one has been created for the simple purpose of practice, but it could prove useful for other users.

## Prerequisites
### Azure
#### Create App registrations
**Supported account types:** <br>
Organization accounts only. <br>
**Redirect URI:** <br>
"Web" https://businesscentral.dynamics.com/OAuthLanding.htm <br>
![PortalAzure001](/res/PortalAzure001.png)

#### Create Client Secret
![PortalAzure002](/res/PortalAzure002.png)

#### Assign API permissions (With Administrator consent) 
API. ReadWrite.All <br>
Automation.ReadWrite.All <br>
![PortalAzure003](/res/PortalAzure003.png)

### Business Central
Create new record in **Azure Active Directory Applications** Indicating the application ID created in Azure. <br>
Add **D365 AUTOMATION** and **EXTEN MGT. -ADMIN** to user permission sets. <br>
Change status to **Enabled** <br>
**Grant consent** <br>
![1AADBC](/res/1AADBC.png)

## Dependency Graph Settings page
![2DGSetup](/res/2DGSetup.png)

- App registrations - **Azure** <br>
Configuration of the **Azure** Registry ID required for operation.

- App shapes inside the diagram <br>
Select which shape an application will be represented by its scope.

- Include when generating the graph <br>
Features to include for chart generation: <br>
    - Microsoft applications. 
    - Link text between dependencies.

- Last time it was generated <br>
Historical.

- Dependency graph <br>
Action to access the data generation page for the graph.

## Show in dependency graph page
![3ShowInDG](/res/3ShowInDG.png)
### Extensions subpage 
List of installed extensions. We can modify the field **Display name** and **Show in chart**. Every time we uncheck the **Show in graph** option of an extension with dependencies, we will have to generate the data from the relationship table again. This is done by the action on the subpage named **Update Relationship Table**.

### Relationships subpage
List of relationships between extensions. We can modify the **Link text** field to add a text between dependencies and **Show in graphic**.

### Actions
#### Generate data
The button generates the data in the intermediate tables that are related to the subpages corresponding to the **extensions** and **relationships** sections. These tables are the ones we will use to customize the graph.
### Display dependency graph
The button will open a new page where we can see the graph as a draft. 
![4DGV.png](/res/4DGV.png)

### Download Markdown as a .md
The button will download an .md file with the content of the chart, which you can easily add to any document.
![5DPDownload](/res/5DPDownload.png)

**Note:** <br>
Both for the action of viewing and downloading the graph, it will be generated using the data found in the extensions and relationships subpages, which must be marked with the Show in graph option.