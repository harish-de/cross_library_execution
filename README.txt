Project structure following "separation of concerns" principle:
1. "Base" directory - containing common interface for database operations

2.  "ThrustOperations",
    "BoostOperations",
    "BoltOperations",
    "ArrayFireOperations",
    "libcudfOperations"
    - these directories contain respective library implementation of database operations and respective adapters

3. "test_tpch_queries"
    - this directory calls and executes each TPCH-query with relevant data
    - add methods to
        - calculate time taken for each operation by a library
        - calculate total time for a query by a library
        - log these details

4. main.cu
    - just initiate the calls to a particular query
    - the iterator for library calls cannot be done here as it does not support cross-platform execution

5. CMakeLists.txt
    - has two libraries
        - cross_library = that contains all files except main.cu
        - cross_library_execution = contains only main.cu
        - these two libraries are linked together

6.     /*
        * Why not to write functors using struct
        * With CUDA 7.5 one can declare device lambdas in host code with [] __device__ (params...) { code ... } plus passing to nvcc this flag: --expt-extended-lambda
        * With CUDA 7.5 onwards, the logic must be directly expressed within thrust function calls
        */

   //    struct myFunctor
   //    {
   //        const int *m_vec1;
   //        const int *m_vec2;
   //        int *m_result;
   //        size_t v1size;
   //        myFunctor(thrust::device_vector<int> const& vec1, thrust::device_vector<int> const& vec2, thrust::device_vector<int>& result)
   //        {
   //            m_vec1 = thrust::raw_pointer_cast(vec1.data());
   //            m_vec2 = thrust::raw_pointer_cast(vec2.data());
   //            m_result = thrust::raw_pointer_cast(result.data());
   //            v1size = vec1.size();
   //        }
   //
   //        __device__
   //        void operator()(const size_t  x) const
   //        {
   //            size_t i = x%v1size;
   //            size_t j = x/v1size;
   //            m_result[i + j * v1size] = m_vec1[i] + m_vec2[j];
   //        }
   //    };
