%option noyywrap

delim	[ \t\n]
ws	{delim}+
letter	[[:alpha:]]
digit	[[:digit:]]
id	({letter}|_)({letter}|{digit}|_)*

%%

{ws}
{id}	{return ID;}
"<"	{return OPEN_TAG_OPEN;}
"</"	{return OPEN_TAG_CLOSE;}
">"	{return CLOSE_TAG_NONEMPTY;}
"/>"	{return CLOSE_TAG_EMPTY;}
"<%"	{return OPEN_SCRIPTLET;}
"%>"	{return CLOSE_JSP;}
"<%="	{return OPEN_EXPRESSION;}
"<%@"	{return OPEN_DIRECTIVE;}
"<%!"	{return OPEN_DECLARATION;}
":"	{return SCOPE;}

%%

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
