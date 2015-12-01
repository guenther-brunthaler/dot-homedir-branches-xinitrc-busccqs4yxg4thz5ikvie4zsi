#! /bin/sh
# (c) 2013 - 2015 by Guenther Brunthaler.
# This script is free software.
# Distribution is permitted under the terms of the GPLv3.

# Prepare environment.
set .bash_profile .bash_login .profile .bashrc
test -n "$BASH_VERSION" && test -n "$BASH_ENV" && set "$@" "$BASH_ENV"
test -n "$ENV" && set "$@" "$ENV"
for unnll50vwub2yhksp08ygh9hm
do
	unnll50vwub2yhksp08ygh9hm=$HOME/$unnll50vwub2yhksp08ygh9hm
	if test -f "$unnll50vwub2yhksp08ygh9hm"
	then
		. "$unnll50vwub2yhksp08ygh9hm"
		break
	fi
done
unset unnll50vwub2yhksp08ygh9hm

# SuSE specific stuff.
OS=`uname -s`
if test x"$OS" = x"Linux"
then
	case $WINDOWMANAGER in
		*gnome*)
			if test -e /etc/SuSE-release && test -d /opt/gnome/bin
			then
				PATH=$PATH:/opt/gnome/bin
				export PATH
			fi
	esac
fi

# Merge preset X resources.
if test -f "$HOME/.Xresources"
then
	/usr/bin/xrdb "$HOME/.Xresources"
fi

# Merge preset X resources.
if test -f "$HOME/.Xmodmap"
then
	/usr/bin/xmodmap "$HOME/.Xmodmap"
fi

# Set a gray background as default. Fancy WMs and SMs will replace the
# background with their own wallpapers anyway.
xsetroot -solid grey

# Find the WM or SM to execute. A user-provided XSESSION has the highest
# priority.
if test -n "$XSESSION"
then
	set -- "$XSESSION"
else
	set --
fi
# Add some additional sane choices as fallback.
set -- "$@" icewm fluxbox jwm blackbox mwm twm
CMD=/bin/false
for xs
do
	if
		test x"${xs%/*}" != x"$xs" && test -x "$xs"
	then
		CMD=$xs
		test -n "$XSESSION" && XSESSION=$xs
		break
	fi
	for bindir in /etc/X11/Sessions /usr/bin
	do
		cmd=$bindir/$xs
		if test -x "$cmd"
		then
			CMD=$cmd
			test -n "$XSESSION" && XSESSION=$xs
			break 2
		fi
	done
done
test -n "$XSESSION" && export XSESSION

# Run window manager.
"$CMD" || /usr/bin/xterm -geometry 80x24+10+10 -ls \
	-title 'No $XSESSION defined'
