%option noyywrap
%{
/* Reconoce números enteros y palabras alfabéticas; además,
 cuenta las ocurrencias de ambos */
#include <stdio.h>






int nros = 0, pals = 0;




%}
  //REGLAS   
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