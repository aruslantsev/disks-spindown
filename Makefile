all: rpm deb


VERSION != cat Version

rpm:
	cat build/disks-spindown.spec.template | sed -e "s/{{ VERSION }}/${VERSION}/g" > build/disks-spindown.spec
	rpmbuild -ba --build-in-place build/disks-spindown.spec

deb:
	rm -r disks-spindown_$(version)-1_all || echo Previous build does not exist
	mkdir disks-spindown_$(version)-1_all
	mkdir -p disks-spindown_$(version)-1_all/usr/bin
	cp disks-spindown disks-spindown_$(version)-1_all/usr/bin
	mkdir -p disks-spindown_$(version)-1_all/usr/lib/systemd/system
	cp systemd/disks-spindown.service disks-spindown_$(version)-1_all/usr/lib/systemd/system
	mkdir -p disks-spindown_$(version)-1_all/etc
	cp conf.d/disks-spindown disks-spindown_$(version)-1_all/etc/disks-spindown.conf
	mkdir disks-spindown_$(version)-1_all/DEBIAN
	cp control disks-spindown_$(version)-1_all/DEBIAN/control
	dpkg-deb --build --root-owner-group disks-spindown_$(version)-1_all
	rm -r disks-spindown_$(version)-1_all
