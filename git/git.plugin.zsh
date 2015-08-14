git-obliterate() {
  if (( $# == 0 ));then
    echo "usage: git-obliterate file1 [file2...]"
  fi
  files=$@
  for file in $files; do
    git filter-branch -f --index-filter "git rm -r --cached $file --ignore-unmatch" \
      --prune-empty --tag-name-filter cat -- --all
    #git ignore $file
    echo "$file" >> .gitignore
    git add .gitignore
    git commit -m "Add $file to .gitignore"
  done
  echo "You're new .gitignore is:"
  cat .gitignore
  echo
  echo "Now, if you really mean it, do a: git push --force"
}
