function aws_switch --argument-names profile --description "Switch AWS profile"
    set --global --export AWS_PROFILE $profile
    aws sts get-caller-identity --no-cli-pager

    switch $status
        case 253
            handle_aws_credentials_error && return
        case 254
            type --query creds; or handle_aws_credentials_error && return
            echo $GREEN"Refreshing credentials..."$RESET_COLOR && creds && sleep 5 && aws --profile $profile sts get-caller-identity --no-cli-pager; or handle_aws_credentials_error && return
        case 255
            set --erase AWS_PROFILE && return
    end
end
