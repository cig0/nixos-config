# Don't remove this line! programs.zsh.shellInit

{ ... }:

let
  # Tools and concepts aligned with the cloud-native movement, including orchestration, containers, and resource management.
  functions = ''
    # Kubernetes
      kla() {
        # List all resources
        kubectl api-resources --verbs=list --namespaced -o name | xargs -t -n 1 kubectl get --show-kind --ignore-not-found "$@"
      }

      kla_events() {
        # List all events
        for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
          echo "Resource:" $i

          if [ -z "$1" ]
          then
              kubectl get --ignore-not-found $i
          else
              kubectl -n $1 get --ignore-not-found $i
          fi
        done
      }

      kdecrypts() {
        # Secret decrypt
        # $1 = secret name
        # $2 = .data.{OBJECT}
        kubectl get secret "$1" -o jsonpath="{.data.$2}" | base64 --decode
      }

    # Podman
    prminone() {
      podman rmi --force $(podman images | grep -i '<none>' | awk -F' ' '{ print $3 }')
    }
  '';

in { functions = functions; }