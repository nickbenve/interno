%option noyywrap
%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

//PROTOTIPOS
void agregarNodo(int ,char*,char*);
long conversorADecimal(char*,int);
int  representacionDigito(char,int);

//IDENTIFICADORES
struct nodoIdentificadores {
    char *identificador;
    int cantidadIdentificadores;
    struct nodoIdentificadores *sig;
};
typedef struct nodoIdentificadores NodoIdentificadores;
NodoIdentificadores *raizIdentificadores=NULL;

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
    char *datoEnOctal;
    int decimal;
    struct nodoConstanteOctal *sig;
};
typedef struct nodoConstanteOctal NodoConstanteOctal;
NodoConstanteOctal *raizConstanteOctal=NULL;
NodoConstanteOctal *fondoConstanteOctal=NULL;

struct nodoConstanteHexa {
    char *datoEnHexa;
    int decimal; 
    struct nodoConstanteHexa *sig;
};
typedef struct nodoConstanteHexa NodoConstanteHexa;
NodoConstanteHexa *raizConstanteHexa=NULL;
NodoConstanteHexa *fondoConstanteHexa=NULL;


struct nodoConstanteDecimal {
    int decimal;
    struct nodoConstanteDecimal *sig;
};

typedef struct nodoConstanteDecimal NodoConstanteDecimal;
NodoConstanteDecimal *raizConstanteDecimal=NULL;
NodoConstanteDecimal *fondoConstanteDecimal=NULL;


struct nodoConstanteReal {
    float mantiza ;
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
    int cantidadOperOCaractPunt;
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
NodoComentario *raizComentario=NULL;
NodoComentario *fondoComentario=NULL;


struct nodoNoReconocidos {
    char *noReconocido;
    int linea; 
    struct nodoNoReconocidos *sig;
};
typedef struct nodoNoReconocidos NodoNoReconocidos;
NodoNoReconocidos *raizNoReconocidos=NULL;
NodoNoReconocidos *fondoNoReconocidos=NULL;


long decimal;
void agregarNodo(int categoria,char* informacionNueva,char* tipo){
          if(categoria==0){  //IDENTIFICADORES

    }else if(categoria==1){   //LITERA CADENA  
            NodoLiteralCadena *nuevoNodo;
            nuevoNodo=malloc(sizeof(struct nodoLiteralCadena));
            nuevoNodo->literalCadena=strdup(informacionNueva);
            nuevoNodo->longitud=strlen(informacionNueva);
            nuevoNodo->sig=NULL;
            if(raizLiteralCadena==NULL){
                raizLiteralCadena=nuevoNodo;            
            }else{
                fondoLiteralCadena->sig=nuevoNodo;
            }
            fondoLiteralCadena=nuevoNodo;
    }else if(categoria==2){   //PALABRAS RESERVADAS
           NodoPalabrasReservadas *nuevoNodo;
           nuevoNodo=malloc(sizeof(struct nodoPalabrasReservadas));
           nuevoNodo->palabraReservada=strdup(informacionNueva);
           nuevoNodo->tipo=strdup(tipo);
           nuevoNodo->sig=NULL;
           if(raizPalabrasReservadas==NULL){
               raizPalabrasReservadas=nuevoNodo;
           }else{
                fondoPalabrasReservadas->sig=nuevoNodo;
           }
          fondoPalabrasReservadas=nuevoNodo;
    }else if(categoria==3){   //OCTAL
          decimal=conversorADecimal(informacionNueva,8);
          NodoConstanteOctal *nuevoNodo;
          nuevoNodo=malloc(sizeof(struct nodoConstanteOctal));
          nuevoNodo->datoEnOctal=strdup(informacionNueva);
          nuevoNodo->decimal=conversorADecimal(informacionNueva,8);
          nuevoNodo->sig=NULL;
          if(raizConstanteOctal=NULL){
               raizConstanteOctal=nuevoNodo;
          }else{
                fondoConstanteOctal->sig=nuevoNodo;
          }
          fondoConstanteOctal=nuevoNodo;
    }else if(categoria==4){   //HEXA  EL RESTO ES SUPER PARECIDO SOLO Q CAMBIAMOS UNAS COSITAS NOMAS
          decimal=conversorADecimal(informacionNueva,16);
          NodoConstanteHexa *nuevoNodo;
          nuevoNodo=malloc(sizeof(struct nodoConstanteHexa));
          nuevoNodo->datoEnHexa=strdup(informacionNueva);
          nuevoNodo->decimal=conversorADecimal(informacionNueva,16);
          nuevoNodo->sig=NULL;
          if(raizConstanteHexa==NULL){
               raizConstanteHexa=nuevoNodo;
          }else{
                fondoConstanteHexa->sig=nuevoNodo;
          }
          fondoConstanteHexa=nuevoNodo;

    }else if(categoria==5){  //DECIMAL
            NodoConstanteDecimal *nuevoNodo;
            nuevoNodo=malloc(sizeof(NodoConstanteDecimal));
            nuevoNodo->decimal=atoi(informacionNueva);
            nuevoNodo->sig=NULL;
            if(raizConstanteDecimal==NULL){
               raizConstanteDecimal=nuevoNodo;
               
            }else{
                fondoConstanteDecimal->sig=nuevoNodo;    
            }
            fondoConstanteDecimal=nuevoNodo;

    }else if(categoria==6){  //REALES
            NodoConstanteReal *nuevoNodo;
            nuevoNodo=malloc(sizeof(NodoConstanteReal));
            float num=strtof(informacionNueva, NULL);
            int parteEn = (int)num;
            nuevoNodo->mantiza=num-parteEn;
            nuevoNodo->parteEntera=parteEn;
            nuevoNodo->sig=NULL;
            if(raizConstanteReal==NULL){
               raizConstanteReal=nuevoNodo;
               
            }else{
                fondoConstanteReal->sig=nuevoNodo;    
            }
            fondoConstanteReal=nuevoNodo;



    }else if(categoria==7){  //CARACTERES 
            NodoConstanteCaracter *nuevoNodo;
            nuevoNodo=malloc(sizeof(NodoConstanteCaracter));
            nuevoNodo->caracter=strdup(informacionNueva);
            if(raizConstanteCaracter==NULL){
               raizConstanteCaracter=nuevoNodo;
            }else{
                fondoConstanteCaracter->sig=nuevoNodo;
            }
            fondoConstanteCaracter=nuevoNodo;

    }else if(categoria==8){  //OPERADORES/CARACTERES DE PUNTUACIÓN
          

    }else if(categoria==9){  //COMENTARIOS 
           NodoComentario *nuevoNodo;
           nuevoNodo=malloc(sizeof(struct nodoComentario));
           nuevoNodo->comentario=strdup(informacionNueva);
           nuevoNodo->tipo=strdup(tipo);
           nuevoNodo->sig=NULL;
           if(raizComentario==NULL){
               raizComentario=nuevoNodo;
           }else{
                fondoComentario->sig=nuevoNodo;
           }
          fondoComentario=nuevoNodo;

    }
}



long conversorADecimal(char* informacionNueva,int base){
   long repredecimal=0;
   int longitud;
   longitud = strlen(informacionNueva);
   longitud--;
   int recorrido=longitud;
   for(;recorrido>=0;recorrido--){
        repredecimal+=pow(base,longitud-recorrido)*representacionDigito(*(informacionNueva+recorrido),base);     
   }
   return repredecimal;
}

int representacionDigito(char digito,int base)
{
    if(base==16)
    {   
        switch(digito)
        {   case 'a':
            case 'A':
                return 10;
                break;
            case 'b':
            case 'B':
                return 11;
                break;
            case 'c':
            case 'C':
                return 12;
                break;
            case 'd':
            case 'D':
                return 13;
                break;
            case 'e':
            case 'E':
                return 14;
                break;
            case 'f':
            case 'F':
                 return 15;
                 break;    
            default:
                 return digito-48;
        }
    }else{
        return digito-48;
    }
} 


%}

