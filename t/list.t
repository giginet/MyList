#
# List.pm
# created by giginet on 2011/8/14
# 
package test::List;
use strict;
use warnings;
use base qw(Test::Class);
use Test::More;
use My::List;

sub init : Test(1){
  new_ok 'My::List';
}

sub setup : Test(setup){
  my $self = shift;
  $self->{"list"} = My::List->new;
}

sub get : Tests{
  my $self = shift;
  my $list = $self->{"list"};
  is $list->first, undef;
  is $list->last, undef;
}

sub append : Tests{
  my $self = shift;
  my $list = $self->{"list"};
  $list->append("はてな");
  is $list->size, 1;
  is $list->first, "はてな";
  is $list->last, "はてな";
  $list->append("しなもん");
  is $list->first, "はてな";
  is $list->last, "しなもん";
  $list->append("はてなようせい");
  is $list->last, "はてなようせい";
}

__PACKAGE__->runtests;

1;
