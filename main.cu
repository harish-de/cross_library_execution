#include <list>
using namespace std;

#pragma once
#include "test_tpch_queries/executeQueries.h"

int main(){
    auto queries = new executeTpchQueries();
    queries->call_tpch_query(10);
}