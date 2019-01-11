SHELL=/bin/bash

ROLENAME=ansible-traefik-docker
TESTIMAGENAME=molecule-test
build-testimage:
	docker build -t ${TESTIMAGENAME} -f <( \
		echo "FROM quay.io/ansible/molecule:latest"; \
		echo "RUN sudo pip install docker-py"; \
	) .

test: build-testimage
	docker run --rm -it \
		-v '${PWD}':/tmp/${ROLENAME} \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-w /tmp/${ROLENAME} \
		${TESTIMAGENAME} \
		sudo molecule test
