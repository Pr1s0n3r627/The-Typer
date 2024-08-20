#include <iostream>

int calculateTotalFlowers(int n) {
if (n == 0) {
return 0;
}

int flowersInBed = 1 << (n - 1); // Calculate the number of flowers in the current bed
return flowersInBed + calculateTotalFlowers(n - 1); // Recursively calculate the total number of flowers
}

int main() {
int n;
std::cout << "Enter the number of flower beds: ";
std::cin >> n;

int totalFlowers = calculateTotalFlowers(n);
std::cout << "Total number of flowers: " << totalFlowers << std::endl;

return 0;
}