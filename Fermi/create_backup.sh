# foo="Hello"
# foo="$foo World"
# echo $foo
# > Hello World

DIR_HOME="/home/mario"
DIR_BACKUPS="$DIR_HOME/TransportHub/ConfigBackups/Fermi"

# Locations of all files we want to backup
FILE_CONKY="$DIR_HOME/.conkyrc-awesome"
FILE_AWESOME="$DIR_HOME/.config/awesome"
FILE_ZSH="$DIR_HOME/.zshrc"
FILE_CUSTOM_SHELL="$DIR_HOME/.custom"
FILE_SUBL="$DIR_HOME/.config/sublime-text-3/Packages/User"

# Conkyrc copy, a single file
cp $FILE_CONKY $DIR_BACKUPS && echo -e "Conky file copied" ||echo -e "\033[33;35mError: Conky file not found :s";

#awesomWM files, whole directory
cp -R $FILE_AWESOME $DIR_BACKUPS && echo -e "AwesomeWM files copied" ||echo -e "\033[33;35mError: AwesomeWM files not found :s";

# Zshrc copy, a single file
cp $FILE_ZSH $DIR_BACKUPS && echo -e "Zshrc file copied" ||echo -e "\033[33;35mError: ZSH file not found :s";

#Custom shell personalized files backup
cp -R $FILE_CUSTOM_SHELL $DIR_BACKUPS && echo -e "Custom shell files copied" ||echo -e "\033[33;35mError: Custom shell files not found :s";

# Sublime User files directory (user settings, macros, other configs live there)
cp -R $FILE_SUBL $DIR_BACKUPS && echo -e "Sublime Text files copied" ||echo -e "\033[33;35mError: Sublime Text files not found :s";