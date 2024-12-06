#!/usr/bin/env perl
use lib ('lib');
use MyDefaults;
use Day05;
use Data::Dumper;

my ($updates,$rules) = Day05::config("day05/input.dat");
print Dumper({rules=>$rules,updates=>$updates});
my $valid = Day05::valid_updates($updates,$rules);
print Dumper($valid);
my $sum = Day05::sum($valid);
print "sum: $sum\n";

