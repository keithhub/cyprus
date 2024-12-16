FROM quay.io/centos-bootc/centos-bootc:stream9

RUN dnf install clevis-dracut clevis-luks clevis-systemd -y && dnf clean all

RUN dracut -fv --regenerate-all

RUN bootc container lint
