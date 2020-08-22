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
#include <list>

#include <thrust/host_vector.h>
#include <thrust/device_vector.h>

using namespace std;
//#include "ThrustCompute.cu"

class AbstractCompute{
public:
    void virtual selection(vector<int> data,string operation,int value){}

    void virtual setUnion(vector<int> lhs, vector<int> rhs){}

    void virtual setIntersection(vector<int> lhs, vector<int> rhs){}

    void virtual setDifference(vector<int> lhs, vector<int> rhs){}

    void virtual sort(vector<int> data,int order){} //0 - ascending, 1 - descending

    void virtual sum(vector<int> data){}

    void virtual findMax(vector<int> data){}
};

//class Compute: public AbstractCompute{
//public:
//    void selection(){
//        cout << "No implementation here";
//    }
//};

class AbstractThrustCompute{
public:
    thrust::device_vector<int> virtual getThrustGpuData(vector<int> data){}

    void virtual thrustSelection(vector<int> data, string operation, int value, int new_value){}

    void virtual thrustSetUnion(vector<int> lhs, vector<int> rhs){}

    void virtual thrustSetIntersection(vector<int> lhs, vector<int> rhs){}

    void virtual thrustSetDifference(vector<int> lhs, vector<int> rhs){}

    void virtual thrustSort(vector<int> data,int order){}

    void virtual thrustSum(vector<int> data){}

    void virtual thrustFindMax(vector<int> data){}
};

class ThrustCompute: public AbstractThrustCompute{
public:
    thrust::device_vector<int> getThrustGpuData(vector<int> data){
        thrust::host_vector<int> hostData(data);
        thrust::device_vector<int> deviceData = hostData;

        return deviceData;
    }


    void thrustSelection(vector<int> data, string operation, int value, int new_value){
        cout << "Running thrust filter " << endl;

        thrust::device_vector<int> deviceData = getThrustGpuData(data);

        thrust::device_vector<int> device_result(deviceData.size());

        thrust::replace_copy_if(thrust::device,deviceData.begin(),deviceData.end(),device_result.begin(),[=] __device__(const int x) {
            return (x >= value);
        },new_value);
    }

    void thrustSetUnion(vector<int> lhs, vector<int> rhs){
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

    void thrustSetIntersection(vector<int> lhs, vector<int> rhs){
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

    void thrustSetDifference(vector<int> lhs, vector<int> rhs){
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

    void thrustSort(vector<int> data, int order){
        cout << "Running thrust sort " << endl;
        thrust::device_vector<int> deviceData = getThrustGpuData(data);
        if(order){
            thrust::sort(thrust::device, deviceData.begin(),deviceData.end(),thrust::greater<int>());
        }else{
            thrust::sort(thrust::device, deviceData.begin(),deviceData.end());
        }
    }

    void thrustSum(vector<int> data){
        cout << "Running thrust Sum " << endl;
        thrust::device_vector<int> deviceData = getThrustGpuData(data);
        thrust::reduce(thrust::device,deviceData.begin(),deviceData.end());
    }

    void thrustFindMax(vector<int> data){
        cout << "Running thrust find Max " << endl;
        thrust::device_vector<int> deviceData = getThrustGpuData(data);
        thrust::reduce(thrust::device,deviceData.begin(),deviceData.end(),0,thrust::maximum<int>());
    }
};

class AbstractArrayFire{
public:
    void virtual arrayFireSelection(vector<int> data, string operation, int value){}
};

class Adapter: public AbstractCompute{
public:
    AbstractThrustCompute *ATC;
    AbstractArrayFire *AAF;
    Adapter(AbstractThrustCompute *ATC_obj){
        ATC = ATC_obj;
    }

    void selection(vector<int> data,string operation,int value){
        int new_value = 1;
        ATC->thrustSelection(data,operation,value,new_value);
    }

    void setUnion(vector<int> lhs, vector<int> rhs){
        ATC->thrustSetUnion(lhs,rhs);
    }

    void setIntersection(vector<int> lhs, vector<int> rhs){
        ATC->thrustSetIntersection(lhs,rhs);
    }

    void setDifference(vector<int> lhs, vector<int> rhs){
        ATC->thrustSetDifference(lhs,rhs);
    }

    void sort(vector<int> data, int order) override{
        ATC->thrustSort(data,order);
    }

    void sum(vector<int> data){
        ATC->thrustSum(data);
    }

    void findMax(vector<int> data){
        ATC->thrustFindMax(data);
    }
};

int main(){

    ThrustCompute *TC = new ThrustCompute();
    AbstractCompute *adapter = new Adapter(TC);

    std::vector<int> l_shipdate;
    l_shipdate.push_back(19940302);
    l_shipdate.push_back(19930202);
    l_shipdate.push_back(19940202);
    l_shipdate.push_back(19930202);
    l_shipdate.push_back(19940202);

    std::vector<int> l_traindate;
    l_traindate.push_back(19940302);
    l_traindate.push_back(19910202);
    l_traindate.push_back(19940302);
    l_traindate.push_back(19970202);
    l_traindate.push_back(19940202);


    int value = 19940101;
    std::string op = "GE";

    adapter->selection(l_shipdate,op,value);
    adapter->setUnion(l_shipdate,l_traindate);
    adapter->setIntersection(l_shipdate,l_traindate);
    adapter->setDifference(l_shipdate,l_traindate);
    adapter->sort(l_shipdate,0);
    adapter->sum(l_shipdate);
    adapter->findMax(l_shipdate);
}