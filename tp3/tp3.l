%option noyywrap
%{
/* Reconoce números enteros y palabras alfabéticas; además,
 cuenta las ocurrencias de ambos */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>


//IDENTIFICADORES
struct nodoIdentificadores {
    char *identificador;
    int cantidadIdentificadores;
    struct nodoIdentificadores *sig;
};
typedef struct nodoIdentificadores NodoIdentificadores;
NodoIdentificadores *raizIdentificadores=NULL;
NodoIdentificadores *fondoIdentificadores=NULL;

//LITERAL CADENA
struct nodoLiteralCadena {
    char *literalCadena;
    int longitud;
    struct nodoLiteralCadena *sig;
};
typedef struct nodoLiteralCadena NodoLiteralCadena;
NodoLiteralCadena *raizLiteralCadena=NULL;
NodoLiteralCadena *fondoLiteralCadena=NULL;

//PALABRAS RESERVADAS 

struct nodoPalabrasReservadas {
    char *palabraReservada;
    char *tipo; 
    struct nodoPalabrasReservadas *sig;
};
typedef struct nodoPalabrasReservadas NodoPalabrasReservadas;
NodoPalabrasReservadas *raizPalabrasReservadas=NULL;
NodoPalabrasReservadas *fondoPalabrasReservadas=NULL;



//CONSTANTES
struct nodoConstanteOctal {
    int octal;
    struct nodoConstanteOctal *sig;
};
typedef struct nodoConstanteOctal NodoConstanteOctal;
NodoConstanteOctal *raizConstanteOctal=NULL;
NodoConstanteOctal *fondoConstanteOctal=NULL;

struct nodoConstanteHexa {
    char *datoEnHexa;
    int hexa; //POSIBLE CONVERSION
    struct nodoConstanteHexa *sig;
};
typedef struct nodoConstanteHexa NodoConstanteHexa;
NodoConstanteHexa *raizConstanteHexa=NULL;
NodoConstanteHexa *fondoConstanteHexa=NULL;


struct nodoConstanteDecimal {
    int decimal ;
    struct nodoConstanteDecimal *sig;
};
typedef struct nodoConstanteDecimal NodoConstanteDecimal;
NodoConstanteDecimal *raizConstanteDecimal=NULL;
NodoConstanteDecimal *fondoConstanteDecimal=NULL;


struct nodoConstanteReal {
    int mantisa ;
    int parteEntera ;
    struct nodoConstanteReal *sig;
};
typedef struct nodoConstanteReal NodoConstanteReal;
NodoConstanteReal *raizConstanteReal=NULL;
NodoConstanteReal *fondoConstanteReal=NULL;

struct nodoConstanteCaracter {
    char *caracter;
    struct nodoConstanteCaracter *sig;
};
typedef struct nodoConstanteCaracter NodoConstanteCaracter;
NodoConstanteCaracter *raizConstanteCaracter=NULL;
NodoConstanteCaracter *fondoConstanteCaracter=NULL;

//OPERADORES/CARACTERES DE PUNTUACIÓN

struct nodoOperOCaractPunt {
    char *caracter;
    struct nodoOperOCaractPunt *sig;
};
typedef struct nodoOperOCaractPunt NodoOperOCaractPunt;
NodoOperOCaractPunt *raizOperOCaractPunt=NULL;
NodoOperOCaractPunt *fondoOperOCaractPunt=NULL;

//COMENTARIOS 

struct nodoComentario {
    char *comentario;
    char *tipo; 
    struct nodoComentario *sig;
};
typedef struct nodoComentario NodoComentario;
NodoComentario *raizComentarios=NULL;
NodoComentario *fondoComentarios=NULL;


struct nodoNoReconocidos {
    char *noReconocido;
    int linea; 
    struct nodoNoReconocidos *sig;
};
typedef struct nodoNoReconocidos NodoNoReconocidos;
NodoNoReconocidos *raizNoReconocidos=NULL;
NodoNoReconocidos *fondoNoReconocidos=NULL;

// STRUCK CON TODOS LOS PUNTEROS (YO HARIA ASI)

agregarNodo(int categoria,char* informacionNueva){
          if(categoria==0){  //IDENTIFICADORES

    }else if(categoria==1){   //LITERA CADENA  

    }else if(categoria==2){   //PALABRAS RESERVADAS

    }else if(categoria==3){   //OCTAL
        
    }else if(categoria==4){   //HEXA

    }else if(categoria==5){  //DECIMAL
            NodoConstanteDecimal *nuevoNodo;
            nuevoNodo->decimal=atoi(informacionNueva);
            nuevoNodo->sig=NULL;
            if(raizConstanteDecimal==NULL){
               raizConstanteDecimal=nuevoNodo;
               fondoConstanteDecimal=nuevoNodo;
            }else{
                fondoConstanteDecimal->sig=nuevoNodo;
                fondoConstanteDecimal=nuevoNodo;
            }

    }else if(categoria==6){  //REALES

    }else if(categoria==7){  //CARACTERES 
            NodoConstanteCaracter *nuevoNodo;
            nuevoNodo->caracter=strdup(informacionNueva);
            if(raizConstanteCaracter==NULL){
               raizConstanteCaracter=nuevoNodo;
               fondoConstanteCaracter=nuevoNodo;
            }else{
                fondoConstanteCaracter->sig=nuevoNodo;
                fondoConstanteCaracter=nuevoNodo;
            }
    }else if(categoria==8){  //OPERADORES/CARACTERES DE PUNTUACIÓN

    }else if(categoria==9){  //COMENTARIOS 


    }else if(categoria==10){

    }

}




}

%}

DIGITO_DECIMAL [0-9]     [0123456789]    
DIGITO_OCTAL [0-7] 
DIGITO_HEXADECIMAL [a-fA-F0-9] 
LETRA [a-zA-Z] 
//PAL_RESERV_TIPDATOS  ["int"""] 
//PAL_RESERV_CONTROL   []
//PAL_RESERV_OTROS     []

%% 
({LETRA}|"_")({LETRA}|{DIGITO_DECIMAL}|"_")* {;} //DENTIFICADORES
  //literal cadena
("int"|"float"|"char"|"long"|"double"|"unsigned"|"short"|"struct"|"typedef"|"void"|"signed"|"enum"|"register"|"union") {accion;}// palabra reserv tipo datos
("do"|"while"|"else"|"if"|"for"|"break"|"case"|"default"|"continue") {accion;}//palabra reservada estructurade control
("sizeof"|"return"|"const"|"volatile"|"goto"|"extern"|"auto"|"static") {accion;}   //palabra reseervada otros

[1-9]{DIGITO_DECIMAL}* {;}
0{DIGITO_OCTAL}* {;}
0[xX]{DIGITO_HEXADECIMAL}+ {;}

{DIGITO_DECIMAL}*.{DIGITO_DECIMAL}+([Ee](+|-)?{DIGITO_DECIMAL}*)? {accion;} //real
{DIGITO_DECIMAL}.([Ee](+|-)?{DIGITO_DECIMAL}*)? {accion;} //real


faltan varios hay q ver y como armar la er

%%
int main(void) { 
    EstructuraDePunteros categorias;
    inicializarCategorias(&categorias);

    yylex();
    printf("Se reconocieron:\n");
    printf("%d Numeros y\n", nros);
    printf("%d Palabras.\n\n", pals);
    return 0;
} 

