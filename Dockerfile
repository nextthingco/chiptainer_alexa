# Base off the Docker container that includes Alpine for installing packages.
FROM ntc-registry.githost.io/nextthingco/chiptainer_alpine

COPY *.patch /tmp/

RUN apk update && \
	apk add python-dev && \
	apk add py-setuptools && \
	apk add alsa-lib-dev && \
	apk add memcached-dev && \
	apk add mpg123 && \
	apk add git && \
	apk add flex && \
	apk add bison && \
	apk add g++ && \
	apk add gcc && \
	apk add make && \
	apk add py2-pip && \

	 # Download source code for device tree compiler needed for CHIP_IO
        git clone https://github.com/atenart/dtc.git && \
        cd dtc && make && make install PREFIX=/usr && \
        cd .. && rm dtc -rf && \
        git clone https://github.com/xtacocorex/CHIP_IO.git && \
        cd CHIP_IO && python setup.py install && \
        # Remove CHIP_IO source code directory after it has been installed
        cd ../ && rm -rf CHIP_IO && \

	# Download/build audio libaries and AlexaPi project
	pip install --upgrade pip && \
	git clone https://github.com/Valodim/python-pulseaudio.git && \
	cd python-pulseaudio && \
	python setup.py install && \
	cd ../ && rm python-pulseaudio -rf && \
	git clone https://github.com/sammachin/AlexaPi.git && \
	cd AlexaPi && \
	pip install -r requirements.txt && \
	pip install pyalsaaudio && \
	patch < /tmp/setup.patch && \
	patch < /tmp/main.patch && \
	patch < /tmp/auth_web.patch && \

	# Remove packages no longer needed.
	apk del git && \
	apk del flex && \
	apk del bison && \
	apk del g++ && \
	apk del gcc && \
	apk del make && \
	apk del py2-pip

ENTRYPOINT cd AlexaPi && \
        /bin/sh setup.sh auto && \
        /bin/sh
