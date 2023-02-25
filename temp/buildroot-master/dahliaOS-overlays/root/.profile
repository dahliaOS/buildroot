
#mv /etc/X11/xorg.conf /etc/X11/breaker.conf
#startx&
##These are old fixups for graphical applications. We don't need these anymore, the X11 service should work fine regardless of whether or not the configuration is valid. This may need to change on Nvidia machines, but that's unlikely.
export PATH="$PATH:$HOME/Applications/links"
export PATH="$PATH:$HOME/Applications/data"
#sleep 30&&mv /etc/X11/breaker.conf /etc/X11/xorg.conf
