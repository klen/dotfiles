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

.PHONY: apps-reset
# target: apps-reset - Reset app configs and databases (keep media)
apps-reset:
	@test -f "$(HOME)/.local/share/server-apps/docker-compose.yml" || (printf "Compose file not found. Run make apps first.\n" && exit 1)
	@printf "This will DELETE app configs/databases and keep ~/media. Continue? [y/N] " && read ans && ([ "$$ans" = "y" ] || [ "$$ans" = "Y" ] || (printf "Aborted.\n" && exit 1))
	@docker compose -f "$(HOME)/.local/share/server-apps/docker-compose.yml" down
	@rm -rf "$(HOME)/.local/share/caddy" "$(HOME)/.local/share/jellyfin" "$(HOME)/.local/share/nextcloud" "$(HOME)/.local/share/postgres" "$(HOME)/.local/share/redis" "$(HOME)/.local/share/qbittorrent" "$(HOME)/.local/share/prowlarr" "$(HOME)/.local/share/sonarr" "$(HOME)/.local/share/radarr" "$(HOME)/Documents/nextcloud"
	@mkdir -p "$(HOME)/.local/share/caddy/data" "$(HOME)/.local/share/caddy/config" "$(HOME)/.local/share/jellyfin/config" "$(HOME)/.local/share/jellyfin/cache" "$(HOME)/.local/share/nextcloud/html" "$(HOME)/.local/share/postgres/data" "$(HOME)/.local/share/redis/data" "$(HOME)/.local/share/qbittorrent/config" "$(HOME)/.local/share/prowlarr/config" "$(HOME)/.local/share/sonarr/config" "$(HOME)/.local/share/radarr/config" "$(HOME)/Documents/nextcloud"
	@chmod 0770 "$(HOME)/Documents/nextcloud"
	@docker compose -f "$(HOME)/.local/share/server-apps/docker-compose.yml" up -d

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

STOW_CMD = stow -v -t $(HOME)
.PHONY: stow
stow:
	@rm -rf ~/.bashrc
	@$(STOW_CMD) agents
	@$(STOW_CMD) bash
	@$(STOW_CMD) common
	@$(STOW_CMD) ghostty
	@$(STOW_CMD) git
	@$(STOW_CMD) js
	@$(STOW_CMD) nvim
	@$(STOW_CMD) python
	@$(STOW_CMD) tmux
	@$(STOW_CMD) vim
	@$(STOW_CMD) zsh

.PHONY: unstow
unstow:
	@$(STOW_CMD) -D agents
	@$(STOW_CMD) -D bash
	@$(STOW_CMD) -D common
	@$(STOW_CMD) -D ghostty
	@$(STOW_CMD) -D git
	@$(STOW_CMD) -D js
	@$(STOW_CMD) -D nvim
	@$(STOW_CMD) -D python
	@$(STOW_CMD) -D tmux
	@$(STOW_CMD) -D vim
	@$(STOW_CMD) -D zsh

.PHONY: eslint
eslint:
	cd $(HOME) && npm install \
		eslint-plugin-prettier eslint-plugin-unicorn eslint-plugin-import \
		eslint-config-airbnb-base eslint-config-prettier eslint-config-airbnb-typescript
