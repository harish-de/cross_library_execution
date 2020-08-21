//
// Created by hkumar on 21.08.20.
//

#include <thrust/host_vector.h>
#include <thrust/device_vector.h>

#include <vector>
#include <string>
using namespace std;

class ThrustCompute{
public:
    void thrustSelection(vector<int> data, string operation, int value, int new_value){
        std::cout << "Running thrust filter " << std::endl;
        thrust::host_vector<int> hostData(data);
        thrust::device_vector<int> deviceData = hostData;

        thrust::device_vector<int> device_result(deviceData.size());

        thrust::replace_copy_if(thrust::device,deviceData.begin(),deviceData.end(),device_result.begin(),[=] __device__(const int x) {
            return (x >= value);
        },new_value);
    }
};
