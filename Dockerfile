FROM centos:latest

MAINTAINER zzzshanghai

ENV INSTALL_DIR=/shadowsocks

RUN yum clean all && \
    yum makecache && \
    yum update -y && \
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-* && \
    yum install -y m2crypto python-setuptools git curl iptables-devel && \
    easy_install pip && pip install cymysql
    
RUN git clone -b manyuser https://github.com/mengskysama/shadowsocks.git $INSTALL_DIR && \
    cp $INSTALL_DIR/config.json $INSTALL_DIR/user-config.json

#RUN git clone -b manyuser https://github.com/mengskysama/shadowsocks.git

ADD run.sh /run.sh

RUN chmod +x run.sh

EXPOSE 20001
EXPOSE 20002

ENTRYPOINT ["/run.sh"]

CMD ["python", "server.py"]
