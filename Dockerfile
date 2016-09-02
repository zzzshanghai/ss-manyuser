FROM centos:latest

MAINTAINER zzzshanghai

RUN yum clean all && \
    yum makecache && \
    yum update -y && \
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-* && \
    yum install -y m2crypto python-setuptools git curl iptables-devel && \
    easy_install pip && pip install cymysql
    
RUN git clone -b manyuser https://github.com/breakwa11/shadowsocks.git
#RUN git clone -b manyuser https://github.com/mengskysama/shadowsocks.git

ADD run.sh /run.sh

RUN chmod +x /run.sh

EXPOSE 20001-200020

ENTRYPOINT ["/run.sh"]

CMD ["server.py"]
