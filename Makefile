all: rpm deb


VERSION != cat Version

rpm:
	cat build/disks-spindown.spec.template | sed -e "s/{{ VERSION }}/${VERSION}/g" > build/disks-spindown.spec
	rpmbuild -ba --build-in-place build/disks-spindown.spec
	cp ${HOME}/rpmbuild/RPMS/noarch/disks-spindown-${VERSION}-1.noarch.rpm build/
deb:
	cat build/control.template | sed -e "s/{{ VERSION }}/${VERSION}/g" > build/control
	rm -r disks-spindown_$(VERSION)-1_all || echo Previous build does not exist
	mkdir disks-spindown_$(VERSION)-1_all
	mkdir -p disks-spindown_$(VERSION)-1_all/usr/bin
	cp src/disks-spindown disks-spindown_$(VERSION)-1_all/usr/bin
	mkdir -p disks-spindown_$(VERSION)-1_all/usr/lib/systemd/system
	cp src/systemd/disks-spindown.service disks-spindown_$(VERSION)-1_all/usr/lib/systemd/system
	mkdir -p disks-spindown_$(VERSION)-1_all/etc
	cp src/conf.d/disks-spindown disks-spindown_$(VERSION)-1_all/etc/disks-spindown.conf
	mkdir disks-spindown_$(VERSION)-1_all/DEBIAN
	cp build/control disks-spindown_$(VERSION)-1_all/DEBIAN/control
	dpkg-deb --build --root-owner-group disks-spindown_$(VERSION)-1_all
	rm -r disks-spindown_$(VERSION)-1_all
	mv disks-spindown_${VERSION}-1_all.deb build/
