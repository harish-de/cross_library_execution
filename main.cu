//#include <list>
//
//#include <thrust/host_vector.h>
//#include <thrust/device_vector.h>
//
//#include <af/array.h>
//#include <arrayfire.h>
//
////#include <boost/compute.hpp>
//
///*
// * Abstract class definition of operators
// */
//
//class compute{
//public:
//    virtual void filter(std::vector<int> data, int value, std::string op) = 0;
//};
//
///*
// * Thrust operator definition
// */
//
//class computeWithThrust : public compute{
//public:
//    void filter(std::vector<int> data, int value, std::string op) override{
//        std::cout << "Running thrust filter " << std::endl;
//        thrust::host_vector<int> hostData(data);
//        thrust::device_vector<int> deviceData = hostData;
//
//        thrust::device_vector<int> device_result(deviceData.size());
//
//        thrust::replace_copy_if(thrust::device,deviceData.begin(),deviceData.end(),device_result.begin(),[=] __device__(const int x) {
//            return (x >= value);
//        },1);
//    }
//};
//
///*
// * ArrayFire operator definition
// */
//
//class computeWithAF: public compute{
//public:
//    void filter(std::vector<int> data, int value, std::string op) override{
//        std::cout << "Running AF filter " << std::endl;
//        int* hostData = &data[0];
//        af::array deviceData((dim_t)data.size(), hostData);
//        af::array indexOut;
//        // write an enum to replace the operator
//        indexOut = af::where(af::operator>=(deviceData,value));
//    }
//};
//
//int main() {
//
//    typedef std::list<compute*> computeList;
//
//    computeList clist;
//    clist.push_back(new computeWithThrust());
//    clist.push_back(new computeWithAF());
//
//    std::vector<int> l_shipdate;
//    l_shipdate.push_back(19940202);
//    l_shipdate.push_back(19930202);
//    l_shipdate.push_back(19940202);
//    l_shipdate.push_back(19930202);
//    l_shipdate.push_back(19940202);
//    l_shipdate.push_back(19930202);
//    l_shipdate.push_back(19940202);
//    l_shipdate.push_back(19930202);
//    l_shipdate.push_back(19940202);
//    l_shipdate.push_back(19930202);
//    l_shipdate.push_back(19940202);
//    l_shipdate.push_back(19930202);
//
//    int value = 19940101;
//    std::string op = "GE";
//
//    for(auto object : clist)
//    {
//        object->filter(l_shipdate,value,op);
//    }
//}
//#include "Thrust_SwitchBoard/ThrustCompute.h"
//#include "Plug/AbstractCompute.h"
//#include "adapter.cu"
#include <vector>
#include <string>
#include <iostream>

#include <thrust/host_vector.h>
#include <thrust/device_vector.h>

using namespace std;
//#include "ThrustCompute.cu"

class AbstractCompute{
public:
    void virtual selection(vector<int> data,string operation,int value){}
};

//class Compute: public AbstractCompute{
//public:
//    void selection(){
//        cout << "No implementation here";
//    }
//};

class AbstractThrustCompute{
public:
    void virtual thrustSelection(vector<int> data, string operation, int value, int new_value){}
};

class ThrustCompute: public AbstractThrustCompute{
public:
    void thrustSelection(vector<int> data, string operation, int value, int new_value){
        cout << "Running thrust filter " << endl;
        thrust::host_vector<int> hostData(data);
        thrust::device_vector<int> deviceData = hostData;

        thrust::device_vector<int> device_result(deviceData.size());

        thrust::replace_copy_if(thrust::device,deviceData.begin(),deviceData.end(),device_result.begin(),[=] __device__(const int x) {
            return (x >= value);
        },new_value);
    }
};

class Adapter: public AbstractCompute{
public:
    AbstractThrustCompute *ATC;
    Adapter(AbstractThrustCompute *ATC_obj){
        ATC = ATC_obj;
    }

    void selection(vector<int> data,string operation,int value){
        int new_value = 1;
        ATC->thrustSelection(data,operation,value,new_value);
    }
};

int main(){
    ThrustCompute *TC = new ThrustCompute();
    AbstractCompute *adapter = new Adapter(TC);

    std::vector<int> l_shipdate;
    l_shipdate.push_back(19940202);
    l_shipdate.push_back(19930202);
    l_shipdate.push_back(19940202);
    l_shipdate.push_back(19930202);
    l_shipdate.push_back(19940202);
    l_shipdate.push_back(19930202);
    l_shipdate.push_back(19940202);
    l_shipdate.push_back(19930202);
    l_shipdate.push_back(19940202);
    l_shipdate.push_back(19930202);
    l_shipdate.push_back(19940202);
    l_shipdate.push_back(19930202);

    int value = 19940101;
    std::string op = "GE";

    adapter->selection(l_shipdate,op,value);
}