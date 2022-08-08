FROM almalinux/8-init:8.6
USER root

RUN dnf install -y unzip 'dnf-command(config-manager)'

COPY start-vc4.sh /opt/
RUN chmod +x /opt/start-vc4.sh

COPY vc-4_4.0000.00007.01.zip /tmp/
WORKDIR /tmp/
RUN unzip vc-4_4.0000.00007.01.zip
WORKDIR /tmp/vc4/
RUN ./installVC4.sh

EXPOSE 80 443 41794 41795 41796 41797

ENTRYPOINT ["/opt/start-vc4.sh"]
