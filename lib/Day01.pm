package Day01;
use strict;
use warnings;
use experimental qw(signatures);
no warnings qw(experimental::signatures);
use Util qw/:all/;

sub read_columns($filename) {
    my (@left, @right);
    read_lines($filename, sub($line) {
        my ($a, $b) = split(/\s+/, trim($line));
        push @left, $a;
        push @right, $b;
    });
    return (\@left, \@right);
}

sub distance($left, $right) {
    my @l = sort @$left;
    my @r = sort @$right;
    my $d = 0;
    while (@l) {
        my ($a, $b) = (shift @l, shift @r);
        $d += abs($a - $b);
    }
    return $d;
}

sub similarity($left, $right) {
    my %freq_for;
    map {++$freq_for{$_}} @{$right};
    my $score = 0;
    map {$score += $_ * ($freq_for{$_} // 0)} @{$left};
    return $score;
}

1;