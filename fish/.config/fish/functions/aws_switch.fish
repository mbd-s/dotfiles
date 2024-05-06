function aws_switch --argument-names profile --description "Switch AWS profile"
    function __handle_aws_credentials_error --description "Helper function to catch AWS credentials errors"
        echo $RED"Check your credentials"$NORMAL
        set --erase AWS_PROFILE
        functions --erase __handle_aws_credentials_error
    end

    set --global --export AWS_PROFILE $profile
    aws sts get-caller-identity --no-cli-pager

    # https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-returncodes.html
    switch $status
        case 253
            __handle_aws_credentials_error && return
        case 254
            type --query creds; or __handle_aws_credentials_error && return
            echo $GREEN"Refreshing credentials..."$NORMAL && creds && sleep 5 && aws --profile $profile sts get-caller-identity --no-cli-pager; or __handle_aws_credentials_error && return
        case 255
            set --erase AWS_PROFILE && return
    end
end
