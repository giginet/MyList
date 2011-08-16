#
# sample.pl
# created by giginet on 2011/8/16
#
use My::List;
use strict;
use warnings;

my $list = My::List->new;
$list->append("Hello");
$list->append("World");
$list->append(2011);
my $iter = $list->iterator;
while ($iter->has_next) {
  print $iter->next->value;
}
