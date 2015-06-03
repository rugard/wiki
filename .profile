# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
# To use rvm in home
#source $HOME/.rvm/scripts/rvm



# commented out by netc for using bundle from system
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


alias ll="ls -lah"

# For use chef ruby
#export PATH=$PATH:/opt/chefdk/embedded/bin

# Because of: http://askubuntu.com/questions/55022/changing-default-crontab-editor
export EDITOR=vim


export PATH="/opt/chefdk/embedded/bin:${HOME}/.chefdk/gem/ruby/2.1.0/bin:$PATH"

