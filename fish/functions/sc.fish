function sc
    set -f cluster_name $(aws eks list-clusters --query clusters | jq -r .[] | fzf --prompt="Select a cluster: ")

    if test -n "$cluster_name"
        aws eks update-kubeconfig --name $cluster_name --region eu-central-1
        echo $GREEN"Connected to the cluster $cluster_name in the $environment environment."$RESET_COLOR
    else
        echo $RED"No valid cluster was selected, so kubeconfig was not updated."$RESET_COLOR
    end
end
