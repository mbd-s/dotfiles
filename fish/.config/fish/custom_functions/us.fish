function us --description "Unset current AWS profile and Kubernetes context"
    set --query AWS_PROFILE && set --erase AWS_PROFILE && echo $GREEN"Unset AWS profile"
    kubecolor config unset current-context
end
