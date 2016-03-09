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
	@command -v ansible-playbook || make ansible-install
	@ansible-playbook -i inventory setup/playbook.yml -c local

desktop:
	@command -v ansible-playbook || make ansible-install
	@ansible-playbook -i inventory setup/desktop.yml -c local


.PHONY: ansible-install
ansible-install:
	@command -v apt-get && sudo apt-get install ansible -y || true
	@command -v yum && sudo yum install ansible || true
	@command -v brew && brew install ansible || true


.PHONY: epel
epel:
	wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-2.noarch.rpm
	sudo rpm -Uvh epel-release-7*.rpm
