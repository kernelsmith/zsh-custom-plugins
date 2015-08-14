### This README.md is executable

#### Simply edit git_user* vars to match your github user & repo, or
#### leave as is if you want to just use my custom plugins.
#### If you want to use ssh instead of https, change
#### git_transport as indicated
#### then run:
#### \curl -sSL https://github.com/kernelsmith/zsh-custom-plugins/blob/master/README.md | sh
#### or, download the README.md and just run it with ./README.md

#----------------------------------

##### git transport should be either "https://github.com/" or "git@github.com:"
##### note the trailing / and : on those
##### git_user should be your git user name"
##### git_user_plugins_repo should be the name of your plugs repo if different
##### git_ohmyzsh_user should be "robbyrussell" 99.99% of the time
##### git_ohmyzsh_repo should be "oh-my-zsh" 99.99% of the time

```
git_transport="https://github.com/"
git_user="kernelsmith"
git_user_plugins_repo="zsh-custom-plugins"
git_ohmyzsh_user="robbyrussell"
git_ohmyzsh_repo="oh-my-zsh"
git clone ${git_transport}${git_ohmyzsh_user}/${git_ohmyzsh_repo}.git
cd ${git_ohmyzsh_repo}/custom
rm -rf plugins
git clone ${git_transport}${git_user}/${git_user_plugins_repo}.git plugins
```
