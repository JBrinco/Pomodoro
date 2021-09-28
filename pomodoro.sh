#!/bin/bash
# Simple pomodoro timer for Linux


TIMER=3000
BREAKTIMER=600
NUMBER=3

while getopts ":d:b:lLn:h" o; do case "${o}" in
	d) TIMER=$((OPTARG*60)) ;;
	b) BREAKTIMER=$((OPTARG*60)) ;;
	n) NUMBER=${OPTARG} ;;
	l) echo -e "Last 10 pomodoros:\n" && tail ~/.config/pomodoro/pomodorolog && exit 0 ;;
	L) less ~/.config/pomodoro/pomodorolog && exit 0 ;;
	h) echo -e "Usage: pomodoro \nOptions: \n -d: timer duration in minutes (default 50)\n -b: Break duration in minutes (default 10)\n -n: Number of pomodoros (default 3)\n -l: Show log of 10 last pomodoros\n -L: Show full log" && exit 0 ;;
	*) printf "Invalid option: -%s\\n" "$OPTARG" && exit 1 ;;
esac done


((MINTIMER=TIMER/60))


while [ "$NUMBER" -gt 0 ]
do
	TIMELEFT=$TIMER
	clear && echo -e "Timer set for $((TIMER/60)) minutes\n${NUMBER} Pomodoros left "
	while [ "$TIMELEFT" -gt 0 ]
	do
		((TIMELEFT=TIMELEFT-60)); sleep 60 && clear && echo -e "Work Period\n$((TIMELEFT/60)) minutes left\n${NUMBER} Pomodoros to go";
	done

	echo "$(date "+%d %b %Y 🕑 %H:%M") $MINTIMER minutes"  >> ~/.config/pomodoro/pomodorolog
	notify-send 'Pomodoro over!' && paplay ~/.config/pomodoro/notification.ogg


	clear && read -p "Pomdoro over. Press enter to start break timer "


	((NUMBER=NUMBER-1))
	TIMELEFT=$BREAKTIMER
	clear && echo -e "Break Period\n$((TIMELEFT/60)) minutes left\n${NUMBER} Pomodoros to go"
	while [ "$TIMELEFT" -gt 0 ]
	do
		((TIMELEFT=TIMELEFT-60)); sleep 60 && clear && echo -e "Break Period\n$((TIMELEFT/60)) minutes left\n${NUMBER} Pomodoros to go"
	done

	notify-send 'Break time over!' && paplay ~/.config/pomodoro/notification.ogg

	clear && read -p "Break time over. Press enter to start new Pomodoro "
done
echo "All done! Have a great day!"
