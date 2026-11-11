function us --description "Unset current AWS profile and Kubernetes context"
    set --query AWS_PROFILE && set --erase AWS_PROFILE && echo $GREEN"Unset AWS profile"
    set --erase AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWSUME_PROFILE
    kubecolor config unset current-context
end
