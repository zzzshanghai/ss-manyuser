FROM centos:latest

MAINTAINER zzzshanghai

ENV INSTALL_DIR=/root/shadowsocks

RUN yum clean all && \
    yum makecache && \
    yum update -y && \
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-* && \
    yum install -y m2crypto python-setuptools git curl iptables-devel && \
    easy_install pip && pip install shadowsocks cymysql

RUN git clone -b manyuser https://github.com/breakwa11/shadowsocks.git
    
#数据库相关信息请填写正确
RUN cp mysql.json user-mysql.json

RUN chmod +x $INSTALL_DIR/run.sh $INSTALL_DIR/server.py $INSTALL_DIR/setup.py $INSTALL_DIR/stop.sh

RUN python $INSTALL_DIR/setup.py install

EXPOSE 20001
EXPOSE 20002

CMD $INSTALL_DIR/run.sh
