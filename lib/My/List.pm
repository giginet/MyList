#
# List.pm
# created by giginet on 2011/8/14
# 
package My::List;
use strict;
use warnings;
use My::Element;
use My::Iterator;

sub new{
  my $class = shift;
  my $elems = @_;
  my $values = {
    _root => undef,
    _size => 0,
  };
  my $self = bless $values, $class;
  foreach (@_){
    $self->append($_);
  }
  return $self;
}

sub append{
  my($self, $value) = @_;
  my $parent = $self->_last_node;
  my $element = My::Element->new($value, $parent, undef);
  if(defined $self->last){
    $self->_last_node->set_child($element);
  }else{
    $self->{"_root"} = \$element;
  }
  ++$self->{"_size"};
}

sub size{
  my $self = shift;
  return $self->{"_size"};
}

sub iterator{
  my $self = shift;
  return My::Iterator->new($self);
}

sub first{
  my $self = shift;
  my $first = $self->_first_node;
  if(defined $first){
    return $first->value;
  }
  return undef;
} 

sub last{
  my $self = shift;
  my $last_node = $self->_last_node;
  if(defined $last_node){
    return $last_node->value;
  }
  return undef;
}

sub is_empty{
}

sub clear{
}

sub get{
}

sub pop{
}

sub _first_node{
  my $self = shift;
  my $first = $self->{"_root"};
  if(defined $first){
    return $$first;
  }
  return undef;
}

sub _last_node{
  my $self = shift;
  my $current = $self->_first_node;
  while($current and $current->child){
    $current = $current->child;
  }
  return $current;
}

1;
