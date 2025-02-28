FROM quay.io/centos-bootc/centos-bootc:stream9

# Remove Subscription Manager

RUN dnf remove -y subscription-manager

# Install and enable Clevis

RUN dnf install -y clevis-dracut clevis-luks clevis-systemd

RUN mkdir -p /usr/lib/bootc/kargs.d
RUN echo 'kargs = ["rd.neednet=1"]' >> /usr/lib/bootc/kargs.d/99-clevis-pin-tang.toml

RUN set -x; kver=$(cd /usr/lib/modules && echo *); dracut -vf /usr/lib/modules/$kver/initramfs.img $kver

# Install and enable Tailscale

RUN dnf config-manager --add-repo https://pkgs.tailscale.com/stable/centos/9/tailscale.repo \
    && dnf install -y tailscale \
    && systemctl enable tailscaled.service

COPY sysctl.d /usr/lib/sysctl.d/

# Clean up

RUN dnf clean all \
    && rm /var/log/dnf.log /var/log/dnf.rpm.log /var/log/dnf.librepo.log /var/log/hawkey.log

# Finish up by linting

RUN bootc container lint
