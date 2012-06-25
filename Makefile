# Makefile for home config

BINDIR=$(CURDIR)/bin
UTILSDIR=$(CURDIR)/utils

all: help


# Show help  {{{
# ---------

.PHONY: help
help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  install      to install config files"
	@echo "  setup        setup developer utilites"
	@echo "  clean        to clean config files"

#  }}}


# Install config  {{{
# --------------

.PHONY: install
install: clean vim ssh
	@echo
	@echo "Install config files"
	ln -s $(CURDIR)/.bash_profile $(HOME)/.
	ln -s $(CURDIR)/.bash_aliases $(HOME)/.
	ln -s $(CURDIR)/.bashrc $(HOME)/.
	ln -s $(CURDIR)/.ctags $(HOME)/.
	ln -s $(CURDIR)/.gitconfig $(HOME)/.
	ln -s $(CURDIR)/.hgrc $(HOME)/.
	ln -s $(CURDIR)/.pylintrc $(HOME)/.
	ln -s $(CURDIR)/.screenrc $(HOME)/.
	ln -s $(CURDIR)/bin $(HOME)/.
	ln -s $(CURDIR)/.pip $(HOME)/.

#  }}}


# Install VIM  {{{
# -----------

.PHONY: vim
vim: $(HOME)/.vim $(HOME)/.vimrc

$(HOME)/.vim:
	@echo
	@echo " Install VIM files."
	git clone --recursive git://github.com/klen/.vim.git $(HOME)/.vim
	echo 'source $HOME/.vim/rc.vim' > ~/.vimrc


clean_vim:
	@echo
	@echo " Clean VIM files."
	rm -rf $(HOME)/.vim
	rm -rf $(HOME)/.vimrc

#  }}}


# Setup SSH  {{{
# ---------

.PHONY: ssh
ssh: $(HOME)/.ssh $(HOME)/.ssh/authorized_keys

$(HOME)/.ssh:
	@echo
	@echo " Install SSH files."
	mkdir -p $(HOME)/.ssh

$(HOME)/.ssh/authorized_keys:
	cp -f $(CURDIR)/.ssh/* $(HOME)/.ssh/.

clean_ssh:
	@echo
	@echo " Clean SSH files."
	rm -rf $(HOME)/.ssh/authorized_keys

#  }}}


# Setup dev tools
# ---------------
setup: $(UTILSDIR)/setup.sh
	$(UTILSDIR)/setup.sh


clean: clean_vim clean_ssh
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
