function song
    set state $(osascript -e 'tell application "Music" to player state')

    if test "$state" != "playing"
      and test "$state" != "paused"
      echo "Music is $state"
      return
    end

    set artist $(osascript -e 'tell application "Music" to get artist of current track')

    set song $(osascript -e 'tell application "Music" to get name of current track')

    set album $(osascript -e 'tell application "Music" to get album of current track')

    echo "$GREEN♫ $song$RESET by $GREEN$artist$RESET
    from $GREEN$album$RESET"
end
