bootstrap:docker
From:fedora:latest

%post
# Krishna Kumar <kks32@cam.ac.uk>
dnf update -y && \
    dnf remove -y vim-minimal python sqlite && \
    dnf install -y boost boost-devel clang cmake cppcheck eigen3-devel findutils gcc gcc-c++ \
                   git hdf5 hdf5-devel kernel-devel \
                   make sqlite sqlite-devel tar valgrind vim \
                   voro++ voro++-devel vtk vtk-devel wget && \
    dnf clean all

export MKL_VER=l_mkl_2017.2.174
echo "
export MKL_VER=l_mkl_2017.2.174" >> /environment
cd /tmp && \
  wget http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/11306/${MKL_VER}.tgz && \
  tar xzf ${MKL_VER}.tgz && \
  cd ${MKL_VER} && \
  sed -i 's/ACCEPT_EULA=decline/ACCEPT_EULA=accept/g' silent.cfg && \
  sed -i 's/ACTIVATION_TYPE=exist_lic/ACTIVATION_TYPE=trial_lic/g' silent.cfg && \
  ./install.sh -s silent.cfg && \
  cd .. && rm -rf ${MKL_VER}*

export TBB_VERSION=2017_20160916
echo "
export TBB_VERSION=2017_20160916" >> /environment
export TBB_DOWNLOAD_URL=https://www.threadingbuildingblocks.org/sites/default/files/software_releases/linux/tbb${TBB_VERSION}oss_lin.tgz
echo "
export TBB_DOWNLOAD_URL=https://www.threadingbuildingblocks.org/sites/default/files/software_releases/linux/tbb${TBB_VERSION}oss_lin.tgz" >> /environment
export TBB_INSTALL_DIR=/opt
echo "
export TBB_INSTALL_DIR=/opt" >> /environment
wget ${TBB_DOWNLOAD_URL} \
	&& tar -C ${TBB_INSTALL_DIR} -xf tbb${TBB_VERSION}oss_lin.tgz \
	&& rm tbb${TBB_VERSION}oss_lin.tgz
sed -i "s%SUBSTITUTE_INSTALL_DIR_HERE%${TBB_INSTALL_DIR}/tbb${TBB_VERSION}oss%" ${TBB_INSTALL_DIR}/tbb${TBB_VERSION}oss/bin/tbbvars.*

useradd cbgeo
USER cbgeo

echo "source ${TBB_INSTALL_DIR}/tbb${TBB_VERSION}oss/bin/tbbvars.sh intel64" >> ~/.bashrc
echo "PATH=${TBB_INSTALL_DIR}/tbb${TBB_VERSION}oss/:$PATH" >> ~/.bashrc
echo "LD_LIBRARY_PATH=${TBB_INSTALL_DIR}/tbb${TBB_VERSION}oss/lib/:$LD_LIBRARY_PATH" >> ~/.bashrc
echo "TBB_VERSION=0" >> ~/.bashrc
export PATH=${TBB_INSTALL_DIR}/tbb${TBB_VERSION}oss/:$PATH
export LD_LIBRARY_PATH=${TBB_INSTALL_DIR}/tbb${TBB_VERSION}oss/lib/:$LD_LIBRARY_PATH
export TBB_VERSION=0
echo "source /opt/intel/bin/compilervars.sh -arch intel64 -platform linux" >> ~/.bashrc
echo "source /opt/intel/mkl/bin/mklvars.sh intel64" >> ~/.bashrc
mkdir -p /home/cbgeo/research && \
    cd /home/cbgeo/research 
