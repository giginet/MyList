#
# Iterator.pm
# created by giginet on 2011/8/14
#
package My::Iterator;
use strict;
use warnings;

sub new{
  my ($class, $list) = @_;
  my $self = {
    _list => \$list,
  _cursor => undef,
};
return bless $self, $class;
}

sub has_next{
  my $self = shift;
  my $current = $self->{"_cursor"};
  if(defined $current){
    return defined $$current->child;
  }else{
    my $list = $self->{"_list"};
    return defined $$list->first;
  }
  return 0;
}

sub next{
  my $self = shift;
  if($self->has_next){
    my $current = $self->{"_cursor"};
    my $list = $self->{"_list"};
    my $next;
    unless(defined $current){
      $next = $$list->_first_node;
    }else{
      $next = $$current->child;
    }
    $self->{"_cursor"} = \$next;
    return $next;
  }
  return undef;
}

sub has_prev{
  my $self = shift;
  my $current = $self->{"_cursor"};
  if(defined $current){
    return defined $$current->parent;
  }
  return 0;

}

sub prev{
  my $self = shift;
  my $current = $self->{"_cursor"};
  my $prev;
  if($self->has_prev){
    if(defined $current){
      $prev = $$current->parent;
      $self->{"_cursor"} = \$prev;
      return $prev;
    }
  }
  return undef;
}

1;
