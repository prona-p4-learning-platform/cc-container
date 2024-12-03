# ProNA cc-container
This _cc-container_ provides a containerized environment for running different cloud computing tools and utilities.

The following tools are included in the container:
- [git](https://git-scm.com/)
- [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/)
- [terraform](https://www.terraform.io/)
- [helm](https://helm.sh/)
- [k9s](https://k9scli.io/)

```bash
# Build the container
docker build -t cc-container .

# Run the container locally
docker run -it --rm cc-container

# Run the container with your local kubeconfig mounted
docker run -it --rm \
  -v ~/.kube/config:/root/.kube/config:ro \
  cc-container
```