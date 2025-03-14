
# Gestión de Inventario - IES Ntra. Sra. de la Victoria de Lepanto en español

## Descripción

Este proyecto es una **aplicación web** para gestionar de manera integral el **equipamiento, hardware, software y ubicaciones** de un centro educativo. Permite dar de alta, actualizar, listar y eliminar equipos, hardware, software, incidencias, mantenimiento, usuarios y ubicaciones.

## Requisitos

Para ejecutar este proyecto, necesitarás tener instalado lo siguiente:

- [Node.js](https://nodejs.org/es/) (Recomendado: versión LTS)
- [MySQL](https://www.mysql.com/downloads/)
- Un editor de texto como [Visual Studio Code](https://code.visualstudio.com/)

## Instalación

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/tu-usuario/inventareandolepanto.git

2. **Acceder a la carpeta del proyecto**:
    cd inventareandolepanto

3. **Instalar las dependencias**:
    npm install

4. **Configurar las variables de entorno**:
    En el fichero .env

    DB_HOST=localhost
    DB_USER=tu_usuario
    DB_PASSWORD=tu_contraseña
    DB_NAME=tu_base_de_datos
    SESSION_SECRET=tu_secreto

5. **Configurar la base de datos**:
    Importa la estructura de la base de datos desde el archivo sql en tu servidor MySQL.

## Uso

1. **Iniciar el servidor**:
    npm run dev o nodemon app_compacto.js

2. **Acceder a la aplicación**:
    http://localhost:3000

## Estructura del Proyecto

GESTIONINVENTARIO
│
├── public/
│   ├── css/                  # Archivos CSS
│   ├── img/                  # Imágenes
│   └── sql/                  # Base de datos inventario.sql (no incluida, carpeta si)
│
├── views/                    # Plantillas EJS (vistas)
│   ├── equipos/
│   ├── hardware/
│   ├── software/
│   ├── ubicaciones/
│   └── usuarios/
│
├── uploads/                  # Directorio para archivos subidos
├── .env                      # Archivo de variables de entorno (no incluido)
├── app.js                    # Configuración principal del servidor
├── package-lock.json         # Información de dependencias
└── package.json              # Información de dependencias

## Contribución

1. **Haz un fork del repositorio.**
2. **Clona tu fork**:
    git clone https://github.com/tu-usuario/inventareandolepanto.git

3. **Crea una rama para tu funcionalidad**:
    git checkout -b nombre-de-tu-rama

4. **Realiza tus cambios y haz commit**:
    git add .
    git commit -m "Descripción de los cambios"

5. **Haz push de tu rama**:
    git push origin nombre-de-tu-rama
6. **Abre un pull request en el repositorio original.**

## Licencia

Este proyecto está bajo la licencia MIT. Para más detalles, consulta el archivo `LICENSE`.

## Notas Adicionales

- **Usuarios y Roles:** El sistema cuenta con diferentes roles para usuarios, como administrador, tecnico y usuario estándar. El administrador tiene acceso completo a todas las funcionalidades, mientras que los tecnicos y usuarios estándar tienen un acceso limitado a las acciones de consulta y gestión de su propio perfil.

- **Importación de Datos:** El proyecto soporta la importación de datos a través de archivos CSV y XLS para el alta masiva de equipos, lo que permite agilizar la incorporación de información al sistema.

- **Seguridad:** Se implementa autenticación mediante sesiones y encriptación de contraseñas usando la librería bcrypt. Además, las rutas están protegidas con middleware de autorización que verifica los roles de los usuarios.

- **Compatibilidad Móvil:** La aplicación tiene un diseño responsivo básico, que permite su uso en dispositivos móviles. Aún se pueden realizar mejoras para optimizar la experiencia móvil.

- **Mensajería Instantánea:** Este proyecto utiliza socket.io para comunicación en tiempo real entre usuarios, con mysql2 para almacenar mensajes y bcrypt para autenticación segura. Express gestiona las conexiones y rutas necesarias, permitiendo una experiencia de mensajería rápida y confiable en la aplicación de inventario.

- **Archivos no incluidos:** Los archivos necesarios para la base de datos (inventario.sql) y .env deben ser creados o configurados manualmente antes de ejecutar el sistema. Asegúrate de tener el entorno adecuado para la base de datos.

- **Dependencias y Módulos:** Este proyecto utiliza módulos populares de Node.js como express, mysql2, multer, xlsx, entre otros. Es importante asegurarse de que todas las dependencias estén correctamente instaladas y actualizadas para el buen funcionamiento de la aplicación.

- **Modificaciones Futuras:** Está planificado mejorar la interfaz móvil, optimizar la carga de grandes cantidades de datos y añadir nuevas funcionalidades, ademas de añadir nuevas secciones para otros modulos del centro.

## ACTUALIZACIÓN 28/11/2024

- **Mejoras Realizadas:** Se ha mejorado la mensajería instantánea con **notificaciones**, se ha mejorado el **diseño** de los botones de filtrado, se añadió **ngrok** para la conexión de la aplicación a internet de forma temporal al iniciar la aplicación, y se ha añadido subida de fichero csv/xls en la sección de **usuarios**.

- **Nota sobre ngrok:** Se implementó **ngrok** para la conexión de la aplicación a internet de forma temporal al iniciar la aplicación. Si no se quiere utilizar ngrok, se debe comentar/eliminar las líneas **16, 1720 y 1726** del archivo `app_compacto.js`. Si se quiere desinstalar el módulo, usa el comando **npm uninstall ngrok**. En caso de que se quiera utilizar ngrok, se debe crear una cuenta en **ngrok.com** y generar un token de acceso.

## ACTUALIZACIÓN 03/12/2024

- **Mejoras Realizadas:** Se ha optimizado el listado de mantenimiento (equipos y hardware). Ahora, al listar, solo aparecerán los mantenimientos creados por el usuario. Los mantenimientos de otros usuarios no serán visibles hasta que se actualicen a los estados **completo**, **cancelado** o **eliminado**. Se ha añadido la base de datos original de la aplicación (la que se ha usado) y una base de datos actualizada hasta lo que se cree que es la 5ª forma normal (en caso de redundancia, mejorarla y normalizarla).

- **Mejoras por Implementar:**
1. **Añadir un historial de mantenimientos**: Registro de las intervenciones realizadas en un equipo o hardware.

2. **Normalizar la base de datos**: Estandarizarla para facilitar su mantenimiento y escalabilidad a la 5ª forma normal.

3. **Añadir más secciones a la base de datos y la aplicación**: Incorporar módulos como mecánica y biblioteca para una mejor gestión.

4. **Coordinar con la Comunidad de Madrid**: Implementar correos oficiales para que, al registrar una incidencia, se notifique al técnico o administrador. Además, cuando se programe un mantenimiento, enviar un correo al usuario que reportó la incidencia con detalles sobre su equipo.

5. **Mejorar el sistema de apertura de incidencias y gestión de equipos**: Asignar un equipo a cada usuario para que solo pueda reportar incidencias relacionadas con su propio equipo.

6. **Optimizar el diseño responsive**: Garantizar que la aplicación sea más adaptable a diferentes dispositivos (opcional/recomendado). También se propone mejorar el **diseño de las vistas** (opcional).

7. **Actualizar el sistema de mensajería instantánea**: Mejorar el diseño, agregar notificaciones con números, permitir responder a mensajes, entre otros. Se busca implementar funcionalidades similares a **WhatsApp**.

8. **Incrementar la seguridad**: Proponer mejoras en la protección de datos y accesos (opcional/recomendado).

# Inventory Management - IES Ntra. Sra. de la Victoria de Lepanto in english

## Description

This project is a **web application** for comprehensive management of the **equipment, hardware, software, and locations** within an educational center. It allows for registering, updating, listing, and deleting equipment, hardware, software, incidents, maintenance, users, and locations.

## Requirements

To run this project, you will need to have the following installed:

- [Node.js](https://nodejs.org/) (Recommended: LTS version)
- [MySQL](https://www.mysql.com/downloads/)
- A text editor like [Visual Studio Code](https://code.visualstudio.com/)

## Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/inventareandolepanto.git

2. **Access the project folder**:
    cd inventareandolepanto

3. **Install dependencies**:
    npm install

4. **Configure environment variables**:
    In the .env file

    DB_HOST=localhost  
    DB_USER=your_username  
    DB_PASSWORD=your_password  
    DB_NAME=your_database_name  
    SESSION_SECRET=your_secret  

5. **Set up the database**:
    Import the database structure from the SQL file to your MySQL server.

## Usage

1. **Start the server**:
    npm run dev or nodemon app_compacto.js

2. **Access the application**:
    http://localhost:3000

## Project Structure

GESTIONINVENTARIO  
│  
├── public/  
│   ├── css/                  # CSS files  
│   ├── img/                  # Images  
│   └── sql/                  # Database inventory.sql (not included, folder is)  
│  
├── views/                    # EJS templates (views)  
│   ├── equipos/  
│   ├── hardware/  
│   ├── software/  
│   ├── ubicaciones/  
│   └── usuarios/  
│  
├── uploads/                  # Directory for uploaded files  
├── .env                      # Environment variables file (not included)  
├── app.js                    # Main server configuration  
├── package-lock.json         # Dependency information  
└── package.json              # Dependency information  

## Contribution

1. **Fork the repository.**  
2. **Clone your fork**:
    git clone https://github.com/your-username/inventareandolepanto.git

3. **Create a branch for your feature**:
    git checkout -b your-branch-name

4. **Make your changes and commit**:
    git add .  
    git commit -m "Description of changes"

5. **Push your branch**:
    git push origin your-branch-name  
6. **Open a pull request in the original repository.**

## License

This project is licensed under the MIT license. For more details, see the `LICENSE` file.

## Additional Notes

- **Users and Roles:** The system has different user roles, such as administrator, technician, and standard user. The administrator has full access to all functionalities, while technicians and standard users have limited access to querying and managing their own profile.

- **Data Import:** The project supports data import through CSV and XLS files for bulk equipment registration, streamlining data entry into the system.

- **Security:** Session-based authentication and password encryption using bcrypt are implemented. Additionally, routes are protected with authorization middleware that checks user roles.

- **Mobile Compatibility:** The application features a basic responsive design, allowing it to be used on mobile devices. Further improvements can enhance the mobile experience.

- **Instant Messaging:** This project uses socket.io for real-time communication between users, with mysql2 for message storage and bcrypt for secure authentication. Express manages the necessary connections and routes, enabling fast and reliable messaging within the inventory application.

- **Excluded Files:** The files required for the database (inventory.sql) and .env must be created or configured manually before running the system. Ensure you have the appropriate database environment.

- **Dependencies and Modules:** This project uses popular Node.js modules such as express, mysql2, multer, and xlsx, among others. It is important to ensure that all dependencies are correctly installed and updated for optimal application performance.

- **Future Modifications:** Plans include improving the mobile interface, optimizing the loading of large data sets, and adding new functionalities, as well as adding new sections for other modules within the center.

## UPDATE 11/28/2024

- **Improvements Made:** Instant messaging with **notifications** has been improved, the **design** of the filter buttons has been enhanced, **ngrok** has been added for temporarily connecting the application to the internet upon startup, and the upload of csv/xls files has been added in the **users** section.

- **Note about ngrok:** **Ngrok** has been implemented to temporarily connect the application to the internet upon startup. If you do not want to use ngrok, you should comment out/delete lines **16, 1720, and 1726** in the `app_compacto.js` file. If you wish to uninstall the module, use the command **npm uninstall ngrok**. To use ngrok, you need to create an account on **ngrok.com** and generate an access token.

## UPDATE 12/03/2024

- **Improvements Made:** The maintenance listing (equipment and hardware) has been optimized. Now, only maintenances created by the user will appear in the list. Maintenances of other users will not be visible until their status is updated to **completed**, **canceled**, or **deleted**. The original database of the application has been added (the one currently in use), along with an updated database that is believed to be in the 5th normal form (if any redundancy is found, it will be improved and normalized).

- **Improvements to Implement:**
1. **Add a maintenance history**: Record of interventions performed on equipment or hardware.

2. **Normalize the database**: Standardize it to improve maintenance and scalability (5NF).

3. **Add more sections to the database and the application**: Incorporate modules such as mechanics and library for better management.

4. **Coordinate with the Community of Madrid**: Implement official emails to notify technicians or administrators when an issue is reported. Additionally, when a maintenance task is scheduled, send an email to the user who reported the issue with details about their equipment.

5. **Improve the incident reporting system and equipment management**: Assign a device to each user so they can only report incidents related to their own equipment.

6. **Optimize responsive design**: Ensure the application is more adaptable to different devices (optional/recommended). Also, improve the **view designs** (optional).

7. **Update the instant messaging system**: Improve the design, add notifications with numbers, allow replying to messages, among other features. Implement functionalities similar to **WhatsApp**.

8. **Increase security**: Propose improvements in data protection and access control (optional/recommended).
