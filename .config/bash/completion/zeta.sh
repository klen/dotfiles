# Zeta integration 
path=$(python -c "import zetalibrary, os.path;print os.path.dirname(zetalibrary.__file__)" 2>/dev/null)
[ -f $path/shell.sh ] && source $path/shell.sh
