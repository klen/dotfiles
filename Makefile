# Makefile for home config

BINDIR=$(CURDIR)/bin
UTILSDIR=$(CURDIR)/utils

.PHONY: help
# target: help - Display callable targets
help:
	@egrep "^# target:" [Mm]akefile

.PHONY: install
# target: install - Install my dot files
install: vim ssh $(HOME)/.gnupg $(HOME)/.bashrc $(HOME)/.bash_aliases $(HOME)/.bash_profile \
    $(HOME)/.ctags $(HOME)/.gitconfig $(HOME)/.hgrc $(HOME)/.pylintrc $(HOME)/.screenrc \
    $(HOME)/.pip $(HOME)/bin $(HOME)/.smartcd
	@echo "Installed"
	@git submodule init && git submodule update

.PHONY: vim
# target: vim - Install my vim files
vim: $(HOME)/.vim $(HOME)/.vimrc

$(HOME)/.vim:
	@echo
	@echo " Install VIM files."
	git clone --recursive git://github.com/klen/.vim.git $(HOME)/.vim
	echo 'source $$HOME/.vim/rc.vim' > ~/.vimrc


.PHONY: clean_vim
clean_vim:
	@echo
	@echo " Clean VIM files."
	rm -rf $(HOME)/.vim
	rm -rf $(HOME)/.vimrc

.PHONY: ssh
# target: ssh - Append my authorized_keys
ssh: $(HOME)/.ssh $(HOME)/.ssh/authorized_keys

$(HOME)/.ssh:
	@echo
	@echo " Install SSH files."
	mkdir -p $(HOME)/.ssh

$(HOME)/.ssh/authorized_keys:
	cat $(CURDIR)/configs/.ssh/authorized_keys >> $(HOME)/.ssh/authorized_keys

$(HOME)/.gnupg:
	cp -r $(CURDIR)/configs/.gnupg $(HOME)
	chmod 700 $(HOME)/.gnupg

$(HOME)/.bashrc:
	ln -s $(CURDIR)/configs/bash/.bashrc $(HOME)/.

$(HOME)/.bash_aliases:
	ln -s $(CURDIR)/configs/bash/.bash_aliases $(HOME)/.

$(HOME)/.bash_profile:
	ln -s $(CURDIR)/configs/bash/.bash_profile $(HOME)/.

$(HOME)/.ctags:
	ln -s $(CURDIR)/configs/.ctags $(HOME)/.

$(HOME)/.gitconfig:
	ln -s $(CURDIR)/configs/.gitconfig $(HOME)/.

$(HOME)/.hgrc:
	ln -s $(CURDIR)/configs/.hgrc $(HOME)/.

$(HOME)/.pylintrc:
	ln -s $(CURDIR)/configs/.pylintrc $(HOME)/.

$(HOME)/.screenrc:
	ln -s $(CURDIR)/configs/.screenrc $(HOME)/.

$(HOME)/.pip:
	ln -s $(CURDIR)/configs/.pip $(HOME)/.

$(HOME)/.smartcd:
	cp -r $(CURDIR)/configs/.smartcd $(HOME)/.

$(HOME)/bin:
	ln -s $(CURDIR)/bin $(HOME)/.

.PHONY: setup
# target: setup - Setup dev tools
setup: $(UTILSDIR)/setup.sh
	$(UTILSDIR)/setup.sh


.PHONY: uninstall
# target: uninstall - Clean installation
uninstall: clean_vim
	@echo
	@echo "Clean your HOME directory"
	rm -rf $(HOME)/.bash_aliases
	rm -rf $(HOME)/.bash_profile
	rm -rf $(HOME)/.bashrc
	rm -rf $(HOME)/.ctags
	rm -rf $(HOME)/.gitconfig
	rm -rf $(HOME)/.hgrc
	rm -rf $(HOME)/.screenrc
	rm -rf $(HOME)/bin
	rm -rf $(HOME)/.pip
	rm -rf $(HOME)/.pylintrc
	rm -rf $(HOME)/.smartcd


# vim: fdm=marker:fdl=0
