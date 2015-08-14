#
# I/O functions, those generally involving stdout, stderr, stdin
#

# most of these functions will check the length of var $quiet and will not
# output anything (or less at least) if $quiet is not empty, allows scripts
# to do stuff like if [ "$arg" == "-q" ]; then quiet=1;fi
puts() {
  # echos '[*] ' and arguments with the -e and -n flags (to stdout)
  # only print something if quiet is empty
  [ -z "$quiet" ] && echo -en "[*] $@"
}
#export -f puts

eqo() {
  # echos the arguments with no frills, but only if not quiet
  # only print something if quiet is empty
  [ -z "$quiet" ] && echo "$@"
}
#export -f eqo

warn() {
  # warnings, i.e. non-fatal errors to stdout
  # echos '[-] ' and arguments with the -e and -n flags (to stdout)
  # only print something if quiet is empty or not empty but less than a value?
  # local quiet_threshold
  # [ $quiet -lt $quiet_threshold ] && echo -en "[-] $@"
  [ -z "$quiet" ] && echo -en "[-] $@"
}
#export -f warn

die() {
  # fatal or nearly-fatal errors, if you give a second argument, it is used as an exit code
  # echos '[!] ' and first argument with the -e and -n flags and redirect to stderr
  # if a second argument is given, this function will exit with that argument as the code
  # NOTE:  $quiet does not affect the output
  echo -en "[!] $1" >&2
  if [ $2 ]; then exit $2;fi
}
#export -f die

# allows you to easily debug variables as varname:varvalue or similar
investigate() {
  # if $3 isn't given, don't prefix output with anything
  local output_prefix='' # could be something like [*]
  if [ -n "$3" ]; then output_prefix="$3";fi

  # if $2 isn't given, default separator to something
  local output_sep=": " # could be ", " ": " etc
  if [ -n "$2" ]; then output_sep="$2";fi

  # if $1 is given, then good, if not, well jeez, don't do anything
  local var2investigate=''
  if [ -n "$1" ]; then
   var2investigate="$1"
   echo -n "${output_prefix}${var2investigate}${output_sep}"
   v='echo -n $'
   v="${v}$(echo -n $var2investigate)"
   eval $v
   echo
  fi
}
#export -f investigate
