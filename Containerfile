FROM quay.io/centos-bootc/centos-bootc:stream9

RUN dnf install -y clevis-dracut clevis-luks clevis-systemd && dnf clean all

RUN set -x; kver=$(cd /usr/lib/modules && echo *); dracut -vf /usr/lib/modules/$kver/initramfs.img $kver

RUN dnf config-manager --add-repo https://pkgs.tailscale.com/stable/centos/9/tailscale.repo \
    && dnf install -y tailscale \
    && dnf clean all \
    && ln -s ../tailscaled.service /usr/lib/systemd/system/multi-user.target.wants/tailscaled.service

RUN bootc container lint
