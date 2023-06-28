function us -d "Unset current AWS profile and Kubernetes context"
    set -q AWS_PROFILE && set -e AWS_PROFILE && echo $GREEN"Unset AWS profile"
    kubecolor config unset current-context
end
