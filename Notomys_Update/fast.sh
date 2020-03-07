#!/usr/bin/env bash
#########################################################################
#									#
# 	This script was made by Stefan Fechet and Taran Elena-Georgiana #
# for CNSB Middle East Real Estate L.L.C. in August 2018. Do not copy   #
# this program or parts of it!	All the rights reserved!		#
#									#
#########################################################################
option=0
work=$PWD
checker=1
while [ $checker == 1 ]; do
        unset selection
	unset inputStr
	unset inputstr
	option=0
	selectionn=$(zenity  --list --width=350 --height=270 --text "NOTOMYS MENU" --radiolist  --column "SELECT" --column "OPTION" TRUE "Use NOTOMYS" FALSE "Recover NOTOMYS password" FALSE "Change NOTOMYS password" FALSE "Recover building password" FALSE "How to use NOTOMYS?" FALSE "Quit" 2> /dev/null);
	case "$selectionn" in
	"Use NOTOMYS")option=1;;
	"Recover NOTOMYS password")option=2;;
	"Change NOTOMYS password")option=3;;
	"Recover building password")option=4;;
	"How to use NOTOMYS?") option=5;;
	"Quit")option=6;;
	esac
	if [ $option == 5 ]; then
		evince /home/$USER/Desktop/CNSB/BUILDINGS/a/"How to use Notomys.pdf"
		option=0
	fi
	if [ $option == 2 ]; then
		sudo chattr -a /usr/bin/dndelete.txt
		option=0
		meil=$(sudo cat /usr/bin/dndelete.txt)
		wget -q --tries=10 --timeout=20 --spider http://google.com
		if [[ $? -eq 0 ]]; then
			echo "NOTOMYS password is '$meil'. Have a nice day!" | s-nail -s "PASSWORD" -A billing billing@cnsb.global
			zenity --info --width=230 --height=100 --text "Check the mail!" 2> /dev/null	
		else
			ok=1
			while [ $ok == 1 ]
				do 
					zenity --question --width=230 --height=100 --timeout 5 --text "No internet connection! Try again?" 2>/dev/null; mac=$?
					if [ $mac == 5 ] || [ $mac == 0 ]; then
						sleep 30
						wget -q --tries=10 --timeout=20 --spider http://google.com
						if [[ $? -eq 0 ]]; then
							ok=0
							echo "NOTOMYS password is '$meil'. Have a nice day!" | s-nail -s "PASSWORD" -A billing billing@cnsb.global	
							zenity --info --width=230 --height=100 --text "Check the mail!" 2> /dev/null
						fi
					else
						ok=0
						zenity --warning --width=230 --height=100 --text "Program canceled!" 2>/dev/null
					fi
					
				done
		fi	
		sudo chattr +a /usr/bin/dndelete.txt
	fi
	if [ $option == 4 ]; then
		you=1
		while [ $you == 1 ]; do
			inp=""
			inputS=""
			inp=$(zenity --entry  --title="BUILDING SEARCH" --text="Building Name:" 2>/dev/null)
			inputS=$(echo $inp | tr ' ' '_')
			if [[ "$inputS" == "" ]]; then
				zenity --warning --width=230 --height=100 --text "Canceled or no name was typed!" 2>/dev/null
				you=0				
			fi
			if [ -d "/home/$USER/Desktop/CNSB/BUILDINGS/$inputS" ] && [[ "$inputS" != "" ]]; then
				if [[ "$inputS" != "a" ]]; then
					you=0
					mailpass=$(cat /home/$USER/Desktop/CNSB/.$inputS\_mail)
	                                passW=$(cat /home/$USER/Desktop/CNSB/.$inputS)				
					wget -q --tries=10 --timeout=20 --spider http://google.com
					if [[ $? -eq 0 ]]; then
						echo "The password for '$inputS' building is '$passW'. Have a nice day!" | s-nail -s "PASSWORD" -A billing $mailpass
						zenity --info --width=230 --height=100 --text "Check the email for building password recovery!" 2>/dev/null
					else
						ok=1
						while [ $ok == 1 ]
							do 
								zenity --question --width=230 --height=100 --timeout 5 --text "No internet connection! Try again?" 2>/dev/null; mac=$?
								if [ $mac == 5 ] || [ $mac == 0 ]; then
									sleep 30
									wget -q --tries=10 --timeout=20 --spider http://google.com
	                						if [[ $? -eq 0 ]]; then
										ok=0
										echo "The password for '$inputS' building is '$passW'. Have a nice day!" | s-nail -s "PASSWORD" -A billing $mailpass
										zenity --info --width=230 --height=100 --text "Check the email for building password recovery!" 2>/dev/null
									fi
								else
									ok=0
									zenity --warning --width=230 --height=100 --text "Program canceled!" 2>/dev/null
								fi
							done
					fi
				else
					zenity --warning --width=230 --height=100 --text "Access denied!" 2>/dev/null
				fi				
			else
				if [[ "$inputS" != "" ]]; then
					zenity --question --width=230 --height=100 --text "There is no building with name $inputS! Do you want to search again?" 2>/dev/null; plia=$? 
                                	if [ $plia == 1 ]; then
                                        	zenity --warning --width=230 --height=100 --text "Program canceled!" 2>/dev/null
                                        	you=0
                                	fi
                        	fi
			fi
		done
	fi
	if [ $option == 3 ]; then
		sudo chattr -a /usr/bin/dndelete.txt
                while IFS='' read -r line || [[ -n "$line" ]]; do
                        PAS=$line
                done < "/usr/bin/dndelete.txt"
                sudo chattr +a /usr/bin/dndelete.txt
                ghj=1
                while [ $ghj == 1 ]; do
                        PASS1=""
                        PASS1=$(zenity --password 2> /dev/null; mlk=$?)
                        if [[ "$PASS1" != "$PAS" ]]; then
                                zenity --question --width=230 --height=100 --text "Incorrect password! Try again?" 2>/dev/null; pli=$?
                                if [ $pli == 1 ]; then
                                        zenity --warning --width=230 --height=100 --text "Program canceled!" 2>/dev/null
                                        ghj=0
                                fi
                        fi
                        if [[ "$PASS1" == "$PAS" ]]; then
                                checking=1
                                zenity --info --width=230 --height=100 --timeout 4 --text "Passwords match!" 2> /dev/null
				zenity --warning --width=230 --height=100 --text "Choose a new pasword for NOTOMYS!" 2> /dev/null
				PASS1=""
				PASS2=""
				while [ "$PASS1" == "" ]; do
					PASS1=$(zenity --password 2> /dev/null)
					if [[ "$PASS1" == "" ]]; then
						zenity --warning --width=230 --height=100 --text "No password typed!" 2> /dev/null
					fi
				done
				zenity --info --width=230 --height=100 --text "Retype password" 2> /dev/null
				while [ "$PASS1" != "$PASS2" ]; do
				PASS2=$(zenity --password 2> /dev/null)
				if [[ "$PASS2" == "" ]]; then
					zenity --warning --width=230 --height=100 --text "No password typed!" 2> /dev/null
				fi
				if [[ "$PASS1" != "$PASS2" ]]; then

					zenity --warning --width=230 --height=100 --text "Passwords are not the same! Try again!" 2> /dev/null
				fi
				done
				if [[ "$PASS1" == "$PASS2" ]]; then
					zenity --info --width=230 --height=100 --text "You set a new password!" 2> /dev/null
					sudo chattr -a /usr/bin/dndelete.txt
					sudo rm /usr/bin/dndelete.txt
					ghj=0
				fi
				sudo echo $PASS1 > dndelete.txt
				sudo mv dndelete.txt /usr/bin/dndelete.txt				
				sudo chattr +a /usr/bin/dndelete.txt			
                        fi
                done
	fi
	if [ $option == 6 ]; then
		checker=0	
	fi
	asdfi=0
	if [ $option == 1 ]; then
		sudo chattr -a /usr/bin/dndelete.txt
		while IFS='' read -r line || [[ -n "$line" ]]; do
			PAS=$line
		done < "/usr/bin/dndelete.txt"
		asdf=1
		while [ $asdf == 1 ]; do
			PASS1=""
			PASS1=$(zenity --password 2> /dev/null; mlk=$?)
			if [[ "$PASS1" != "$PAS" ]]; then
				zenity --question  --text "Incorrect password! Try again?" 2>/dev/null; pli=$?
				if [ $pli == 1 ]; then
					zenity --warning --width=230 --height=100 --text "Program canceled!" 2>/dev/null
					asdf=0
				fi
			fi
			if [[ "$PASS1" == "$PAS" ]]; then
			       	asdf=0
				asdfi=1
				zenity --info --width=230 --height=100 --timeout 4 --text "Passwords match!" 2> /dev/null
				zenity --info --width=230 --height=100 --text "WELCOME TO NOTOMYS!" 2> /dev/null
			fi
		done
		sudo chattr +a /usr/bin/dndelete.txt
	fi
	HELP=0
	if [ $option == 1 ] && [ $asdfi == 1 ]; then
		zenity --question --width=230 --height=100 --text "Create a new building?" 2>/dev/null; pli=$?
               	if [ $pli == 0 ]; then
			mkdir -p /home/$USER/Desktop/CNSB
			cd /home/$USER/Desktop/CNSB
			mkdir -p /home/$USER/Desktop/CNSB/BUILDINGS
			cd /home/$USER/Desktop/CNSB/BUILDINGS
			mkdir -p a
			semafor=1
			semn=1
			while [ $semafor == 1 ]; do
				inputstr=""
				inputStr=""
				inputstr=$(zenity --entry  --title="ADD NEW BUILDING" --text="Building Name:" 2>/dev/null)
				inputStr=$(echo $inputstr | tr ' ' '_')
				if [[ "$inputStr" == "" ]]; then
					semafor=0
					semn=0
				fi
				if [ -d "/home/$USER/Desktop/CNSB/BUILDINGS/$inputStr" ] && [ $semn == 1 ]; then
					zenity --warning --width=230 --height=100 --text "A building with name $inputStr already exists or no text entered! Retry" 2>/dev/null
				else
					semafor=0
				fi
			done
			if [[ "$inputStr" != "" ]]; then
				mkdir $inputStr
				cd ../
				mkdir -p $inputStr
				cd /home/$USER/Desktop/CNSB/BUILDINGS
				HELP=1
			fi
		fi
		cd /home/$USER/Desktop/CNSB/BUILDINGS
		#ls > /home/$USER/Desktop/temp.txt
		for fullfile in /home/$USER/Desktop/CNSB/BUILDINGS/*; do 
			echo $(basename "$fullfile" | cut -d. -f1) >> /home/$USER/Desktop/temp.txt
		done
		a=""
		e=" "
		q=1
		b="aaaa"
		j=0
		while IFS='' read -r line || [[ -n "$line" ]]; do
			if [[ "$b" == "aaaa" ]]; then
				((j++))
				b="m"
				m=$line$e$line
				m=${m::-1}
			else
				a=$a$line$e$line$e
				((j++))
			fi
		done < "/home/$USER/Desktop/temp.txt"
		#selection=$(zenity --list --column="Building"  $a  2> /dev/null);
		if [[ "$inputStr" != "" ]] && [ $HELP == 1 ]; then
			HELP=0		
			zenity --warning --width=230 --height=100 --text "Choose a pasword for $inputStr!" 2> /dev/null
			PASS1=""
			PASS2=""
			while [ "$PASS1" == "" ]; do
				PASS1=$(zenity --password 2> /dev/null)
				if [[ "$PASS1" == "" ]]; then
					zenity --warning --width=230 --height=100 --text "No password typed!" 2> /dev/null
				fi
			done
			zenity --info --width=230 --height=100 --text "Retype password" 2> /dev/null
			while [ "$PASS1" != "$PASS2" ]; do
				PASS2=$(zenity --password 2> /dev/null)
				if [[ "$PASS2" == "" ]]; then
					zenity --warning --width=230 --height=100 --text "No password typed!" 2> /dev/null
				fi
				if [[ "$PASS1" != "$PASS2" ]]; then

					zenity --warning --width=230 --height=100 --text "Passwords are not the same! Try again!" 2> /dev/null
				fi
			done
			if [[ "$PASS1" == "$PASS2" ]]; then
				zenity --info --width=230 --height=100 --text "You set a new password for $inputStr!" 2> /dev/null
				mayl=""
				while [ "$mayl" == "" ]; do
					mayl=$(zenity --entry --title "Mail address" --text="Type the mail address from which you will send mails and recover password" 2>/dev/null)
				done
				echo $mayl > /home/$USER/Desktop/CNSB/.$inputStr\_mail
				sudo chattr +a /home/$USER/Desktop/CNSB/.$inputStr\_mail
				touch /home/$USER/Desktop/CNSB/$inputStr/$inputStr\_index.txt
				touch /home/$USER/Desktop/CNSB/$inputStr/$inputStr\_mails.txt	
			fi
			echo $PASS1 > /home/$USER/Desktop/CNSB/$inputStr.txt
			mv /home/$USER/Desktop/CNSB/$inputStr.txt /home/$USER/Desktop/CNSB/.$inputStr
			cd /home/$USER/Desktop/CNSB
			zip -r -q $inputStr $inputStr
			rm -r /home/$USER/Desktop/CNSB/$inputStr 
			val=$(cat /home/$USER/Desktop/CNSB/.$inputStr)
			gpg --yes --batch --passphrase="$val" -q -c /home/$USER/Desktop/CNSB/$inputStr\.zip
			sudo rm /home/$USER/Desktop/CNSB/"$inputStr"\.zip
			sudo chattr +a /home/$USER/Desktop/CNSB/$inputStr\.zip.gpg
			cd BUILDINGS/
			zip -r -q $inputStr $inputStr
			rm -r /home/$USER/Desktop/CNSB/BUILDINGS/$inputStr
			gpg --yes --batch --passphrase="$val" -q -c /home/$USER/Desktop/CNSB/BUILDINGS/$inputStr\.zip
			sudo rm /home/$USER/Desktop/CNSB/BUILDINGS/"$inputStr"\.zip
			sudo chattr +a /home/$USER/Desktop/CNSB/BUILDINGS/$inputStr\.zip.gpg 
			cd 
			cd $work		
		fi
		if [[ "$j" -eq "1" ]]; then
			selection=$(zenity  --list --width=300 --height=400 --text "CHOOSE A BUILDING" --radiolist  --column "SELECT" --column "BUILDING" TRUE $m 2> /dev/null);
		else
			a=${a::-1}
			selection=$(zenity  --list --width=300 --height=400 --text "CHOOSE A BUILDING" --radiolist  --column "SELECT" --column "BUILDING" TRUE $m  $a 2> /dev/null);
		fi
		checking=0			
		if [ $checker == 1 ]; then
			sudo chattr +a /usr/bin/dndelete.txt
			if [ $checking == 0 ]; then				
				IFS=' '
				a=$m$a
				arrayn=( $a )
				tLen=${#arrayn[@]}
				for (( i=0; i<${tLen}; ((i=i+2)) ));
					do
						INDI=${arrayn[$i]}
						case "$selection" in
						$INDI) zenity --width=300 --height=100 --question --text "Are you sure you want to choose $INDI?"; q=$? ;;
						esac 2>/dev/null
					done
				if [ $q == 1 ] || [[ "$selection" == "a" ]]; then
					rez=$(zenity --width=300 --height=100 --warning --text "Program canceled!" 2>/dev/null)
					if [ -e /home/$USER/Desktop/temp.txt ]; then
						rm /home/$USER/Desktop/temp.txt
					fi	
				fi
				if [ $q == 0 ] && [[ "$selection" != "a" ]]; then
					checker=0
					sudo chattr -a /home/$USER/Desktop/CNSB/.$selection
					while IFS='' read -r line || [[ -n "$line" ]]; do
						PAS=$line
					done < "/home/$USER/Desktop/CNSB/.$selection"
					sudo chattr +a /home/$USER/Desktop/CNSB/.$selection
					asdfg=1
					while [ $asdfg == 1 ]; do
						PASS1=""
						PASS1=$(zenity --password 2> /dev/null; mlk=$?)
						if [[ "$PASS1" != "$PAS" ]]; then
							zenity --question --width=230 --height=100 --text "Incorrect password! Try again?" 2>/dev/null; pli=$?
							if [ $pli == 1 ]; then
								zenity --warning --width=230 --height=100 --text "Program canceled!" 2>/dev/null
								asdfg=0
								checker=1
							fi
						fi
						if [[ "$PASS1" == "$PAS" ]]; then
						       	checking=1
							asdfg=0
							sudo chattr -a /home/$USER/Desktop/CNSB/BUILDINGS/$selection\.zip.gpg 
							val=$(cat /home/$USER/Desktop/CNSB/.$selection)
							gpg --yes --batch -q --passphrase="$val" /home/$USER/Desktop/CNSB/BUILDINGS/$selection\.zip.gpg 
							sudo rm /home/$USER/Desktop/CNSB/BUILDINGS/$selection\.zip.gpg 
							unzip -q /home/$USER/Desktop/CNSB/BUILDINGS/$selection\.zip -d /home/$USER/Desktop/CNSB/BUILDINGS/
							sudo rm /home/$USER/Desktop/CNSB/BUILDINGS/"$selection"\.zip
							sudo chattr -a /home/$USER/Desktop/CNSB/$selection\.zip.gpg 
							gpg --yes --batch -q --passphrase="$val" /home/$USER/Desktop/CNSB/$selection\.zip.gpg 
							sudo rm /home/$USER/Desktop/CNSB/$selection\.zip.gpg 
							unzip -q /home/$USER/Desktop/CNSB/$selection\.zip -d /home/$USER/Desktop/CNSB/
							sudo rm /home/$USER/Desktop/CNSB/"$selection"\.zip
						fi
					done
				fi
				if [ -e /home/$USER/Desktop/temp.txt ]
				then
				    rm /home/$USER/Desktop/temp.txt
				fi
				if [ $checking == 1 ];then
					BUILDING=$selection
					panda=1
					while [ $panda == 1 ]; do
						checker=1
						opt=0
						select=$(zenity  --list --width=400 --height=250 --text "BUILDING MENU" --radiolist  --column "SELECT" --column "OPTION" TRUE "Deliver Invoices" FALSE "Change mail address for password recovery" FALSE "Change building password" FALSE "Return to MAIN MENU" 2> /dev/null);
						case "$select" in
						"Deliver Invoices")opt=1;;
						"Change mail address for password recovery")opt=2;;
						"Change building password")opt=3;;
						"Return to MAIN MENU")opt=4;;
						esac
						if [ $opt == 4 ]; then
							panda=0
							opt=0
							cd /home/$USER/Desktop/CNSB
							zip -r -q $BUILDING $BUILDING
							rm -r /home/$USER/Desktop/CNSB/$BUILDING 
							val=$(cat /home/$USER/Desktop/CNSB/.$BUILDING)
							gpg --yes --batch --passphrase="$val" -q -c /home/$USER/Desktop/CNSB/$BUILDING\.zip
							sudo rm /home/$USER/Desktop/CNSB/"$BUILDING"\.zip
							sudo chattr +a /home/$USER/Desktop/CNSB/$BUILDING\.zip.gpg
							cd BUILDINGS/
							zip -r -q $BUILDING $BUILDING
							rm -r /home/$USER/Desktop/CNSB/BUILDINGS/$BUILDING
							gpg --yes --batch --passphrase="$val" -q -c /home/$USER/Desktop/CNSB/BUILDINGS/$BUILDING\.zip
							sudo rm /home/$USER/Desktop/CNSB/BUILDINGS/"$BUILDING"\.zip
							sudo chattr +a /home/$USER/Desktop/CNSB/BUILDINGS/$BUILDING\.zip.gpg
							cd 
							cd $work 
						fi
						if [ $opt == 3 ]; then
							opt=0
							sudo chattr -a /home/$USER/Desktop/CNSB/.$BUILDING
							PAS=$(cat /home/$USER/Desktop/CNSB/.$BUILDING)
							ghj=1
							while [ $ghj == 1 ]; do
								PASS1=""
								PASS1=$(zenity --password 2> /dev/null; mlk=$?)
								if [[ "$PASS1" != "$PAS" ]]; then
									zenity --question --width=230 --height=100 --text "Incorrect password! Try again?" 2>/dev/null; pli=$?
									if [ $pli == 1 ]; then
										zenity --warning --width=230 --height=100 --text "Program canceled!" 2>/dev/null
										ghj=0
									fi
								fi
								if [[ "$PASS1" == "$PAS" ]]; then
									checking=1
									zenity --info --width=230 --height=100 --timeout 4 --text "Passwords match!" 2> /dev/null
									zenity --warning --width=230 --height=100 --text "Choose a new pasword for $BUILDING!" 2> /dev/null
									PASS1=""
									PASS2=""
									while [ "$PASS1" == "" ]; do
										PASS1=$(zenity --password 2> /dev/null)
										if [[ "$PASS1" == "" ]]; then
											zenity --warning --width=230 --height=100 --text "No password typed!" 2> /dev/null
										fi
									done
									zenity --info --width=230 --height=100 --text "Retype password" 2> /dev/null
									while [ "$PASS1" != "$PASS2" ]; do
									PASS2=$(zenity --password 2> /dev/null)
									if [[ "$PASS2" == "" ]]; then
										zenity --warning --width=230 --height=100 --text "No password typed!" 2> /dev/null
									fi
									if [[ "$PASS1" != "$PASS2" ]]; then

										zenity --warning --width=230 --height=100 --text "Passwords are not the same! Try again!" 2> /dev/null
									fi
									done
									if [[ "$PASS1" == "$PASS2" ]]; then
										zenity --info --width=230 --height=100 --text "You set a new password for $BUILDING!" 2> /dev/null
										ghj=0
									fi
									sudo echo $PASS1 > /home/$USER/Desktop/CNSB/.$BUILDING
									sudo chattr +a /home/$USER/Desktop/CNSB/.$BUILDING
								fi
							done
						fi
						if [ $opt == 2 ]; then
							opt=0
							sudo chattr -a /home/$USER/Desktop/CNSB/.$BUILDING
							PAS=$(cat /home/$USER/Desktop/CNSB/.$BUILDING)
							sudo chattr +a /home/$USER/Desktop/CNSB/.$BUILDING
							ghj=1
							pli=7
							while [ $ghj == 1 ]; do
								PASS1=""
								PASS1=$(zenity --password 2> /dev/null; mlk=$?)
								if [[ "$PASS1" != "$PAS" ]]; then
									zenity --question --width=230 --height=100 --text "Incorrect password, nothing typed or canceled! Try again?" 2>/dev/null; pli=$?
									if [ $pli == 1 ]; then
										zenity --warning --width=230 --height=100 --text "Program canceled!" 2>/dev/null
										ghj=0
									fi
								fi
								if [[ "$PASS1" == "$PAS" ]]; then
									checking=1
									zenity --info --width=230 --height=100 --timeout 4 --text "Passwords match!" 2> /dev/null
									mayl=""
									while [ "$mayl" == "" ]; do
										mayl=$(zenity --entry --title "Mail address" --text="Type the new mail address from which you will recover building password" 2>/dev/null)
									done
									sudo chattr -a /home/$USER/Desktop/CNSB/.$BUILDING\_mail
									echo $mayl > /home/$USER/Desktop/CNSB/.$BUILDING\_mail
									sudo chattr +a /home/$USER/Desktop/CNSB/.$BUILDING\_mail
									ghj=0
									zenity --info --width=230 --height=100 --text "A new recovery mail was created!" 2>/dev/null
								fi
							done	
						fi
						if [ $opt == 1 ]; then
							pinguin=1
							while [ $pinguin == 1 ]; do
								sele=$(zenity  --list --width=350 --height=250 --text "INVOICES MENU" --radiolist  --column "SELECT" --column "OPTION" TRUE "Create folders and send mails" FALSE "Create folders"  FALSE "Return to BUILDING MENU" 2> /dev/null);
								case "$sele" in
								"Create folders and send mails")sap=1;;
								"Create folders")sap=2;;
								"Return to BUILDING MENU")sap=3;;
								esac
								if [ $sap == 3 ]; then
									pinguin=0
									sap=0
								fi
								if [ $sap == 1 ]; then
									sap=0
									mkdir -p /home/$USER/Desktop/CNSB
									mkdir -p /home/$USER/Desktop/CNSB/$BUILDING
									touch /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt
									if [ -e /home/$USER/Desktop/*.pdf ] && [ -e /home/$USER/Desktop/*.xlsx ]; then
										mkdir -p /home/$USER/Desktop/facturi
										cp /home/$USER/Desktop/*.pdf /home/$USER/Desktop/facturi/
										mv /home/$USER/Desktop/facturi/*.pdf /home/$USER/Desktop/facturi/a.pdf
										cd /home/$USER/Desktop/facturi
										pdftk /home/$USER/Desktop/facturi/*.pdf burst
										rm /home/$USER/Desktop/facturi/a.pdf
										dt=$(date +%m-%Y)
										mkdir -p /home/$USER/Desktop/CNSB/$BUILDING/$dt
										mv /home/$USER/Desktop/*.pdf /home/$USER/Desktop/CNSB/$BUILDING/$dt/
										rm doc_data.txt
										cd ..
										xlsx2csv /home/$USER/Desktop/*.xlsx /home/$USER/Desktop/text.txt
										cut -d',' -f2,40,46 text.txt | tr "," "!" | tr "/" "," > /home/$USER/Desktop/mail.txt
										grep -v "Unit" /home/$USER/Desktop/mail.txt | sort | uniq > /home/$USER/Desktop/temp.txt
										cat /home/$USER/Desktop/temp.txt > /home/$USER/Desktop/mail.txt
										rm /home/$USER/Desktop/temp.txt
										rm /home/$USER/Desktop/text.txt
										mv /home/$USER/Desktop/*.xlsx /home/$USER/Desktop/CNSB/$BUILDING/$dt/
										mkdir -p /home/$USER/Desktop/CNSB/$BUILDING
										mkdir -p /home/$USER/Desktop/CNSB/BUILDINGS/$BUILDING
										if [ -e /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt ]; then
											sort /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt | uniq > /home/$USER/Desktop/temp.txt
											cat /home/$USER/Desktop/temp.txt > /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt
											rm /home/$USER/Desktop/temp.txt 
										fi
										if [ -e /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_mails.txt ]; then
											sort /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_mails.txt | uniq > /home/$USER/Desktop/exp.txt
											cat /home/$USER/Desktop/exp.txt > /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_mails.txt
											rm /home/$USER/Desktop/exp.txt
										fi  
										searchdir="/home/$USER/Desktop/facturi"
										for dir in $searchdir/*;
											do
												vrk=0
												vrb=1
												h=$(basename "$dir")
												pdftotext -layout "$dir" /home/$USER/Desktop/facturi/"$h".txt
												var=$(grep Unit /home/$USER/Desktop/facturi/"$h".txt)
												IFS=' '
												array=( $var )
												unit=${array[1]}
												mkdir -p /home/$USER/Desktop/CNSB/BUILDINGS/$BUILDING/$unit
												name=$(grep "Invoice Number" /home/$USER/Desktop/facturi/"$h".txt | cut -d":" -f3)
												id=$BUILDING$unit"A"
												x="$name - unit $unit"
												year=$(grep -w "Unit:" /home/$USER/Desktop/facturi/"$h".txt | cut -d":" -f3 | cut -d"." -f3)
												month=$(grep -w "Unit:" /home/$USER/Desktop/facturi/"$h".txt | cut -d":" -f3 | cut -d"." -f2)
												date=$(date +%d-%m-%y)
												ut=$(grep -w $unit /home/$USER/Desktop/mail.txt)
												IFS='!'
												arrayl=( $ut )
												unset NAM
												nam=${arrayl[1]}
												NAM=$(echo $NAM | tr ' ' '_')
												aa=$(grep -n Customer /home/$USER/Desktop/facturi/"$h".txt | cut -d":" -f1)
												ba=$(grep -n Unit: /home/$USER/Desktop/facturi/"$h".txt | cut -d":" -f1)
												ca=$(($ba-$aa))
												((ca--))
												name1=$(grep -A $ca Customer /home/$USER/Desktop/facturi/"$h".txt | cut -d":" -f2)
												name1=$(echo $name1 | sed -e 's/\<Invoice\>//g' | sed -e 's/\<Number\>//g' | tr -s " " | tr '\n' ' ' | tr -s " " | sed -e 's/[[:space:]]*$//' | sed -e 's/^[[:space:]]*//')
												NAME1=$(echo $name1 | tr ' ' '_')
												name2=$(grep -w $unit /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt | cut -d"!" -f2 )
												NAME2=$(echo $name2 | tr ' ' '_')
												mkdir -p /home/$USER/Desktop/CNSB/BUILDINGS/$BUILDING/$unit/$NAM
												if grep -wq $unit /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt; then
													if [[ "$name1" != "$name2" ]];
														then
															k=1
															while [ $k == 1 ];
																do
																	line=$(zenity --entry  --title="QUESTION" --text="UNIT: $unit - Do you think $name1 and $name2 are the same person? Type yes or no: " 2>/dev/null)
																	k=1
																	if [[ "$line" == "no" ]]
																		then
																			vrk=0
																			vrb=0
																			k=0
																			mkdir -p /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_Archive
																			mkdir -p /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_Archive/$unit
																			mkdir -p /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_Archive/$unit/$NAME2
																			mv "/home/$USER/Desktop/CNSB/BUILDINGS/$BUILDING/$unit"/* /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_Archive/$unit/$NAME2
																			grep -wv $name2 /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt > temp.txt
																			rm /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt
																			mv temp.txt /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt
																	else
																		if [[ "$line" == "yes" ]]
																			then
																				vrk=1
																				vrb=1
																				k=0
																		else
																			zenity --warning --width=230 --height=100 --timeout 2 --text "Please type yes or no!" 2>/dev/null
																		fi
																	fi
																	if [[ "$k" == 0 ]]
																		then
																			break
																	fi
																done
													fi
												fi
												us=$(grep -w "$unit!$name1" /home/$USER/Desktop/mail.txt)
												un=$(echo $us | tr '     ' ' ')
												p=$(echo $un | wc -w)
												IFS=' '
												arrayq=( $un )
												unset MAIL
										       		for (( k=0; k < $p; ++k ))
													do
														if [[ ${arrayq[k]} = *"@"* ]]; then
															MAIL=$MAIL${arrayq[k]}","
														fi
													done
												if [ -n "$MAIL" ]; then
													MAIL=${MAIL::-1}
											     		IFS=','
													arrayn=( $MAIL )
													tLen=${#arrayn[@]}
													for (( i=0; i<${tLen}; i++ ));
										 	      		        do
															INDIVIDUAL=${arrayn[$i]}		
														done
												fi
												mv /home/$USER/Desktop/facturi/"$h" /home/$USER/Desktop/facturi/"$x.pdf"
												if [ -z "$MAIL" ]; then
													MAIL="NONE"
													vr=0
												else
													vr=1
												fi
												cp /home/$USER/Desktop/facturi/"$x.pdf" /home/$USER/Desktop/CNSB/BUILDINGS/$BUILDING/$unit/"$x.pdf"
												rm /home/$USER/Desktop/facturi/"$h".txt
												if [ $vrk != "1" ]; then
													echo "$unit!$name1" >> /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt
												fi												
												sort /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt | uniq > temp.txt
												rm /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt
												mv temp.txt /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt
												if [ $vr != "0" ]; then
													echo "$unit!$name1!$MAIL!/home/$USER/Desktop/CNSB/BUILDINGS/$BUILDING/$unit/"$x.pdf"" >> /home/$USER/Desktop/AST.txt
												fi
											done
										sort /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt | uniq > temp.txt
										rm /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt
										mv temp.txt /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt
										rm /home/$USER/Desktop/mail.txt
										cat /home/$USER/Desktop/AST.txt > /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_mails.txt
										sort /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_mails.txt | uniq > /home/$USER/Desktop/temp.txt
										cat /home/$USER/Desktop/temp.txt > /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_mails.txt
										rm /home/$USER/Desktop/temp.txt
										rm /home/$USER/Desktop/AST.txt
										rm -r /home/$USER/Desktop/facturi
										if  [ -e /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_journal.txt ]; then
											kostas=0
										else
											touch /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_journal.txt
										fi
										file=/home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_mails.txt
										today=`date +%d-%m-%Y`
										now=`date +%k:%M`
										final=0
										fin=1
										if [ -e $file ]; then
											final=1
											verificare=$(wc -l < $file)
											if [ $verificare == 0 ]; then
												zenity --warning --width=230 --height=100 --timeout 2 --text "FILE EMPTY! NO MAIL TO SEND!" 2>/dev/null
												final=0
												fin=0
											fi
										else
											zenity --warning --width=230 --height=100 --timeout 2 --text "OPERATION NOT PERMITED! NO MAIL TO SEND!" 2>/dev/null
											final=0
											fin=0
										fi
										cangur=1
										verificare=$(wc -l < /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_journal.txt)
										line=$(head -$verificare /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_journal.txt | tail -1)
										if [[ "$line" == "#############################################################################################################################" ]] || [ $verificare == 0 ]; then
											echo "################################################# $today" >> /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_journal.txt
										fi
										while [ $final == 1 ]
											do
												ok=0
												wget -q --tries=10 --timeout=20 --spider http://google.com
												if [[ $? -eq 0 ]]; then
													for (( k=1; k<=$(wc -l < /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_mails.txt); k++ )); 
														do

															wget -q --tries=10 --timeout=20 --spider http://google.com
															if [[ $? -eq 0 ]]; then
																MAIL=$(head -1 $file | cut -d$'!' -f3)
																dir=$(head -1 $file | cut -d$'!' -f4)
																NUME=$(head -1 $file | cut -d$'!' -f2)
																AP=$(head -1 $file | cut -d$'!' -f1)
																IFS=','
																arrayn=( $MAIL )
																tLen=${#arrayn[@]}
																for (( i=0; i<${tLen}; i++ ));
																	do
											       							INDIVIDUAL=${arrayn[$i]}
																		if [[ "$INDIVIDUAL" != "NONE" ]];then
																			echo "Your invoice was issued. Please check the attachment. Have a nice day!" | s-nail -s "Invoice" -a $dir -A billing $INDIVIDUAL
																		konstantin=0
																		fi
																		echo "UNIT: $AP NAME: $NUME MAIL: $INDIVIDUAL TIME: $today $now" >> /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_journal.txt
																		zenity --info --width=230 --height=100 --timeout 2 --text "Mail sent to $INDIVIDUAL" 2>/dev/null
																	done
																sed -i '1d' $file	 
																sleep 15
															else
																ok=1
																while [ $ok == 1 ]
																	do 
																		zenity --question --width=230 --height=100 --timeout 5 --text "No internet connection! Try again?" 2>/dev/null; mac=$?
																		if [ $mac == 5 ] || [ $mac == 0 ]; then
																			sleep 30
																			wget -q --tries=10 --timeout=20 --spider http://google.com
																			if [[ $? -eq 0 ]]; then
																				ok=0
																				echo "UNIT: $AP NAME: $NUME MAIL: $INDIVIDUAL TIME: $today $now" >> /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_journal.txt
																				zenity --info --width=230 --height=100 --timeout 2 --text "Mail sent to $INDIVIDUAL" 2>/dev/null
																			fi
																		else	
																			ok=0
																			zenity --warning --width=230 --height=100 --text "Program canceled!" 2>/dev/null
																			cangur=0
																			final=0	
																			k=9999999999
																		  break							
																		fi		
																	done	
															fi
														done 
													sleep 30
												else
													zenity --question --width=230 --height=100 --timeout 5 --text "No internet connection! Try again?" 2>/dev/null; mac=$?
													
													if [ $mac == 1 ]; then
														zenity --warning --width=230 --height=100 --text "Program canceled!" 2>/dev/null
														final=0
														cangur=0
														break
													else
														sleep 30	
													fi
												fi
												vrb=$(wc -l < /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_mails.txt)
												if [ $vrb == 0 ]; then
													rm /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_mails.txt
													final=0
												fi
											done
										if [ $cangur == 1 ] && [ $fin == 1 ]; then
											echo "#############################################################################################################################" >> /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_journal.txt
										fi
									else
										zenity --warning --width=150 --timeout 2 --text "No pdf or/and xlsx file found!" 2>/dev/null
									fi
								fi
								if [ $sap == 2 ]; then
									sap=0
									mkdir -p /home/$USER/Desktop/CNSB
									mkdir -p /home/$USER/Desktop/CNSB/$BUILDING
									touch /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt
									if [ -e /home/$USER/Desktop/*.pdf ] && [ -e /home/$USER/Desktop/*.xlsx ]; then
										mkdir -p /home/$USER/Desktop/facturi
										cp /home/$USER/Desktop/*.pdf /home/$USER/Desktop/facturi/
										mv /home/$USER/Desktop/facturi/*.pdf /home/$USER/Desktop/facturi/a.pdf
										cd /home/$USER/Desktop/facturi
										pdftk /home/$USER/Desktop/facturi/*.pdf burst
										rm /home/$USER/Desktop/facturi/a.pdf
										dt=$(date +%m-%Y)
										mkdir -p /home/$USER/Desktop/CNSB/$BUILDING/$dt
										mv /home/$USER/Desktop/*.pdf /home/$USER/Desktop/CNSB/$BUILDING/$dt/
										rm doc_data.txt
										cd ..
										xlsx2csv /home/$USER/Desktop/*.xlsx /home/$USER/Desktop/text.txt
										cut -d',' -f2,40,46 text.txt | tr "," "!" | tr "/" "," > /home/$USER/Desktop/mail.txt
										grep -v "Unit" /home/$USER/Desktop/mail.txt | sort | uniq > /home/$USER/Desktop/temp.txt
										cat /home/$USER/Desktop/temp.txt > /home/$USER/Desktop/mail.txt
										rm /home/$USER/Desktop/temp.txt
										rm /home/$USER/Desktop/text.txt
										mv /home/$USER/Desktop/*.xlsx /home/$USER/Desktop/CNSB/$BUILDING/$dt/
										mkdir -p /home/$USER/Desktop/CNSB/$BUILDING
										mkdir -p /home/$USER/Desktop/CNSB/BUILDINGS/$BUILDING
										if [ -e /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt ]; then
											sort /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt | uniq > /home/$USER/Desktop/temp.txt
											cat /home/$USER/Desktop/temp.txt > /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt
											rm /home/$USER/Desktop/temp.txt 
										fi
										if [ -e /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_mails.txt ]; then
											sort /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_mails.txt | uniq > /home/$USER/Desktop/exp.txt
											cat /home/$USER/Desktop/exp.txt > /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_mails.txt
											rm /home/$USER/Desktop/exp.txt
										fi  
										searchdir="/home/$USER/Desktop/facturi"
										for dir in $searchdir/*;
											do
												vrk=0												
												vrb=1
												h=$(basename "$dir")
												pdftotext -layout "$dir" /home/$USER/Desktop/facturi/"$h".txt
												var=$(grep Unit /home/$USER/Desktop/facturi/"$h".txt)
												IFS=' '
												array=( $var )
												unit=${array[1]}
												mkdir -p /home/$USER/Desktop/CNSB/BUILDINGS/$BUILDING/$unit
												name=$(grep "Invoice Number" /home/$USER/Desktop/facturi/"$h".txt | cut -d":" -f3)
												id=$BUILDING$unit"A"
												x="$name - unit $unit"
												year=$(grep -w "Unit:" /home/$USER/Desktop/facturi/"$h".txt | cut -d":" -f3 | cut -d"." -f3)
												month=$(grep -w "Unit:" /home/$USER/Desktop/facturi/"$h".txt | cut -d":" -f3 | cut -d"." -f2)
												date=$(date +%d-%m-%y)
												ut=$(grep -w $unit /home/$USER/Desktop/mail.txt)
												IFS='!'
												arrayl=( $ut )
												unset NAM
												nam=${arrayl[1]}
												NAM=$(echo $NAM | tr ' ' '_')
												aa=$(grep -n Customer /home/$USER/Desktop/facturi/"$h".txt | cut -d":" -f1)
												ba=$(grep -n Unit: /home/$USER/Desktop/facturi/"$h".txt | cut -d":" -f1)
												ca=$(($ba-$aa))
												((ca--))
												name1=$(grep -A $ca Customer /home/$USER/Desktop/facturi/"$h".txt | cut -d":" -f2)
												name1=$(echo $name1 | sed -e 's/\<Invoice\>//g' | sed -e 's/\<Number\>//g' | tr -s " " | tr '\n' ' ' | tr -s " " | sed -e 's/[[:space:]]*$//' | sed -e 's/^[[:space:]]*//')
												NAME1=$(echo $name1 | tr ' ' '_')
										       	 	name2=$(grep -w $unit /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt | cut -d"!" -f2 )
												NAME2=$(echo $name2 | tr ' ' '_')
												mkdir -p /home/$USER/Desktop/CNSB/BUILDINGS/$BUILDING/$unit/$NAM
												if grep -wq $unit /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt; then
													if [[ "$name1" != "$name2" ]];
														then
															k=1
															while [ $k == 1 ];
																do
																	line=$(zenity --entry  --title="QUESTION" --text="UNIT: $unit - Do you think $name1 and $name2 are the same person? Type yes or no: " 2>/dev/null)
																	k=1
																	if [[ "$line" == "no" ]]
																		then
																			vrk=0
																			vrb=0
																			k=0
																			mkdir -p /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_Archive
																			mkdir -p /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_Archive/$unit
																			mkdir -p /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_Archive/$unit/$NAME2
																			mv "/home/$USER/Desktop/CNSB/BUILDINGS/$BUILDING/$unit"/* /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_Archive/$unit/$NAME2
																			grep -wv $name2 /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt > temp.txt
																			rm /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt
																			mv temp.txt /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt
																	else
																		if [[ "$line" == "yes" ]]
																			then
																				vrk=1
																				vrb=1
																				k=0
																		else
																			zenity --warning --width=230 --height=100 --timeout 2 --text "Please type yes or no!" 2>/dev/null
																		fi
																	fi
																	if [[ "$k" == 0 ]]
																		then
																			break
																	fi
																done
													fi
												fi
												un=$(echo $ut | tr '     ' ' ')
												p=$(echo $un | wc -w)
												IFS=' '
												arrayq=( $un )
												unset MAIL
										       		for (( k=0; k < $p; ++k ))
													do
														if [[ ${arrayq[k]} = *"@"* ]]; then
															MAIL=$MAIL${arrayq[k]}","
														fi
												done
												if [ -n "$MAIL" ]; then
													MAIL=${MAIL::-1}
											     		IFS=','
													arrayn=( $MAIL )
													tLen=${#arrayn[@]}
													for (( i=0; i<${tLen}; i++ ));
										 	      		        do
															INDIVIDUAL=${arrayn[$i]}				
														done
												fi
												mv /home/$USER/Desktop/facturi/"$h" /home/$USER/Desktop/facturi/"$x.pdf"
												if [ -z "$MAIL" ]; then
													MAIL="NONE"
													vr=0
												else
													vr=1
												fi
												cp /home/$USER/Desktop/facturi/"$x.pdf" /home/$USER/Desktop/CNSB/BUILDINGS/$BUILDING/$unit/"$x.pdf"
												rm /home/$USER/Desktop/facturi/"$h".txt
												if [ $vrk != "1" ]; then
													echo "$unit!$name1" >> /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt
												fi												
												sort /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt | uniq > temp.txt
												rm /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt
												mv temp.txt /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt
												if [ $vr != "0" ]; then
													echo "$unit!$name1!$MAIL!/home/$USER/Desktop/CNSB/BUILDINGS/$BUILDING/$unit/"$x.pdf"" >> /home/$USER/Desktop/AST.txt
												fi	
											done
										sort /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt | uniq > temp.txt
										rm /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt
										mv temp.txt /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_index.txt
										rm /home/$USER/Desktop/mail.txt
										cat /home/$USER/Desktop/AST.txt > /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_mails.txt
										sort /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_mails.txt | uniq > /home/$USER/Desktop/temp.txt
										cat /home/$USER/Desktop/temp.txt > /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_mails.txt
										rm /home/$USER/Desktop/temp.txt
										rm /home/$USER/Desktop/AST.txt
										rm -r /home/$USER/Desktop/facturi
										rm /home/$USER/Desktop/CNSB/$BUILDING/$BUILDING\_mails.txt
										
									else
										zenity --warning --width=150 --timeout 2 --text "No pdf or/and xlsx file found!" 2>/dev/null
									fi
								fi							
							done
						fi
					done	
				fi
			fi
		fi
	fi
done
