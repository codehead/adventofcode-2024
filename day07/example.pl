#!/usr/bin/env perl
use lib ('lib');
use MyDefaults;
use Day07;
++$|;

# my @equation = Day07::read_equations("day07/example.dat");
# my $sum = 0;
# foreach my $equation (@equation) {
#   my ($result, @factors) = @{$equation};
#   print "result: ", $result, "factors", join(',', @factors), "\n";
#   die if @factors < 2;
#   my $ops = @factors - 1;
#   my $permutations = 2 ** $ops;
#   my $match = 0;
#   for (my $i = 0; $i < $permutations; $i++) {
#     my @f = @factors;
#     my $accum = shift(@f);
#     my $j = $i;
#     while (@f) {
#       my $n = @f;
#       my $f = shift(@f);
#       my $op = $j&1;
#       print "    accum=$accum op=[$op]",($op?'+':'*')," $f\n";
#       $accum = $op ? ($accum + $f) : ($accum * $f);
#       $j>>=1;
#     }
#     print "  [$i] result=$result accum=$accum\n";
#     if ($accum == $result) {
#       print "    match!\n";
#       $match = 1;
#       last;
#     }
#   }
#   # print "match=$match";
#   if ($match) {
#     $sum += $result;
#   }
# }
my $sum = Day07::process_equations(Day07::read_equations("day07/example.dat"));
print "sum: $sum\n";
$sum = Day07::process_3ops(Day07::read_equations("day07/example.dat"));
print "sum3: $sum\n";
