:-dynamic ancestro/2.

%pareja(lucas,diego)
%pareja(diego,lucas)

ancestro(flor,juana).
ancestro(flor,maria).

ancestro(paty,alberto).
ancestro(paty,luisa).

ancestro(ruth,miguel).
ancestro(ruth,sofia).

ancestro(maria,mario).
ancestro(maria,ana).

ancestro(luisa,pedro).
ancestro(luisa,juan).

ancestro(ana,lucas).

ancestro(luis,juana).
ancestro(luis,maria).

ancestro(antonio,alberto).
ancestro(antonio,luisa).

ancestro(jose,miguel).
ancestro(jose,sofia).

ancestro(alberto,mario).
ancestro(alberto,ana).

ancestro(miguel,pedro).
ancestro(miguel,juan).

ancestro(pedro,lucas).

ancestro(juan,rodrigo).

ancestro_adoptivo(lucas,diego).
ancestro_adoptivo(rodrigo,diego).

hombre(luis).
hombre(antonio).
hombre(jose).
hombre(alberto).
hombre(miguel).
hombre(mario).
hombre(pedro).
hombre(juan).
hombre(rodrigo).

hombre(lucas).
hombre(diego).


%mujer(karla)

mujer(flor).
mujer(paty).
mujer(ruth).
mujer(juana).
mujer(maria).
mujer(luisa).
mujer(sofia).
mujer(ana).

madre(X,Y):-ancestro(X,Y),mujer(X).
padre(X,Y):-(ancestro(X,Y),hombre(X)).

hermano(X,Y):-((madre(Z,X),madre(Z,Y));(padre(W,X),padre(W,Y))), X\=Y.
%hermana(X,Y):-

tia(X,Y):-hermano(X,Z),ancestro(Z,Y),mujer(X).
tio(X,Y):-hermano(X,Z),ancestro(Z,Y),hombre(X).

esposo(X,Y):-padre(X,W),madre(Y,W).
esposa(X,Y):-madre(X,W),padre(Y,W).

cunada(X,Y):-hermano(X,W),esposa(W,Y),mujer(X).
cunada(X,Y):-esposa(X,W),hermano(W,Y).

abuelo(X,Y):-(padre(X,Z), ancestro(Z,Y)).
abuela(X,Y):-madre(X,Z), ancestro(Z,Y).

padre_adoptivo(X,Y):-ancestro_adoptivo(X,Y),hombre(X).

%padre_adoptivo(X,Y):-ancestro_adoptivo(X,Y), pareja(X,W), hombre(X), pareja(X,Y)\=pareja(X,W).
hijo_adoptivo(X,Y):-hombre(X), padre_adoptivo(Y,X).
%hijo_adoptivo(X,Y):-(padre_adoptivo(Y,X);padre_adoptivo(Y,W)), padre_adoptivo(Y,X)\=padre_adoptivo(Y,W).
pareja(X,Y):-hombre(X), (padre_adoptivo(X,W),padre_adoptivo(Y,W)), padre_adoptivo(X,W)\=padre_adoptivo(Y,W).


hijo(X,Y):-hombre(X),(padre(Y,X);madre(Y,X)).
hija(X,Y):-mujer(X),(padre(Y,X);madre(Y,X)).

bisabuelo(X,Y):-padre(X,Z), ancestro(Z ,W),ancestro(W,Y).
bisabuela(X,Y):-madre(X,Z), ancestro(Z,W),ancestro(W,Y).

primo(X,Y):-hombre(X), sobrino(X,Z),ancestro(Z,Y), X\=Y.
prima(X,Y):-mujer(X), sobrina(X,Z),ancestro(Z,Y).

nieto(X,Y):-hombre(X), (abuelo(Y,X);abuela(Y,X)).
nieta(X,Y):-mujer(X), (abuelo(Y,X);abuela(Y,X)).

sobrino(X,Y):-hombre(X), (tio(Y,X);tia(Y,X)).
sobrina(X,Y):-mujer(X), (tio(Y,X);tia(Y,X)).

bisnieto(X,Y):-bisabuelo(Y,X);bisabuela(Y,X).
bisnieta(X,Y):-bisabuela(Y,X);bisabuelo(Y,X).

preguntar:-
 write('Digite el nombre del ancestro(con minúscula y terminando con punto) '),  read(Ancestro), nl,
 write('Digite el nombre del descendiente (con minúscula y terminando con punto)'),  read(Descendiente), nl,
 assert(ancestro(Ancestro,Descendiente)),repetir.

repetir:- write('desea incluir otro ancestro y su descendiente? (si/no) '), read(Respuesta),nl, ((Respuesta==si)->preguntar;fail).

undo :-ancestro(_ ,_),fail.
undo.
