#include <list>
using namespace std;

#pragma once
#include "test_tpch_queries/executeQueries.h"

int main(){
    executeTpchQueries *queries = new executeTpchQueries();
    queries->call_tpch6();
}