#!/bin/bash

POD=client
CMD='go test -bench . | grep ns/op | awk "{print \$3}"'

for _ in $(seq 1 3); do
  if kubectl exec "$POD" -- pgrep -f 'go test -bench' >/dev/null 2>&1; then
    echo "bench is already running in pod $POD" >&2
    exit 1
  fi

  kubectl exec "$POD" -- sh -c "$CMD" &>/dev/null
  sleep 1
done

for _ in $(seq 1 10); do
  if kubectl exec "$POD" -- pgrep -f 'go test -bench' >/dev/null 2>&1; then
    echo "bench is already running in pod $POD" >&2
    exit 1
  fi

  kubectl exec "$POD" -- sh -c "$CMD"
  sleep 1
done
