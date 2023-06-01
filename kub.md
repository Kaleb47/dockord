Creating a Kubernetes deployment configuration for the scenario you've described would involve multiple parts. You'd have to define configurations for the individual Dockerfiles, then create Kubernetes YAML configuration files for each deployment, as well as services and possibly PersistentVolumeClaims and Ingress.

For simplicity, let's assume that you have Docker images for Bitcoin Core, Ordinal Wallet and the Generative AI already. Here's a basic setup for your deployments and services.

**Note:** This is a simplified example. Depending on your actual environment and requirements, you might need to modify these configurations, or use other Kubernetes objects (like StatefulSets, PersistentVolumes, PersistentVolumeClaims, ConfigMaps, Secrets, etc.).

**1. Bitcoin Core and Ordinal Wallet Deployment**

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: bitcoin-ordinal-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: bitcoin-ordinal
  template:
    metadata:
      labels:
        app: bitcoin-ordinal
    spec:
      containers:
      - name: bitcoin-core
        image: <your-bitcoin-core-image>
        ports:
        - containerPort: 8332
      - name: ordinal-wallet
        image: <your-ordinal-wallet-image>
        ports:
        - containerPort: <wallet-port>
---
apiVersion: v1
kind: Service
metadata:
  name: bitcoin-ordinal-service
spec:
  selector:
    app: bitcoin-ordinal
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8332
    - protocol: TCP
      port: 81
      targetPort: <wallet-port>
```

**2. Generative AI Deployment**

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: generative-ai-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: generative-ai
  template:
    metadata:
      labels:
        app: generative-ai
    spec:
      containers:
      - name: generative-ai
        image: <your-generative-ai-image>
        ports:
        - containerPort: <generative-ai-port>
---
apiVersion: v1
kind: Service
metadata:
  name: generative-ai-service
spec:
  selector:
    app: generative-ai
  ports:
    - protocol: TCP
      port: 82
      targetPort: <generative-ai-port>
```

Replace `<your-bitcoin-core-image>`, `<your-ordinal-wallet-image>`, `<wallet-port>`, `<your-generative-ai-image>`, and `<generative-ai-port>` with the correct values for your images and ports.

You'd create these files, and then use `kubectl apply -f <file.yaml>` to create these deployments and services in your Kubernetes cluster. Please note that this is an example and might need to be adapted to your environment. 

Lastly, don't forget about security and robustness. Kubernetes configurations can get complex, especially when dealing with networking, storage, and multi-container pods. Always thoroughly test your configurations in a controlled environment before deploying to production.
