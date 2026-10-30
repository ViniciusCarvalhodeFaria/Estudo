%option noyywrap

%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "ex1.tab.h"
%}

DIGITO [0-9]
NUM {DIGITO}+
VALOR_REAL {DIGITO}+\.{DIGITO}+
SOMA_SINAL [+]
SUB_SINAL [-]
LPAR [(]
RPAR [)]
DTYPES int|float|double|char|void
NEW_LINE \n

%%
[\t]+   ;
{VALOR_REAL} {
        yylval.fval = atof(yytext);
        return T_FLOAT;
}
{NUM} {
    yylval.ival = atoi(yytext);
    return T_INT;
}
{NEW_LINE} 	{
	return T_NEWLINE;
}
{LPAR} 	{
	return T_LPAR;
}
{RPAR} 	{
	return T_RPAR;
}
{SOMA_SINAL} 	{
	return T_MAIS;
}
{SUB_SINAL} 	{
	return T_MENOS;
}



%%