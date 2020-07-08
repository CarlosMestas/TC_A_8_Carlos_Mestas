%{
    #include <stdio.h>
    #include <stdlib.h>
    #define YYDEBUG 1
    extern int yylex(void);
    extern char *yytext;
    void yyerror(char* s);

%}
%token NUM
%token EOL

%left '+' '-'
%left '*' '/'

%%

stm_lst: stm stm_lst EOL 
       | stm EOL 
       ;

stm: exp ';'        {printf("= %d \n",$1);
                    exit(0);}
   ;

exp: exp '-' exp   { $$= $1 - $3;}
   | exp '+' exp   { $$= $1 + $3;}
   | exp '*' exp   { $$= $1 * $3;} 
   | exp '/' exp   { 
                      if($3!=0){
                        $$= $1 / $3;
                        }
                      else{
                        yyerror("No hay division entre 0");
                        $$ = 0;
                      }
                    }
   | exp '+' error  {printf("Error en la suma ... segundo termino\n");
                    yyerrok;
                    yyclearin;
                    }
   | error '+' exp  {printf("Error en la suma ... primer termino\n");
                    yyerrok;
                    yyclearin;
                    }
   | exp '-' error  {printf("Error en la resta ... segundo termino\n");
                    yyerrok;
                    yyclearin;
                    }
   | error '-' exp  {printf("Error en la resta ... primer termino\n");
                    yyerrok;
                    yyclearin;
                    }
   | exp '*' error  {printf("Error en la multiplicacion ... segundo termino\n");
                    yyerrok;
                    yyclearin;
                    }
   | error '*' exp  {printf("Error en la multiplicacion ... primer termino\n");
                    yyerrok;
                    yyclearin;
                    }
   | exp '/' error  {printf("Error en la division ... segundo termino\n");
                    yyerrok;
                    yyclearin;
                    }
   | error '/' exp  {printf("Error en la division ... primer termino\n");
                    yyerrok;
                    yyclearin;
                    }                 
   |  '(' exp ')'   { $$= $2;}
   |  NUM           { $$= $1;}
   ;
%%

void yyerror(char* s){
    printf("\tError sintactico: %s \n",s);
}

int main(int argc,char **argv){
    yydebug = 0;
    yyparse();
    return 0;
}