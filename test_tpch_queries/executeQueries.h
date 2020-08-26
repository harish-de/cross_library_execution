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
    void call_tpch6();
};

#endif //CROSS_LIBRARY_EXECUTION_EXECUTEQUERIES_H
