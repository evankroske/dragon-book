use strict;
use warnings;

my @constants = ();
while (<>) {
	push(@constants, $1) if /([[:upper:]][[:upper:]_]+)/
}
print('qw(' . join(' ', @constants) . ')')
