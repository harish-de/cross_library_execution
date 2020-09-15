//
// Created by hkumar on 26.08.20.
//

#pragma once
#include "BoostComputeOps.h"


compute::vector<int> BoostCompute::getBoostGpuData(vector<int> data, compute::context context, compute::command_queue queue) {

    compute::vector<int> device_vector(data.size(),context);
    compute::copy(data.begin(), data.end(), device_vector.begin(), queue);
    return device_vector;
}

vector<int> BoostCompute::getBoostCpuData(compute::vector<int> deviceData,compute::command_queue queue) {

    vector<int> hostData(deviceData.size());
    compute::copy(deviceData.begin(),deviceData.end(),hostData.begin(),queue);
    return hostData;
}



compute::vector<int> BoostCompute::boostSelection(compute::vector<int> deviceVec,
                                                  string operation,
                                                  int value,
                                                  compute::command_queue queue,
                                                  compute::context context,
                                                  compute::device device) {

    compute::vector<int> deviceResult(deviceVec.size(),context);

    BOOST_COMPUTE_CLOSURE(int,greaterOrEqualTo,(int x),(value),{
        return ( x >= value);
    });

    BOOST_COMPUTE_CLOSURE(int, lesserOrEqualTo,(int x),(value),{
        return ( x <= value);
    });

    BOOST_COMPUTE_CLOSURE(int,greaterThan,(int x),(value),{
        return ( x > value);
    });

    BOOST_COMPUTE_CLOSURE(int,lesserThan,(int x),(value),{
        return ( x < value);
    });

    BOOST_COMPUTE_CLOSURE(int,equalTo,(int x),(value),{
        return ( x == value);
    });

    BOOST_COMPUTE_CLOSURE(int,notEqual,(int x),(value),{
        return ( x != value);
    });


    if(!operation.compare("GE")) {
        compute::transform(deviceVec.begin(), deviceVec.end(), deviceResult.begin(),
                           greaterOrEqualTo, queue);
    }
    else if(!operation.compare("LE")) {
        compute::transform(deviceVec.begin(), deviceVec.end(), deviceResult.begin(),
                           lesserOrEqualTo, queue);
    }
    else if(!operation.compare("G")) {
        compute::transform(deviceVec.begin(), deviceVec.end(), deviceResult.begin(),
                           greaterThan, queue);
    }
    else if(!operation.compare("L")) {
        compute::transform(deviceVec.begin(), deviceVec.end(), deviceResult.begin(),
                           lesserThan, queue);
    }
    else if(!operation.compare("EQ")) {
        compute::transform(deviceVec.begin(), deviceVec.end(), deviceResult.begin(),
                           equalTo, queue);
    }
    else{
        compute::transform(deviceVec.begin(), deviceVec.end(), deviceResult.begin(),
                           notEqual, queue);
    }

    return deviceResult;
}

compute::vector<int> BoostCompute::boostConjunction(compute::vector<int> deviceLHS,
                                                    compute::vector<int> deviceRHS,
                                                    compute::command_queue queue,
                                                    compute::context context) {

    compute::vector<int> deviceResult(deviceLHS.size(),context);

    compute::transform(deviceLHS.begin(),
                       deviceLHS.end(),
                       deviceRHS.begin(),
                       deviceResult.begin(),
                       compute::bit_and<int>(),
                       queue);
    return deviceResult;
}

compute::vector<int> BoostCompute::boostJoin(compute::vector<int> deviceParent, compute::vector<int> deviceChild,
                                             compute::command_queue queue, compute::context context) {

    compute::vector<int> deviceResult(context);

//    size_t second_size = deviceParent.size();
//    BOOST_COMPUTE_CLOSURE(int,nestedLoopJoin,(int x,int y),(second_size),{
//        return ( x != value);
//    });
//    const int *m_vec1 = compute::raw_pointer_cast(deviceParent.data());

//    compute::set_intersection(deviceParent.begin(),deviceParent.end(),deviceChild.begin(),deviceChild.end(),std::back_inserter(deviceResult),queue);
    return deviceResult;
}

compute::vector<int> BoostCompute::boostProduct(compute::vector<int> deviceLHS, compute::vector<int> deviceRHS,
                                                compute::command_queue queue, compute::context context) {

    compute::vector<int> deviceResult(deviceLHS.size(),context);

    compute::transform(deviceLHS.begin(),
                       deviceLHS.end(),
                       deviceRHS.begin(),
                       deviceResult.begin(),
                       compute::multiplies<int>(),
                       queue);

    return deviceResult;
}

int BoostCompute::boostSum(compute::vector<int> deviceData, compute::command_queue queue,
                           compute::context context) {
    compute::vector<int> deviceResult(deviceData.size(),context);

// reason to use reduce not accumulate - because the former is faster
//    https://www.boost.org/doc/libs/1_65_1/libs/compute/doc/html/boost/compute/accumulate.html
    compute::reduce(deviceData.begin(), deviceData.end(),deviceResult.begin(),compute::plus<int>(),queue);
    int result = deviceResult[0];
    return result;
}

float BoostCompute::boostAvg(compute::vector<int> deviceData, compute::command_queue queue, compute::context context) {
    compute::vector<float> deviceResult(deviceData.size(),context);
    compute::reduce(deviceData.begin(), deviceData.end(),deviceResult.begin(),compute::plus<int>(),queue);
    int total = deviceResult[0];
    float result = (float)total/deviceData.size();
    return result;
}

int BoostCompute::boostCountIf(compute::vector<int> deviceData, compute::command_queue queue, compute::context context) {
    return compute::count(deviceData.begin(),deviceData.end(),1,queue);
}

int BoostCompute::boostCount(compute::vector<int> deviceData) {
    return deviceData.size();
}

compute::vector<int> BoostCompute::boostPrefixSum(compute::vector<int> deviceSelData, compute::command_queue queue,
                                                  compute::context context) {
    compute::vector<int> dataIndex(deviceSelData.size(),context);
    compute::iota(dataIndex.begin(),dataIndex.end(),0,queue);

    compute::vector<int> ps(deviceSelData.size(),context);
    compute::exclusive_scan(deviceSelData.begin(),deviceSelData.end(),ps.begin(),queue); // prefix sum result
//
    int size = ps.back();
    compute::vector<int> device_result(size,context);

    compute::scatter_if(dataIndex.begin(),dataIndex.end(),ps.begin(),deviceSelData.begin(),device_result.begin(),queue);

    return device_result;
}

int BoostCompute::boostFindMax(compute::vector<int> data, compute::command_queue queue, compute::context context) {
    compute::vector<float> deviceResult(data.size(),context);
    compute::reduce(data.begin(), data.end(),deviceResult.begin(),compute::max<int>(),queue);
    return deviceResult[0];
}

int BoostCompute::boostFindMin(compute::vector<int> data, compute::command_queue queue, compute::context context) {
    compute::vector<float> deviceResult(data.size(),context);
    compute::reduce(data.begin(), data.end(),deviceResult.begin(),compute::min<int>(),queue);
    return deviceResult[0];
}