package Day06;
use MyDefaults;
use Util qw/:all/;
use Storable qw/dclone/;

++$|;

my $HEADING = [
  [ 0, -1 ], # N
  [ 1, 0 ],  # E
  [ 0, 1 ],  # S
  [ -1, 0 ], # W
];
my %HEADING_FOR = (
  '^' => 0,
  '>' => 1,
  'v' => 2,
  '<' => 3,
);
my @HEADING_CHAR = ('^', '>', 'v', '<');

sub read_map($filename) {
  my $found = 0;
  my ($x, $y) = (-1, -1);
  my $heading;
  my @map = read_lines($filename, sub($line) {
    ++$y unless $found;
    my $row = [ split(//, $line) ];
    if ($line =~ m/([\^><v])/) {
      $x = index($line, $1); # or $x=pos; ?
      $heading = $HEADING_FOR{$1};
      $found = 1;
      # print STDERR "Found person[$1] heading=[$1] at [$x,$y]\n";
    }
    return $row;
  });
  return (\@map, [ $x, $y ], $heading);
}

sub walk($mapin, $pos, $heading) {
  my $map = dclone($mapin);
  my $step = 0;
  my $loop = 0;
  my ($x, $y) = @$pos;
  # print "walk pos=[$x,$y] heading=[$heading]\n";
  my $xmax = @{$map->[0]};
  my $ymax = @{$map};
  my $been = {};
  while (1) {
    ++$step;
    my $current = $map->[$y][$x];
    # print STDERR "$step at pos=[$x,$y] current=[$current] heading=[$heading] $HEADING_CHAR[$heading]\n";
    $map->[$y][$x] = 'X';
    $been->{$x}{$y}{$heading} = 1;
    my $dir = $HEADING->[$heading];
    my $nx = $x + $dir->[0];
    my $ny = $y + $dir->[1];
    if ($been->{$nx}{$ny}{$heading}) {
      ++$loop;
      last;
    };
    if ($nx < 0 || $nx >= $xmax || $ny < 0 || $ny >= $ymax) {
      last;
    }
    # trying to predict loops by examining next step misses cases where
    # further steps are needed to complete the actual loop
    # TODO: use recursion to find loops
    # if($been->{$x}{$y}{($heading + 1)%4}) {
    #   ++$loop;
    #   print STDERR "loop $loop at pos=[$nx,$ny] heading=[$heading]\n";
    #   print_map($map);
    # }
    my $newcell = $map->[$ny][$nx];
    if ($newcell eq '#') {
      $heading = ($heading + 1) % 4;
      next;
    }
    ($x, $y) = ($nx, $ny);
  }
  return ($map, [ $x, $y ], $heading, $loop);
}

sub count($map, @rest) {
  my $count = 0;
  for (my $y = 0; $y < @{$map}; ++$y) {
    for (my $x = 0; $x < @{$map->[$y]}; ++$x) {
      $count += $map->[$y][$x] eq 'X';
    }
  }
  return $count;
}

sub print_map($map) {
  print "    ";
  for (my $x = 0; $x < @{$map->[0]}; ++$x) {
    print STDERR $x % 10;
  }
  print "\n";
  for (my $y = 0; $y < @{$map}; ++$y) {
    print STDERR sprintf("%3d ", $y), join('', @{$map->[$y]}), "\n";
  }
}

# brute-force approach - add random blocks and hope for a loop
sub count_loops($mapin, $pos, $heading) {
  my $loop = 0;
  for (my $y = 0; $y < @{$mapin}; ++$y) {
    for (my $x = 0; $x < @{$mapin->[$y]}; ++$x) {
      next unless ($mapin->[$y][$x] eq '.');
      my $map = dclone($mapin);
      $map->[$y][$x] = '#';
      my @state = walk($map, $pos, $heading);
      if ($state[3]) { # looped
        ++$loop;
      }
    }
    # print ".";
  }
  # print "\n";
  return $loop;
}

1;
