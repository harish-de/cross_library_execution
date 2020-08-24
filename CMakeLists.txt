cmake_minimum_required(VERSION 3.15)
project(cross_library_execution LANGUAGES CUDA CXX)
set(CMAKE_CUDA_STANDARD 14)

FIND_PACKAGE(ArrayFire REQUIRED)
#find_package(Boost  REQUIRED)
#find_package(OpenCL REQUIRED)

INCLUDE_DIRECTORIES(${ArrayFire_INCLUDE_DIRS})
#INCLUDE_DIRECTORIES(${Boost_INCLUDE_DIRS})
#INCLUDE_DIRECTORIES(${OpenCL_INCLUDE_DIRS})

#find_package(BoostCompute REQUIRED)
#include_directories(${BoostCompute_INCLUDE_DIRS})

# target_compile_features(main PUBLIC cxx_std_11)

set(CMAKE_CUDA_FLAGS "${CMAKE_CUDA_FLAGS} \
    --expt-extended-lambda \
    ")


include_directories(/usr/local/cuda-11.0/include/)
add_executable(
        cross_library_execution
        main.cu
        AbstractCompute.h
        ThrustCompute.cu
#        adapter.cu
        AbstractThrustCompute.cuh
        Adapter.h
        Thrust_something.cu Thrust_something.cuh)

set_property(TARGET cross_library_execution
        PROPERTY CUDA_SEPARABLE_COMPILATION ON)

#TARGET_LINK_LIBRARIES(cross_library_execution LINK_PUBLIC ${ArrayFire_LIBRARIES} ${Boost_LIBRARIES} ${OpenCL_LIBRARIES})

target_link_libraries(cross_library_execution LINK_PUBLIC ${ArrayFire_LIBRARIES})

set_target_properties(
        cross_library_execution
        PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)


