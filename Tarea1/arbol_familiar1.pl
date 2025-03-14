%Primer ejercicio - Tarea1
%Inteligencia artificial - 2024-2
%Profesores: Manuel Cristóbal López Michelone, Yessica Martínez Reyes y César Hernández Solís.
%Alumno: Rivera Zavala Javier Alejandro - 311288876.


%Hechos

hombre(javier).
hombre(rosendo).
hombre(luis).
hombre(noe).
hombre(heriberto).
hombre(crispin).
hombre(raul).
hombre(juan).
mujer(himelda).
mujer(ricarda).
mujer(noelia).
mujer(carmen).
mujer(leticia).
mujer(angelica).
progenitor(rosendo, carmen).
progenitor(rosendo, javier).
progenitor(rosendo, luis).
progenitor(rosendo, noe).
progenitor(noelia, carmen).
progenitor(noelia, javier).
progenitor(noelia, luis).
progenitor(noelia, noe).
progenitor(heriberto, noelia).
progenitor(heriberto, juan).
progenitor(heriberto, leticia).
progenitor(crispin, rosendo).
progenitor(crispin, raul).
progenitor(crispin, angelica).
progenitor(himelda, noelia).
progenitor(himelda, juan).
progenitor(himelda, leticia).
progenitor(ricarda, rosendo).
progenitor(ricarda, raul).
progenitor(ricarda, angelica).
pareja(rosendo, noelia).
pareja(noelia, rosendo).
pareja(ricarda, crispin).
pareja(crispin, ricarda).
pareja(heriberto, himelda).
pareja(himelda, heriberto).


%Reglas

%Están orientadas desde la izquierda, es decir, en la regla(X, Y) X es "tal cosa" de Y.

marido(X, Y) :-pareja(X, Y), hombre(X), X\==Y. 
esposa(X, Y) :-pareja(X, Y), mujer(X), X\==Y. 
padre(X, Y) :-progenitor(X, Y), hombre(X), X\==Y. 
madre(X, Y) :-progenitor(X, Y), mujer(X), X\==Y. 
hijo(Y, X) :-progenitor(X, Y), hombre(Y), X\==Y.
hija(Y, X) :-progenitor(X, Y), mujer(Y), X\==Y.
abuelo(X, Y) :-progenitor(M, Y), progenitor(X, M), hombre(X), X\==Y.
abuela(X, Y) :-progenitor(M, Y), progenitor(X,M), mujer(X), X\==Y.
hermana(X, Y) :-progenitor(Z, X), progenitor(Z, Y), X\==Y, mujer(X). 
hermano(X, Y) :-progenitor(Z, X), progenitor(Z, Y), X\==Y, hombre(X).
tio(X, Y) :-hermano(X, Z), progenitor(Z, Y), X\==Y.
tia(X, Y) :-hermana(X, Z), progenitor(Z, Y), X\==Y.
nieto(X, Y) :-progenitor(Y, Z), progenitor(Z, X), hombre(X), X\==Y.
nieta(X, Y) :-progenitor(Y, Z), progenitor(Z, X), mujer(X), X\==Y.


