function eks_switch --argument-names profile --description "Connect to an EKS-managed Kubernetes cluster in the given AWS account"
    set --global --export AWS_PROFILE $profile
    kubectl config unset current-context >/dev/null

    echo $GREEN"----------------| AWS Identity |----------------
    "$RESET_COLOR
    aws --profile $profile sts get-caller-identity --no-cli-pager

    switch $status
        case 253
            handle_aws_credentials_error && return
        case 254
            type --query creds; or handle_aws_credentials_error && return
            echo $GREEN"Refreshing credentials..."$RESET_COLOR && creds && sleep 5 && aws --profile $profile sts get-caller-identity --no-cli-pager; or handle_aws_credentials_error && return
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
