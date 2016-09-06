FROM centos:latest

MAINTAINER zzzshanghai

RUN yum clean all && \
    yum makecache && \
    yum update -y && \
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-* && \
    yum install -y m2crypto python-setuptools git curl iptables-devel && \
    easy_install pip && pip install shadowsocks cymysql

RUN git clone -b manyuser https://github.com/breakwa11/shadowsocks.git

WORKDIR /root/shadowsocks
    
#数据库相关信息请填写正确
COPY mysql.json user-mysql.json

RUN chmod +x run.sh server.py setup.py stop.sh

RUN python setup.py install

EXPOSE 20001
EXPOSE 20002

CMD run.sh
