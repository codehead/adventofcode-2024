use MyDefaults;
use Test::More;
use Day01;

is Day01::distance(Day01::read_columns("day01/example.dat")), 11, "example distance";
is Day01::similarity(Day01::read_columns("day01/example.dat")), 31, "example similarity";
done_testing;
