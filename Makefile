# Makefile for home config

BINDIR=$(CURDIR)/bin
CFGDIR=$(CURDIR)/cfg
LIBDIR=$(CURDIR)/lib

.PHONY: help
# target: help - Display callable targets
help:
	@egrep "^# target:" [Mm]akefile

.PHONY: install
# target: install - Install my dot files
install: vim ssh git bash $(HOME)/.gnupg $(HOME)/.ctags $(HOME)/.hgrc $(HOME)/.pylintrc $(HOME)/.screenrc $(HOME)/.pip
	@git submodule init && git submodule update
	@echo "All configurations has been installed"

.PHONY: ssh
# target: ssh - Install my keys in the system
ssh: $(HOME)/.ssh
	@echo "Install klen.pub to ssh keys"
	cat $(LIBDIR)/klen.pub >> $(HOME)/.ssh/authorized_keys

.PHONY: git
# target: git - Setup git
git: $(HOME)/.gitconfig

.PHONY: vim
# target: vim - Install my vim files
vim: $(HOME)/.vim $(HOME)/.vimrc

.PHONY: bash
# target: bash - Setup bash
bash: $(HOME)/.bashrc $(HOME)/.bash_aliases $(HOME)/.bash_profile $(HOME)/bin $(HOME)/.smartcd

.PHONY: uninstall
# target: uninstall - Clean installation
uninstall: clean_vim clean_ctags clean_gnupg clean_pip clean_gitconfig clean_screenrc clean_pylintrc clean_hgrc clean_bash
	@echo "Clean your HOME directory"

# ---------------------------------------------

$(HOME)/.ctags:
	@echo "Setup ctags configuration"
	ln -s $(CFGDIR)/ctags $(HOME)/.ctags

clean_ctags:
	@echo "Remove ctags configuration"
	rm -f $(HOME)/.ctags

$(HOME)/.gnupg:
	@echo "Setup gnupg configuration"
	cp -r $(CFGDIR)/gnupg $(HOME)
	chmod 700 $(HOME)/.gnupg

clean_gnupg:
	@echo "Remove gnupg configuration"
	rm -rf $(HOME)/.gnupg

$(HOME)/.pip:
	@echo "Setup pip configuration"
	ln -s $(CFGDIR)/pip $(HOME)/.pip

clean_pip:
	@echo "Remove pip configuration"
	rm -rf $(HOME)/.pip

$(HOME)/.ssh:
	@echo "Make .ssh directory"
	mkdir -p $(HOME)/.ssh

$(HOME)/.gitconfig:
	@echo "Setup git configuration"
	ln -s $(CFGDIR)/gitconfig $(HOME)/.gitconfig

clean_gitconfig:
	@echo "Remove git configuration"
	rm -rf $(HOME)/.gitconfig

$(HOME)/.screenrc:
	@echo "Setup screen configuration"
	ln -s $(CFGDIR)/screenrc $(HOME)/.screenrc

.PHONY: clean_screenrc
clean_screenrc:
	@echo "Remove screen configuration"
	rm -rf $(HOME)/.screenrc

$(HOME)/.pylintrc:
	@echo "Setup pylint configuration"
	ln -s $(CFGDIR)/pylintrc $(HOME)/.pylintrc

.PHONY: clean_pylintrc
clean_pylintrc:
	@echo "Remove pylint configuration"
	rm -rf $(HOME)/.pylintrc

$(HOME)/.hgrc:
	@echo "Setup mercurial configuration"
	ln -s $(CFGDIR)/hgrc $(HOME)/.hgrc

.PHONY: clean_hgrc
clean_hgrc:
	@echo "Remove mercurial configuration"
	rm -rf $(HOME)/.hgrc

$(HOME)/.vim:
	@echo " Setup VIM configuration"
	git clone --recursive git://github.com/klen/.vim.git $(HOME)/.vim
	echo 'source $$HOME/.vim/rc.vim' > ~/.vimrc

.PHONY: clean_vim
clean_vim:
	@echo "Remove VIM configuration"
	rm -rf $(HOME)/.vim
	rm -rf $(HOME)/.vimrc

$(HOME)/.bashrc:
	@echo "Setup bash configuration"
	ln -s $(CFGDIR)/bash/bashrc $(HOME)/.bashrc

$(HOME)/.bash_aliases:
	ln -s $(CFGDIR)/bash/bash_aliases $(HOME)/.bash_aliases

$(HOME)/.bash_profile:
	ln -s $(CFGDIR)/bash/bash_profile $(HOME)/.bash_profile

$(HOME)/bin:
	ln -s $(BINDIR) $(HOME)/bin

$(HOME)/.smartcd:
	@echo "Setup smartcd configuration"
	cp -r $(CFGDIR)/smartcd $(HOME)/.smartcd

.PHONY: clean_bash
clean_bash:
	@echo "Remove bash configuration"
	rm -rf $(HOME)/.bashrc
	rm -rf $(HOME)/.bash_aliases
	rm -rf $(HOME)/.bash_profile
	rm -rf $(HOME)/bin
	rm -rf $(HOME)/.smartcd

# vim: fdm=marker:fdl=0
