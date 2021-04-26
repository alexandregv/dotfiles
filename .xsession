export DISLAY=":0.0"
if [ "$(hostname)" = "dump-reach" ]; then
  xrandr --output DP-2 --primary
  xrandr --output DP-3 --auto --left-of DP-2
  xrandr --output DP-3 --rotate left
fi
picom --experimental-backends --backend glx --xrender-sync-fence -b
dwall -s lakeside
