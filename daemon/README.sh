#/bin/sh
set -x
####################
# INSTALLATION
# You should only have to do this once
# Pro-tip - just issue the following command to install this:
# README.sh install
#
####################

APP_NAME=runway

# you can issue the following commands (within the {} brackets to install )
# OR - you can just run 'README.sh install'

function install
{
	#Copy the init file into init.d
	sudo cp runway.init "/etc/init.d/$APP_NAME"

	#create the config file
	cat > /tmp/$APP_NAME << EOF
RUNWAY_PATH="$PWD/../"
RUNWAY_SCRIPT="Flasher.py"
EOF
	sudo cp "/tmp/$APP_NAME" "/etc/default/$APP_NAME"

	#make sure it's executable
	sudo chmod +x "/etc/init.d/$APP_NAME"

	#put it in rc so it starts
	sudo update-rc.d "$APP_NAME" defaults
	sudo insserv "$APP_NAME" 

	#endable the daemon (unsure if we need both this and the previous line)
	#sudo update-rc.d "$APP_NAME" enable
}

# you can issue the following commands (within the {} brackets to install )
# OR - you can just run 'README.sh start'
function start
{
	sudo service runway start
}

function disable
{
	sudo update-rc.d runway disable
}

###################
###IGNORE THIS PART if just looking to read the instructions, this is what makes sh do the work for you
###################

#action should be install  
action=$1

if [ ! $action ]; then
    echo "$0 Installs runway startup scripts"
    echo 
    echo "usage: $0 install | start | disable"
    exit 1;
fi

if [ $action == "install" ]; then
	install
elif [ $action == "start" ]; then
	start
elif [ $action == "disable" ]; then
	disable
else 
	echo "I don't understand command $action"
fi