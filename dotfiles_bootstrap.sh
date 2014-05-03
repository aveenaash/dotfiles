##########################################################################
######## https://github.com/gf3/dotfiles/blob/master/bootstrap.sh ########
##########################################################################


##BACKUP
backup="$HOME/dotfiles_backup"
backupDotfiles(){
 mkdir "$backup"
 mv ~/.vim "$backup"
 mv ~/.vimrc "$backup"
 mv ~/.bashrc "$backup"
 mv ~/.gitconfig "$backup"
 mv ~/.bash_profile "$backup"
 mv ~/.emacs.d "$backup"
}

installDotfiles(){
 cp -r .vim ~/
 cp .vimrc ~/
 cp .bash_profile ~/
 cp .bashrc ~/
 cp .gitconfig ~/
 cp .tmux.conf ~/
 cp .bash_aliases ~/

 cp -r .emacs.d ~/

 cp -r .lein ~/

 git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle && git clone https://github.com/altercation/vim-colors-solarized ~/.vim/bundle/vim-colors-solarized

 git clone https://github.com/sellout/emacs-color-theme-solarized.git ~/.emacs.d/emacs-color-theme-solarized
}

configureGitDiff(){
 #sudo touch /usr/local/bin/git_diff_wrapper
 sudo tee -a /usr/local/bin/git_diff_wrapper  >/dev/null << 'EOF'
				#!/bin/sh
				vimdiff "$2" "$5"
EOF
 sudo chmod 777 /usr/local/bin/git_diff_wrapper
}

askForGitconfigUser(){

   echo -n "git username (eg. iPrayag): "
   read username

   echo -n "git email (eg. prayag.upd@gmail.com) : "
   read email

cat >> ~/.gitconfig <<EOF 
   [user]
	name  = $username
	email = $email
EOF
}

installVundleDeps(){
  vim +BundleInstall +qall
}

init(){
 backupDotfiles
 installDotfiles
 askForGitconfigUser
 configureGitDiff
 installVundleDeps
 gconftool --type string --set /desktop/gnome/background/primary_color "#002b36"
 sudo apt-get install emacs24 emacs24-el emacs24-common-non-dfsg
 echo "####################################################"
 echo "###### [info] : dotfiles installed \,,/ ############"
 echo "####################################################"
}

update(){
  cp .vimrc ~/
  cp .bash_aliases ~/

  echo "#########################################################"
  echo "################## UPDATED ##############################"
  echo "#########################################################"
}

##main
start(){
echo -n "######################################################## "
echo
echo -n "#################### select options #################### "
echo
echo -n "######################################################## "
echo
echo -n "INSTALLATION  - i "
echo
echo -n "UPDATE        - u "
echo
read option

if [ 'i' == $option ] 
then
	init
elif [ 'u' == $option ] 
then
        update
else
	echo "WTF"
fi
}

start
