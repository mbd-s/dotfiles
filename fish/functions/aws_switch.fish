function aws_switch -a environment
    set -gx AWS_PROFILE $environment

    kubectl config unset current-context > /dev/null

    echo $GREEN"----------------| AWS Identity |----------------
    "$RESET_COLOR
    aws sts get-caller-identity --no-cli-pager

    set -l credentials_error_message $RED"Check your credentials"$RESET_COLOR

    switch $status
        case 253
            echo $credentials_error_message && return
        case 254
            type -q creds; or echo $credentials_error_message && return
            echo $GREEN"Refreshing credentials..."$RESET_COLOR && creds && sleep 8 && aws sts get-caller-identity --no-cli-pager; or echo $credentials_error_message && return
    end
    echo

    set -f cluster_name $(aws eks list-clusters --query clusters | jq -r .[] | fzf --prompt="Select a cluster: ")

    if test -n "$cluster_name"
        aws eks update-kubeconfig --name $cluster_name --region eu-central-1
        echo $GREEN"Connected to the cluster $cluster_name in the $environment environment."$RESET_COLOR
    else
        echo $RED"No valid cluster was selected, so kubeconfig was not updated."$RESET_COLOR
    end
end
