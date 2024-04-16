function google --description "Perform a Google seach"
    set --local base_url "https://www.google.com/search?q="
    open "$base_url$argv"
end
