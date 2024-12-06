package Day05;
use MyDefaults;
use Util qw/:all/;

sub config($filename) {
  my @lines = read_lines($filename, undef);
  my (@rules, @updates);
  my $rule = 1;
  foreach my $line (@lines) {
    if ($line) {
      if ($rule) {
        push @rules, [ split(/\|/, $line) ];
      } else {
        push @updates, [ split(/,/, $line) ];
      }
    } else {
      $rule = 0;
    }
  }
  return (\@updates, \@rules,);
}

sub valid_updates($updates, $rules) {
  my @valid = grep {valid_update($_, $rules)} @$updates;
  return \@valid;
}

sub invalid_updates($updates, $rules) {
  return ([ grep {!valid_update($_, $rules)} @$updates ], $rules);
}

sub valid_update($update, $rules) {
  my $valid = 1;
  for (my $i = 0; $i < @{$update} - 1; ++$i) {
    for (my $j = $i; $j < @{$update}; ++$j) {
      my ($a, $b) = ($update->[$i], $update->[$j]);
      foreach my $rule (@$rules) {
        my ($first, $second) = @$rule;
        if ($a == $second && $b == $first) {
          $valid = 0;
          last;
        }
      }
    }
  }
  return $valid;
}

sub sum($updates) {
  my $sum = 0;
  foreach my $update (@$updates) {
    my $max = @$update;
    my $middle = int(($max - 1) / 2);
    $sum += $update->[$middle];
  }
  return $sum;
}

sub order($updates, $rules) {
  my @ordered;
  foreach my $update (@$updates) {
    push @ordered, order_update($update, $rules);
  }
  return \@ordered;
}

sub order_update($update, $rules) {
  my @update = @$update;
  for (my $i = 0; $i < @update - 1; ++$i) {
    for (my $j = $i; $j < @update; ++$j) {
      my ($a, $b) = ($update[$i], $update[$j]);
      foreach my $rule (@$rules) {
        my ($first, $second) = @$rule;
        if ($a == $second && $b == $first) {
          # swap
          ($update[$j], $update[$i]) = ($update[$i], $update[$j]);
        }
      }
    }
  }
  return \@update;
}

1;
