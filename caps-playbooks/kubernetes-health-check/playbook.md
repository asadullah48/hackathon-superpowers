---
title: Kubernetes Health Check
description: Verify Kubernetes cluster health, resource availability, and readiness before deploying applications
version: 1.0.0
author: Asadullah (asadullah48)
allowed_tools:
  - bash_tool
---

# Kubernetes Health Check

## Purpose
Perform comprehensive health checks on Kubernetes clusters to ensure readiness for application deployments. Validates cluster connectivity, resource availability, and essential components.

## Prerequisites
- kubectl installed and configured
- Access to Kubernetes cluster (Minikube, cloud cluster, etc.)
- Sufficient permissions to query cluster resources

## Instructions

### Step 1: Verify Cluster Connectivity

Check if kubectl can connect to the cluster:
```bash
# Check cluster info
kubectl cluster-info

# Verify current context
kubectl config current-context

# List all nodes
kubectl get nodes
```

**Expected Results:**
- Cluster-info shows running control plane
- At least one node in `Ready` state
- No connection errors

### Step 2: Check Node Resources

Verify sufficient resources are available:
```bash
# Get detailed node information
kubectl describe nodes

# Check resource usage (requires metrics-server)
kubectl top nodes
```

**Minimum Requirements:**
- CPU: >2 cores available
- Memory: >4GB available
- Disk: >20GB available
- Status: All nodes `Ready`

### Step 3: Verify System Components

Ensure essential Kubernetes components are running:
```bash
# Check system pods
kubectl get pods -n kube-system

# Check critical components
kubectl get pods -n kube-system | grep -E 'coredns|etcd|kube-apiserver|kube-controller|kube-scheduler'
```

**All pods should be:**
- Status: `Running`
- Restarts: <3 (some restarts normal during startup)
- Ready: All containers ready (e.g., 1/1, 2/2)

### Step 4: Validate Storage

Verify storage classes are available:
```bash
# List storage classes
kubectl get storageclass

# Check for default storage class
kubectl get storageclass -o json | jq -r '.items[] | select(.metadata.annotations."storageclass.kubernetes.io/is-default-class"=="true") | .metadata.name'
```

**Requirements:**
- At least one storage class exists
- One marked as `(default)`

### Step 5: Test Networking

Validate cluster networking:
```bash
# Check kube-proxy
kubectl get pods -n kube-system | grep kube-proxy

# Verify DNS resolution
kubectl run -it --rm debug --image=busybox --restart=Never -- nslookup kubernetes.default

# Check CNI plugin
kubectl get pods -n kube-system | grep -E 'calico|flannel|weave|cilium'
```

**Networking is healthy when:**
- kube-proxy pods running
- DNS lookups succeed
- CNI plugin pods running

### Step 6: Generate Health Report

Create comprehensive report with status indicators for cluster readiness.

### Step 7: Interpret Results

**✅ Healthy Cluster:**
- All nodes `Ready`
- System pods `Running`
- kubectl responds without errors
- Storage class exists
- Network pods running
- Resources meet minimums

**⚠️ Warning Signs:**
- Nodes `NotReady` or `Unknown`
- Pods in `CrashLoopBackOff`
- High resource utilization (>90%)
- No default storage class
- DNS resolution failures

**🚨 Critical Issues:**
- Cannot connect to cluster
- No nodes available
- etcd or API server down
- Zero storage classes
- Network pods failing

## Validation

Pre-deployment checks passed when:
- [ ] kubectl connects successfully
- [ ] All nodes are Ready
- [ ] System pods running (coredns, etcd, kube-apiserver)
- [ ] Default storage class exists
- [ ] DNS resolution works
- [ ] Resources meet requirements (2 CPU, 4GB RAM)
- [ ] No critical events in last 15 minutes
- [ ] Health check script exits with code 0

## Troubleshooting

**Problem**: Cannot connect to cluster
```bash
# Check context
kubectl config get-contexts
kubectl config use-context <correct-context>

# For Minikube
minikube status
minikube start
```

**Problem**: Nodes NotReady
```bash
# Check node details
kubectl describe node <node-name>

# Restart Minikube with more resources
minikube stop
minikube start --cpus=4 --memory=8192
```

**Problem**: No storage class
```bash
# For Minikube
minikube addons enable storage-provisioner
kubectl get storageclass
```

## Best Practices

1. **Always Check First**: Run health checks before any deployment
2. **Save Reports**: Keep health reports for troubleshooting
3. **Automate**: Add to CI/CD pipelines
4. **Monitor Trends**: Track resource usage over time
5. **Document Baseline**: Know what "healthy" looks like

## Related Playbooks
- **kafka-k8s-setup**: Deploy Kafka after health verification
- **postgres-k8s-setup**: Deploy PostgreSQL after health check
- **helm-chart-deployer**: Generic deployment with health checks
