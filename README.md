# Pomodoro

Simple Pomodoro timer for the command line

# What it is

A simple Bash script for tracking your pomodoros! Will write a log to ~/.pomodorolog with all your completed pomodoros, so you can keep track.

I wrote this for myself. It is an extremely simple script, you can modify it to your liking.

# Setup

You need to create a ~/.config/pomodoro directory. Move notification.ogg there. For convenience, you should add the script to your PATH.

The script asumes you use dunst for notifications (you probably don't). Simply remove the `&& dunstctl close-all` from the script (in 2 places). All this does is automatically clear the previous notification when you start a new pomodoro or break.

# How to use

In the directory where the script is, type `./pomodoro -h` to get all the possible options. Or if you added it to your PATH, just do `pomodoro -h`.


# To add

- [ ] .config/pomodoro directory with log, config file, etc, as well as a better way to acess the log and count pomodoro time.


Inspired by https://github.com/rukshn/pomodoro
