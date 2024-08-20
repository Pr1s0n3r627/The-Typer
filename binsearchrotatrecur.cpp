#include <iostream>
#include <vector>

using namespace std;

int search(vector<int>& arr, int left, int right, int x) {
if (left > right) return -1;

int mid = left + (right - left) / 2;

if (arr[mid] == x) return mid;

if (arr[left] <= arr[mid]) {
if (x >= arr[left] && x < arr[mid])
return search(arr, left, mid - 1, x);
return search(arr, mid + 1, right, x);
}

if (x > arr[mid] && x <= arr[right])
return search(arr, mid + 1, right, x);
return search(arr, left, mid - 1, x);
}

int main() {
int n, x;
cin >> n;
vector<int> arr(n);
for (int i = 0; i < n; ++i) cin >> arr[i];
cin >> x;

int result = search(arr, 0, n - 1, x);

if (result != -1)
cout << "Element found at index: " << result << endl;
else
cout << "Element not found in the array." << endl;

return 0;
}
