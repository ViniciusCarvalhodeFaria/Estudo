%option noyywrap

%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>


void install_num ( char *texto, int eh_float){
    if(eh_float){
        printf("%f é float\n", atof(texto));
    }
    else{
        printf("%i é inteiro\n", atoi(texto));
    }
}
%}

%%

[0-9]+\.[0-9]+ {install_num(yytext, 1);}
[0-9]+ {install_num(yytext, 0);}
\n|.                          ;

%%

int main ( int argc, char **argv){
    if (argc>1){
        yyin = fopen(argv[1], "r");
        if (!yyin){
        perror(argv[1]);
        return 1;
        }
    }
    yylex();
    return 0;

}

