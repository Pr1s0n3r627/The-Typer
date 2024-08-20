#include <iostream>
#include <vector>

using namespace std;

void findTreasure(int numCaves, vector<int> caveList, int treasureCave) {
for (int i = 0; i < numCaves; i++) {
if (caveList[i] == treasureCave) {
cout << "Treasure found in cave number: " << i << endl;
return;
}
}
cout << "Treasure not found in any cave" << endl;
}

int main() {
int numCaves;
cout << "Enter the number of caves: ";
cin >> numCaves;

vector<int> caveList(numCaves);
cout << "Enter the cave numbers: ";
for (int i = 0; i < numCaves; i++) {
cin >> caveList[i];
}

int treasureCave;
cout << "Enter the cave number you want to find: ";
cin >> treasureCave;

findTreasure(numCaves, caveList, treasureCave);

return 0;
}
