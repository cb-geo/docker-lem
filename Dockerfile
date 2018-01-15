FROM fedora:latest
MAINTAINER Krishna Kumar <kks32@cam.ac.uk>

# Update to latest packages, remove vim-minimal & Install Git, GCC, Clang, Autotools and VIM
RUN dnf update -y && \
    dnf remove -y vim-minimal python sqlite && \
    dnf install -y boost boost-devel clang cmake cppcheck eigen3-devel findutils gcc gcc-c++ \
                   git hdf5 hdf5-devel kernel-devel \
                   make sqlite sqlite-devel tar tbb tbb-devel valgrind vim \
                   voro++ voro++-devel vtk vtk-devel wget && \
    dnf clean all

# Install CUDA
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/fedora25/x86_64/cuda-repo-fedora25-9.1.85-1.x86_64.rpm && \
    dnf install -y ./cuda-repo-fedora25-9.1.85-1.x86_64.rpm && \
    dnf install -y cuda && \
    dnf clean all

# Install MKL
ENV MKL_VER=l_mkl_2017.2.174

RUN cd /tmp && \
  wget http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/11306/${MKL_VER}.tgz && \
  tar xzf ${MKL_VER}.tgz && \
  cd ${MKL_VER} && \
  sed -i 's/ACCEPT_EULA=decline/ACCEPT_EULA=accept/g' silent.cfg && \
  sed -i 's/ACTIVATION_TYPE=exist_lic/ACTIVATION_TYPE=trial_lic/g' silent.cfg && \
# NOTE: Installer may complain about "Unsupported OS". Installation should still be valid.
  ./install.sh -s silent.cfg && \
# Clean up
  cd .. && rm -rf ${MKL_VER}*

# Create a user cbgeo
RUN useradd cbgeo
USER cbgeo

# Configure MKL
RUN echo "source /opt/intel/bin/compilervars.sh -arch intel64 -platform linux" >> ~/.bashrc
RUN echo "source /opt/intel/mkl/bin/mklvars.sh intel64" >> ~/.bashrc

# Create a research directory and clone git repo of lbmdem code
RUN mkdir -p /home/cbgeo/research && \
    cd /home/cbgeo/research 
#    && \
#    git clone https://github.com/cb-geo/lem.git

# Done
#WORKDIR /home/cbgeo/research/lem
WORKDIR /home/cbgeo/research/

RUN /bin/bash "$@"
