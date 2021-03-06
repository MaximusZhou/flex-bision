/* 
* simplest version of calculator
* $bison -d fb1-5.y
* $cc -o fb1-5 fb1-5.tab.c lex.yy.c -lfl
*/

%{
#  include <stdio.h>
%}

/* declare tokens */
%token NUMBER
%token ADD SUB MUL DIV ABS
%token OP CP
%token EOL

%%


calclist: /* nothing  */
 | calclist exp EOL { printf("dex=%d,hex=0x%x\n> ", $2, $2); }
 | calclist EOL { printf("> "); } /* blank line or a comment */
 ;

exp: factor
 | exp ADD exp { $$ = $1 + $3; }
 | exp SUB factor { $$ = $1 - $3; }
 | exp ABS factor { $$ = $1 | $3; }
 ;

factor: term
 | factor MUL term { $$ = $1 * $3; }
 | factor DIV term { $$ = $1 / $3; }
 ;

term: NUMBER
 | ABS term { $$ = $2 >= 0? $2 : - $2; }
 | OP exp CP { $$ = $2; }
 ;
%%

int main()
{
  printf("> "); 
  yyparse();

  return 0;
}

yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}
