#!/bin/bash

POD=client

kubectl exec "$POD" -- sh -c 'for i in $(seq 1 50); do go test -bench . | grep ns/op | awk "{print \$3}"; done'
