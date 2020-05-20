#include <stdio.h>
#include <malloc.h> 
#include <string.h>      

typedef struct{ //relleno de matriz
    int estadoSig;
    char elemento[2];  
}datoTT;

typedef struct pila{ //contenido de la pila
    char dato;
    struct pila *sig;
}Pila;

typedef Pila * PilaPtr; // Puntero para acceder a la pila


//defimos funciones
int selecColumna (char); //Selecciona la columna dependiendo del caracter leido de la expresión
void insertar(PilaPtr *tope, char dato); //mandas puntero y lo q queres agregar
char eliminar(PilaPtr *tope);//elimina ultimo nodo
int cimaPila(PilaPtr *tope); //ya devuelve 0=$ o 1=R para saber a cual de las dos matrices entrar

//definimos datos globales
datoTT auxCopiaDatosMatriz;

char caractSalida;
char expresion [50];

int recExpr;//es i para recorrer la palabra
int caracter;//a que columna corresponde(en relacion al caracter leido de la expresión)
int estado;
int cima;//cima de la pila
char elementoSuperior; //variable donde se guarda la cima

datoTT tt[6][4][2]={
     {{{3,"$"},{3,"R"}},{{1,"$"},{1,"R"}},{{3,"$"},{3,"R"}},{{3,"$"},{3,"R"}}},
     {{{1,"$"},{1,"R"}},{{1,"$"},{1,"R"}},{{3,"$"},{3,"R"}},{{3,"$"},{3,"R"}}},
     {{{3,"$"},{3,"R"}},{{0,"$"},{0,"R"}},{{0,"$"},{0,"R"}},{{3,"$"},{3,"R"}}},
     {{{0,"R$"},{3,"RR"}},{{3,"$"},{3,"R"}},{{3,"$"},{3,"R"}},{{3,"$"},{3,"R"}}},
     {{{3,"$"},{3,"R"}},{{3,"$"},{2,"Ɛ"}},{{3,"$"},{2,"Ɛ"}},{{3,"$"},{3,"R"}}},
     {{{3,"$"},{3,"R"}},{{3,"$"},{2,"R"}},{{3,"$"},{2,"R"}},{{3,"$"},{3,"R"}}},
     
};



int main()
{
    
    do{
        PilaPtr tope=NULL;
        recExpr=0;
        estado=0;
        insertar(&tope,'$');
        printf("Ingrese la expresion que desea averiguar si es valida o invalida\n");
        scanf(" %s",&expresion);   
        while(expresion[recExpr]!='\0' && estado!=3) {
            if(expresion[recExpr]!=32) // distinto del espacio
            {
             caracter=selecColumna(expresion[recExpr]); //devuelve la columna en la entra el caracter en al matriz
             cima=cimaPila(&tope);
             auxCopiaDatosMatriz=tt[caracter][estado][cima];
             estado=auxCopiaDatosMatriz.estadoSig;
            
             elementoSuperior=eliminar(&tope);     //Pop
             insertar(&tope,elementoSuperior);     //Push
             
            if((strcmp(auxCopiaDatosMatriz.elemento,"RR")==0) ||(strcmp(auxCopiaDatosMatriz.elemento,"R$")==0)){
                 insertar(&tope,'R');
            }
            if(strcmp(auxCopiaDatosMatriz.elemento,"Ɛ")==0){
                char inservible=eliminar(&tope); 
            }
            
            
            
            
             //if(auxCopiaDatosMatriz.elemento=="RR"||auxCopiaDatosMatriz.elemento=="R$"){
             //  insertar(&tope,'R');
             //}
             //if(auxCopiaDatosMatriz.elemento=="Ɛ"){
             //   char inservible=eliminar(&tope); 
             //}   
             
             
            }          
        recExpr++;
        }   
        //(strcmp(res, "No") != 0)
        if(estado==3||tope->dato!='$'){
            printf("La expresion %s",expresion);
            printf("es invalida \n");
        }else{
            printf("La expresion %s",expresion);
            printf(" es valida \n");
        }
        
        //dice si es valido o no
        //ciclo q elimine toda la cola
        
        printf("Ingrese el caracter Y/y si desea ingresar otra expresion, sino ingrese N/n\n");
        scanf(" %s",&caractSalida);    
    }while(caractSalida=='y'||caractSalida=='Y');
    return 0;
}    
    

int selecColumna (char caracter) 
 {
    int columnaCaracter;
        if  (caracter==48)
        {
           //48 es 0 en ascii
           columnaCaracter=0;
       } else if (caracter>=49 && caracter <=57)
       {
           // 1-9
           columnaCaracter=1;
       } else if (caracter==42 || caracter==43 || caracter==45 || caracter==47)
       {
           // * + - /
           columnaCaracter = 2;
       } else if (caracter == 40)
       {
           // (
           columnaCaracter = 3;
       } else if (caracter==41)
       {
           // )
           columnaCaracter = 4;
       } else 
       {
           columnaCaracter = 5;
       }

    return columnaCaracter;
 }


void insertar(PilaPtr *tope, char dato){
    PilaPtr nuevo; 
    nuevo=(PilaPtr) malloc(sizeof(Pila));//reservar memoria
    nuevo->dato=dato;
    nuevo->sig=*tope;   
    *tope=nuevo;

}

char eliminar(PilaPtr *tope){
    PilaPtr temp;
    char dato;
    temp=*tope;
    dato=temp->dato;
    *tope=(*tope)->sig;
    free(temp);
    return dato;
}

int cimaPila(PilaPtr *tope){
    
    char aux;
    aux=(*tope)->dato;
    if(aux=='$'){
        return 0;
    }else{
        return 1;
    }
    
}










