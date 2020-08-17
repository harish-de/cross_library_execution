cmake_minimum_required(VERSION 3.17)
project(cross_library_execution CUDA)

set(CMAKE_CUDA_STANDARD 14)

FIND_PACKAGE(ArrayFire REQUIRED)

INCLUDE_DIRECTORIES(${ArrayFire_INCLUDE_DIRS})

add_executable(cross_library_execution main.cu)

TARGET_LINK_LIBRARIES(cross_library_execution ${ArrayFire_LIBRARIES})

set(CMAKE_CUDA_FLAGS "${CMAKE_CUDA_FLAGS} \
    --expt-extended-lambda \
    ")

set_target_properties(
        cross_library_execution
        PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)