%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yyparse();

extern FILE* yyin;

void yyerror(const char* s);

%}

/* "extern" avisa o C: "essa coisa existe em OUTRO arquivo".
   yylex  -> vem do Flex (lex.yy.c); entrega o proximo token
   yyparse-> vem do proprio Bison; faz a analise sintatica
   yyin   -> arquivo de onde o Flex le o texto */




%union {
    int ival;
    float fval;
}

%token<ival> T_INT
%token<fval> T_FLOAT
%token T_MAIS T_MENOS T_LPAR T_RPAR
%token T_NEWLINE

%left T_MAIS T_MENOS

%type<fval> exp
%type<fval> fator

%start calculo

%%

calculo: | calculo linha; 

linha: exp T_NEWLINE {
        printf("resultado: %f\n", $1);
    }
    | T_NEWLINE
    ;

exp : exp T_MAIS fator {
            $$ = $1 + $3;
        }
    | exp T_MENOS fator {
        $$ = $1 - $3;
        }
    | fator { 
        $$ = $1;
    }
    ;
fator : T_LPAR exp T_RPAR{
            $$ = $2;
        }
    | T_INT { $$ = $1;}
    | T_FLOAT {$$ = $1;}
    ;

%%

int main ( int argc, char **argv){
    yyin = fopen(argv[1], "r");
    do{
        yyparse();
    }while(!feof(yyin));

    fclose(yyin);

    return 0;
}

void yyerror(const char* s){
    fprintf(stderr, "Parse error %s\n", s);
    exit(1);
}