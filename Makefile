# Makefile for home config

BINDIR=$(CURDIR)/bin
UTILSDIR=$(CURDIR)/utils

.PHONY: help
# target: help - Display callable targets
help:
	@egrep "^# target:" [Mm]akefile

.PHONY: install
# target: install - Install my dot files
install: uninstall vim ssh
	@echo
	@echo "Install config files"
	git submodule init && git submodule update
	ln -s $(CURDIR)/configs/bash/.bash_profile $(HOME)/.
	ln -s $(CURDIR)/configs/bash/.bash_aliases $(HOME)/.
	ln -s $(CURDIR)/configs/bash/.bashrc $(HOME)/.
	ln -s $(CURDIR)/configs/.ctags $(HOME)/.
	ln -s $(CURDIR)/configs/.gitconfig $(HOME)/.
	ln -s $(CURDIR)/configs/.hgrc $(HOME)/.
	ln -s $(CURDIR)/configs/.pylintrc $(HOME)/.
	ln -s $(CURDIR)/configs/.screenrc $(HOME)/.
	ln -s $(CURDIR)/configs/.pip $(HOME)/.
	ln -s $(CURDIR)/bin $(HOME)/.

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
	cp -f $(CURDIR)/configs/.ssh/* $(HOME)/.ssh/.

clean_ssh:
	@echo
	@echo " Clean SSH files."
	rm -rf $(HOME)/.ssh/authorized_keys

.PHONY: setup
# target: setup - Setup dev tools
setup: $(UTILSDIR)/setup.sh
	$(UTILSDIR)/setup.sh


.PHONY: uninstall
# target: uninstall - Clean installation
uninstall: clean_vim clean_ssh
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


# vim: fdm=marker:fdl=0
