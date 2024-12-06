use MyDefaults;
use Test::More;
use Day06;

my @state = Day06::read_map("day06/example.dat");
is @{$state[0]}, 10, "map rows";
is_deeply $state[1], [4,6], "initial position";
is $state[2], 0, "initial heading";

my @newstate = Day06::walk(@state);
is Day06::count(@newstate), 41, "example count";

is Day06::count_loops(@state), 6, "example loop count";

@state = Day06::read_map("day06/input.dat");
@state = Day06::walk(@state);
is Day06::count(@state), 5101, "puzzle1 count";

# 2nd part takes a *LONG* time
# @state = Day06::read_map("day06/input.dat");
# is Day06::count_loops(@state), 1951, "puzzle2 loop count";

done_testing;
