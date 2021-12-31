cmake_minimum_required(VERSION 3.13)

project(cause_crash_dump)

set(CMAKE_CXX_STANDARD 20)

add_subdirectory(src)

# cpack instructions

include(CPack)

install(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION bin)
