function exenv --argument-names env_file --description "Export environment variables from a file, in the format KEY=VALUE"
    set -q env_file[1]; or set env_file env.development

    for line in (cat $env_file);
      set env_vars (string split --max 1 = $line)
      set -gx $env_vars[1] $env_vars[2]
    end
end
