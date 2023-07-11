function sc --description "Switch Kubernetes context"
    test "$AWS_PROFILE" = "" && echo $RED"No AWS profile set"$RESET_COLOR && return

    set --function cluster_name $(aws --profile $AWS_PROFILE eks list-clusters --query clusters | jq --raw-output .[] | fzf --prompt="Select a cluster: ")

    if test -n "$cluster_name"
        aws eks update-kubeconfig --name $cluster_name --region eu-central-1
        echo $GREEN"Connected to the cluster $cluster_name with the $AWS_PROFILE AWS profile."$RESET_COLOR
    else
        echo $RED"No cluster was selected, so the Kubernetes context was not updated."$RESET_COLOR
    end
end
