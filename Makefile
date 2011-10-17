# Makefile for home config

all: help

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  install      to install config files"
	@echo "  clean        to clean config files"


install: clean
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
	ln -s $(CURDIR)/.vimrc $(HOME)/.
	ln -s $(CURDIR)/bin $(HOME)/.
	ln -s $(CURDIR)/.pip $(HOME)/.
	mkdir -p $(HOME)/.ssh
	cp -f $(CURDIR)/.ssh/* $(HOME)/.ssh/.
	git clone git://github.com/klen/.vim.git $(HOME)/.vim
	cd $(HOME)/.vim && git submodule init && git submodule update

setup:
	$(CURDIR)/bin/setup.sh

clean:
	@echo
	@echo "Clean your HOME directory"
	rm -rf $(HOME)/.bash_aliases
	rm -rf $(HOME)/.bash_profile
	rm -rf $(HOME)/.bashrc
	rm -rf $(HOME)/.ctags
	rm -rf $(HOME)/.gitconfig
	rm -rf $(HOME)/.hgrc
	rm -rf $(HOME)/.screenrc
	rm -rf $(HOME)/.vimrc
	rm -rf $(HOME)/bin
	rm -rf $(HOME)/.pip
	rm -rf $(HOME)/.pylintrc
	rm -rf $(HOME)/.vim
