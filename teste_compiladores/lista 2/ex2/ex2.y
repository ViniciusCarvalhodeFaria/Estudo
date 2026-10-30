%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yyparse();
extern int yylex();

extern FILE *yyin;

void yyerror(const char* s);
%}

%union{
    int ival;
    float fval;
}

%token<ival> T_INT
%token<fval> T_FLOAT
%token T_MAIS T_MENOS T_DIV T_MUL T_LPAR T_RPAR T_NEWLINE

%left T_MENOS T_MAIS

%left T_DIV T_MUL

%type<fval> exp
%type<fval> fator

%start calculo

%%

calculo: | calculo linha;

linha: exp T_NEWLINE{
    printf("resultado: %f\n", $1);
}
| T_NEWLINE
;
exp: exp T_MAIS exp{
    $$ = $1 + $3;
}
| exp T_MENOS exp {
        $$ = $1 - $3;
        }
| exp T_DIV exp {
    $$ = $1 / $3;
}
| exp T_MUL exp{
    $$ = $1 *  $3;
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

int main ( int argc , char **argv){
    if(argc > 1){
        yyin = fopen(argv[1], "r");
    }

    do{
        yyparse();
    }while(!feof(yyin));

    fclose(yyin);

    return 0;
}

void yyerror ( const char* s){
    fprintf(stderr, "Parse error %s\n", s);
    exit(1);
}