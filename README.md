# Dependency Graph 
Small tool designed to create a graph showing installed extensions and their respective dependencies, all from the **Business Central** environment in which the extension is running. In addition, it allows you to preview and download the generated text to easily add it to the client's documentation in Markdown format. <br> <br>
**Usage video:** <br> 
https://youtu.be/PsgThQVQAw4 <br> <br>
Very proud to be on Stefan Maron's Open Source Business Central Applications list: <br>
https://stefanmaron.com/opensourcealprojects/ <br><br>
**PS:** <br>
Although there are numerous more advanced tools available, this one has been created for the simple purpose of practice, but it could prove useful for other users.

## Usage
![Usage.gif](/res/Usage.gif)

## Previous configuration
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
