#
# Element.pm
# created by giginet on 2011/8/14
# 
package My::Element;
use strict;
use warnings;

sub new{
  my($class, $value, $parent, $child) = @_;
  my $self = {
    _parent => $parent,
    _value => $value,
    _child => $child
  };
  return bless $self, $class;
}

sub value{
  my $self = shift;
  return $self->{"_value"};
}

sub set_value{
  my($self, $value) = @_;
  $self->{"_value"} = $value;
}

sub parent{
  my $self = shift;
  my $parent = ${$self->{"_parent"}};
  if(defined $parent){
    return $$parent;
  }
  return undef;

}

sub set_parent{
  my($self, $parent) = @_;
  $self->{"_parent"} = \$parent;
}

sub child{
  my $self = shift;
  my $child = $self->{"_child"};
  if(defined $child){
    return $$child;
  }
  return undef;
}

sub set_child{
  my($self, $child) = @_;
  $self->{"_child"} = \$child;
}


1;
