FROM quay.io/centos-bootc/centos-bootc:stream9

RUN dnf install -y clevis clevis-dracut clevis-luks clevis-systemd && dnf clean all

COPY 60-clevis.conf /usr/lib/dracut/dracut.conf.d/60-clevis.conf

RUN dracut -fv --regenerate-all

RUN bootc container lint
