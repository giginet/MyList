#
# Iterator.pm
# created by giginet on 2011/8/14
#
#
=head1 モジュール名

My/Iterator.pm

=head1 概要

リストの要素を操作するイテレータです

=head2 new
新しいイテレータを生成します。
引数に与えたリストと関連づけて生成します

@param リスト
@return 新たに生成されたイテレータ

=head2 has_next
次の要素があるかどうかを返します

@return 次のノードがあるかどうか

=head2 has_prev
前の要素があるかどうかを返します

@return 前の要素があるかどうか

=head2 next
次の要素を返します

@return 次の要素

=head2 prev
前の要素を返します

@params 前の要素

=head1 作者

giginet

=cut

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

sub has_prev{
  my $self = shift;
  my $current = $self->{"_cursor"};
  if(defined $current){
    return defined $$current->parent;
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
