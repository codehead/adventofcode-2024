#!/usr/bin/env perl
use lib ('lib');
use MyDefaults;
use Day06;
++$|;

my @state = Day06::read_map("day06/input.dat");
my $count = Day06::count_loops(@state);
print "loops: $count\n";
