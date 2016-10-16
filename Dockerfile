FROM fedora:latest
MAINTAINER Krishna Kumar <kks32@cam.ac.uk>

# Update to latest packages, remove vim-minimal & Install Git, GCC, Clang, Autotools and VIM
RUN dnf update -y && \
    dnf remove -y vim-minimal python sqlite && \
    dnf install -y clang cmake cppcheck eigen3-devel findutils gcc gcc-c++ \
                   git make valgrind vim voro++ voro++-devel && \
    dnf clean all

# Install Intel Threaded Building blocks
ENV TBB_VERSION 2017_20160916
ENV TBB_DOWNLOAD_URL https://www.threadingbuildingblocks.org/sites/default/files/software_releases/linux/tbb${TBB_VERSION}oss_lin.tgz
ENV TBB_INSTALL_DIR /opt

RUN wget ${TBB_DOWNLOAD_URL} \
	&& tar -C ${TBB_INSTALL_DIR} -xf tbb${TBB_VERSION}oss_lin.tgz \
	&& rm tbb${TBB_VERSION}oss_lin.tgz

RUN sed -i "s%SUBSTITUTE_INSTALL_DIR_HERE%${TBB_INSTALL_DIR}/tbb${TBB_VERSION}oss%" ${TBB_INSTALL_DIR}/tbb${TBB_VERSION}oss/bin/tbbvars.*

RUN echo "source ${TBB_INSTALL_DIR}/tbb${TBB_VERSION}oss/bin/tbbvars.sh intel64" >> /etc/bash.bashrc

# Create a user cbgeo
RUN useradd cbgeo
USER cbgeo

# Create a research directory and clone git repo of lbmdem code
RUN mkdir -p /home/cbgeo/research && \
    cd /home/cbgeo/research 
#    && \
#    git clone https://github.com/cb-geo/lem.git

# Done
#WORKDIR /home/cbgeo/research/lem
WORKDIR /home/cbgeo/research/
