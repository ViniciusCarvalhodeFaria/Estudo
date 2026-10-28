%option noyywrap

%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>  
int contM=0;
int contm = 0;
int num = 0;

%}

%%

[A-Z] {contM++;}
[a-z] {contm++;}
[0-9] {num++;}
. | \n       ;

%%

int main ( int argc, char **argv) {
    if (argc >1){
        yyin = fopen(argv[1], "r");
        if (!yyin) { perror(argv[1]); return 1; }
    yylex();
    printf("%d\n", contM);
    printf("%d\n", contm);
    printf("%d\n", num);
    return 0;
    }
}