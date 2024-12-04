#!/usr/bin/env perl
use lib ('lib');
use MyDefaults;
use Day01;

my ($left, $right) = Day01::read_columns("day01/example.dat");
print "distance:", Day01::distance($left, $right), "\n";
print "similarity:", Day01::similarity($left, $right), "\n";
