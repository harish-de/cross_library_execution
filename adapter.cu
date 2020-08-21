//
// Created by hkumar on 21.08.20.
//
#include "AbstractCompute.h"
#include "AbstractThrustCompute.cuh"

#include <vector>
#include <string>
using namespace std;

class Adapter: public AbstractCompute{
public:
    AbstractThrustCompute *ATC;
    Adapter(AbstractThrustCompute *ATC_obj){
        ATC = ATC_obj;
    }

    void selection(vector<int> data,string operation,int value){
        int new_value = 1;
        ATC->thrustSelection(data,operation,value,new_value);
    }
};

