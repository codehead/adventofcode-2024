#!/usr/bin/env perl
use lib ('lib');
use MyDefaults;
use Day01;

my ($left, $right) = Day01::read_columns("day01/puzzle.dat");
print Day01::similarity($left, $right), "\n";

