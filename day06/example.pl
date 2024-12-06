#!/usr/bin/env perl
use lib ('lib');
use MyDefaults;
use Day06;
++$|;

my @state = Day06::read_map("day06/example.dat");

my @newstate = Day06::walk(@state);
my $count = Day06::count(@newstate);
Day06::print_map($newstate[0]);
print "count: $count\n";

my $loops = Day06::count_loops(@state);
print "loops: ", $loops, "\n";
