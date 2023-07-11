function handle_aws_credentials_error --description "Helper function to catch AWS credentials errors"
    echo $RED"Check your credentials"$RESET_COLOR
    set --erase AWS_PROFILE
end
