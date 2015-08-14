
transfer() {
  local curl_cmd=""
  local res=""
  local urls=""
  local bases=""
  local site="https://transfer.sh/"
  case $# in
  0)  >&2 echo "Usage: ${FUNCNAME[0]} file [file...]"; exit 1
      ;;
  1)  curl_cmd="curl --upload-file $1 ${site}$(basename $1)"
      ;;
  *)  curl_cmd="curl -i"
      for f in $@; do curl_cmd="${curl_cmd} -F filedata=@${f}"; done
      curl_cmd="${curl_cmd} ${site}"
      ;;
  esac
  res=$(echo $($curl_cmd) | grep -i $site)
  echo
  echo "res--${res}--res"
  echo "Download url(s):"
  echo $res
  echo "Combinined/compressed downloads:"
  for url in $res; do
    if echo $url | grep -q $site; then bases="${bases},${url##$site}";fi
  done
  #bases="${bases##,\,}" # remove leading comma
  bases=$(echo $bases | cut -c 2-)
  for ext in .tar.gz .tar .zip; do
    echo "curl ${site}($bases)${ext}"
  done
}
#export -f transfer

# Analysis
# scan using clamav
# curl -X PUT --upload-file $file https://transfer.sh/eicar.com/scan
# Upload malware to VirusTotal, get a permalink in return
# curl -X PUT --upload-file $file https://transfer.sh/test.txt/virustotal

# Encrypt & upload
#cat $clear_text_file | gpg -ac -o-|curl -X PUT --upload-file "-" https://transfer.sh/test.txt

# Decrypt & download
#curl $url | gpg -o- > $clear_text_file
