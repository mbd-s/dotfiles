function eject --description "Eject all mountable volumes"
    osascript -e 'tell application "Finder" to eject (every disk whose ejectable is true)'
end
