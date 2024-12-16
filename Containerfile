FROM quay.io/centos-bootc/centos-bootc:stream9

RUN dnf install clevis-dracut clevis-luks clevis-systemd -y && dnf clean all

COPY <<"EOT" /etc/dracut.conf.d/10-static_ip.conf
kernel-cmdline="ip=209.135.170.196::209.135.170.1:255.255.255.0::ens18:none nameserver=9.9.9.9"
EOT

RUN dracut -fv --regenerate-all

RUN bootc container lint
