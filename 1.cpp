#include <bits/stdc++.h>

using namespace std;

/* Parte 1:

int main() {
  
  string s;

  long long sum = 0;
  while (cin >> s) {
    int num = 0;
    for (char &c : s) {
      if (isdigit(c)) {
        int dig = c - '0';
        num = 10 * dig;
        break;
      }
    }

    for (auto it = s.rbegin(); it != s.rend(); it++) {
      if (isdigit(*it)) {
        int dig = *it - '0';
        num += dig;
        break;
      }
    }

    sum += num;
  }

  cout << sum << endl;

  return 0;
}

*/
int main() {

  string s;

  long long sum = 0;

  while (cin >> s) {

    vector<string> numbers = {"", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"};
    int num = 0;

    int dig = -1;
    int first = s.size();

    for (int i = 0; i < s.size(); i++) {
      if (isdigit(s[i])) {
        first = i;
        dig = s[i] - '0';
        break;
      }
    }

    for (int i = 1; i < 10; i++) {
      auto pos = s.find(numbers[i]);
      if (pos != string::npos) {
        if (pos < first) {
          first = pos;
          dig = i;
        }
      }
    }

    //cerr << dig << endl;
    num = dig * 10;

    for (auto& n : numbers) reverse(n.begin(), n.end());
    reverse(s.begin(), s.end());

    dig = -1;
    first = s.size();

    for (int i = 0; i < s.size(); i++) {
      if (isdigit(s[i])) {
        first = i;
        dig = s[i] - '0';
        break;
      }
    }

    for (int i = 1; i < 10; i++) {
      auto pos = s.find(numbers[i]);
      if (pos != string::npos) {
        if (pos < first) {
          first = pos;
          dig = i;
        }
      }
    }

    //cerr << dig << endl;
    num += dig;
    sum += num;
  }

  cout << sum << endl;

  return 0;
}
