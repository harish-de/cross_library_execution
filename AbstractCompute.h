//
// Created by hkumar on 21.08.20.
//
#include <vector>
#include <string>

using namespace std;

class AbstractCompute{
public:
    void virtual selection(vector<int> data, string operation, int value){}
};
