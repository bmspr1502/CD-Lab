#include <bits/stdc++.h>
using namespace std;

void find_center(vector<pair<float, float>> li, pair<float, float> a)
{
    cout << "Distance from: " << a.first << ", " << a.second << endl;
    cout << "\nPoints\t\tDistance\n";
    for (auto x : li)
    {
        cout << x.first << "," << x.second << " = \t";
        float dist = 0;
        dist += pow(a.first - x.first, 2) + pow(a.second - x.second, 2);
        dist = sqrt(dist);
        cout << dist << endl;
    }
}

int main()
{
    vector<pair<float, float>> input = {
        {1.9, 0.97},
        {1.76, 0.84},
        {2.32, 1.63},
        {2.31, 2.09},
        {1.14, 2.11},
        {5.02, 3.02},
        {5.74, 3.84},
        {2.25, 3.47},
        {4.71, 3.6},
        {3.17, 4.96}};

    find_center(input, {1.946, 1.852});
    cout << endl;
    find_center(input, {4.66, 3.855});

    return 0;
}