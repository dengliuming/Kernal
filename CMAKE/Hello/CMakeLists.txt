cmake_minimum_required(VERSION 3.10)	# 设置cmake最小版本
PROJECT (HELLO VERSION 1.0 LANGUAGES C CXX)					# 设置工程名 版本号 所支持的语言
SET(SRC_LIST hello.cpp)					# 将源文件赋值给变量SRC_LIST	
MESSAGE(STATUS "THIS isBINARY dir" ${HELLO_BINARY_DIR})	# 打印：-- THIS isBINARY 																		dir/home/book/share/Kernal/CMAKE
SET(A 1)												# 打印：1
SET(CMAKE_CXX_STANDARAD 11)								# 设置C++标准为C++ 11
# //设置输出文件位置
SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)     # 将可执行的文件(.exe\dll)放到当前工程目录下的bin文件中
SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)     # 静态库文件存放位置
# //
# OPTION：开关
OPTION(DATE_ENABLE "OUTPUT DATE" ON)            # 开启当前日期  ：变量开关:DATE_ENABLE
IF(DATE_ENABLE)
    SET(DATE "2022.8.14")
ENDIF()
CONFIGURE_FILE(config.h.in config.h)                    # 输入文件中形如 @VAR@ 或 ${VAR} 的字符串会被替换为这些变量的当前值，如果未定义则被替换为空字符串
                                                        # 并生成config.h的头文件

add_subdirectory(cal)       # 进入lib子目录下的CMakeLists.txt
include_directories(${PROJECT_BINARY_DIR})
ADD_EXECUTABLE(hello ${SRC_LIST})						# 生成hello的可执行文件

target_link_libraries(hello PUBLIC addtion)             # 链接静态库
# 或者 ： target_link_libraries(hello PUBLIC /home/book/share/Kernal/CMAKE/Hello/cal/libsubtion.so)  # 绝对路径来链接动静太库
# 注意：静态库可以任意位置，只要链接了就行，但是动态库必须跟可执行文件是同级目录下
target_link_libraries(hello PUBLIC subtion)             # 链接动态库

target_include_directories(hello PUBLIC ${HELLO_SOURCE_DIR}/cal)  # 指定目标的头文件路径

INSTALL(TARGETS hello DESTINATION bin)   # 将hello文件安装到bin目录下
INSTALL(FILES "${PROJECT_BINARY_DIR}/config.h" DESTINATION include) # 将config.h安装到include目录下
# INSTALL(FILES "${PROJECT_BINARY_DIR}/cal/addaction.h" DESTINATION include) 
# INSTALL(FILES "${PROJECT_BINARY_DIR}/cal/subtion.h" DESTINATION include) 
# target_include_directories(hello PUBLIC "${HELLO_BINARY_DIR}")  # 指定目标的头文件路径
