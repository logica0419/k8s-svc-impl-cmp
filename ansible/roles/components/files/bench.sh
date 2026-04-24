#!/bin/bash

POD=client
CMD='go test -bench . | grep ns/op | awk "{print \$3}"'

while sudo kubectl get pods -A 2>/dev/null | grep -q 'ContainerCreating'; do
  echo 'waiting for ContainerCreating pod to finish...'
  sleep 1
done

for _ in $(seq 1 3); do
  if sudo kubectl exec "$POD" -- pgrep -f 'go test -bench' >/dev/null 2>&1; then
    echo "bench is already running in pod $POD" >&2
    exit 1
  fi

  sudo kubectl exec "$POD" -- sh -c "$CMD" &>/dev/null
  sleep 1
done

for _ in $(seq 1 5); do
  if sudo kubectl exec "$POD" -- pgrep -f 'go test -bench' >/dev/null 2>&1; then
    echo "bench is already running in pod $POD" >&2
    exit 1
  fi

  sudo kubectl exec "$POD" -- sh -c "$CMD"
  sleep 1
done
