workspace "PREME" "Documentación de intervenciones en territorio nacional" {
    model {
        // Usuarios
        personal = person "Personal de Campo"
        supervisor = person "Supervisor"
        administrador = person "Administrador"
        
        preme = softwareSystem "PREME" "Plataforma Nacional de Registro de Atenciones de Emergencia" {
            servicioRegistro = container "Servicio de Registro de Atenciones en Campo"
            servicioTransporte = container "Servicio de transporte del paciente"
            servicioMonitoreo = container "Servicio de Monitoreo y Supervisión"
            servicioReportes = container "Servicio de Reportes y Estadísticas"
            servicioSeguridad = container "Servicio de Seguridad, Acceso y Auditoría"
            servicioAdministracion = container "Servicio de Administración del Sistema"
            appMobile = container "Aplicación Móvil"
            appWeb = container "Aplicacion Web"
            db = container "Base de Datos" 
            apiGW = container "API Gateway"
        }
        
        // Sistemas Externos
        gcs = softwareSystem "Google Cloud Service"
        servicioGeoespacial = softwareSystem "Servicio de visualizacion Geoespacial"
        mailjet = softwareSystem "MailJet"
        auth = softwareSystem "oAuth 2.0"
        
        // Direcciones
        personal -> appMobile "usa"
        supervisor -> appWeb "usa"
        administrador -> appWeb "usa"
        
        appMobile -> apiGW "registra datos y acciones"
        appWeb -> apiGW "consulta informacion y alertas"
        
        apiGW -> servicioRegistro "utiliza"
        apiGW -> servicioTransporte "utiliza"
        apiGW -> servicioMonitoreo "utiliza"
        apiGW -> servicioReportes "utiliza"
        apiGW -> servicioSeguridad "utiliza"
        apiGW -> servicioAdministracion "utiliza"
        
        servicioRegistro -> db "almacena informacion automáticamente"
        servicioTransporte -> db "almacena registros"
        servicioReportes -> db "almacena reportes automaticos"
        servicioSeguridad -> db "almacena intentos de acceso y auditorias"
        servicioReportes -> gcs "Exporta reportes en PDF / Excel"
        servicioMonitoreo -> servicioGeoespacial "Muestra ubicaciones"
        servicioMonitoreo -> mailJet "Envia alertas por correo"
        
        auth -> servicioSeguridad "autenticación y permisos"
        db -> gcs "almacena respaldo"
    }
    
    views {
        container preme "Contenedores" "Vista de contenedores del sistema" {
            include *
            autolayout
        }
        
        styles {
            element "Person" {
                shape "Person"
                background "#5564eb"
                color "#ffffff"
            }
            element "Container" {
                shape "RoundedBox"
                background "#2c5545"
                color "#ffffff"
            }
        }
    }
}