function speedtest --wraps='networkQuality -v' --description 'alias speedtest networkQuality -v'
  networkQuality -v $argv; 
end
