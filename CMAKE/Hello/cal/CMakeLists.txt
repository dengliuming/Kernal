ADD_LIBRARY(addtion STATIC addaction.cpp)       # 生成静态库文件

ADD_LIBRARY(subtion SHARED subtion.cpp)         # 生成动态库文件

INSTALL(TARGETS addtion DESTINATION lib)         # 将静态库文件安装到lib中
INSTALL(TARGETS subtion DESTINATION bin)         # 将动态库文件安装到bin中，保证跟可执行文件相同目录

INSTALL(FILES addaction.h DESTINATION include) 
INSTALL(FILES subtion.h DESTINATION include) 