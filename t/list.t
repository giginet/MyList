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
  is $list->first, undef, "リストが空の時、最初のデータを取得できない";
  is $list->last, undef, "リストが空の時、最後のデータを取得できない";
}

sub append : Tests{
  my $self = shift;
  my $list = $self->{"list"};
  $list->append("はてな");
  is $list->first, "はてな", "データ一つ追加時、一番最初の要素が取得できる";
  is $list->last, "はてな", "データ一つ追加時、一番最後の要素が取得できる";
  $list->append("しなもん");
  is $list->first, "はてな", "データ複数個追加時、一番最初の要素が取得できる";
  is $list->last, "しなもん", "データ複数個追加時、一番最後の要素が取得できる";
  my $ref = "はてなようせい";
  $list->append(\$ref);
is $list->last, \$ref, "リファレンスが追加できる";
  $list->append([1,1,2,3,5,8,13]);
  is_deeply $list->last, [1,1,2,3,5,8,13], "Arrayが追加できる";
  $list->append({Suzumiya => "Haruhi", Nagato => "Yuki", Asahina => "Mikuru"});
  is_deeply $list->last, {Suzumiya => "Haruhi", Nagato => "Yuki", Asahina => "Mikuru"}, "Hashが追加できる";
  is $list->size, 5 , "追加した要素の数が正しく取得できる";
}

sub iterator : Tests{
  my $self = shift;
  my $list = $self->{"list"};
  $list->append("はてな");
  my $itr = $list->iterator;
  ok $itr->has_next, "次の値を持っている";
  $list->append("しなもん");
  ok $itr->has_next, "次の値を持っている";
  ok !($itr->has_prev), "前の値を持っていない";
  is $itr->next->value, "はてな", "nextで一つ目の値が取り出せる";
  is $itr->next->value, "しなもん", "nextでそれ以降の値が取り出せる";
  is $itr->prev->value, "はてな", "prevで一つ前の値が取り出せる";
  is $itr->prev, undef, "prevでundefが取り出せる";
  $itr->next;
  foreach (0..100){
    $list->append($_);
  }
  my $times = int(rand() * 100);
  for(my $i=0;$i<$times;++$i){
    $itr->next;
  }
  is $itr->next->value, $times, "nextを複数回実行した場合、次の値が取り出せる";
}
__PACKAGE__->runtests;

1;
