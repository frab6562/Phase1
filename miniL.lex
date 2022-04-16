/* cs152-miniL phase1 */
%{   
/* write your C code here for definitions of variables and including headers */
int currLine = 1, currpos = 1;
int numIntegers = 0;
int numOperators = 0;
int munParens = 0;
int numEquals = 0;
%}
   /* some common rules */
DIGIT	[0-9]
LETTER	[a-z|A-Z]
IDENT	{LETTER}([_]*{LETTER}*{DIGIT}*)*({LETTER}|{DIGIT})

%%
 /* specific lexer rules in regex */
"function"	{printf("FUNCTION\n"); currpos += yyleng;}
"beginparams"   {printf("BEGIN_PARAMS\n"); currpos += yyleng;}
"endparams"	{printf("END_PARAMS\n"); currpos += yyleng;} 
"beginlocals"	{printf("BEGIN_LOCALS\n"); currpos += yyleng;}
"endlocals"	{printf("END_LOCALS\n"); currpos += yyleng;}
"beginbody"	{printf("BEGIN_BODY\n"); currpos += yyleng;}
"endbody"	{printf("END_BODY\n"); currpos += yyleng;}
"integer"	{printf("INTEGER\n"); currpos += yyleng;}
"array"		{printf("ARRAY\n"); currpos += yyleng;}
"enum"		{printf("ENUMR\n"); currpos += yyleng;}
"of"		{printf("OF\n"); currpos += yyleng;}
"if"		{printf("IF\n"); currpos += yyleng;}
"then"		{printf("THEN\n"); currpos += yyleng;}
"endif"		{printf("ENDIF\n"); currpos += yyleng;}
"else"		{printf("ELSE\n"); currpos += yyleng;}
"for"		{printf("FOR\n"); currpos += yyleng;}
"while"		{printf("WHILE\n"); currpos += yyleng;}
"do"		{printf("DO\n"); currpos += yyleng;}
"beginloop"	{printf("BEGIN_LOOP\n"); currpos += yyleng;}
"endloop"	{printf("END_LOOP\n"); currpos += yyleng;}
"continue"	{printf("CONTINUE\n"); currpos += yyleng;}
"read"		{printf("READ\n"); currpos += yyleng;}
"write"		{printf("WRITE\n"); currpos += yyleng;}
"and"		{printf("AND\n"); currpos += yyleng;}
"or"		{printf("OR\n"); currpos += yyleng;}
"not"		{printf("NOT\n"); currpos += yyleng;}
"true"		{printf("TRUE\n"); currpos += yyleng;}
"false"		{printf("FALSE\n"); currpos += yyleng;}
"return"	{printf("RETURN\n"); currpos += yyleng;}

"-"           	{printf("SUB\n"); currpos += yyleng;}
"+"           	{printf("ADD\n"); currpos += yyleng;}
"*"             {printf("MULT\n"); currpos += yyleng;}
"/"             {printf("DIV\n"); currpos += yyleng;}
"%"		{printf("MOD\n"); currpos += yyleng;}


"=="		{printf("EQ\n"); currpos += yyleng;}
"<>"		{printf("NEQ\n"); currpos += yyleng;}
"<"		{printf("LT\n"); currpos += yyleng;}
">"		{printf("GT\n"); currpos += yyleng;}
"<="		{printf("LTE\n"); currpos += yyleng;}
">="		{printf("GTE\n"); currpos += yyleng;}

{DIGIT}+        {printf("NUMBER %s\n", yytext);currpos += yyleng;}
{LETTER}	{printf("IDENT %s\n", yytext); currpos += yyleng;} 
{IDENT}         {printf("IDENT %s\n", yytext); currpos += yyleng;} 
([_]+{DIGIT}*{IDENT}*)    {printf("Error at line %d, column %d: identifier \"%s\" cannot start with an underscore\n", currpos, currLine, yytext); exit(0);}
({IDENT}[_])    {printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", currpos, currLine, yytext); exit(0);}
({DIGIT}+{IDENT}) {printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", currpos, currLine, yytext); exit(0);}

";"		{printf("SEMICOLON\n"); currpos += yyleng;}
":"		{printf("COLON\n"); currpos += yyleng;}
","		{printf("COMMA\n"); currpos += yyleng;}
"("		{printf("L_PAREN\n"); currpos += yyleng;}
")"		{printf("R_PAREN\n"); currpos += yyleng;}
"["		{printf("L_SQUARE_BRACKET\n"); currpos += yyleng;}
"]"		{printf("R_SQUARE_BRACKET\n"); currpos += yyleng;}
":="		{printf("ASSIGN\n"); currpos += yyleng;}

[##].* 		{currLine++; currpos = 1;}
[ ] 		{currpos += yyleng;}
[ \t]           {currpos += yyleng;}
"\n"            {currLine++; currpos = 1;}

.               {printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currpos, yytext); exit(0);}

%%
 /* C functions used in lexer */
int main(int argc, char ** argv)
{
  yylex();
  if (argc >= 2) {
    if (yyin == NULL) {
      yyin = stdin;
    }
  }
  else {
    yyin = stdin;
  }
  yylex();
  return 0;
}
