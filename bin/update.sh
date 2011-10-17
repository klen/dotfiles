# Colors
red='\e[0;31m';
cyan='\e[0;36m';
nc='\e[0m';

print () { echo; echo -e  ${cyan} ${1}${nc}; }

for I in "makesite zetalibrary"; do
    print "Upgrade ${I}"
    sudo pip install --upgrade $I
done

cd ~/.vim && git pull
cd ~/.home && git pull
