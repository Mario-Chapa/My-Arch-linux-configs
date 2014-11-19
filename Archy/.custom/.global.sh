#  custom stuff
# n1 -eq n2   True if the integers n1 and n2 are algebraically equal.
# n1 -ne n2   True if the integers n1 and n2 are not algebraically equal.
# n1 -gt n2   True if the integer n1 is algebraically greater than the integer n2.
# n1 -ge n2   True if the integer n1 is algebraically greater than or equal to the integer n2.
# n1 -lt n2   True if the integer n1 is algebraically less than the integer n2.
# n1 -le n2   True if the integer n1 is algebraically less than or equal to the integer n2.
# s1          True if s1 is not the null string.
# s1 = s2     True if strings s1 and s2 are identical.
# s1 != s2    True if strings s1 and s2 are not identical.

#  "File Name: $0"
#  "First Parameter : $1"
#  "Second Parameter : $2"
#  "Quoted Values: $@"
#  "Quoted Values: $*"
#  "Total Number of Parameters : $#"

# for TOKEN in $*
# do
#    echo $TOKEN
# done

# ~% FILE="example.tar.gz"
# ~% echo "${FILE%%.*}"
# example
# ~% echo "${FILE%.*}"
# example.tar
# ~% echo "${FILE#*.}"
# tar.gz
# ~% echo "${FILE##*.}"
# gz

# Executing a command from within a shell script
# 1) Functions are suitable for such tasks:
# func (){
# ls -l
# }
# Invoke it by saying func
# 2) Also another suitable solution could be eval:
# var="ls -l"
# eval $var
# 3) The third one is using variables directly:
# var=$(ls -l)
# OR
# var=`ls -l`

cd #Fix zsh remembering last directory
export EDITOR=vim
######### Misc. aliases #################

alias ls='ls -X1sh --sort=extension --group-directories-first --color'
alias lsa='ls -X1shA --sort=extension --group-directories-first --color'
alias pacup='sudo pacmatic -Syu'
alias nano='nano -xcS'
alias cd..='cd ..'
alias rm='rm -iv'
alias pacinstall='pacup && sudo pacmatic -S'
alias grep='grep --color=auto'
alias tree='tree -hFC -L 1'
alias R='R --quiet'
alias less='less -N --prompt=">>>"'
alias ffplay='ffplay -loglevel quiet'
alias mp='mplayer -msgcolor'
alias dir='dir --color --group-directories-first'
alias st='subl3'
alias unison='unison -auto'
# CDPATH hack
export CDPATH=.:~

# export PATH=$PATH:.
##############ZSH aliases ##############
alias -g gp='| grep -i'
alias -g lez='| less'

# blank the screen to save energy
# alias afk='xset dpms force off'

#mplayer playlisting
# alias play-a-list='mplayer -playlist'

cdl() {
	cd "$*" && dir --color --group-directories-first
}
compdef cdl=cd
compdef pacmatic=pacman

md () {
	if [[ $# -lt 2 ]]; then
		mkdir -p "$1" && cd "$1";
	else
		echo $fg_bold[blue] "\t-Only one directory name please";
		return 128
	fi
}
# Rename file, it preserves the file ext, so you do not need to type it
ren () {
	if [[ $# -eq 2 ]]; then
		if [[ -f $1  ]]; then
			mv $1 $2."${1#*.}"
		else
			echo $fg_bold[red]"Error:\t"$fg_bold[blue]"File does not exist :s";
			return 128
		fi

	else
		echo $fg_bold[red]"Error:\t"$fg_bold[blue]"I need file name and new name please";
		return 128
	fi
}
# Package libreoffice does not fork to background
office () {
	if [[ -f $1 ]]; then
		libreoffice $1 &> ~/.log_office&
	else
		echo $fg_bold[red]"Error:\t"$fg_bold[blue]"File does not exist :s";
		return 128
	fi
}
# comment
vp () {
	if [[ -f $1 ]]; then
		mupdf $1 &> ~/.log_mupdf&
	else
		echo $fg_bold[red]"Error:\t"$fg_bold[blue]"File does not exist :s";
		return 128
	fi
}
