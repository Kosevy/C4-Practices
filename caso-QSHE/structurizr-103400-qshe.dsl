workspace "Sistema QSHE" "Control de incidentes medioambientales" {

    !impliedRelationships "false" 
    !identifiers "hierarchical" 

    model {
        RepresentanteLegal = person "Representante Legal" "Representa legalmente a la empresa" "Representante" 
        Supervisor = person "Supervisor" "Supervisa el incidente" "Supervisor" 
        MedicoTratante = person "Medico Tratante" "Medico que atiende accidente" "Medico" 
        QSHE = softwareSystem "QSHE" "Sistema de Calidad, Seguridad, Medioambiente" "QSHE" {
            BD = container "BD" "Base de datos" "Oracle 12C 1521" "Oracle" 
            ServidorApps = container "Servidor Apps" "Wildlfy 18" "JEE 8080" "Wildlfy" {
                Motordeflujo = component "Motor de flujo" "" "Java  EE" "Componente" 
                GestordeFormularios = component "Gestor de Formularios" "Formularios" "Java JEE" "Componente" 
                WebService = component "Web Service" "WS Incidente" "REST" "rest" 
                ConectorExterno = component "Conector Externo" "OEFA-OSINERGMIN" "" "Componente" 
                ConectorBD = component "Conector BD" "Conector BD" "" "Componente" 
            }
            WebAPP = container "WebAPP" 
        }
        SistemadecontroldeRiesgosIndustriales = softwareSystem "Sistema de control de Riesgos Industriales" "Control se seguridad industrial" "SEGURIDAD" 
        OEFA = softwareSystem "OEFA" "Sistema de reporte de incidentes accidentes" "OEFA" 
        OSINERGMIN = softwareSystem "OSINERGMIN" "Supervisor" "OSINERGMIN" 
        MedicoTratante -> QSHE "Atiende accidente" "Web" 
        SistemadecontroldeRiesgosIndustriales -> QSHE "Actgualiza y hace seguimiento" "WEB" 
        QSHE -> OEFA "reporta" 
        QSHE -> OSINERGMIN "reporta" 
        QSHE.ServidorApps -> QSHE.BD "Lee y escribe" 
        MedicoTratante -> QSHE.WebAPP "Autoriza" 
        Supervisor -> QSHE.WebAPP "Actualiza" 
        RepresentanteLegal -> QSHE.WebAPP "Autoriza" 
        QSHE.ServidorApps -> OSINERGMIN "actualiza" 
        QSHE.ServidorApps -> OEFA "Actualiza" 
        SistemadecontroldeRiesgosIndustriales -> QSHE.ServidorApps "lee y actualiza" 
        QSHE.WebAPP -> QSHE.ServidorApps "Actualiza" 
        RepresentanteLegal -> QSHE "Encargado de representar legalmente a empresa" "WEB" 
        Supervisor -> QSHE "Reporta incidente accidente" "Web" 
    }

    views {
        systemContext QSHE "Contexto" "Diagrama de contexto" {
            include RepresentanteLegal 
            include Supervisor 
            include MedicoTratante 
            include QSHE 
            include SistemadecontroldeRiesgosIndustriales 
            include OEFA 
            include OSINERGMIN 
        }

        container QSHE "Contenedores" "Vista de contenedores QSHE" {
            include RepresentanteLegal 
            include QSHE.BD 
            include QSHE.ServidorApps 
            include Supervisor 
            include QSHE.WebAPP 
            include MedicoTratante 
            include SistemadecontroldeRiesgosIndustriales 
            include OEFA 
            include OSINERGMIN 
        }

        component QSHE.BD "Componente" {
            include RepresentanteLegal 
            include Supervisor 
            include QSHE.WebAPP 
            include MedicoTratante 
            include QSHE.ServidorApps.Motordeflujo 
            include QSHE.ServidorApps.GestordeFormularios 
            include QSHE.ServidorApps.WebService 
            include QSHE.ServidorApps.ConectorExterno 
            include QSHE.ServidorApps.ConectorBD 
            include SistemadecontroldeRiesgosIndustriales 
            include OEFA 
            include OSINERGMIN 
        }

        styles {
            element "Medico" {
                shape "Person" 
                background "#26cf48" 
                color "#ffffff" 
            }
            element "Oracle" {
                shape "Cylinder" 
                background "#ec0e0e" 
                color "#ffffff" 
            }
            element "Person" {
                shape "Person" 
                background "#232ecd" 
                color "#ffffff" 
            }
            element "QSHE" {
                shape "RoundedBox" 
                background "#d49816" 
            }
            element "Representante" {
                shape "Person" 
                background "#3412de" 
                color "#ffffff" 
            }
        }

    }

}