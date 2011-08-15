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
  my $self = shift;
  return !($self->size);
}

sub clear{
  my $self = shift;
  $self->{"_root"} = undef;
  $self->{"_size"} = 0;
}

sub get{
  my($self, $index) = @_;
  return undef if($index < 0 or $index >= $self->size);
  my $itr = $self->iterator;
  foreach (0...$index-1){
    $itr->next
  }
  return $itr->next->value;
}

sub pop{
  my $self = shift;
  my $last_node = $self->_last_node;
  unless(defined $last_node){
    return undef;
  }
  my $prev_node = $last_node->parent;
  if(defined $prev_node){
    $prev_node->set_child(undef);
    $last_node->set_parent(undef);
  }else{
    $self->{"_root"} = undef;
  }
  --$self->{"_size"};
  return $last_node->value;
}

sub to_list{
  my $self = shift;
  my $itr = $self->iterator;
  my @list;
  push(@list, $itr->next->value) while($itr->has_next);
  return @list;
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
