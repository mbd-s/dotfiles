function fopen --wraps='vi ~/.config/fish/config.fish' --description 'alias fopen vi ~/.config/fish/config.fish'
  vi ~/.config/fish/config.fish $argv; 
end
