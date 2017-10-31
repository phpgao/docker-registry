PREFIX ?=

install:
	mkdir -p ${PREFIX}/usr/lib/docker-registry
	cp docker-registry.service ${PREFIX}/usr/lib/systemd/system/docker-registry.service
	cp -r _docker/ ${PREFIX}/usr/lib/docker-registry/
	cp docker-compose.yml ${PREFIX}/usr/lib/docker-registry/docker-compose.yml

deb-clean:
	sudo rm -rf build

deb: deb-clean
deb: PREFIX=build/deb
deb:
	mkdir -p ${PREFIX}/usr/lib/systemd/system/
	env PREFIX=${PREFIX} make install

	mkdir build/deb/DEBIAN
	cp deb/postinst build/deb/DEBIAN
	cp deb/prerm build/deb/DEBIAN
	cp deb/control build/deb/DEBIAN
	sudo chown -R root:root build/deb
	dpkg-deb --build build/deb build/docker-registry.deb
