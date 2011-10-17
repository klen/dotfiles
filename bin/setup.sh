#!/bin/bash

# Colors
red='\e[0;31m';
cyan='\e[0;36m';
nc='\e[0m';

alert () { echo; echo -e  ${red}${1}${cyan} not found! Attempting to install... $nc; }

print () { echo; echo -e  ${cyan} ${1}${nc}; }

configure_locales () {
    print 'Configure locales.'
    dpkg-reconfigure locales
    sudo locale-gen ru_RU.UTF-8
    sudo locale-gen en_US.UTF-8
}

update_system () {
    print 'Update system.'
    sudo add-apt-repository ppa:richarvey/nodester
    sudo apt-get update -y
    sudo apt-get upgrade -y
}

install_dev_tools () {
    print 'Install dev tools.'
    sudo apt-get install -y build-essential python-dev libxml2-dev git-core exuberant-ctags python-software-properties subversion supervisor postgresql python-psycopg2 vim-nox python-setuptools nodejs
}

install_python_modules () {
    print 'Install python modules.'
    sudo easy_install -U setuptools
    for I in "pip virtualenv zetalibrary makesite ipdb pylint"; do
        (python -c "import $I" 2>/dev/null || {
            alert $I
            sudo easy_install -U $I
        }) && echo -e ${cyan}$I installed.${nc}
    done
}

setup () {
    configure_locales
    update_system
    install_dev_tools
    install_python_modules
}

setup
