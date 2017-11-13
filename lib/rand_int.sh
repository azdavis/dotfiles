# requires: true.
# ensures: rand_int x y prints a uniformly random, non-cryptographically-safe
# integer in the interval [x, y] to stdout.
rand_int() {
	awk "BEGIN{srand();print int($1+rand()*($2-$1+1))}"
}
