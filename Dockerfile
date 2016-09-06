FROM centos:latest

MAINTAINER zzzshanghai

RUN yum clean all && \
    yum makecache && \
    yum update -y && \
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-* && \
    yum install -y m2crypto python-setuptools git curl iptables-devel && \
    easy_install pip && pip install shadowsocks cymysql

RUN git clone -b manyuser https://github.com/breakwa11/shadowsocks.git && \
    cp /root/shadowsocks/mysql.json /root/shadowsocks/user-mysql.json

RUN chmod +x /root/shadowsocks/run.sh /root/shadowsocks/server.py /root/shadowsocks/setup.py /root/shadowsocks/stop.sh

RUN python /root/shadowsocks/setup.py install

EXPOSE 20001
EXPOSE 20002

CMD /root/shadowsocks/run.sh
