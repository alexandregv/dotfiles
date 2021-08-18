export DISPLAY=":0.0"
if [ "$(hostname)" = "dump-reach" ]; then
  autorandr docked
fi
picom --experimental-backends --backend glx --xrender-sync-fence -b
dwall -s lakeside
