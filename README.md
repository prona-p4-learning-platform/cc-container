# ProNA cc-container
This _cc-container_ provides a containerized environment for running different cloud computing tools and utilities.

The following tools are included in the container:
- [git](https://git-scm.com/)
- [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/)
- [helm](https://helm.sh/)
- [k9s](https://k9scli.io/)

```bash
# Build the container
docker build -t cc-container .

# Run the container locally
docker run -it --rm cc-container

# Run the container with your local kubeconfig as a volume
docker run -it --rm -d --name cc-container \
  -v ~/.kube/config:/home/p4/.kube/config:ro \
  cc-container

# Run the container with your local kubeconfig as environment variable (base64 encoded)
docker run -it --rm -d --name cc-container \
  -e KUBECONFIG_BASE64=$(cat ~/.kube/config | base64 -w 0) \
  cc-container

# SSH into the container
docker exec -it cc-container /bin/bash
```