#!/bin/bash
# Simple pomodoro timer for Linux


TIMER=3000
BREAKTIMER=600
NUMBER=3

while getopts ":d:b:n:h" o; do case "${o}" in
	d) TIMER=$((OPTARG*60)) ;;
	b) BREAKTIMER=$((OPTARG*60)) ;;
	n) NUMBER=${OPTARG} ;;
	h) echo -e "Usage: pomodoro (50 minute cycle default)\n Options: \n d: timer duration in minutes (default 50)\n b: Break duration in minutes (default 10)\n n: Number of pomodoros (default 3)" && exit 0 ;;
	*) printf "Invalid option: -%s\\n" "$OPTARG" && exit 1 ;;
esac done


((MINTIMER=TIMER/60))


while [ "$NUMBER" -gt 1 ]
do
	TIMELEFT=$TIMER
	clear && echo -e "Timer set for $((TIMER/60)) minutes\n${NUMBER} Pomodoros left "
	while [ "$TIMELEFT" -gt 60 ]
	do
		((TIMELEFT=TIMELEFT-60)); sleep 60 && clear && echo -e "Work Period\n$((TIMELEFT/60)) minutes left\n${NUMBER} Pomodoros to go";
	done

	echo "$(date "+%d %b %Y 🕑 %H:%M") $MINTIMER minutes"  >> ~/.pomodorolog
	notify-send 'Pomodoro over!' && paplay ~/.config/notification.ogg


	clear && read -p "Pomdoro over. Press enter to start break timer "


	((NUMBER=NUMBER-1))
	TIMELEFT=$BREAKTIMER
	clear && echo -e "Break Period\n$((TIMELEFT/60)) minutes left\n${NUMBER} Pomodoros to go"
	while [ "$TIMELEFT" -gt 60 ]
	do
		((TIMELEFT=TIMELEFT-60)); sleep 60 && clear && echo -e "Break Period\n$((TIMELEFT/60)) minutes left\n${NUMBER} Pomodoros to go"
	done

	notify-send 'Break time over!' && paplay ~/.config/notification.ogg

	clear && read -p "Break time over. Press enter to start new Pomodoro "
done
echo "All done! Have a great day!"