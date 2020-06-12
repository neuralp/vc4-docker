FROM ubuntu:xenial

RUN dpkg --add-architecture i386
RUN apt update && apt upgrade -y

RUN apt install apt-transport-https tclsh mariadb-server python -y
RUN apt install --no-install-recommends expect -y

COPY crestron.key /root/
RUN apt-key add /root/crestron.key

COPY crestron.list /etc/apt/sources.list.d/
RUN apt update

# Install libperl5 but there seems to be an error in the i386 install that needs to be solved
RUN apt install libperl5.22:i386 -y; exit 0
RUN rm /usr/share/doc/libperl5.22/changelog.Debian.gz
RUN apt install libperl5.22:i386 apt-transport-https -y

ADD https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/v1.4/files/docker/systemctl.py /bin/systemctl
RUN chmod +x /bin/systemctl

COPY vc4install.exp /root/
RUN chmod +x /root/vc4install.exp
RUN ~/vc4install.exp

COPY start-vc4.sh /opt/
RUN chmod +x /opt/start-vc4.sh

ENTRYPOINT ["/opt/start-vc4.sh"]
