FROM quay.io/centos-bootc/centos-bootc:stream9

RUN dnf install -y clevis clevis-dracut clevis-luks clevis-systemd && dnf clean all

RUN set -x; kver=$(cd /usr/lib/modules && echo *); dracut -vf /usr/lib/modules/$kver/initramfs.img $kver

RUN bootc container lint
