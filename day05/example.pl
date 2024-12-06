#!/usr/bin/env perl
use lib ('lib');
use MyDefaults;
use Day05;
++$|;

my ($updates, $rules) = Day05::config("day05/example.dat");
my $valid = Day05::valid_updates($updates, $rules);
my $sum = Day05::sum($valid);
print "sum_valid: $sum\n";

my ($invalid) = Day05::invalid_updates($updates, $rules);
my $ordered = Day05::order($invalid, $rules);
$sum = Day05::sum($ordered);
print "sum_reordered: $sum\n";
