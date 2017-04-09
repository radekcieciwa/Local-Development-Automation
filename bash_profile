# symbolic link to Sublime Text
# ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/sublime
# ln -s  /Applications/SourceTree.app/Contents/MacOS/SourceTree /usr/local/bin/sourcetree
alias addkey="cd /Users/radoslawcieciwa/; ssh-add"
alias boo="cd /Users/radoslawcieciwa/Development/iOS/Badoo"
alias rap="cd /Users/radoslawcieciwa/Development/iOS/ReceptionApp/ReceptionApp"
alias bh="cat /Users/radoslawcieciwa/.bash_profile | grep -e '()' -e 'alias'"
alias correct="swiftlint autocorrect"

qrun() {
	if [ $# -eq 0 ]; then
		open Badoo.xcworkspace
	fi
	if [ $# -eq 1 ]; then
		boo
		cd $1
		open Badoo.xcworkspace
	fi
}

# _waiter() {
# 	if [ $# -eq 1 ]; then
# 		for i in {0..$1}
# 		do
# 			echo "Countdown $(($1 - $i)) sec"
# 			sleep 1
# 		done
# 		return 0
# 	fi 
# 	echo "_waiter(): Arguments number error."
# 	return 1
# }

qclean() {
	if [ $# -eq 1 ]; then
		rm -f -r $1
	fi
}

qboot() {
	if [ $# -lt 1 ]; then
		echo "Wrong usage try $0 <ticket> <codename>"
		return 1
	fi

	if [ $# -eq 1 ]; then
		ticket=$1
		working_directory=$1
		echo "Bot:Warning: Settings $1 as a codename"
	fi	

	if [ $# -gt 1 ]; then
		ticket=$1
		working_directory=$2
	fi

	boo
	cd Source 
	git submodule update
	qdev
	git submodule update
	cd ..
	rsync --progress -avzh Source/. $working_directory
	cd $working_directory
	echo "Bot:Info: Copy success"
	./scripts/shared_scripts/bootstrap/gitSetup.py
	./scripts/shared_scripts/code_style/install_pre_commit_hook.py
	echo "Bot:Info: Git hooks install success"
	./aida -ei $ticket
	echo "Bot:Info: Aida ticket boot success"
	qprint	
	pwd
	eval "osascript -e 'display notification \"Created branch for ticket $ticket in $working_directory\" with title \"BDEV: Success\" subtitle \"Created branch for ticket $ticket\"'"
}

qgrep() {
	git checkout `eval git branch | grep $1`
	qprint
}

qdev() {
	qgrep dev
	echo "=== UPDATING ==="
	git pull
	qprint
}

qprint() {
	echo "=== CURRENT ===="	
	git branch
}
