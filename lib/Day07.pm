package Day07;
use MyDefaults;
use Util qw/:all/;
use Storable qw/dclone/;
use Math::BaseConvert;

sub read_equations($filename) {
  return [ read_lines($filename, sub($line) {
    return [ split(/:?\s+/, $line) ];
  }) ];
}

++$|;

sub process_equations($eq) {
  my @equation = @$eq;
  my $sum = 0;
  foreach my $equation (@equation) {
    my ($result, @factors) = @{$equation};
    # print "result: ", $result, "factors", join(',', @factors), "\n";
    die if @factors < 2;
    my $ops = @factors - 1;
    my $permutations = 2 ** $ops;
    my $match = 0;
    for (my $i = 0; $i < $permutations; $i++) {
      my @f = @factors;
      my $accum = shift(@f);
      my $j = $i;
      while (@f) {
        my $n = @f;
        my $f = shift(@f);
        my $op = $j & 1;
        # print "    accum=$accum op=[$op]", ($op ? '+' : '*'), " $f\n";
        $accum = $op ? ($accum + $f) : ($accum * $f);
        $j >>= 1;
      }
      # print "  [$i] result=$result accum=$accum\n";
      if ($accum == $result) {
        # print "    match!\n";
        $match = 1;
        last;
      }
    }
    if ($match) {
      $sum += $result;
    }
  }
  return $sum;
}

sub process_3ops($eq) {
  my @equation = @$eq;
  my $sum = 0;
  foreach my $equation (@equation) {
    my ($result, @factors) = @{$equation};
    print "[$result]";
    # print "result: ", $result, "factors", join(',', @factors), "\n";
    die if @factors < 2;
    my $match = 0;
    my $n = (@factors - 1);
    my $BASE = 3;
    my $max = $BASE ** $n;
    print "($max)";
    for(my $i = 0; $i < $max; $i++) {
      my $ops = Math::BaseConvert::cnv($i, 10, $BASE);
      my @ops = reverse split(//, sprintf("%0${n}d",$ops));
      my @f = @factors;
      my $accum = shift(@f);
      # print "OPS $result ".join('',@ops)."\n";
      # print "$accum ";
      my @OP = ('+','*','||');
      while (@f) {
        my $f = shift(@f);
        my $op = shift @ops;
        # print "$OP[$op] $f ";
        # print "    accum=$accum op=[$op]", ($op ? '+' : '*'), " $f\n";
        $accum = ($op == 0) ? ($accum + $f)
                 : ($op == 1) ? ($accum * $f)
                   : ($accum . $f);
        # print "($accum) ";
      }
      # print "= $accum\n";
      # print "  [$i] result=$result accum=$accum\n";
      if ($accum == $result) {
        # print "    $result match!\n";
        $match = 1;
        last;
      }
        if ($accum > $result) {
          next;
        }

    }
    print $match ? "." : "!";
    if ($match) {
      $sum += $result;
    }
  }
  print "\n";
  return $sum;
}
1;
