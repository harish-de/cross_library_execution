//
// Created by hkumar on 26.08.20.
//

#pragma once
#include "executeQueries.h"
#include <vector>
#include <list>
#include "../ThrustOperations/ThrustComputeOps.cuh"
#include "../ThrustOperations/ThrustAdapter.cuh"
#include "../BoostOperations/BoostComputeOps.h"
#include "../BoostOperations/BoostAdapter.h"
using namespace std;

void executeTpchQueries::executeQ6(BaseCompute *adapter) {

    vector<int> l_shipdate;
    l_shipdate.push_back(19940302);
    l_shipdate.push_back(19930202);
    l_shipdate.push_back(19940202);
    l_shipdate.push_back(19930202);
    l_shipdate.push_back(19940202);

    vector<int> l_traindate;
    l_traindate.push_back(19940302);
    l_traindate.push_back(19910202);
    l_traindate.push_back(19940302);
    l_traindate.push_back(19970202);
    l_traindate.push_back(19940202);

    int value = 19940101;
    string op = "GE";

    adapter->selection(l_shipdate,op,value);
    adapter->setUnion(l_shipdate,l_traindate);
    adapter->setIntersection(l_shipdate,l_traindate);
    adapter->setDifference(l_shipdate,l_traindate);
    adapter->sort(l_shipdate,0);
    adapter->sum(l_shipdate);
    adapter->findMax(l_shipdate);
}

void executeTpchQueries::call_tpch6() {
    typedef list<BaseCompute*> libraryList;

    libraryList libraries;
    libraries.push_back(new ThrustAdapter(new ThrustCompute));

    for(auto object : libraries)
    {
        executeQ6(object);
    }
}
