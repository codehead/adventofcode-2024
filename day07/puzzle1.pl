#!/usr/bin/env perl
use lib ('lib');
use MyDefaults;
use Day07;
++$|;

my $sum = Day07::process_equations(Day07::read_equations("day07/input.dat"));
print "sum: $sum\n";
