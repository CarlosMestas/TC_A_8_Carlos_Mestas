%{
    #include "sintactico.tab.h"
    /*
    externt yylval
    */
%}
number [0-9]+
%%
{number}              {yylval = atoi(yytext); return (NUM);}
"\n"                  {return (EOL);}
.                     {return yytext[0];}
%%
int yywrap(){
    return 0;
}

