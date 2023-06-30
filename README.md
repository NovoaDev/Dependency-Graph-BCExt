# Dependency Graph BCExt
[![en](https://img.shields.io/badge/lang-en-pink.svg)](https://github.com/NovoaDev/Dependency-Graph-BCExt/blob/main/README.md)
[![es](https://img.shields.io/badge/lang-es-black.svg)](https://github.com/NovoaDev/Dependency-Graph-BCExt/blob/main/README..md)

Small extension created out of curiosity, for practice and experimentation, while simultaneously solving a "problem" I face every day at work: knowing the dependencies of each client's environment and adding the graph to the markdown, among other things. There may be many better solutions available.

## Prerequisites
- Create Application Registration in Azure
    - Supported account types: Only organization accounts.
    - Redirect URI: "Web" https://businesscentral.dynamics.com/OAuthLanding.htm.
    - Create Client Secret
    - API Permissions (With Administrator Consent)
        - API.ReadWrite.All
        - Automation.ReadWrite.All

- Configure new registration in Azure Active Directory Applications for Business Central.
    - Add user permission sets
        - D365 AUTOMATION
        - EXTEN. MGT. - ADMIN
    - Change status to enabled
    - Grant consent.

![1AADBC](/res/1AADBC.png)

## Settings screen
We'll take you to the  **Dependency Graph Settings** page  in Business Central. <br>
![2DGSetup](/res/2DGSetup.png)
- App registrations - **Azure** <br>
Configuration of the  **Azure** Registry ID  required for operation.

- App shapes inside the diagram <br>
Select which shape an application will be represented by its scope.

- Include when generating the graph <br>
Features to include for chart generation: <br>
    - Microsoft applications. 
    - Link text between dependencies.

- Last time it was generated <br>
Historical.

- Dependency graph <br>
Action to access the data generation screen for the chart.

## Show In Dependency Graph screen
![3ShowInDG](/res/3ShowInDG.png)

### Generate data
Generate data in intermediate tables where the graph can be customized. It will populate the subparts of extensions and relationships.

### Accion
### Display dependency graph
A new page will open where we can see the graph as a draft. The graph will be generated using data from the subparts marked with the "show in graph" boolean.

![4DGV.png](/res/4DGV.png)

### Download Markdown as .md
Download a .md file with the graph content for easy integration into any document.

**Note:** <br>
Both for the action of viewing and downloading the graph, it will be generated using data from the subparts marked with the "show in graph" boolean.

#### Subpart Extensions 
List of installed extensions. We can modify the Display Name field and the show in graph boolean. Whenever we remove the option to show an extension with dependencies in the graph, we will need to regenerate the data in the relationships table. This can be done through the action in the subform called Update relationships table.

#### Subpart Relationships
List of relationships between extensions. We can modify the Link Text field to add text between dependencies and the show in graph boolean.