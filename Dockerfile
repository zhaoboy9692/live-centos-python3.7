FROM lambdadriver/docker-ffmpeg-centos:latest
MAINTAINER genezhao zhaoboy9692@163.com
USER root

RUN yum install wget -y
ENV PYTHON_VERSION=3.7.2 \
    SSL_VERSION=1_1_1d

RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup && \
    wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo && \
    yum -y install epel-release && \
    wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo && \
    yum clean all && \
    yum makecache
RUN yum install -y wget zlib-devel bzip2-devel openssl-devel openssl-static ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel libffi-devel lzma gcc
RUN yum -y groupinstall "Development tools"  &&  wget https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tgz && tar xzf Python-3.7.2.tgz
RUN cd Python-3.7.2 && ./configure --enable-optimizations && make altinstall
RUN  yum install -y  openssl-devel zlib git
RUN cd rtmpdump && make && make install
RUN python3.7 -m pip install python-librtmp==0.3.0 websockets==6.0 pyppeteer==0.2.2 -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
RUN pyppeteer-install
#RUN pip3 install websockets==6.0 --force-reinstall -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
#CMD ['python3.7','run.py','monitor']