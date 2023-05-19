function aws_switch -a profile -d "Switch AWS profile and Kubernetes context"
    set -gx AWS_PROFILE $profile
    kubectl config unset current-context >/dev/null

    echo $GREEN"----------------| AWS Identity |----------------
    "$RESET_COLOR
    aws --profile $profile sts get-caller-identity --no-cli-pager

    set -l credentials_error_message $RED"Check your credentials"$RESET_COLOR

    switch $status
        case 253
            echo $credentials_error_message && return
        case 254
            type -q creds; or echo $credentials_error_message && return
            echo $GREEN"Refreshing credentials..."$RESET_COLOR && creds && sleep 5 && aws --profile $profile sts get-caller-identity --no-cli-pager; or echo $credentials_error_message && return
    end
    echo

    set -f cluster_name $(aws --profile $profile eks list-clusters --query clusters | jq -r .[] | fzf --prompt="Select a cluster: ")

    if test -n "$cluster_name"
        aws --profile $profile eks update-kubeconfig --name $cluster_name --region eu-central-1
        echo $GREEN"Connected to the cluster $cluster_name with the $profile AWS profile."$RESET_COLOR
    else
        echo $RED"No cluster was selected, so the kubernetes context was not updated."$RESET_COLOR
    end
end
