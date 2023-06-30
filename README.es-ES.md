# Dependency Graph 
[![en](https://img.shields.io/badge/lang-en-pink.svg)](https://github.com/NovoaDev/Dependency-Graph-BCExt/blob/main/README.md)
[![es](https://img.shields.io/badge/lang-es-black.svg)](https://github.com/NovoaDev/Dependency-Graph-BCExt/blob/main/README.es-ES.md)

Pequeña herramienta diseñada para crear un gráfico que muestra las extensiones instaladas y sus respectivas dependencias, todo ello desde el entorno de **Business Central** en el que se esté ejecutando la extensión. Además, permite previsualizar y descargar el texto generado para agregarlo fácilmente a la documentación del cliente en formato Markdown. <br> <br>
**PD:** <br>
Aunque existen numerosas herramientas más avanzadas disponibles, esta ha sido creada con el simple propósito de practicar, pero podría resultar útil para otros usuarios.

## Prerrequisitos
### Azure
#### Crear Registro de Aplicación 
**Tipos de cuenta compatibles:** <br>
Solo cuentas de la organización. <br>
**URI de redirección:** <br>
"Web" https://businesscentral.dynamics.com/OAuthLanding.htm <br>
![PortalAzure001](/res/PortalAzure001es-ES.png)

#### Crear Secreto de Cliente
![PortalAzure002](/res/PortalAzure002es-ES.png)

#### Asignar permisos de API (Con consentimiento del Administrador) 
API.ReadWrite.All <br>
Automation.ReadWrite.All <br>
![PortalAzure003](/res/PortalAzure003es-ES.png)

### Business Central
Crear nuevo registro en **Aplicaciones de Azure Active Directory** Indicando el ID de aplicación creado en Azure. <br>
Agregar conjuntos de permisos de usuario **D365 AUTOMATION** y **EXTEN. MGT. - ADMIN**. <br>
Cambiar estado a **activado** <br>
**Conceder consentimiento** <br>
![1AADBC](/res/1AADBCes-ES.png)

## Página configuración del gráfico de dependencia
![2DGSetup](/res/2DGSetupes-ES.png)
- Registros de aplicaciones - **Azure** <br>
Configuración del ID de Registro en **Azure** necesario para el funcionamiento.

- Figuras de las app dentro del diagrama <br>
Permite seleccionar con qué figura se representará una aplicación según su alcance.

- Incluir al generar el gráfico <br>
Características a incluir para la generación del gráfico: <br>
    - Aplicaciones de Microsoft. 
    - Texto enlace entre dependencias.

- Última vez que se generó <br>
Histórico.

- Gráfico de dependencia <br>
Acción para acceder a la página de generación de datos para el gráfico.

## Página mostrar en gráfico de dependencia
![3ShowInDG](/res/3ShowInDGes-ES.png)
### Subpágina Extensiones 
Lista de extensiones instaladas. Podremos modificar el campo **Nombre para mostrar** y **Mostrar en gráfico**. Cada vez que desmarquemos la opción **Mostrar en gráfico** de una extensión con dependencias, tendremos que generar nuevamente los datos de la tabla de relaciones. Esto se realiza mediante la acción de la subpágina llamada **Actualizar la tabla de relaciones**.

### Subpágina Relaciones
Lista de relaciones entre extensiones. Podremos modificar el campo **Texto de enlace** para agregar un texto entre dependencias y **Mostrar en gráfico**.

### Acciones
#### Generar datos
El botón genera los datos en las tablas intermedias que están relacionadas con las subpáginas correspondientes a las secciones de **extensiones** y **relaciones**. Estas tablas son las que utilizaremos para personalizar el gráfico.
### Visualizar gráfico de dependencia
El botón abrirá una nueva página donde podremos ver el gráfico como borrador. 
![4DGV.png](/res/4DGV.png)

### Descargar Markdown como un .md
El botón descargará un archivo .md con el contenido del gráfico, el cual podrás agregar fácilmente a cualquier documento.
![5DPDownload](/res/5DPDownload.png)

**Nota:** <br>
Tanto para la acción de visualizar como para descargar el gráfico, se generará utilizando los datos que se encuentren en las subpáginas extensiones y relaciones, las cuales deben estar marcadas con la opción Mostrar en gráfico.