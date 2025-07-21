workspace "TURBO" "Pedidos de Comestibles" {

    !impliedRelationships "false" 
    
    model {
        cliente = person "Cliente" "Solicita servicios de delivery" "Cliente"
        conductor = person "Conductor" "Transporta productos solicitados" "Conductor"
        operador = person "Operador" "Empleado encargado de enrolar y verificar a conductores, y brindar soporte." "Operador"
        aliado = person "Aliado" "Abastece los pedidos" "Aliado"
        TURBO = softwareSystem "TURBO" "pedidos de comestibles, medicamentos y más" "TURBO" {
            gestionTURBO = container "Gestion de TURBO" "Java y Scala"
            appClientes = container "AppClientes" "Java y Scala"
            appConductores = container "AppConductores" "Java y Scala"
            
            apiGW = container "API GATEWAY"
            
            servicioTURBO = container "Servicio TURBO" {
                log1 = component "Hacer un pedido"
                log2 = component "Limite de tiempo"
                log3 = component "Catalogo de productos demandados"
                log4 = component "Disponibilidad de servicio"
                log5 = component "Carrito de compras"
                log6 = component "Disposición de conductor"
                log7 = component "Costo de tarifa"
                log8 = component "Nivel de responsabilidad"
            }
            servicioDespacho = container "Servicio de Despacho"
            servicioPago = container "Canalizar Pago"
            servicioCache = container "Servicio de Cache"
            
            
            activeMQ = container "Active MQ"
            cassandra = container "Cassandra"
            mySQL = container "MySQL"
        }
        
        servicioPagoExterno = softwareSystem "Servicios de Pago" "Paypal MasterCard Visa"
        servicioGoogle = softwareSystem "Google Maps" "Actualiza la ubicación de conductores y clientes"
        
        //context
        
        cliente -> TURBO "Solicita productos"
        conductor -> TURBO "Recibe y entrega pedidos"
        operador -> TURBO "Gestionan enrolamiento y soporte"
        aliado -> TURBO "Prepara y entrega el pedido al conductor"
        
        servicioPagoExterno -> TURBO "Registra pagos"
        TURBO -> servicioGoogle "Utiliza"
        
        //container
        cliente -> appClientes "utiliza"
        conductor -> appConductores "utiliza"
        aliado -> gestionTURBO "utiliza"
        
        gestionTURBO -> apiGW "usa"
        appClientes -> apiGW "usa"
        appConductores -> apiGW "usa"
        
        apiGW -> servicioTURBO "usa"
        apiGW -> servicioDespacho "usa"
        apiGW -> servicioPago "usa"
        apiGW -> servicioCache "usa"
        
        servicioDespacho -> Cassandra "almacena información"
        servicioTURBO -> Cassandra "almacena información"
        servicioPago -> mySQL "guarda información"
        
        servicioPagoExterno -> servicioPago "envia"
        
        cassandra -> activeMQ "almacena pedido"
        mySQL -> activeMQ "almacena"
        
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
        systemContext TURBO "Contexto" "Diagrama de Contexto" {
            include conductor
            include cliente
            include operador
            include aliado
            include TURBO
            include servicioPagoExterno
            include servicioGoogle
        }
        
        container TURBO "Contenedores" "Vista de contenedores TURBO" {
            include conductor
            include cliente
            include aliado
            include TURBO
            include gestionTURBO
            include appClientes
            include appConductores
            include apiGW
            include activeMQ
            include servicioDespacho
            include servicioTURBO
            include servicioPago
            include servicioCache
            include cassandra
            include mySQL
            include servicioPagoExterno
        }
        
        component servicioTURBO "Componentes" "Vista de componentes" {
            include *
        }
        
        styles {
            element "Person" {
                shape "Person" 
                background "#232ecd" 
                color "#ffffff" 
            }
            element "Oracle" {
                shape "Cylinder" 
                background "#ec0e0e" 
                color "#ffffff" 
            }
            element "TURBO" {
                shape "RoundedBox"
                background "#d49816"
                color "#ffffff"
            }
            element "Element" {
                background #1168bd
                color #ffffff
                shape RoundedBox
            }
        }
    }
}