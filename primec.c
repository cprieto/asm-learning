#include <stdio.h>

int main()
{
	unsigned int limit;
	unsigned int guess;
	unsigned int factor;

	printf("Guess primes up to: ");
	scanf("%u", &limit);

	printf("2\n3\n");
	guess = 5;
	while (guess <= limit) {
		factor = 3; // look for a factor of guess
		while (factor * factor < guess && guess % factor != 0)
			factor += 2;
		if (guess % factor != 0)
			printf("%d\n", guess);
		guess += 2; // only look at odd numbers
	}

	return 0;
}
