%{
typedef enum {NONE, LT, LE, EQ, NE, GT, GE, IF, THEN, ELSE, ID, NUMBER, RELOP} token;
char *relop_to_name[] = {"NONE", "LT", "LE", "EQ", "NE", "GT", "GE", "IF", "THEN", "ELSE", "ID", "NUMBER", "RELOP"};
typedef union {
	int l;
	double d;
} token_val;
token_val yylval;

double install_num();
%}
%option noyywrap

delim	[ \t\n]
ws	{delim}+
letter	[[:alpha:]]
digit	[[:digit:]]
id	{letter}({letter}|{digit})*
number	[+\-]?{digit}+(\.{digit}+)?(E[+\-]?{digit}+)?

%%

{ws}	{/* no action and no return */}
if	{return IF;}
then	{return THEN;}
else	{return ELSE;}
{id}	{yylval.l = install_id(); return (ID);}
{number}	{yylval.d = install_num(); return (NUMBER);}
"<"	{yylval.l = LT; return (RELOP);}
"<="	{yylval.l = LE; return (RELOP);}
"="	{yylval.l = EQ; return (RELOP);}
"<>"	{yylval.l = NE; return (RELOP);}
">"	{yylval.l = GT; return (RELOP);}
">="	{yylval.l = GE; return (RELOP);}

%%

int install_id()
{
	return 0;
}

double install_num()
{
	double n;
	sscanf(yytext, "%lf", &n);
	return n;
}

int main()
{
	token next;
	while (next = yylex()) {
		printf("%s: ", relop_to_name[next]);
		switch (next) {
			case RELOP:
				printf("%s\n", relop_to_name[yylval.l]);
			break;
			case NUMBER:
				printf("%lf\n", yylval.d);
			break;
			case ID:
				printf("%s\n", yytext);
			break;
			default:
				printf("\n");
			break;
		}
	}
	return 0;
}
