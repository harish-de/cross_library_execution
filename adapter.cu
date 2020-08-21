//
// Created by hkumar on 21.08.20.
//
#include "Plug/Compute.h"
#include "Thrust_SwitchBoard/ThrustCompute.cuh"

#include <vector>
#include <string>
using namespace std;

class Adapter: public Compute{
public:
    ThrustCompute *ATC;
    Adapter(ThrustCompute *ATC_obj){
        ATC = ATC_obj;
    }

    void selection(vector<int> data,string operation,int value) override{
        int new_value = 1;
        ATC->thrustSelection(data,operation,value,new_value);
    }
};

