FROM centos:7
LABEL maintainer="nlp@pachiratech.com"
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
# 配置系统时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# 安装GCC、MinGW64
RUN yum update -y \
    && yum install -y epel-release \
    && curl https://copr.fedorainfracloud.org/coprs/alonid/mingw-epel7/repo/epel-7/alonid-mingw-epel7-epel-7.repo -o /etc/yum.repos.d/alonid-mingw-epel7-epel-7.repo \
    && yum makecache \
    && yum install -y git make cmake gcc gcc-c++ binutils flex bison mingw64-gcc mingw64-gcc-c++ \
    && yum clean all
# 安装Doxygen
RUN curl -o doxygen.tar.gz https://pilotfiber.dl.sourceforge.net/project/doxygen/rel-1.8.11/doxygen-1.8.11.src.tar.gz \
    && tar -xf doxygen.tar.gz \
    && cd doxygen-1.8.11 \
    && mkdir build \
    && cd build \
    && cmake -G "Unix Makefiles" .. \
    && make -j \
    && make install \
    && cd ../../ \
    && rm -rf doxygen-1.8.11 \
    && rm -f doxygen.tar.gz
