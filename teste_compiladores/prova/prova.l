%option noyywrap

%{
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
%}

%%
[_a-zA-Z][_a-zA-Z0-9]*  { printf("identificador: %s\n", yytext); }
[+-]?[0-9]+             { printf("inteiro: %s\n", yytext); }
[ \t\r\n]+              { /* ignora espaços */ }
.                       { }

%%

int main( int argc , char **argv){
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