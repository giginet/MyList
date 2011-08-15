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

sub empty : Tests{
  my $list = My::List->new;
  ok $list->is_empty, "リストが空";
  $list->append("はてな");
  ok !($list->is_empty), "リストが空ではない";
  $list->clear;
  is $list->first, undef, "リストが初期化できる";
}

sub get : Tests{
  my $self = shift;
  my $list = $self->{"list"};
  is $list->first, undef, "リストが空の時、最初のデータを取得できない";
  is $list->last, undef, "リストが空の時、最後のデータを取得できない";
  foreach (0...100){
    $list->append($_);
  }
  is $list->get(0), 0, "0番目の値が取得可能";
  my $index = int(rand() * 100);
  is $list->get($index), $index, "任意のインデックスの値が取得可能";
  is $list->get(101), undef, "インデックスの値が範囲外のとき取得できない";
  is $list->get(-1), undef, "インデックスの値がマイナスのとき取得できない";
}

sub iterator : Tests{
  my $self = shift;
  my $list = $self->{"list"};
  my $itr = $list->iterator;
  ok !($itr->has_next), "リストが空の時、次の値を持っていない";
  ok !($itr->has_prev), "リストが空の時、前の値を持っていない";
  $list->append("はてな");
  ok $itr->has_next, "次の値を持っている";
  is $itr->next->value, "はてな", "nextで一つ目の値が取り出せる";
  ok !($itr->has_next), "次の値を持っていない";
  ok !($itr->has_prev), "前の値を持っていない";
  $list->append("しなもん");
  ok $itr->has_next, "次の値を持っている";
  is $itr->next->value, "しなもん", "nextでそれ以降の値が取り出せる";
  ok $itr->has_prev, "前の値を持っている";
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

sub pop : Tests{
  my $list = My::List->new("はてな", "しなもん");
  is $list->pop, "しなもん", "popができる";
  is $list->size, 1, "リストの長さが正しい";
  is $list->pop, "はてな", "popができる";
  is $list->pop, undef, "空のリストのpopができる";
  is $list->size, 0, "リストの長さが正しい";
}

sub to_list : Tests{
  my $list = My::List->new("はてな", "しなもん", "はてなようせい");
  is_deeply [$list->to_list], ["はてな", "しなもん", "はてなようせい"], "to_listが正しく動作する";
}

__PACKAGE__->runtests;

1;
