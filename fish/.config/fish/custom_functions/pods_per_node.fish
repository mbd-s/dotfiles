function pods_per_node --description 'Watch pods in all namespaces and count them per node'
    watch -n 10 "kubectl get pods --all-namespaces --output jsonpath='{.items[*].spec.nodeName}' | tr ' ' '\n' | sort | uniq --count | sort --numeric-sort"
end
