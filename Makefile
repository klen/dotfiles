# Makefile for home config

all: ansible

.PHONY: help
# target: help - Display callable targets
help:
	@egrep "^# target:" [Mm]akefile

.PHONY: ansible
# target: ansible - Setup the system with ansible
ansible:
	@sudo apt-get install ansible
	@git submodule update --init
	@ansible-playbook -i inventory setup/playbook.yml -c local -sK
