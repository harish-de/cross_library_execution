//
// Created by hkumar on 26.08.20.
//

#ifndef CROSS_LIBRARY_EXECUTION_BOOSTCOMPUTEOPS_H
#define CROSS_LIBRARY_EXECUTION_BOOSTCOMPUTEOPS_H

#pragma once
#include <boost/compute/container/vector.hpp>
#include <boost/compute/algorithm/copy_if.hpp>
#include <boost/compute/algorithm/copy.hpp>
#include <boost/compute/algorithm/transform.hpp>
#include <boost/compute/functional/operator.hpp>
#include <boost/compute/algorithm/for_each_n.hpp>
#include <boost/compute/iterator/counting_iterator.hpp>
#include <boost/compute/algorithm/generate.hpp>
#include <boost/compute/algorithm/iota.hpp>
#include <boost/compute/algorithm/scatter_if.hpp>
#include <boost/compute/algorithm/set_intersection.hpp>
#include <boost/compute/algorithm/merge.hpp>

#include <iterator>
#include <vector>
#include <string>
using namespace std;
using boost::compute::lambda::_1;
namespace compute = boost::compute;

class BoostCompute{
public:
    compute::vector<int> virtual getBoostGpuData(vector<int> data, compute::context context, compute::command_queue queue);

    vector<int> virtual getBoostCpuData(compute::vector<int> data,compute::command_queue queue);

    compute::vector<int> virtual boostSelection(compute::vector<int> data,
                                       string operation, int value,
                                       compute::command_queue queue,
                                       compute::context context,
                                       compute::device device);

    compute::vector<int> virtual boostConjunction(compute::vector<int> deviceLHS,
                                                  compute::vector<int> deviceRHS,
                                                  compute::command_queue queue,
                                                  compute::context context);

    compute::vector<int> virtual boostProduct(compute::vector<int> deviceLHS,
                                          compute::vector<int> deviceRHS,
                                          compute::command_queue queue,
                                          compute::context context);

    int virtual boostSum(compute::vector<int> deviceData,
                                          compute::command_queue queue,
                                          compute::context context);

    float virtual boostAvg(compute::vector<int> deviceData,
                           compute::command_queue queue,
                           compute::context context);

    int virtual boostCountIf(compute::vector<int> deviceData,
                           compute::command_queue queue,
                           compute::context context);

    int virtual boostCount(compute::vector<int> deviceData);

    compute::vector<int> virtual boostJoin(compute::vector<int> deviceParent,
                                           compute::vector<int> deviceChild,
                                           compute::command_queue queue,
                                           compute::context context);

    compute::vector<int> virtual boostPrefixSum(compute::vector<int> deviceSelData,
                                                compute::command_queue queue,
                                                compute::context context);

    int virtual boostFindMax(compute::vector<int> data,
                             compute::command_queue queue,
                             compute::context context);

    int virtual boostFindMin(compute::vector<int> data,
                             compute::command_queue queue,
                             compute::context context);
};

#endif //CROSS_LIBRARY_EXECUTION_BOOSTCOMPUTEOPS_H