DIGITO_DECIMAL [0-9]    
DIGITO_OCTAL [0-7] 
DIGITO_HEXADECIMAL [a-fA-F0-9] 
LETRA [a-zA-Z] 
PAL_RESERV_TIPDATOS  ["int"|"float"|"char"|"long"|"double"|"unsigned"|"short"|"struct"|"typedef"|"void"|"signed"|"enum"|"register"|"union"]
PAL_RESERV_CONTROL   ["do"|"while"|"else"|"if"|"for"|"break"|"case"|"default"|"continue"]
PAL_RESERV_OTROS     ["sizeof"|"return"|"const"|"volatile"|"goto"|"extern"|"auto"|"static"]
CARACTER_IMPRIMIBLE  [\! | \" # \$ % & '() * + , - . / 0 1 2 3 4 5 6 7 8 9 : ; < = > ? @ A B C D E F G H I J K L M N O P Q R S T U V W X Y Z [ \ ] ^ _ ` a b c d e f g h i j k l m n o p q r s t u v w x y z { | } ~]
%% 
({LETRA}|"_")({LETRA}|{DIGITO_DECIMAL}|"_")* {;} //IDENTIFICADORES
 //literal cadena
PAL_RESERV_TIPDATOS {accion;} // palabra reserv tipo datos
PAL_RESERV_CONTROL {accion;}//palabra reservada estructura de control
PAL_RESERV_OTROS  {accion;}   //palabra reservada otros


[1-9]{DIGITO_DECIMAL}* {;}
0{DIGITO_OCTAL}* {;}
0[xX]{DIGITO_HEXADECIMAL}+ {;}

{DIGITO_DECIMAL}*.{DIGITO_DECIMAL}+([Ee](+|-)?{DIGITO_DECIMAL}*)? {accion;} //real
{DIGITO_DECIMAL}.([Ee](+|-)?{DIGITO_DECIMAL}*)? {accion;} //real

//caracteres (imp y no imp)
\'[CARACTER_IMPRIMIBLE]\' {;}



%%
int main(void) { 
    yylex();
    
    printf("Se reconocieron:\n");
    printf("%d Numeros y\n", nros);
    printf("%d Palabras.\n\n", pals);
    return 0;
} 

