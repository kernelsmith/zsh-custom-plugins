#
# Utility functions that are likely to be needed/used
#
# NOTE:  add the function to extras.rc if it's rarely used

debug "utils.rc"

# mkdir if the dir doesn't already exist
chk_mkdir() {
  # make a directory (with -p) if it doesn't exist
  if [ ! -d "$1" ]; then
    # make the directory, or fail out, use 'die' if available
    mkdir -p $1 || type -t die && die "Can't create directory...aborting" $_ERR_CANT_WRITE_DIR
  fi
}
export -f chk_mkdir

# get a nicely formatted, 'ls'-sortable timestamp
# does not automatically add a \n at the end
stampit() {
  echo -n "$@.$(date +%Y%m%d-%H%M%S)"
}
export -f stampit

# easily change the terminal title
ttitle() {
  echo -e '\033k'$@'\033\'
}
export -f ttitle

rgrep() {
  if [ -n "${2}" ]; then
    find -L . -type f -name \*.*rb -exec grep -n -C $2 -i -H --color "$1" {} \;
  else
    find -L . -type f -name \*.*rb -exec grep -n -i -H --color "$1" {} \;
  fi
}
export -f rgrep

# find large files.  $1 is min size in megs to show 
find_large() {
  find ~/ -size +${1}M -ls
}