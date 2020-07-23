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
    struct nodoIdentificadores *ant;
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
             NodoIdentificadores *nuevoNodo,*recorrido;
            char informacionNMayuscula[strlen(informacionNueva)];
            int limite=sizeof(informacionNMayuscula);
            strcpy(informacionNMayuscula,informacionNueva);
            char caracter=informacionNMayuscula[0];
            int a=0;
            while(a<=limite){
                if(caracter>=97&&caracter<=122){
                    caracter=caracter-32;
                }
                informacionNMayuscula[a]=caracter;
                caracter=informacionNMayuscula[a+1];
                a++;
                
            }
            if(raizIdentificadores==NULL){
                nuevoNodo=malloc(sizeof(NodoIdentificadores));
                nuevoNodo->identificador=strdup(informacionNueva);
                nuevoNodo->identificadorMayuscula=strdup(informacionNMayuscula);
                nuevoNodo->cantidadIdentificadores=1;
                nuevoNodo->sig=NULL;
                nuevoNodo->ant=NULL;
                raizIdentificadores=nuevoNodo;
            }else{
                recorrido=raizIdentificadores;
                int c=0;
                while(recorrido->sig!=NULL&&strcmp(informacionNMayuscula,recorrido->identificadorMayuscula)>=0){
                    recorrido=recorrido->sig;
                }
                int b;
                b=strcmp(informacionNMayuscula,recorrido->identificadorMayuscula);
                if(b>0&&strcmp(informacionNueva,recorrido->identificador)!=0){
                        nuevoNodo=malloc(sizeof(NodoIdentificadores));
                        nuevoNodo->identificador=strdup(informacionNueva);
                        nuevoNodo->identificadorMayuscula=strdup(informacionNMayuscula);
                        nuevoNodo->cantidadIdentificadores=1;
                        nuevoNodo->sig=recorrido->sig;
                        nuevoNodo->ant=recorrido;
                        recorrido->sig=nuevoNodo;
                    }else{
                        if(b==0&&strcmp(informacionNueva,recorrido->identificador)==0){
                            (recorrido->cantidadIdentificadores)++;  
                        }else{
                            nuevoNodo=malloc(sizeof(NodoIdentificadores));
                            nuevoNodo->identificador=strdup(informacionNueva);
                            nuevoNodo->identificadorMayuscula=strdup(informacionNMayuscula);
                            nuevoNodo->cantidadIdentificadores=1;
                            nuevoNodo->sig=recorrido;
                            if(recorrido->ant==NULL){
                                raizIdentificadores=nuevoNodo;
                            }else{
                                (recorrido->ant)->sig=nuevoNodo;
                            }
                            
                        }
                    }
               
            }
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
          if(raizConstanteOctal==NULL){
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
            NodoOperOCaractPunt *recorridoOC,*nuevoNodo;
            recorridoOC=raizOperOCaractPunt;
            if(raizOperOCaractPunt==NULL){
                 nuevoNodo=malloc(sizeof(NodoOperOCaractPunt));
                 nuevoNodo->caracter=strdup(informacionNueva);
                 nuevoNodo->cantidadOperOCaractPunt=1;
                 nuevoNodo->sig=NULL;
                 raizOperOCaractPunt=nuevoNodo;
                 fondoOperOCaractPunt=nuevoNodo;
            }else{
                 while(recorridoOC!=NULL&& strcmp(informacionNueva,recorridoOC->caracter)!=0){
                    recorridoOC=recorridoOC->sig;    
                 }
                 if(recorridoOC==NULL){
                    nuevoNodo=malloc(sizeof(NodoOperOCaractPunt));
                    nuevoNodo->caracter=strdup(informacionNueva);
                    nuevoNodo->cantidadOperOCaractPunt=1;
                    nuevoNodo->sig=NULL;
                    fondoOperOCaractPunt->sig=nuevoNodo;
                    fondoOperOCaractPunt=nuevoNodo;
                }else{
                    (recorridoOC->cantidadOperOCaractPunt)++;
                }
            }

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
PAL_RESERV_TIPDATOS  [int|float|char|long|double|unsigned|short|struct|typedef|void|signed|enum|register|union]
PAL_RESERV_CONTROL   [do|while|else|if|for|break|case|default|continue]
PAL_RESERV_OTROS     [sizeof|return|const|volatile|goto|extern|auto|static]
CARACTER_IMPRIMIBLE  ["!"|"|"|"\"|"\""|"#"|"$"|"%"|"&"|"'"|"("|")"|"\*"|"+"|","|"-"|"."|"/"|"0"|"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"|":"|";"|"<"|"="|">"|"?"|"@"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"\["|"\]"|"^"|"_"|"`"|"a"|"b"|"c"|"d"|"e"|"f"|"g"|"h"|"i"|"j"|"k"|"l"|"m"|"n"|"o"|"p"|"q"|"r"|"s"| "t"|"u"|"v"|"w"|"x"|"y"|"z"|"\{"|"\}"|"~"]
CARACTER_PUNTUACION  ["\["|"\]"|"\("|"\)"|"\{"|"\}"|"\."|"->"|"\+\+"|"\+"|"\-\-"|"\-"|"&"|"\*"|"˜"|"\!"|"\/"|"%"|"<<"|">>"|"<"|">"|"<="|">="|"=="|"!="|"ˆ"|"&&"|"||"|"="|"*="|"/="|"%="|"+="|"-="|"<<="|">>="|"&="|"ˆ="|"|="|"\?"|":"|"\;"|"..."|","|"#"|"##"|"$"]
%% 

"{CARACTER_IMPRIMIBLE}+" {agregarNodo(1,yytext," ");}

{PAL_RESERV_TIPDATOS} {agregarNodo(2,yytext,"tipo de dato");}
{PAL_RESERV_CONTROL} {agregarNodo(2,yytext,"de control");}
{PAL_RESERV_OTROS}  {agregarNodo(2,yytext,"otros");}  s

0{DIGITO_OCTAL}* {agregarNodo(3,yytext,"");}
0[xX]{DIGITO_HEXADECIMAL}+ {agregarNodo(4,yytext,"");} 
[1-9]{DIGITO_DECIMAL}* {agregarNodo(5,yytext,"");} 
{CARACTER_IMPRIMIBLE} {agregarNodo(7,yytext," ");} 
{CARACTER_PUNTUACION} {agregarNodo(8,yytext," ");} 
({LETRA}|"_")({LETRA}|{DIGITO_DECIMAL})* {agregarNodo(0,yytext," ");} 

{DIGITO_DECIMAL}\.{DIGITO_DECIMAL}+([Ee](\+|\-)?{DIGITO_DECIMAL})? {agregarNodo(6,yytext,"");} 
{DIGITO_DECIMAL}+\.([Ee](\+|\-)?{DIGITO_DECIMAL})? {agregarNodo(6,yytext,"");}
"//"{CARACTER_IMPRIMIBLE}/"\n" {agregarNodo(9,yytext,"linea");} 
"/\*"{CARACTER_IMPRIMIBLE}*"/\*" {agregarNodo(9,yytext,"multiple linea");}
%%
int main(void) { 
    yylex();

    NodoIdentificadores *recorridoI;
    recorridoI=raizIdentificadores;
    while(recorridoI!=NULL){
       printf("el identificador %s ",recorridoI->identificador);
       printf("aparece estas veces: %d \n",recorridoI->cantidadIdentificadores);

       recorridoI=recorridoI->sig;
    }

    NodoLiteralCadena *recorridoLC;
    recorridoLC=raizLiteralCadena;
    while(recorridoLC!=NULL){
       printf("el literal cadena %s",recorridoLC->literalCadena);
       printf(" tiene un largo de %d \n",recorridoLC->longitud);
       recorridoLC=recorridoLC->sig;
    }
    
    NodoPalabrasReservadas *recorridoPR;
    recorridoPR=raizPalabrasReservadas;
    while(recorridoPR!=NULL){
       printf("La palabra reservada %s",recorridoPR->palabraReservada);
       printf(" tiene un tipo  %s \n",recorridoPR->tipo);
       recorridoPR=recorridoPR->sig;
    }
    
    NodoConstanteOctal *recorridoCO;
    recorridoCO=raizConstanteOctal;
    while(recorridoCO!=NULL){
       printf("La constante octal %s",recorridoCO->datoEnOctal);
       printf(" vale en decimal  %d \n",recorridoCO->decimal);
       recorridoCO=recorridoCO->sig;
    }
    
    NodoConstanteHexa *recorridoCH;
    recorridoCH=raizConstanteHexa;
    while(recorridoCH!=NULL){
       printf("La constante hexa %s",recorridoCH->datoEnHexa);
       printf(" vale en decimal  %d \n",recorridoCH->decimal);
       recorridoCH=recorridoCH->sig;
    }
    
    NodoConstanteDecimal *recorridoD;
    recorridoD=raizConstanteDecimal;
    while(recorridoD!=NULL){
       printf(" decimal  %d \n",recorridoD->decimal);
       recorridoD=recorridoD->sig;
    }
    
    NodoConstanteReal *recorridoR;
    recorridoR=raizConstanteReal;
    while(recorridoR!=NULL){
       printf("el valor entero %d ",recorridoR->parteEntera);
       printf(" con mantiza %f \n",recorridoR->mantiza);
       recorridoR=recorridoR->sig;
    }
    
    NodoConstanteCaracter *recorridoC;
    recorridoC=raizConstanteCaracter;
    while(recorridoC!=NULL){
       printf("el caracter %s \n",recorridoC->caracter);
       recorridoC=recorridoC->sig;
    }
    
    NodoOperOCaractPunt *recorridoCP;
    recorridoCP=raizOperOCaractPunt;
    while(recorridoCP!=NULL){
       printf("el caracter de ope o punt %s ",recorridoCP->caracter);
       printf("aparece estas veces: %d \n",recorridoCP->cantidadOperOCaractPunt);

       recorridoCP=recorridoCP->sig;
    }

    NodoComentario *recorridoComen;
    recorridoComen=raizComentario;
    while(recorridoComen!=NULL){
       
       printf("el comentario %s",recorridoComen->comentario);
       printf(" es de tipo %s \n",recorridoComen->tipo);
       recorridoComen=recorridoComen->sig;
    }
    return 0;
} 

