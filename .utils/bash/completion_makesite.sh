# Makesite integration 
path=$(python -c "import makesite, os.path;print os.path.dirname(makesite.__file__)" 2>/dev/null)
[ -f $path/shell.sh ] && source $path/shell.sh
