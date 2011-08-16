#
# List.pm
# created by giginet on 2011/8/14
# 
=head1 モジュール名

My/List.pm

=head1 概要

汎用双方向連結リストモジュールです

=head1 使い方

my $list = My::List->new;
$list->append("Hello");
$list->append("World");
$list->append(2011);
my $iter = $list->iterator;
while ($iter->has_next) {
  print $iter->next->value;
}

=head1 メソッド

=head2 new
新しいリストを生成します。
引数に与えた値でリストを初期化します。

@param リストの初期値
@return 新たに生成されたリスト

=head2 append
リストの末尾に要素を追加します。

@param 追加する要素

=head2 clear
リストを空にします。

=head2 first
リストの最初の要素を取り出します。
リストが空の場合はundefが返ります。

@return 0番目の要素、またはundef

=head2 get
リストの任意のindexの要素を取り出します。
indexを与えない場合や、indexが範囲外の時はundefを返します。

@param index 0から始まるindex
@return index番目の要素、またはundef

=head2 is_empty
リストが空かどうか判定します。

@return 1または空文字

=head2 iterator
リストのイテレータを返します。

@return イテレータ
@see My::Iterator

=head2 last
リストの末尾の要素を取り出します。
リストが空の場合はundefが返ります。

@return 末尾の要素、またはundef

=head2 pop
リストの末尾の要素を破壊的に削除し、その値を取り出します。
リストが空の場合はundefが返ります。

@return 末尾の要素、またはundef

=head2 size
リストの要素数を返します。

@return 要素数

=head2 to_array
リストをPerl標準のArrayにして返します。

@return Array

=head1 作者

giginet

=cut

package My::List;
use strict;
use warnings;
use My::List::Node;
use My::List::Iterator;

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
  my $node = My::List::Node->new($value, $parent, undef);
  if(defined $self->last){
    $self->_last_node->set_child($node);
  }else{
    $self->{"_root"} = \$node;
  }
  ++$self->{"_size"};
}

sub clear{
  my $self = shift;
  $self->{"_root"} = undef;
  $self->{"_size"} = 0;
}

sub first{
  my $self = shift;
  my $first = $self->_first_node;
  if(defined $first){
    return $first->value;
  }
  return undef;
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

sub is_empty{
  my $self = shift;
  return !($self->size);
}

sub iterator{
  my $self = shift;
  return My::List::Iterator->new($self);
}

sub last{
  my $self = shift;
  my $last_node = $self->_last_node;
  if(defined $last_node){
    return $last_node->value;
  }
  return undef;
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

sub size{
  my $self = shift;
  return $self->{"_size"};
}

sub to_array{
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
