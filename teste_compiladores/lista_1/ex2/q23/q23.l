%option noyywrap

%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int v = 0;
int c =0;
%}

%%
[a-z] {v++;}
[A-Z] {c++;}
.|\n      ;
%%

int main(int argc, char **argv){
    if(argc>1){
        yyin = fopen(argv[1], "r");

        yylex();
        printf( "%i e %i", v , c);

        return 0;


    }
}

