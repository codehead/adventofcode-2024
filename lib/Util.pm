package Util;
use strict;
use warnings;
use experimental qw(signatures);
no warnings qw(experimental::signatures);
use Exporter 'import';

our @EXPORT_OK = qw(read_lines trim);
our %EXPORT_TAGS = (all => \@EXPORT_OK);

sub trim($str) {
  $str =~ s/^\s+//;
  $str =~ s/^\s+//;
  return $str;
}

sub read_lines($filename, $line_callback) {
  my @ret;
  open(my $fh, "<", $filename) || die("Error opening $filename: $!");
  while (<$fh>) {
    chomp;
    push @ret, $line_callback ? &$line_callback($_) : $_; # append callback result to $str
  }
  close($fh);
  return @ret;
}

1;
