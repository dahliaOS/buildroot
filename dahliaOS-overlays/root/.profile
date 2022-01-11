mv /etc/X11/xorg.conf /etc/X11/breaker.conf
ln -s ~/Applications/data/io.dahliaos.dap.dap ~/Applications/links/dap
ln -s ~/Applications/data/io.dahliaos.web_runtime.dap ~/Applications/links/web_runtime
startx&
export PATH="$PATH:$HOME/Applications/links"
sleep 30&&mv /etc/X11/breaker.conf /etc/X11/xorg.conf
