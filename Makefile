# Makefile for home config
all: update ansible stow

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
	@ansible-playbook -i inventory setup/playbook.yml -c local -k

.PHONY: server
# target: server - Setup macOS server profile
server:
	@command -v ansible-playbook || make ansible-install
	@ansible-playbook -i inventory setup/server.mac.yml -c local -K

.PHONY: apps
# target: apps - Run media and cloud apps stack
apps:
	@command -v ansible-playbook || make ansible-install
	@ansible-playbook -i inventory setup/server.apps.yml -c local

.PHONY: nextcloud-reset
# target: nextcloud-reset - Reset Nextcloud data and database
nextcloud-reset:
	@test -f "$(HOME)/.local/share/server-apps/docker-compose.yml" || (printf "Compose file not found. Run make apps first.\n" && exit 1)
	@printf "This will DELETE Nextcloud data and DB. Continue? [y/N] " && read ans && ([ "$$ans" = "y" ] || [ "$$ans" = "Y" ] || (printf "Aborted.\n" && exit 1))
	@docker compose -f "$(HOME)/.local/share/server-apps/docker-compose.yml" stop nextcloud postgres redis
	@docker compose -f "$(HOME)/.local/share/server-apps/docker-compose.yml" rm -f nextcloud postgres redis
	@rm -rf "$(HOME)/.local/share/nextcloud/html" "$(HOME)/Documents/nextcloud" "$(HOME)/.local/share/postgres/data" "$(HOME)/.local/share/redis/data"
	@mkdir -p "$(HOME)/Documents/nextcloud" "$(HOME)/.local/share/nextcloud/html" "$(HOME)/.local/share/postgres/data" "$(HOME)/.local/share/redis/data"
	@chmod 0770 "$(HOME)/Documents/nextcloud"
	@docker compose -f "$(HOME)/.local/share/server-apps/docker-compose.yml" up -d postgres redis nextcloud

desktop:
	@command -v ansible-playbook || make ansible-install
	@ansible-playbook -i inventory setup/desktop.yml -c local

.PHONY: ansible-install
ansible-install:
	@command -v apt-get && sudo apt-get install ansible -y --force-yes || true
	@command -v yum && sudo yum install ansible || true
	@command -v brew && brew install ansible || true

.PHONY: epel
epel:
	wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-2.noarch.rpm
	sudo rpm -Uvh epel-release-7*.rpm

.PHONY: stow
stow:
	@rm -rf ~/.bashrc
	@stow -v -t $(HOME) .

.PHONY: unstow
unstow:
	@stow -v -D -t $(HOME) .

.PHONY: eslint
eslint:
	cd $(HOME) && npm install \
		eslint-plugin-prettier eslint-plugin-unicorn eslint-plugin-import \
		eslint-config-airbnb-base eslint-config-prettier eslint-config-airbnb-typescript
