%Segundo ejercicio - Tarea1
%Inteligencia artificial - 2024-2
%Profesores: Manuel Cristóbal López Michelone, Yessica Martínez Reyes y César Hernández Solís.
%Alumno: Rivera Zavala Javier Alejandro - 311288876.


%Hechos

hombre(seniorProblema). %protagonista
hombre(papaSeniorP).	%padre del protagonista
hombre(hijitoSP).		%hijo más reciente del protagonista
mujer(senioraViuda).	%esposa del protagonista
mujer(hijaViuda).		%hija de la esposa del protagonista	
mujer(hijitaHVPSP).		%hija más reciente del padre del protagonista

progenitor(papaSeniorP, seniorProblema).
progenitor(senioraViuda, hijaViuda).
progenitor(senioraViuda, hijitoSP).
progenitor(seniorProblema, hijitoSP).
progenitor(hijaViuda, hijitaHVPSP).

pareja(seniorProblema, senioraViuda).
pareja(senioraViuda, seniorProblema).
pareja(hijaViuda, papaSeniorP).
pareja(papaSeniorP, hijaViuda).



%Reglas

%Están orientadas desde la izquierda, es decir, en la regla(X, Y) X es "tal cosa" de Y.

%Disclaimer: para no hacerme lios con los parentescos, de momento mis reglas y hechos siguen un esquema
%un tanto de familia de tradicional panista. El problema no requeria de extenderse mucho más, disculpen las molestias.

marido(X, Y) :-pareja(X, Y), hombre(X), X\==Y. 
esposa(X, Y) :-pareja(X, Y), mujer(X), X\==Y. 

padre(X, Y) :-progenitor(X, Y), hombre(X); marido(X, Z), progenitor(Z, Y).
madre(X, Y) :-progenitor(X, Y), mujer(X); esposa(X, Z), progenitor(Z, Y). 

hijo(Y, X) :-padre(X, Y), hombre(Y); madre(X, Y), hombre(Y).
hija(Y, X) :-padre(X, Y), mujer(Y); madre(X, Y), mujer(Y).

abuelo(X, Y) :-progenitor(M, Y), progenitor(X, M), hombre(X); nieto(Y, X), hombre(X); nieta(Y, X), hombre(X).
abuela(X, Y) :-progenitor(M, Y), progenitor(X,M), mujer(X); nieto(Y, X), mujer(X); nieta(Y, X), mujer(X).

hermana(X, Y) :-hija(X, Z), padre(Z, Y); hija(X, Z), madre(Z, Y).
hermano(X, Y) :-hijo(X, Z), padre(Z, Y); hijo(X, Z), madre(Z, Y). 

tio(X, Y) :-hermano(X, Z), padre(Z, Y); hermano(X, Z), madre(Z, Y).
tia(X, Y) :-hermana(X, Z), padre(Z, Y); hermana(X, Z), madre(Z, Y).

nieto(X, Y) :-hijo(X, Z), hijo(Z, Y); hijo(X, Z), hija(Z, Y).
nieta(X, Y) :-hija(X, Z), hijo(Z, Y); hija(X, Z), hija(Z, Y).

yerno(X, Y) :-marido(X, Z), hija(Z, Y). 
nuera(X, Y) :-esposa(X, Z), hijo(Z, Y). 

suegro(X, Y) :-yerno(Y, X), hombre(X); nuera(Y, X), hombre(X).
suegra(X, Y) :-yerno(Y, X), mujer(X); nuera(Y, X), mujer(X).

bisnieto(X, Y) :-nieto(X, Z), hijo(Z, Y); nieto(X, Z), hija(Z, Y).
bisnieta(X, Y) :-nieta(X, Z), hijo(Z, Y); nieta(X, Z), hija(Z, Y). 

cuniado(X, Y) :-hermano(X, Z), pareja(Z, Y).
cuniada(X, Y) :-hermana(X, Z), pareja(Z, Y).
