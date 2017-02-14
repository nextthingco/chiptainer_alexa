# Base off the Docker container that includes Alpine for installing packages.
FROM ntc-registry.githost.io/nextthingco/chiptainer_alpine

RUN apk update && \
	apk add python-dev && \
	apk add memcached-dev && \
	apk add mpg123 && \
	apk add alsa-lib-dev && \
	apk add git && \
	
	apk add py2-pip && \
	pip install --upgrade pip && \
	git clone https://github.com/Valodim/python-pulseaudio.git && \
	cd python-pulseaudio && \
	python setup.py install && \
	cd ../ && rm python-pulseaudio -rf && \
	git clone https://github.com/sammachin/AlexaPi.git && \
	cd AlexaPi && \
	pip install -r requirements.txt
