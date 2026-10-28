%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>


extern int yylex();
extern int yyparse();

extern FILE* yyin;

void yyerror(const char* s);
%}

%union{
    int ival;
    float fval;
}

%token<ival> T_INT
%token<fval> T_FLOAT

%token T_MAIS T_MENOS T_LPAR T_RPAR T_DIV T_MUL
%token T_NEWLINE

%left T_MAIS T_MENOS
%left T_MUL T_DIV

%type<fval> exp
%type<fval> termo
%type<fval> fator   

%start calculo

%%
calculo: // Vazio / epsilon
        | calculo linha // corpo da regra
        ; // finalização da regra

linha : exp T_NEWLINE {
            printf("Resultado: %f\n", $1);
        }
        | T_NEWLINE // Consumo de linhas vazias
        ;

exp : exp T_MAIS termo {
            $$ = $1 + $3; 
        }
      | exp T_MENOS termo { 
            $$ = $1 - $3;
        }

      | termo {
            $$ = $1; 
       }
      ;

termo : termo T_MUL fator{ 
            $$ = $1 * $3;
        }
        | termo T_DIV fator { 
            $$ = ((1.0) * $1 )/((1.0) * $3);
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

int main(int argc, char **argv){
    if(argc > 1){
        yyin = fopen(argv[1], "r");
        if (yyin == NULL){
            printf("Problema na leitura do arquivo.");
            return -1;
        }
    }
    else{
        yyin = fopen("./exp2.txt","r");
        if(yyin == NULL){
            printf("Problema na leitura do arquivo padrão.");
            return -1;
        }
    }

    do{ // Estrutura em Loop para análise sintática
        yyparse();
    }while(!feof(yyin));

    fclose(yyin);

    return 0;
}

void yyerror(const char *s){
    fprintf(stderr, "Parse error %s\n", s);
    exit(1);
}