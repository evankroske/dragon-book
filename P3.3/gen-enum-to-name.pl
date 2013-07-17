use strict;
use warnings;
use feature qw(say);

my @constants = qw(LT LE EQ NE GT GE IF THEN ELSE ID NUMBER RELOP);
my @quoted = map { qq/"$_"/ } @constants;
my $strings = join(', ', @quoted);
say "char *relop_to_name[] = {$strings};"
