%{
typedef enum {NONE, ID, OPEN_TAG_OPEN, OPEN_TAG_CLOSE, CLOSE_TAG_NONEMPTY, CLOSE_TAG_EMPTY, OPEN_SCRIPTLET, OPEN_EXPRESSION, OPEN_DIRECTIVE, OPEN_DECLARATION, CLOSE_JSP, SCOPE} token;
char *token_to_string[] = {"NONE", "ID", "OPEN_TAG_OPEN", "OPEN_TAG_CLOSE", "CLOSE_TAG_NONEMPTY", "CLOSE_TAG_EMPTY", "OPEN_SCRIPTLET", "OPEN_EXPRESSION", "OPEN_DIRECTIVE", "OPEN_DECLARATION", "CLOSE_JSP", "SCOPE"};
%}

%option noyywrap

delim	[ \t\n]
ws	{delim}+
letter	[[:alpha:]]
digit	[[:digit:]]
id	({letter}|_)({letter}|{digit}|_)*

%%

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
.	{ECHO;}

%%

int main()
{
	token next;
	while (next = yylex()) {
		printf("[%s: \"%s\"]", token_to_string[next], yytext);
	}
	return 0;
}
