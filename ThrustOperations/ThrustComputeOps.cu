//
// Created by hkumar on 26.08.20.
//

#include "ThrustComputeOps.cuh"

thrust::device_vector<int> ThrustCompute::getThrustGpuData(vector<int> data) {
    thrust::host_vector<int> hostData(data);
    thrust::device_vector<int> deviceData = hostData;

    return deviceData;
}

void ThrustCompute::thrustSelection(vector<int> data, string operation, int value, int new_value){
    cout << "Running thrust filter " << endl;

    thrust::device_vector<int> deviceData = getThrustGpuData(data);

    thrust::device_vector<int> device_result(deviceData.size());

    thrust::replace_copy_if(thrust::device,deviceData.begin(),deviceData.end(),device_result.begin(),[=] __device__(const int x) {
        return (x >= value);
    },new_value);
}

void ThrustCompute::thrustSetUnion(vector<int> lhs, vector<int> rhs){
    cout <<  "Running thrust set union" << endl;
    thrust::device_vector<int> lhs_deviceData = getThrustGpuData(lhs);;
    thrust::device_vector<int> rhs_deviceData = getThrustGpuData(rhs);

    thrust::device_vector<int> device_result(2*lhs_deviceData.size());

    thrust::set_union(thrust::device,lhs_deviceData.begin(),lhs_deviceData.end(),
                      rhs_deviceData.begin(),rhs_deviceData.end(),
                      device_result.begin());

//        std::cout<<"result=";
//        thrust::copy(device_result.begin(), device_result.end(), std::ostream_iterator<int>(std::cout, " "));
//        std::cout<<std::endl;
}

void ThrustCompute::thrustSetIntersection(vector<int> lhs, vector<int> rhs){
    cout <<  "Running thrust set intersection" << endl;

    thrust::device_vector<int> lhs_deviceData = getThrustGpuData(lhs);;
    thrust::device_vector<int> rhs_deviceData = getThrustGpuData(rhs);

    thrust::device_vector<int> device_result(lhs_deviceData.size());

    thrust::set_intersection(thrust::device, lhs_deviceData.begin(),lhs_deviceData.end(),
                             rhs_deviceData.begin(),rhs_deviceData.end(),
                             device_result.begin());
//        std::cout<<"result=";
//        thrust::copy(device_result.begin(), device_result.end(), std::ostream_iterator<int>(std::cout, " "));
//        std::cout<<std::endl;
}

void ThrustCompute::thrustSetDifference(vector<int> lhs, vector<int> rhs){
    cout <<  "Running thrust set difference" << endl;

    thrust::device_vector<int> lhs_deviceData = getThrustGpuData(lhs);;
    thrust::device_vector<int> rhs_deviceData = getThrustGpuData(rhs);

    thrust::device_vector<int> device_result(2*lhs_deviceData.size());

    thrust::set_difference(thrust::device, lhs_deviceData.begin(),lhs_deviceData.end(),
                           rhs_deviceData.begin(),rhs_deviceData.end(),
                           device_result.begin());
//        std::cout<<"result=";
//        thrust::copy(device_result.begin(), device_result.end(), std::ostream_iterator<int>(std::cout, " "));
//        std::cout<<std::endl;
}

void ThrustCompute::thrustSort(vector<int> data, int order){
    cout << "Running thrust sort " << endl;
    thrust::device_vector<int> deviceData = getThrustGpuData(data);
    if(order){
        thrust::sort(thrust::device, deviceData.begin(),deviceData.end(),thrust::greater<int>());
    }else{
        thrust::sort(thrust::device, deviceData.begin(),deviceData.end());
    }
}

void ThrustCompute::thrustSum(vector<int> data){
    cout << "Running thrust Sum " << endl;
    thrust::device_vector<int> deviceData = getThrustGpuData(data);
    thrust::reduce(thrust::device,deviceData.begin(),deviceData.end());
}

void ThrustCompute::thrustFindMax(vector<int> data){
    cout << "Running thrust find Max " << endl;
    thrust::device_vector<int> deviceData = getThrustGpuData(data);
    thrust::reduce(thrust::device,deviceData.begin(),deviceData.end(),0,thrust::maximum<int>());
}