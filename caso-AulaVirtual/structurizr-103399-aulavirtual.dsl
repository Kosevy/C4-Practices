workspace "Aula Virtual" "Entonrno de colaboracion alumno docente" {

    model {
    alumno = person   "alumno"  "usuario que consulta material del curso"
    docente = person "docente"  " usuario que publica material"
    supervisor = person "supervisor"  "supervisa el contenido del aula"  "Super"
    aula  =  softwareSystem  "Aula"   "Entorno virtual de colaboracion Blackboard"  {
        webapp  = container  "App web"   "Interfase del aula"  "java 9 jsf"
        Collaborate  = container "Colaborate"   "Sesion virtual"   {
            ultra = component  "Ultra"  "interfase ultra"
            chat = component  "Chat" "Sesion de chat"
            pantalla = component  "pantalla"  "Compartir pantalla"
            encuesta = component   "encuesta"   "realizar sondeos"
            video = component       "video"     "sesion virtual"
            conector  = component  "conector"  "conector a BD oracle"
        }
        Evaluaciones  = container "Evaluaciones"   " examenes virtuales"
      Material  = container   "Material"   "material del curso"
      Integrantes  = container  "Integrantes"  "Alumnos y docentes del curso "
      BD = container  "Base de datos"  "Base de datos "  "Oradle 19 C  1521"  "Oracle"
         
        
        
    }
    socrates = softwareSystem  "Socrates"  "Sistema academico"
    
    alumno -> aula   "lee material"
    docente  -> aula "publica material "
    supervisor -> aula   "supervisando"
    aula -> socrates  "lee info"
    
    alumno  -> webapp  "ingresa"
    docente -> webapp "ingresa"
      supervisor -> webapp "ingresa"
    webapp -> Evaluaciones  "usa"
    webapp -> Material  "usa"
    webapp -> Collaborate  "usa"
     webapp -> Integrantes  "usa"
     Evaluaciones -> BD  "lee y escribe"
     Material -> BD  "lee y escribe"
    Collaborate -> BD  "lee y escribe"
    Integrantes -> BD  "lee y escribe"
    
    
   ultra  -> chat  "usa"
    ultra  -> pantalla  "usa"
    ultra  -> encuesta  "usa"
    ultra  -> video  "usa"
    
    conector -> BD  "conecta"
     webapp  -> ultra "usa"
    chat -> conector "usa"
      pantalla -> conector "usa"
       encuesta -> conector "usa"
          video -> conector "usa"
    
   
    }
            
         
            
     views {
     systemContext  aula {
         include *
      
     }
     container    aula {
         include *
     }
     
     component  Collaborate   "Componente"{
          include *
     }
     
     
     styles {
     element "Oracle" {
                shape "Cylinder" 
                background "#ec0e0e" 
                color "#ffffff" 
            }
     
     element "Super" {
                shape "Robot" 
                background "#26cf48" 
                color "#ffffff" 
            }
     
     }
     
     
        theme default
    }   
        
        
        

}