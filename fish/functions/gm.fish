function gm -d "Update various dependencies"
    brewski
    asdf plugin update --all
    fisher update
end
