#!/usr/bin/env perl
use lib ('lib');
use MyDefaults;
use Day05;
use Data::Dumper;
++$|;

my ($updates, $rules) = Day05::config("day05/input.dat");
# print Dumper({rules=>$rules,updates=>$updates});
my ($invalid) = Day05::invalid_updates($updates, $rules);
print "invalid=" . Dumper($invalid);
my $ordered = Day05::order($invalid, $rules);
my $sum = Day05::sum($ordered);
print "sum: $sum\n";

