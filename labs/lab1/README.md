## Cloud Computing - Kubernetes - Lab 1

In this first lab, you will learn how to work with Kubernetes to deploy your first fault-tolerant and scalable Nginx web server.

### kubectl

[`kubectl`](https://kubernetes.io/docs/reference/kubectl/) is the command-line tool for interacting with Kubernetes clusters. It allows you to deploy applications, inspect and manage cluster resources, and view logs.

#### Deploying the Nginx Application

1. Inspect the provided `nginx.yaml` file to understand the Deployment and Service definitions.
2. Apply the configuration to your cluster:

    ```bash
    kubectl apply -f nginx.yaml
    ```

3. Verify the deployment status:

    ```bash
    kubectl get pods
    kubectl get svc
    ```

4. Wait 2-5 minutes for the LoadBalancer to be provisioned.
5. Retrieve the external IP address of the `nginx-service`:

    ```bash
    kubectl get svc nginx-service
    ```

6. Open the external IP address in your browser to verify the Nginx welcome page is displayed.

### k9s

[`k9s`](https://k9scli.io/) is a terminal-based UI to interact with Kubernetes clusters, providing real-time resource monitoring and management.

#### Explore Resources with k9s

1. Start `k9s`:

    ```bash
    k9s
    ```

2. Inspect the `nginx-deployment` and `nginx-service` resources.

3. Attempt to delete one or more Nginx pods to observe how Kubernetes automatically restarts new ones.

4. Eplore other resources in your k8s namespace, e.g., logs of containers, scale the replicaset, build new deployments and enter a shell in deployed pods etc. You can find examples on the k9s webpage and GitHub repo.

5. Exit `k9s` using `:q` or `Ctrl+C`.

### Cleanup the deployment

Delete your deployment and service contained in nginx.yaml:

    ```bash
    kubectl delete -f nginx.yaml
    ```

or use `k9s`, navigate to deployments `:deployments` and delete the deployment and afterwards the service in `:service`.
