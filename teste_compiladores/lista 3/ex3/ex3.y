%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>


extern int yylex();
extern int yyparse();

extern FILE* yyin;

void yyerror(const char* s);


#define MAX 100
struct { char nome[32]; double valor; } tab[MAX];
int n = 0;

double busca(const char *nome) {
    for (int i = 0; i < n; i++)
        if (strcmp(tab[i].nome, nome) == 0) return tab[i].valor;
    fprintf(stderr, "variavel '%s' nao definida\n", nome);
    return 0;
}

void guarda(const char *nome, double v) {
    for (int i = 0; i < n; i++)
        if (strcmp(tab[i].nome, nome) == 0) { tab[i].valor = v; return; }
    if (n < MAX) { strcpy(tab[n].nome, nome); tab[n].valor = v; n++; }
}
%}

%union{
    double num;
    char *id;
}

%token<id> T_ID
%token<num> T_NUM
%token T_MAIS T_MENOS T_MULT T_DIV T_ATRIB T_APAR T_FPAR T_NEWLINE
%token T_SIN T_COS T_SQRT    

%left T_MAIS T_MENOS
%left T_MULT T_DIV

%type<num> exp termo fator
%start calculo

%%
calculo: | calculo linha;

linha:  T_NEWLINE | exp T_NEWLINE {printf("%g\n",$1);}| T_ID T_ATRIB exp {guarda($1,$3); printf("%s = %g", $1, $3);}
%%



int main(){

}

void yyerror( const char* s){
    fprintf(stderr, " erro: %s", s);
    exit(1);
}