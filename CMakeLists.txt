cmake_minimum_required(VERSION 3.14)
project(gloam LANGUAGES C)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

string(COMPARE EQUAL "${CMAKE_CURRENT_SOURCE_DIR}" "${CMAKE_SOURCE_DIR}" GLOAM_STANDALONE)

# Set up external dependencies via FetchContent
include(FetchContent)

# xxhash
if (NOT TARGET xxhash)
    FetchContent_Declare(
        xxHash
        GIT_REPOSITORY https://git.uplinklabs.net/IntroversionSoftware/gamelibs-xxhash.git
        GIT_TAG origin/master
        SOURCE_SUBDIR build/cmake
    )
    FetchContent_MakeAvailable(xxHash)
endif()

if (MSVC)
    add_compile_definitions(_CRT_SECURE_NO_WARNINGS)
endif()

add_library(gloam_GL STATIC
    src/gl.c)
add_library(gloam_EGL STATIC
    src/egl.c)
add_library(gloam_GLX STATIC
    src/glx.c)
add_library(gloam_Vulkan STATIC
    src/vk.c)
add_library(gloam_WGL STATIC
    src/wgl.c)

target_include_directories(gloam_GL PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>)
target_include_directories(gloam_EGL PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>)
target_include_directories(gloam_GLX PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>)
target_include_directories(gloam_Vulkan PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>)
target_include_directories(gloam_WGL PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>)

target_link_libraries(gloam_GL PUBLIC xxHash::xxhash)
target_link_libraries(gloam_EGL PUBLIC xxHash::xxhash)
target_link_libraries(gloam_GLX PUBLIC xxHash::xxhash)
target_link_libraries(gloam_Vulkan PUBLIC xxHash::xxhash)
target_link_libraries(gloam_WGL PUBLIC xxHash::xxhash)

set_target_properties(gloam_GL PROPERTIES FOLDER "Gloam")
set_target_properties(gloam_EGL PROPERTIES FOLDER "Gloam")
set_target_properties(gloam_GLX PROPERTIES FOLDER "Gloam")
set_target_properties(gloam_Vulkan PROPERTIES FOLDER "Gloam")
set_target_properties(gloam_WGL PROPERTIES FOLDER "Gloam")

if (NOT GLOAM_STANDALONE)
    set_target_properties(gloam_GL PROPERTIES EXCLUDE_FROM_ALL TRUE)
    set_target_properties(gloam_EGL PROPERTIES EXCLUDE_FROM_ALL TRUE)
    set_target_properties(gloam_GLX PROPERTIES EXCLUDE_FROM_ALL TRUE)
    set_target_properties(gloam_Vulkan PROPERTIES EXCLUDE_FROM_ALL TRUE)
    set_target_properties(gloam_WGL PROPERTIES EXCLUDE_FROM_ALL TRUE)
endif()

add_library(gloam::GL ALIAS gloam_GL)
add_library(gloam::EGL ALIAS gloam_EGL)
add_library(gloam::GLX ALIAS gloam_GLX)
add_library(gloam::Vulkan ALIAS gloam_Vulkan)
add_library(gloam::WGL ALIAS gloam_WGL)
