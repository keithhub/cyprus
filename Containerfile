FROM quay.io/centos-bootc/centos-bootc:stream9

RUN dnf install clevis-dracut clevis-luks clevis-systemd -y && dnf clean all

COPY 10-static_ip.conf /etc/dracut.conf.d/

RUN dracut -fv --regenerate-all

RUN bootc container lint
