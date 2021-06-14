set ctr openfortivpn-ctr

buildah from --name $ctr --pull fedora

buildah run $ctr dnf -y upgrade

buildah run $ctr dnf -y install systemd

buildah run $ctr rm -f (string match -rv '^systemd-tmpfiles-setup.service$' -- /lib/systemd/system/sysinit.target.wants/*)

buildah run $ctr rm -f /lib/systemd/system/multi-user.target.wants/*

buildah run $ctr rm -f /etc/systemd/system/*.wants/*

buildah run $ctr rm -f /lib/systemd/system/local-fs.target.wants/*
buildah run $ctr rm -f /lib/systemd/system/sockets.target.wants/*udev*
buildah run $ctr rm -f /lib/systemd/system/sockets.target.wants/*initctl*
buildah run $ctr rm -f /lib/systemd/system/basic.target.wants/*
buildah run $ctr rm -f /lib/systemd/system/anaconda.target.wants/*

buildah run $ctr dnf -y install openfortivpn

buildah run $ctr dnf clean all

# buildah config --entrypoint "/usr/sbin/init" $ctr

buildah commit $ctr openfortivpn

buildah rm $ctr

