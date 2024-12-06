package MyDefaults;
use utf8;
use v5.24;
use strict;
use warnings;
use feature qw();

sub import {
  my ($class, $tag) = @_;
  strict->import;
  warnings->import();
  warnings->unimport(qw(experimental::signatures experimental::postderef));
  feature->import(qw(signatures postderef));
  utf8->import();
  v5.24->import();
}

sub unimport {
  warnings->unimport();
  strict->unimport();
  feature->unimport;
  utf8->unimport();
}

1;
