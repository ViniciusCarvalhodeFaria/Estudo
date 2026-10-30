%option noyywrap


%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int cont = 0;

%}

%%

[A-Z][A-Za-z]* { cont++; }
[a-z][A-Za-z]* ;
. | \n         ;

%%

int main(int argc, char **argv) {
 if (argc > 1){
        yyin = fopen(argv[1], "r");
        if (!yyin) { perror(argv[1]); return 1; }
    }
    yylex();
    printf("%d\n", cont);
    return 0;
}