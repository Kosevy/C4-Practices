workspace "Caso UBER" "Proveedor de servicios de movilización" {


    model {
        cliente = person "Cliente" "Usuario que toma los servicios de UBER"
        conductor = person "Conductor" "Usuario conductor que ofrece los servicios de transporte de UBER"
        operador = person "Operador" "Supervisa actividades de conductores"
        uber = softwareSystem "UBER" "Servicio de transporte de pasajeros" {
            appOperadores = container "Activación Personal" "Python"
            appPasajeros = container "APP Pasajeros" "Java y Scala"
            appConductores = container "APP Conductores" "Java y Scala"
            
            apiGW = container "API GATEWAY"
            
            servicioRiders = container "Riders" "Gestión demanda"
            servicioCabs = container "Cabs" "Gestión oferta"
            servicioDisco = container "Disco" "Despacho operacional"
            servicioS3 = container "S3" "Indice jerárquico"
            
            apacheKafka = container "Kafka"
            mongoDB = container "MongoDB" 
            cassandra = container "Cassandra"
            mySQL = container "MySQL"
            seguridad = container "seguridad" {
                log1 = component "Seguimiento de API http"
                log2 = component "Uso de perfil de usuarios"
                log3 = component "Recolección de feedback y comentarios"
                log4 = component "Promoción de cupones"
                log5 = component "Detección de fraude"
                log6 = component "Fraude de pagos"
                log7 = component "Abuso de conductores"
                log8 = component "Seguimiento histórico de cuentas comprometidas por hackers"
            }
        }
        servicioPago = softwareSystem "Servicios de Pago" "Paypal MasterCard Visa"
        servicioGoogle = softwareSystem "Google Maps" "Servicios de geocalización Google"
        
        // context
        cliente -> uber "Solicita servicios de transporte" "WEB"
        conductor -> uber "atiende servicios de transporte" "WEB"
        operador -> uber "Monitorea estado y actividades" "WEB"
        
        servicioPago -> uber "registra pagos" "WEB"
        uber -> servicioGoogle "lee datos de geocalización"
        
        //container
        operador -> appOperadores "utiliza"
        cliente -> appPasajeros "utiliza"
        conductor -> appConductores "utiliza"
        
        appOperadores -> apiGW "usa"
        appPasajeros -> apiGW "usa"
        appConductores -> apiGW "usa"
        
        apiGW -> servicioRiders "usa"
        apiGW -> servicioCabs "usa"
        apiGW -> servicioDisco "usa"
        
        servicioRiders -> apacheKafka "almacena"
        servicioCabs -> apacheKafka "almacena"
        servicioDisco -> servicioS3 "utiliza"
        servicioDisco -> mySQL "lee y escribe"
        servicioS3 -> cassandra "lee y escribe"
        apacheKafka -> mongoDB "lee y escribe"
        
        servicioPago -> servicioDisco "registra pagos"
        servicioS3 -> servicioGoogle "utiliza"
        
        //component
        
        apiGW -> log1 "usa"
        log1 -> log2 "usa"
        log1 -> log3 "usa"
        log1 -> log4 "usa"
        log1 -> log5 "usa"
        log1 -> log6 "usa"
        log1 -> log7 "usa"
        log1 -> log8 "usa"
    }
    
    views {
        systemContext uber "Contexto" "Diagrama de contexto" {
            include cliente
            include conductor
            include operador
            include uber
            include servicioPago
            include servicioGoogle
        }
        
        container uber "Contenedores" "Vista de contenederos UBER" {
            include cliente
            include conductor
            include operador
            include uber
            include servicioPago
            include servicioGoogle
            include appOperadores
            include appPasajeros
            include appConductores
            include apiGW
            include servicioRiders
            include servicioCabs
            include servicioDisco
            include servicioS3
            include apacheKafka
            include mongoDB
            include cassandra
            include mySQL
        }
        
        component seguridad "Componentes" "Vista de componentes" {
            include *
        }
    
        styles {
            element "Person" {
                shape "Person"
                background "#232ecd"
                color "#ffffff"
            }
            element "Conductor" {
                shape "Person"
                background "#3412de" 
                color "#ffffff" 
            }
        }
    }
    
    
    configuration {
        scope softwaresystem
    }

}