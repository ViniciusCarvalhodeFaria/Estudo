%option noyywrap

%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int n = 0;
#define MAX 1000
char *buffer[MAX];
%}

%%

[R][$][ ]*[0-9]+[,][0-9][0-9] {if(n < MAX){ buffer[n++] = strdup(yytext); }}
\n|.                                                                   ;

%%

int main ( int argc ,char ** argv){
    int i;
    if (argc>1){
        yyin = fopen(argv[1], "r");
        if (!yyin){
            perror(argv[1]);
            return 1;
        }
    }
        yylex();
        for ( i=0; i<n; i++){
            printf ("%s\n", buffer[i]);
            free(buffer[i]);

        }
        return 0; 
}