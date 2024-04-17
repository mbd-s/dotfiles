function eks_switch --argument-names profile --description "Connect to an EKS-managed Kubernetes cluster in the given AWS account"
    function __handle_aws_credentials_error --description "Helper function to catch AWS credentials errors"
        echo $RED"Check your credentials"$RESET_COLOR
        set --erase AWS_PROFILE
        functions --erase __handle_aws_credentials_error
    end

    set --global --export AWS_PROFILE $profile
    kubectl config unset current-context >/dev/null

    echo $GREEN"----------------| AWS Identity |----------------
    "$RESET_COLOR
    aws --profile $profile sts get-caller-identity --no-cli-pager

    switch $status
        case 253
            __handle_aws_credentials_error && return
        case 254
            type --query creds; or __handle_aws_credentials_error && return
            echo $GREEN"Refreshing credentials..."$RESET_COLOR && creds && sleep 5 && aws --profile $profile sts get-caller-identity --no-cli-pager; or __handle_aws_credentials_error && return
        case 255
            set --erase AWS_PROFILE && return
    end
    echo

    set --function cluster_name $(aws --profile $profile eks list-clusters --query clusters | jq --raw-output .[] | fzf --prompt="Select a cluster: ")

    if test -n "$cluster_name"
        aws --profile $profile eks update-kubeconfig --name $cluster_name --region eu-central-1
        echo && echo $GREEN"Connected to the $cluster_name cluster with the $profile AWS profile."$RESET_COLOR
    else
        echo $RED"No cluster was selected, so the Kubernetes context was not updated."$RESET_COLOR
    end
end
