#
# Functions to help with git, github operations
#

# show commit "stats"
git_stats() {
  git nicelog --merges --since=2014-01-01 | grep -i land | cut -f 2 -d "<" | sort | uniq -c | sort -nr
}
#export -f git_stats

# shorten github urls
git_shorten() {
  curl -s -S -i http://git.io -F "url=$1" | grep Location | cut -d " " -f 2
}
#export -f shorten

# update all given git branches with latest from upstream
# default to master branch if no args given
up() {
  git fetch upstream
  # default to updating the master branch if no branches supplied
  if [ -n "$1" ];then
    branches="$@"
  else
    branches="master"
  fi

  for branch in $branches; do
    git checkout $branch
    stash=$(git stash save)
    git fetch
    git rebase upstream/master
    # if anything got stashed, reapply it?
    [ "$stash" != "No local changes to save" ] && git stash pop
  done
}; #export -f up
