//
// Created by hkumar on 26.08.20.
//

#include "ThrustComputeOps.cuh"

thrust::device_vector<int> ThrustCompute::getThrustGpuData(vector<int> data) {
    thrust::host_vector<int> hostData(data);
    thrust::device_vector<int> deviceData = hostData;

    return deviceData;
}

vector<int> ThrustCompute::getThrustCpuData(thrust::device_vector<int> d_data) {
    vector<int> h_data(d_data.size());
    thrust::copy(d_data.begin(),d_data.end(),h_data.begin());
    return h_data;
}

thrust::device_vector<int> ThrustCompute::thrustSelection(thrust::device_vector<int> deviceData, string operation, int value){

    thrust::device_vector<int> device_result(deviceData.size());

    if(!operation.compare("GE")) {

        thrust::transform(thrust::device,deviceData.begin(),deviceData.end(),device_result.begin(),[=] __device__(const int x) {
            return (x >= value);
        });
    }
    else if(!operation.compare("LE")) {

        thrust::transform(thrust::device,deviceData.begin(),deviceData.end(),device_result.begin(),[=] __device__(const int x) {
            return (x <= value);
        });
    }
    else if(!operation.compare("G")) {
        thrust::transform(thrust::device,deviceData.begin(),deviceData.end(),device_result.begin(),[=] __device__(const int x) {
            return (x > value);
        });
    }
    else if(!operation.compare("L")) {
        thrust::transform(thrust::device,deviceData.begin(),deviceData.end(),device_result.begin(),[=] __device__(const int x) {
            return (x < value);
        });
    }
    else if(!operation.compare("EQ")) {
        thrust::transform(thrust::device,deviceData.begin(),deviceData.end(),device_result.begin(),[=] __device__(const int x) {
            return (x == value);
        });
    }
    else{
        thrust::transform(thrust::device,deviceData.begin(),deviceData.end(),device_result.begin(),[=] __device__(const int x) {
            return (x != value);
        });
    }

    return device_result;
}

thrust::device_vector<int> ThrustCompute::thrustSelectionArrays(thrust::device_vector<int> deviceLHS, string operation,
                                                                thrust::device_vector<int> deviceRHS) {

    thrust::device_vector<int> result_dev(deviceLHS.size());

    size_t v1size = deviceLHS.size();
    const int *m_vec1 = thrust::raw_pointer_cast(deviceLHS.data());
    const int *m_vec2 = thrust::raw_pointer_cast(deviceRHS.data());
    int *m_result = thrust::raw_pointer_cast(result_dev.data());

    thrust::for_each_n( thrust::device,
                        thrust::counting_iterator<size_t>(0),
                        (v1size),
                        [=] __device__ (const std::size_t x){
                            m_result[x] = (m_vec1[x] < m_vec2[x]);
                        });

    return result_dev;
}

thrust::device_vector<int> ThrustCompute::thrustConjunction(thrust::device_vector<int> deviceLHS,thrust::device_vector<int> deviceRHS) {

    thrust::device_vector<int> device_result(deviceLHS.size());

    thrust::transform(deviceLHS.begin(),deviceLHS.end(),deviceRHS.begin(),device_result.begin(),thrust::bit_and<int>());

    return device_result;
}

//void ThrustCompute::thrustSetUnion(vector<int> lhs, vector<int> rhs){
//    cout <<  "Running thrust set union" << endl;
//    thrust::device_vector<int> lhs_deviceData = getThrustGpuData(lhs);;
//    thrust::device_vector<int> rhs_deviceData = getThrustGpuData(rhs);
//
//    thrust::device_vector<int> device_result(2*lhs_deviceData.size());
//
//    thrust::set_union(thrust::device,lhs_deviceData.begin(),lhs_deviceData.end(),
//                      rhs_deviceData.begin(),rhs_deviceData.end(),
//                      device_result.begin());
//
//}

//void ThrustCompute::thrustSetIntersection(vector<int> lhs, vector<int> rhs){
//    cout <<  "Running thrust set intersection" << endl;
//
//    thrust::device_vector<int> lhs_deviceData = getThrustGpuData(lhs);;
//    thrust::device_vector<int> rhs_deviceData = getThrustGpuData(rhs);
//
//    thrust::device_vector<int> device_result(lhs_deviceData.size());
//
//    thrust::set_intersection(thrust::device, lhs_deviceData.begin(),lhs_deviceData.end(),
//                             rhs_deviceData.begin(),rhs_deviceData.end(),
//                             device_result.begin());
////        std::cout<<"result=";
////        thrust::copy(device_result.begin(), device_result.end(), std::ostream_iterator<int>(std::cout, " "));
////        std::cout<<std::endl;
//}

