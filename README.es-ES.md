# Dependency Graph BCExt
[![en](https://img.shields.io/badge/lang-en-pink.svg)](https://github.com/NovoaDev/Dependency-Graph-BCExt/blob/main/README.md)
[![es](https://img.shields.io/badge/lang-es-black.svg)](https://github.com/NovoaDev/Dependency-Graph-BCExt/blob/main/README.es-ES.md)

Pequeña extensión creada por curiosidad, para practicar y probar cosas, al mismo tiempo que soluciono un "problema" que enfrento diariamente en el trabajo: saber qué dependencias tiene cada entorno de cada cliente y añadir el gráfico al markdown. Es posible que existan muchas soluciones mejores.

## Prerrequisitos
- Crear Registro de Aplicación en Azure
    - Tipos de cuenta compatibles: Solo cuentas de la organización.
    - URI de redirección: "Web" https://businesscentral.dynamics.com/OAuthLanding.htm.
    - Crear Secreto de Cliente
    - Permisos de API (Con consentimiento del Administrador)
        - API.ReadWrite.All
        - Automation.ReadWrite.All

- Configurar nuevo registro en Aplicaciones de Azure Active Directory de Business Central.
    - Agregar conjuntos de permisos de usuario
        - D365 AUTOMATION
        - EXTEN. MGT. - ADMIN
    - Cambiar estado a activado
    - Conceder consentimiento.

![1AADBC](/res/1AADBCes-ES.png)

## Pantalla de configuración
Accederemos a la página **Configuración del gráfico de dependencia** en Business Central. <br>
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
Acción para acceder a la pantalla de generación de datos para el gráfico.

## Pantalla Mostrar en gráfico de dependencia
![3ShowInDG](/res/3ShowInDGes-ES.png)

### Generar datos
Genera los datos en las tablas intermedias donde se podrá personalizar el gráfico. Rellenará las subpartes de extensiones y relaciones.

### Accion
### Visualizar gráfico de dependencia
Se abrirá una nueva página donde podremos ver el gráfico como borrador. El gráfico se generará con los datos que se encuentren en las subpartes marcadas con el booleano "mostrar en gráfico".

![4DGV.png](/res/4DGV.png)

### Descargar Markdown como un .md
Descargará un archivo .md con el contenido del gráfico para agregarlo fácilmente a cualquier documento.

![5DPDownload](/res/5DPDownload)

**Nota:** <br>
Tanto para la acción de visualizar como para descargar el gráfico, se generará con los datos que se encuentren en las subpartes marcadas con el booleano "mostrar en gráfico".

#### Subparte Extensiones 
Lista de extensiones instaladas. Podremos modificar el campo Nombre para mostrar y el booleano mostrar en gráfico. Cada vez que quitemos la opción de mostrar en gráfico de una extensión con dependencias, tendremos que generar nuevamente los datos de la tabla de relaciones. Esto se realiza desde la acción del subformulario llamada Actualizar la tabla de relaciones.

#### Subparte Relaciones
Lista de relaciones entre extensiones. Podremos modificar el campo Texto de enlace para agregar un texto entre dependencias y el booleano mostrar en gráfico.