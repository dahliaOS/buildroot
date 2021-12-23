mv /etc/X11/xorg.conf /etc/X11/breaker.conf
startx&
export PATH="$PATH:$HOME/Applications/links"
sleep 30&&mv /etc/X11/breaker.conf /etc/X11/xorg.conf