//void ThrustCompute::thrustSetDifference(vector<int> lhs, vector<int> rhs){
//    cout <<  "Running thrust set difference" << endl;
//
//    thrust::device_vector<int> lhs_deviceData = getThrustGpuData(lhs);;
//    thrust::device_vector<int> rhs_deviceData = getThrustGpuData(rhs);
//
//    thrust::device_vector<int> device_result(2*lhs_deviceData.size());
//
//    thrust::set_difference(thrust::device, lhs_deviceData.begin(),lhs_deviceData.end(),
//                           rhs_deviceData.begin(),rhs_deviceData.end(),
//                           device_result.begin());
//}

thrust::device_vector<int> ThrustCompute::thrustSort(thrust::device_vector<int> deviceData, int order){
    if(order){
        thrust::sort(thrust::device, deviceData.begin(),deviceData.end(),thrust::greater<int>());
    }else{
        thrust::sort(thrust::device, deviceData.begin(),deviceData.end());
    }
}

thrust::device_vector<int> ThrustCompute::thrustProduct(thrust::device_vector<int> deviceLHS, thrust::device_vector<int> deviceRHS){
    thrust::device_vector<int> device_result(deviceLHS.size());

    thrust::transform(deviceLHS.begin(),deviceLHS.end(),deviceRHS.begin(),device_result.begin(),thrust::multiplies<int>());

    return device_result;
}

int ThrustCompute::thrustSum(thrust::device_vector<int> deviceData) {
    int result = thrust::reduce(deviceData.begin(),deviceData.end(),0);
    return result;
}

float ThrustCompute::thrustAvg(thrust::device_vector<int> deviceData) {

    int total = thrust::reduce(deviceData.begin(),deviceData.end(),0);
    float result = (float)total/deviceData.size();
    return result;
}

int ThrustCompute::thrustCountIf(thrust::device_vector<int> deviceData) {
    // counting number of 1s is enough here
    return thrust::count(deviceData.begin(),deviceData.end(),1);
}

int ThrustCompute::thrustCount(thrust::device_vector<int> deviceData) {
    return deviceData.size();
}


thrust::device_vector<int> ThrustCompute::thrustJoin(thrust::device_vector<int> vec1_dev, thrust::device_vector<int> vec2_dev) {

    // Allocate device memory to copy results to
    thrust::device_vector<int> result_dev(vec1_dev.size() * vec2_dev.size());

//    // How do I create N*M threads, each of which calls func(i, j) ?
//    size_t v1size = vec1_dev.size();
//    const int *m_vec1 = thrust::raw_pointer_cast(vec1_dev.data());
//    const int *m_vec2 = thrust::raw_pointer_cast(vec2_dev.data());
//    int *m_result = thrust::raw_pointer_cast(result_dev.data());
//
//    thrust::for_each_n( thrust::device,
//                        thrust::counting_iterator<size_t>(0),
//                        (vec1_dev.size() * vec2_dev.size()),
//                        [=] __device__ (const std::size_t x){
//
//                            size_t i = x%v1size;
//                            size_t j = x/v1size;
//                            m_result[i + j * v1size] = (m_vec1[i] == m_vec2[j]);
//                        });




    thrust::device_vector<int> result(vec2_dev.size());
    thrust::device_vector<int>::iterator vec1_it;
//
    for(thrust::device_vector<int>::iterator it = vec2_dev.begin(); it != vec2_dev.end(); it++){
//        cout << "iterator: " << vec2_dev. << endl;
        vec1_it = thrust::find(vec1_dev.begin(),vec1_dev.end(),it);
        int vec1_index = thrust::distance(vec1_dev.begin(),it);
        result.push_back((vec1_index,thrust::distance(vec2_dev.begin(),it)));
    }

    return result;
//    return result_dev;
}

thrust::device_vector<int> ThrustCompute::thrustPrefixSum(thrust::device_vector<int> deviceSelData) {

    thrust::device_vector<int> dataIndex(deviceSelData.size());
    thrust::sequence(dataIndex.begin(),dataIndex.end(),0);

    thrust::device_vector<int> ps(deviceSelData.size());
    thrust::exclusive_scan(deviceSelData.begin(),deviceSelData.end(),ps.begin()); // prefix sum result
//
    int size = ps.back();
    thrust::device_vector<int> device_result(size);

//    for(int i = 0; i < deviceData.size(); i++){
//        if(deviceData[i]){
//            device_result[ps[i]] = i;
//        }
//    }

    thrust::scatter_if(dataIndex.begin(),dataIndex.end(),ps.begin(),deviceSelData.begin(),device_result.begin());

    return device_result;
}

int ThrustCompute::thrustFindMax(thrust::device_vector<int> data){
    return thrust::reduce(thrust::device,data.begin(),data.end(),0,thrust::maximum<int>());
}

int ThrustCompute::thrustFindMin(thrust::device_vector<int> data){
    return thrust::reduce(thrust::device,data.begin(),data.end(),0,thrust::minimum<int>());
}