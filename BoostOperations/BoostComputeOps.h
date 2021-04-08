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
#include <boost/compute/algorithm/scatter.hpp>
#include <boost/compute/algorithm/set_intersection.hpp>
#include <boost/compute/algorithm/merge.hpp>
#include <boost/compute/algorithm/sort.hpp>
#include <boost/compute/algorithm/reduce_by_key.hpp>
#include <boost/compute/algorithm/min_element.hpp>
#include <boost/compute/algorithm/unique.hpp>
#include <boost/compute/algorithm/sort_by_key.hpp>


#include <iterator>
#include <vector>
#include <string>
#include <chrono>

using namespace std::chrono;
using namespace std;
using boost::compute::lambda::_1;
namespace compute = boost::compute;

class BoostCompute{
public:
    int iteration = 1;

    compute::vector<int> virtual getBoostGpuData(vector<int> data, compute::context context, compute::command_queue queue);

    compute::vector<int> virtual boostcpu2gpu(vector<int> data, compute::context context, compute::command_queue queue);

    vector<int> virtual getBoostCpuData(compute::vector<int> data,compute::command_queue queue);

    vector<int> virtual boostgpu2cpu(compute::vector<int> data,compute::command_queue queue);

    vector<float> virtual getBoostCpuData(compute::vector<float> data,compute::command_queue queue);

    compute::vector<int> virtual boostSelection(compute::vector<int> data,
                                                string operation, int value,
                                                compute::command_queue queue,
                                                compute::context context,
                                                compute::device device);

    compute::vector<int> virtual boostFilter(compute::vector<int> data,
                                                string operation, int value,
                                                compute::command_queue queue,
                                                compute::context context,
                                                compute::device device);

    compute::vector<int> virtual boostSelectionArrays(compute::vector<int> lhs,
                                                      string operation, compute::vector<int> rhs,
                                                      compute::command_queue queue,
                                                      compute::context context);

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
                             compute::context context,
                             int value);

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

    compute::vector<int> boostSort(compute::vector<int> deviceData,
                                   int order,
                                   compute::command_queue queue,
                                   compute::context context);

    compute::vector<int> boostSortByKey(compute::vector<int> deviceData,
                                        compute::vector<int> dependentData,
                                        int order,
                                        compute::command_queue queue,
                                        compute::context context);

    compute::vector<int> virtual boostGroupBy(compute::vector<int> keys,
                                              compute::vector<int> values,
                                              compute::command_queue queue,
                                              compute::context context);

    compute::vector<int> virtual boostCountByKey(compute::vector<int> data,
                                                 compute::command_queue queue,
                                                 compute::context context);

    compute::vector<float> virtual boostAvgByKey(compute::vector<int> k,
                                                 compute::vector<int> v,
                                                 compute::command_queue queue,
                                                 compute::context context);

    compute::vector<int> virtual boostSumOfVectors(compute::vector<int> array1,
                                                   compute::vector<int> array2,
                                                   compute::command_queue queue,
                                                   compute::context context);

    void virtual boostScatter(compute::vector<int> data,
                              compute::vector<int> map,
                              compute::command_queue queue,
                              compute::context context);

    void virtual boostGather(compute::vector<int> data,
			     compute::vector<int> map,
			     compute::command_queue queue,
			     compute::context context);
};

#endif //CROSS_LIBRARY_EXECUTION_BOOSTCOMPUTEOPS_H
