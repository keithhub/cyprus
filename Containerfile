FROM quay.io/centos-bootc/centos-bootc:stream9

RUN dnf remove -y subscription-manager

RUN dnf install -y clevis-dracut clevis-luks clevis-systemd

RUN set -x; kver=$(cd /usr/lib/modules && echo *); dracut -vf /usr/lib/modules/$kver/initramfs.img $kver

RUN dnf config-manager --add-repo https://pkgs.tailscale.com/stable/centos/9/tailscale.repo \
    && dnf install -y tailscale \
    && systemctl enable tailscaled.service

COPY sysctl.d /usr/lib/sysctl.d/

RUN dnf clean all \
    && rm /var/log/dnf.log /var/log/dnf.rpm.log /var/log/dnf.librepo.log /var/log/hawkey.log

RUN bootc container lint
