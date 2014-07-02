# Makefile for home config

all: update ansible

.PHONY: help
# target: help - Display callable targets
help:
	@egrep "^# target:" [Mm]akefile

.PHONY: update
# target: update - Setup the system with ansible
update:
	@git fetch origin
	@git rebase origin/master
	@git submodule update --init

.PHONY: ansible
# target: ansible - Setup the system with ansible
ansible:
	@sudo apt-get install ansible -y || echo "Skip ansible installation"
	@ansible-playbook -i inventory setup/playbook.yml -c local -sK
