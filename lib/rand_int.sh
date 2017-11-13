rand_int() {
	awk "BEGIN{srand();print int($1+rand()*($2-$1+1))}"
}
