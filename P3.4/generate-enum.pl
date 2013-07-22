use strict;
use warnings;
use feature qw(say);

my @tokens = qw(ID OPEN_TAG_OPEN OPEN_TAG_CLOSE CLOSE_TAG_NONEMPTY CLOSE_TAG_EMPTY OPEN_SCRIPTLET OPEN_EXPRESSION OPEN_DIRECTIVE OPEN_DECLARATION SCOPE);

say('typedef enum {' . join(', ', @tokens) . '} token;');
say('char *token_to_string[] = {' . join(', ', map("\"$_\"", @tokens)) . '};');
