%option noyywrap
%{
/* Reconoce números enteros y palabras alfabéticas; además,
 cuenta las ocurrencias de ambos */
#include <stdio.h>
//IDENTIFICADORES
struct nodoIdentificadores {
    char *identificador;
    int cantidadIdentificadores;
    struct nodoIdentificadores *sig;
};
//struct nodoIdentificadores *raizIdentificadores=NULL;
//struct nodoIdentificadores *fondoIdentificadores=NULL;

//LITERAL CADENA
struct nodoLiteralCadena {
    char *literalCadena;
    int longitud;
    struct nodoLiteralCadena *sig;
};
//struct nodoLiteralCadena *raizLiteralCadena=NULL;
//struct nodoLiteralCadena *fondoLiteralCadena=NULL;

//PALABRAS RESERVADAS 

struct nodoPalabrasReservadas {
    char *palabraReservada;
    char tipo[19]; //ACA CAPAZ PODEMOS HACER DINAMICO TAMBIEN
    struct nodoPalabrasReservadas *sig;
};
//struct nodoPalabrasReservadas *raizPalabrasReservadas=NULL;
//struct nodoPalabrasReservadas *fondoPalabrasReservadas=NULL;



//CONSTANTES
struct nodoConstanteOctal {
    int octal;
    struct nodoConstanteOctal *sig;
};
//struct nodoConstanteOctal *raizConstanteOctal=NULL;
//struct nodoConstanteOctal *fondoConstanteOctal=NULL;

struct nodoConstanteHexa {
    char *datoEnHexa;
    int hexa; //POSIBLE CONVERSION
    struct nodoConstanteHexa *sig;
};
//struct nodoConstanteHexa *raizConstanteHexa=NULL;
//struct nodoConstanteHexa *fondoConstanteHexa=NULL;


struct nodoConstanteDecimal {
    int decimal ;
    struct nodoConstanteDecimal *sig;
};
//struct nodoConstanteDecimal *raizConstanteDecimal=NULL;
//struct nodoConstanteDecimal *fondoConstanteDecimal=NULL;


struct nodoConstanteReal {
    int mantisa ;
    int parteEntera ;
    struct nodoConstanteReal *sig;
};
//struct nodoConstanteReal *raizConstanteReal=NULL;
//struct nodoConstanteReal *fondoConstanteReal=NULL;

struct nodoConstanteCaracter {
    char caracter;
    struct nodoConstanteCaracter *sig;
};
struct nodoConstanteCaracter *raizConstanteCaracter=NULL;
struct nodoConstanteCaracter *fondoConstanteCaracter=NULL;

//OPERADORES/CARACTERES DE PUNTUACIÓN

struct nodoOperOCaractPunt {
    char caracter;
    struct nodoOperOCaractPunt *sig;
};
//struct nodoOperOCaractPunt *raizOperOCaractPunt=NULL;
//struct nodoOperOCaractPunt *fondoOperOCaractPunt=NULL;

//COMENTARIOS 

struct nodoComentario {
    char *comentario;
    char tipo[10]; //ACA PODEMOS VER TAMBIEN DINAMICO
    struct nodoComentario *sig;
};
//struct nodoComentario *raizComentarios=NULL;
//struct nodoComentario *fondoComentarios=NULL;


struct nodoNoReconocidos {
    char *noReconocido;
    int linea; 
    struct nodoNoReconocidos *sig;
};
//struct nodoNoReconocidos *raizNoReconocidos=NULL;
//struct nodoNoReconocidos *fondoNoReconocidos=NULL;

// STRUCK CON TODOS LOS PUNTEROS (YO HARIA ASI)

struct categorias{
    struct nodoIdentificadores *raizIdentificadores;
    struct nodoIdentificadores *fondoIdentificadores;

    struct nodoLiteralCadena *raizLiteralCadena;
    struct nodoLiteralCadena *fondoLiteralCadena;

    struct nodoPalabrasReservadas *raizPalabrasReservadas;
    struct nodoPalabrasReservadas *fondoPalabrasReservadas;

    struct nodoConstanteOctal *raizConstanteOctal;
    struct nodoConstanteOctal *fondoConstanteOctal;
    struct nodoConstanteHexa *raizConstanteHexa;
    struct nodoConstanteHexa *fondoConstanteHexa;
    struct nodoConstanteDecimal *raizConstanteDecimal;
    struct nodoConstanteDecimal *fondoConstanteDecimal;
    struct nodoConstanteReal *raizConstanteReal;
    struct nodoConstanteReal *fondoConstanteReal;
    struct nodoConstanteCaracter *raizConstanteCaracter;
    struct nodoConstanteCaracter *fondoConstanteCaracter;

    struct nodoOperOCaractPunt *raizOperOCaractPunt;
    struct nodoOperOCaractPunt *fondoOperOCaractPunt;

    struct nodoComentario *raizComentarios;
    struct nodoComentario *fondoComentarios;

    struct nodoNoReconocidos *raizNoReconocidos;
    struct nodoNoReconocidos *fondoNoReconocidos;
};





%}
  //REGLAS  ta medio raro nose porq no pone colorcitos   
%% 
[_a-zA-Z][_0-9a-zA-Z]* {ACCION;} //DENTIFICADORES

int|float|char|long|double|unsigned|short|struct|typedef|void|signed|enum|register|union {accion;}// palabra reserv tipo datos
do|while|else|if|for|break|case|default|continue {accion;}//palabra reservada estructurade control
sizeof|return|const|volatile|goto|extern|auto|static {accion;}   //palabra reseervada otros

0[0-7]* {accion;}//octal

0[xX][0-9a-fA-F]+ {accion;}//hexa

[1-9][0-9]* {accion;} //hexa

[0-9]*.[0-9]+([Ee](+|-)?[0-9]*)? {accion;} //real
[0-9].([Ee](+|-)?[0-9]*)? {accion;} //real

faltan varios hay q ver y como armar la er



%%
     //PROGRAMA EN C
int main(void) { /
 yylex();
 printf("Se reconocieron:\n");
 printf("%d Numeros y\n", nros);
 printf("%d Palabras.\n\n", pals);
 return 0;
} 