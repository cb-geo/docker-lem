FROM fedora:latest
MAINTAINER Krishna Kumar <kks32@cam.ac.uk>

# Update to latest packages, remove vim-minimal & Install Git, GCC, Clang, Autotools and VIM
RUN dnf update -y && \
    dnf remove -y vim-minimal python sqlite && \
    dnf install -y boost boost-devel clang cmake cppcheck eigen3-devel findutils gcc gcc-c++ \
                   git gmsh gmsh-devel hdf5 hdf5-devel kernel-devel \
                   make sqlite sqlite-devel tar tbb tbb-devel valgrind vim \
                   voro++ voro++-devel vtk vtk-devel wget && \
    dnf clean all

# Install CUDA
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/fedora25/x86_64/cuda-repo-fedora25-9.1.85-1.x86_64.rpm && \
    dnf install -y ./cuda-repo-fedora25-9.1.85-1.x86_64.rpm && \
    dnf install -y cuda && \
    dnf clean all

# Install MKL
RUN wget -q http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/12414/l_mkl_2018.1.163.tgz && \
    tar -xzf l_mkl_2018.1.163.tgz && \
    cd l_mkl_2018.1.163 && \
    sed -i 's/ACCEPT_EULA=decline/ACCEPT_EULA=accept/g' silent.cfg && \
    sed -i 's/ARCH_SELECTED=ALL/ARCH_SELECTED=INTEL64/g' silent.cfg && \
    sed -i 's/COMPONENTS=DEFAULTS/COMPONENTS=;intel-comp-l-all-vars__noarch;intel-comp-nomcu-vars__noarch;intel-openmp__x86_64;intel-tbb-libs__x86_64;intel-mkl-common__noarch;intel-mkl-installer-license__noarch;intel-mkl-core__x86_64;intel-mkl-core-rt__x86_64;intel-mkl-doc__noarch;intel-mkl-doc-ps__noarch;intel-mkl-gnu__x86_64;intel-mkl-gnu-rt__x86_64;intel-mkl-common-ps__noarch;intel-mkl-core-ps__x86_64;intel-mkl-common-c__noarch;intel-mkl-core-c__x86_64;intel-mkl-common-c-ps__noarch;intel-mkl-tbb__x86_64;intel-mkl-tbb-rt__x86_64;intel-mkl-gnu-c__x86_64;intel-mkl-common-f__noarch;intel-mkl-core-f__x86_64;intel-mkl-gnu-f-rt__x86_64;intel-mkl-gnu-f__x86_64;intel-mkl-f95-common__noarch;intel-mkl-f__x86_64;intel-mkl-psxe__noarch;intel-psxe-common__noarch;intel-psxe-common-doc__noarch;intel-compxe-pset/g' silent.cfg && \
    ./install.sh -s silent.cfg && \
    cd .. && rm -rf * && \
    rm -rf /opt/intel/.*.log /opt/intel/compilers_and_libraries_2018.1.163/licensing && \
    echo "/opt/intel/mkl/lib/intel64" >> /etc/ld.so.conf.d/intel.conf && \
    ldconfig && \
    echo "source /opt/intel/mkl/bin/mklvars.sh intel64" >> /etc/bash.bashrc

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
