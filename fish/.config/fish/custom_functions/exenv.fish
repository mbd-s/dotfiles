function exenv --argument-names env_file --description "Export environment variables from a file where the format is KEY=VALUE"
    if not test -n "$env_file"
        echo "Usage: exenv <env_file>" && return
    end

    for line in (cat $env_file)
        if test -n "$line"; and not string match --quiet --regex '^\s*#' "$line"
            set env_var (string split --max 1 = $line)
            if test (count $env_var) -eq 2
                set --global --export $env_var[1] $env_var[2]
            end
        end
    end
end
