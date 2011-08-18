#
# Node.pm
# created by giginet on 2011/8/14
# 
=head1 モジュール名

My/List/Node.pm

=head1 概要

連結リストの各要素を表すNodeです

=head2 new
新しいノードを生成します。
引数に与

@param リストの初期値
@return 新たに生成されたリスト

=head2 child
子ノードを取り出します。　

@return 子ノード

=head2 parent
親ノードを取り出します

@return 親ノード

=head2 set_child
子ノードへの参照をセットします

@params セットする子ノード

=head2 set_parent
親ノードへの参照をセットします

@params セットする親ノード

=head2 set_value
ノードの値をセットします

@params セットする値

=head2 value
ノードの値を取り出します

@return 値

=head1 作者

giginet

=cut
package My::List::Node;
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

sub child{
    my $self = shift;
    my $child = $self->{_child};
    return $child;
}

sub parent{
    my $self = shift;
    my $parent = $self->{_parent};
    return $parent;
}

sub set_child{
    my($self, $child) = @_;
    $self->{_child} = $child;
}

sub set_parent{
    my($self, $parent) = @_;
    $self->{_parent} = $parent;
}

sub set_value{
    my($self, $value) = @_;
    $self->{_value} = $value;
}

sub value{
    my $self = shift;
    return $self->{_value};
}

1;
