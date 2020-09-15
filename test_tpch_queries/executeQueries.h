//
// Created by hkumar on 26.08.20.
//

#ifndef CROSS_LIBRARY_EXECUTION_EXECUTEQUERIES_H
#define CROSS_LIBRARY_EXECUTION_EXECUTEQUERIES_H

#pragma once
#include "../Base/BaseCompute.h"

class executeTpchQueries{
public:
    void executeQ6(BaseCompute *adapter);
    void call_tpch_query(int queryNum);
    void executeQ1(BaseCompute *adapter);
    void executeQ2(BaseCompute *adapter);
    void executeQ3(BaseCompute *adapter);
    void testJoin(BaseCompute *adapter);
};

#endif //CROSS_LIBRARY_EXECUTION_EXECUTEQUERIES_H
