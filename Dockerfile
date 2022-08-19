FROM almalinux/8-init:8.6
USER root

RUN dnf install -y unzip expect firewalld 'dnf-command(config-manager)'

COPY start-vc4.sh /opt/
RUN chmod +x /opt/start-vc4.sh

WORKDIR /tmp
COPY vc-4_4.0000.00007.01.zip /tmp
RUN unzip vc-4_4.0000.00007.01.zip

COPY vc4install.exp /tmp/vc4
COPY installVC4.sh /tmp/vc4
RUN chmod +x /tmp/vc4/vc4install.exp
RUN chmod +x /tmp/vc4/installVC4.sh

WORKDIR /tmp/vc4
RUN ./vc4install.exp

EXPOSE 80 443 41794 41795 41796 41797

ENTRYPOINT ["/opt/start-vc4.sh"]
