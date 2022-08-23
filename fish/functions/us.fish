function us -d "Unset current AWS profile and Kubernetes context"
    set -gx AWS_PROFILE && kubectl config unset current-context >/dev/null
end
