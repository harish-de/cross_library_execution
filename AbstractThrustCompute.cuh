//
// Created by hkumar on 21.08.20.
//

#ifndef CROSS_LIBRARY_EXECUTION_ABSTRACTTHRUSTCOMPUTE_CUH
#define CROSS_LIBRARY_EXECUTION_ABSTRACTTHRUSTCOMPUTE_CUH

#endif //CROSS_LIBRARY_EXECUTION_ABSTRACTTHRUSTCOMPUTE_CUH

#include <vector>
#include <string>
using namespace std;

class AbstractThrustCompute{
public:
    void virtual thrustSelection(vector<int> data, string operation, int value, int new_value){}
};

