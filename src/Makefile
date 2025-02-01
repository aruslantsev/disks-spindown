all: rpm deb

rpm:
	rpmbuild -ba --build-in-place disks-spindown.spec

version != grep --color=never Version control | cut -d\  -f2
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
