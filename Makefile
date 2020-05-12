#
# This is the root Makefile for ensuring that the containers are all built
# properly
# GROUP can be overridden in the environment to root the docker images under
# different registry namespace
GROUP?=berga
# PREFIX defaults to `jnlp-agent` and can be changed to compute different image
# names
PREFIX?=mailcatcher

build:
	set -e; \
	docker build -f docker/alpine/Dockerfile -t ${GROUP}/${PREFIX}:alpine -t ${GROUP}/${PREFIX}:latest .

push:
	set -e; \
	docker push ${GROUP}/${PREFIX}:latest ${GROUP}/${PREFIX}:lpine

check: build

.PHONY: build check clean