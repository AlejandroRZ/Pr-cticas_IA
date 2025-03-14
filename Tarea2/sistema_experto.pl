% Tarea 2 - Mini sistema experto
% Javier Alejandro Rivera Zavala - 311288876
% Profesores: Manuel Cristóbal López Michelone, Yessica Martínez Reyes y César Hernández Reyes Solís
% Para correr la práctica se utiliza la consulta 'go.'
% Utilice SWI-Prolog 9.0.4 para Linux x86_64.

go :- hypothesize(Mascota), write('Tu mascota puede ser un: '), write(Mascota), nl, undo.

%Hipótesis a ser probadas 
hypothesize(perro) :- perro, !. 
hypothesize(gato) :- gato, !. 
hypothesize(canario) :- canario, !. 
hypothesize(pez) :- pez, !. 
hypothesize(conejo) :- conejo, !. 
hypothesize(desconocido).

%Reglas de identificación de mascotas 
perro :- mamifero, verify(ladra), verify(es_amistoso).
gato :- mamifero, verify(maulla), verify(es_huragno). 
canario :- ave, verify(puede_volar), verify(tiene_color_amarillo). 
pez :- acuatico, verify(vive_en_agua), verify(es_pequegno). 
conejo :- mamifero, verify(come_verduras), verify(tiene_orejas_largas). 

%Reglas de clasificación taxonomicas  
mamifero :- verify(tiene_pelo), !. 
mamifero :- verify(amamanta). 
ave :- verify(tiene_plumas), !. 
ave :- verify(puede_volar), 
       verify(pone_huevos). 
acuatico :- verify(vive_en_agua), !. 

%Cómo hacer preguntas  
ask(Pregunta) :- 
        write('¿La mascota : '), 
        write(Pregunta), write('? '), 
         read(Respuesta), nl, 
         ( (Respuesta == si ; Respuesta == s) 
         -> assert(si(Pregunta)) ; 
         assert(no(Pregunta)), fail). 
:- dynamic si/1, no/1. 

%Cómo verificar algo  
verify(Caracteristica) :- (si(Caracteristica) -> true ; (no(Caracteristica) -> fail ; ask(Caracteristica))). 

%Deshacer todas las afirmaciones de sí/no 
undo :- retract(si(_)),fail. 
undo :- retract(no(_)),fail. 
undo.