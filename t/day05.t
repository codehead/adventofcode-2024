use MyDefaults;
use Test::More;
use Day05;

is Day05::sum(
  Day05::valid_updates(
    Day05::config("day05/example.dat")
  )
), 143, "example sum_valid";

is Day05::sum(
  Day05::order(
    Day05::invalid_updates(
      Day05::config("day05/example.dat")
    )
  )
), 123, "example sum_reordered";

is Day05::sum(
  Day05::valid_updates(
    Day05::config("day05/input.dat")
  )
), 5108, "puzzle1 solution";

is Day05::sum(
  Day05::order(
    Day05::invalid_updates(
      Day05::config("day05/input.dat")
    )
  )
), 7380, "puzzle2 solution";

done_testing;
