# .bash_profile if .bashrc is not automatically loaded in login shells
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# added by Anaconda3 5.0.0 installer
export PATH="/Users/tgrue/anaconda3/bin:$PATH"
