#!/usr/bin/env perl
use lib ('lib');
use MyDefaults;
use Day06;
++$|;

my @state = Day06::read_map("day06/input.dat");
@state = Day06::walk(@state);
my $count = Day06::count(@state);
# Day06::print_map($state[0]);
print "count: $count\n";
