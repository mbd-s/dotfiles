function us -d "Unset AWS profile and current k8s context"
    set -gx AWS_PROFILE && kubectl config unset current-context > /dev/null
end

