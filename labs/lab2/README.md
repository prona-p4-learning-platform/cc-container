## Cloud Computing - Kubernetes - Lab 2

In this lab, you will learn how to deploy and use Grafana for monitoring and observability in Kubernetes clusters. You'll deploy sample applications and create dashboards to visualize their metrics.

### Prerequisites

- Completed Lab 1
- Access to a Kubernetes cluster
- `kubectl` and `helm` installed (already installed by instructor)
- Shared Prometheus instance (already deployed by instructor)

### Lab Overview

You will:
1. Deploy Grafana using Helm with custom configuration
2. Deploy two sample applications for monitoring
3. Configure Grafana to connect to the shared Prometheus data source
4. Create and explore dashboards to monitor your applications
5. Learn to interpret monitoring data and alerts

### Step 1: Add Grafana Helm Repository

First, add the official Grafana Helm repository:

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

### Step 2: Deploy Sample Applications

Deploy two test applications that will generate metrics for monitoring:

```bash
kubectl apply -f sample-apps.yaml
```

Verify the deployments:

```bash
kubectl get pods
kubectl get svc
```

### Step 3: Deploy Grafana with Custom Configuration

Deploy Grafana using the custom values file:

```bash
helm install my-grafana grafana/grafana -f grafana-values.yaml
```

Wait for Grafana to be ready:

```bash
kubectl get pods -l app.kubernetes.io/name=grafana
```

### Step 4: Access Grafana

Get the Grafana service external IP:

```bash
kubectl get svc my-grafana
```

Get the admin password:

```bash
kubectl get secret my-grafana -o jsonpath="{.data.admin-password}" | base64 --decode
```

Access Grafana in your browser using the external IP. Login with:
- Username: `admin`
- Password: (from the command above)

### Step 5: Configure Prometheus Data Source

1. In Grafana, go to **Configuration** → **Data Sources**
2. Click **Add data source**
3. Select **Prometheus**
4. Set the URL to: `http://prometheus-server.<prometheus_namespace>.svc.cluster.local`
5. Click **Save & Test**

### Step 6: Import and Create Dashboards

#### Import Pre-built Dashboard

1. Go to **Dashboards** → **Import**
2. Use dashboard ID `6417` (Kubernetes Cluster Monitoring)
3. Select your Prometheus data source
4. Click **Import**

#### Create Custom Dashboard

1. Create a new dashboard
2. Add panels to monitor:
   - CPU usage of your sample applications
   - Memory usage
   - Network traffic
   - Pod restart counts

### Step 7: Explore Monitoring Data

Use your dashboards to:
1. Monitor the performance of your sample applications
2. Observe metrics in real-time
3. Scale your applications and watch the metrics change:

```bash
kubectl scale deployment sample-app-1 --replicas=5
kubectl scale deployment sample-app-2 --replicas=2
```

### Step 8: Generate Load and Observe

Generate some load on your applications to see metrics change:

```bash
# Get the LoadBalancer IP of sample-app-1
kubectl get svc sample-app-1-service

# Generate load (replace <EXTERNAL-IP> with actual IP)
for i in {1..100}; do curl http://<EXTERNAL-IP>/; done
```

Watch how the metrics change in your Grafana dashboards.

### Useful kubectl Commands for Monitoring

```bash
# View resource usage
kubectl top pods
kubectl top nodes

# Check application logs
kubectl logs -l app=sample-app-1
kubectl logs -l app=sample-app-2

# Describe resources for troubleshooting
kubectl describe pod <pod-name>
```

### Understanding Key Metrics

- **CPU Usage**: Shows computational load
- **Memory Usage**: Shows memory consumption
- **Network I/O**: Shows network traffic patterns
- **Pod Restarts**: Indicates application stability
- **Request Rate**: Shows application traffic

### Cleanup

When finished, clean up your resources:

```bash
# Delete sample applications
kubectl delete -f sample-apps.yaml

# Delete Grafana
helm uninstall my-grafana
```

### Additional Resources

- [Grafana Documentation](https://grafana.com/docs/)
- [Prometheus Metrics](https://prometheus.io/docs/concepts/metric_types/)
- [Kubernetes Monitoring Best Practices](https://kubernetes.io/docs/concepts/cluster-administration/monitoring/)