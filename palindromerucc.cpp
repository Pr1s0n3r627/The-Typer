#include <iostream>
#include <string>

using namespace std;

bool isPal(string &s, int l, int r) {
while (l < r && !isalnum(s[l])) l++;
while (l < r && !isalnum(s[r])) r--;
if (l >= r) return true;
if (tolower(s[l]) != tolower(s[r])) return false;
return isPal(s, l + 1, r - 1);
}

int main() {
string s;
getline(cin, s);
if (isPal(s, 0, s.length() - 1))
cout << "The string is a palindrome" << endl;
else
cout << "The string is not a palindrome" << endl;
return 0;
}
