#include <iostream>
#include <string>
using namespace std;
int populloVektorin(int a[])
{
 int n;
 cout << "Jep numrin e anetareve te vektorit (max. 5):"; cin >> n;
 cout << "\nShtyp elementet nje nga nje:\n";
 for (int i = 1; i <= n; i++) { cin >> a[i];
 }
 return n;
}
void unazaVlerave(int p, int n, int &min, int a[], int &loc)
{
 for (int k = p + 1; k <= n; k++)
 {
 if (min > a[k])
 {
 min = a[k];
 loc = k;
 }
 }
}
void unazaKalimit(int a[], int n)
{
 int min, loc, tmp;
 for (int p = 1; p <= n - 1; p++) // Loop for Pass
 {
 min = a[p]; // Element Selection
 loc = p;
 unazaVlerave(p, n, min, a, loc);
 tmp = a[p];
 a[p] = a[loc];
 a[loc] = tmp;
 }
 cout << "\nVlerat e vektorit ne fund: \n";
 for (int i = 1; i <= n; i++) {
 cout << a[i] << endl;
 }
}
int main()
{
 int a[5], n = 0;
 n = populloVektorin(a);
 unazaKalimit(a, n);

}
