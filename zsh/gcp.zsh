
# alias grafana-pod-shell="\
# (\
# export POD_NAME=$(\
# kubectl get pods --namespace monitoring -l "app.kubernetes.io/name=grafana" -o jsonpath="{.items[0].metadata.name}") \
# && \
# echo ${POD_NAME} && \
# kubectl exec -it ${POD_NAME} --namespace monitoring -- bash\
# )"

grafana-pod () {

  echo $(kubectl get pods --namespace monitoring -l "app.kubernetes.io/name=grafana" -o \
                            jsonpath="{.items[0].metadata.name}")

}
grafana-shell () {

  export POD_NAME=$(grafana-pod)

  if [ -z ${POD_NAME} ]; then
    echo POD_NAME must be provided
  else
    kubectl exec -it ${POD_NAME} --namespace monitoring -- bash
  fi
}

grafana-logs () {
  kubectl logs -n monitoring $(grafana-pod)
}
