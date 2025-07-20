# LibreChat Helm Charts on Red Hat OpenShift
<link rel="icon" href="https://raw.githubusercontent.com/maximilianoPizarro/botpress-helm-chart/main/favicon-152.ico" type="image/x-icon" >
<p align="left">
<img src="https://img.shields.io/badge/redhat-CC0000?style=for-the-badge&logo=redhat&logoColor=white" alt="Redhat">
<img src="https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white" alt="kubernetes">
<img src="https://img.shields.io/badge/helm-0db7ed?style=for-the-badge&logo=helm&logoColor=white" alt="Helm">
<img src="https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="shell">
<a href="https://www.linkedin.com/in/maximiliano-gregorio-pizarro-consultor-it"><img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="linkedin" /></a>
<a href="https://artifacthub.io/packages/search?repo=librechat-openshift"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/librechat" alt="Artifact Hub" /></a>
</p>

This Librechat Helm Chart provides an easy, light weight template to deploy LibreChat on Kubernetes. LibreChat is a free, open-source, and self-hosted AI chatbot that allows you to interact with various large language models (LLMs) and customize your AI experience. For more information, visit the official website: [https://www.librechat.ai/](https://www.librechat.ai/)
 
# Installation

## Environment Variables

### Chart Parameters

| Parameter | Description | Default |
|---|---|---|
| `replicaCount` | Number of LibreChat pods. | `1` |
| `image.repository` | Repository for the LibreChat container image. | `ghcr.io/danny-avila/librechat` |
| `image.tag` | Tag for the LibreChat container image. | The Chart's `AppVersion` |
| `route.enabled` | Enables an OpenShift Route for LibreChat. | `true` |
| `route.host` | The hostname for the OpenShift Route. **Must be overridden.** | `librechat.openshiftapps.com` |
| `ingress.enabled` | Enables a Kubernetes Ingress for LibreChat. | `false` |
| `global.librechat.existingSecretName` | Name of the K8s secret containing API keys and other credentials. | `librechat-credentials-env` |
| `librechat.configYamlContent` | Inline configuration for `librechat.yaml`. | (See `values.yaml`) |
| `librechat.imageVolume.enabled` | Enables a PersistentVolume for user-uploaded images. | `true` |
| `librechat.imageVolume.size` | Size of the persistent volume for images. | `10G` |
| `librechat-rag-api.enabled` | Deploys the LibreChat RAG API subchart. | `true` |
| `meilisearch.enabled` | Deploys the Meilisearch subchart for search functionality. | `true` |
| `postgresql.enabled` | Deploys the PostgreSQL (pgvector) subchart for vector storage. | `true` |
| `mongodb.enabled` | Deploys the MongoDB subchart for application data. | `true` |
| `resources` | Defines resource requests and limits (CPU, memory, GPU) for the LibreChat pod. | `{}` |

### Chart Parameters OpenID Connect

| Parameter | Description | Default |
|---|---|---|
| `librechat.openid.enabled` | Enables OpenID Connect authentication. | `false` |
| `librechat.openid.issuerURL` | OpenID Connect issuer URL. | `""` |
| `librechat.openid.clientID` | OpenID Connect client ID. | `""` |
| `librechat.openid.clientSecret` | OpenID Connect client secret. | `""` | 
| `librechat.openid.scope` | OpenID Connect scope. | `"openid profile email"` |

### LLM Model Endpoint Configuration Parameters

Add the endpoints to the different llm models in `librechat.openid.enabled`

```yaml
endpoints:
  custom:
    # OpenRouter.ai
    - name: "OpenRouter"
      apiKey: "${OPENAI_API_KEY}"
      baseURL: "https://localhost"
      models:
        default: ["ollama/llama-3-1-8b-instruct"]
        fetch: true
      titleConvo: true
      titleModel: "llama-3-1-8b-instruct"
      summarize: false
      summaryModel: "llama-3-1-8b-instruct"
      forcePrompt: false
      modelDisplayLabel: "OpenRouter"
      # OpenAI
    - name: "OpenAI"
      apiKey: "${OPENAI_API_KEY}"
      baseURL: "https://api.openai.com/v1"
      models:
        default: ["gpt-4o", "gpt-4-turbo", "gpt-3.5-turbo"]
        fetch: true
      titleConvo: true
      titleModel: "gpt-4o"
      summarize: false
      summaryModel: "gpt-3.5-turbo"
      forcePrompt: false
      modelDisplayLabel: "OpenAI"
    # Google Gemini
    - name: "Google"
      apiKey: "${GOOGLE_API_KEY}"
      baseURL: "https://generativelanguage.googleapis.com/v1beta"
      models:
        default: ["gemini-pro", "gemini-1.5-pro-latest"]
        fetch: true
      titleConvo: true
      titleModel: "gemini-pro"
      summarize: false
      summaryModel: "gemini-pro"
      forcePrompt: false
      modelDisplayLabel: "Google Gemini"
    # DeepSeek
    - name: "DeepSeek"
      apiKey: "${DEEPSEEK_API_KEY}"
      baseURL: "https://api.deepseek.com/v1"
      models:
        default: ["deepseek-chat", "deepseek-coder"]
        fetch: true
      titleConvo: true
      titleModel: "deepseek-chat"
      summarize: false
      summaryModel: "deepseek-chat"
      forcePrompt: false
      modelDisplayLabel: "DeepSeek"
    # Ollama (Local/Open Source)
    - name: "Ollama"
      apiKey: "ollama" # No API key needed for local Ollama
      baseURL: "http://localhost:11434/v1" # Adjust if Ollama is on a different host
      models:
        default: ["llama3", "mistral", "phi3"] # Example models, fetch from your Ollama instance
        fetch: true
      titleConvo: true
      titleModel: "llama3"
      summarize: false
      summaryModel: "llama3"
```      

### Resource Configuration (CPU, Memory and GPU)

You can specify resource requests and limits for LibreChat pods using the `resources` parameter. This is crucial to ensure stability and performance in a shared cluster.

The structure follows the Kubernetes container resource standard.

**Example usage in `values.yaml` for CPU and Memory:**

```yaml
resources:
  requests:
    cpu: "500m"
    memory: "1Gi"
  limits:
    cpu: "1"
    memory: "2Gi"
```

**To request GPUs (if the OpenShift cluster is configured with the NVIDIA GPU Operator):**

```yaml
resources:
  limits:
    nvidia.com/gpu: 1
```

### Configuring Ingress in Kubernetes

If you are deploying on a standard Kubernetes cluster (not OpenShift) or prefer to use an Ingress instead of an OpenShift Route, enable `ingress.enabled` and configure the relevant Ingress parameters (host, TLS, etc.) according to your needs.

**Example:**

```yaml
route:
  enabled: true
  host: "librechat.apps.mycluster.example.com"
```

**Example:**

```yaml
ingress:
  enabled: true
  className: "nginx" 
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
  hosts:
    - host: librechat.example.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: librechat-tls
      hosts:
        - librechat.example.com
```

### Secret librechat-credentials-env

In this Chart, LibreChat will only work with environment Variables. You can Specify Vars and Secret using an existing Secret (This can be generated by [creating an Env File and converting it to a Kubernetes Secret](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-secret-em-) `--from-env-file`)  

1. Generate Variables
Generate `CREDS_KEY`, `JWT_SECRET`, `JWT_REFRESH_SECRET`  and `MEILI_MASTER_KEY`  using `openssl rand -hex 32` and `CREDS_IV` using openssl rand -hex 16.
place them in a secret like this (If you want to change the secret name, remember to change it in your helm values):

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: librechat-credentials-env
  namespace: <librechat-chart-namespace>
type: Opaque
stringData:
  CREDS_KEY: <generated value>
  JWT_SECRET: <generated value>
  JWT_REFRESH_SECRET: <generated value>
  MEILI_MASTER_KEY: <generated value>
```

2. Add Credentials to the Secret
Dependant of the Model you want to use, [create Credentials in your provider](https://docs.librechat.ai/install/configuration/ai_setup.html) and add them to the Secret:

```yaml
apiVersion: v1
kind: Secret
. . . .

  OPENAI_API_KEY: <your secret value>
```

3. Apply the Secret to the Cluster

4. Fill out values.yaml and apply the Chart to the Cluster


### User Image Persistence

The persistent volume for user images (`librechat.imageVolume`) is essential if you expect users to upload images to LibreChat and want them to persist across pod restarts or updates. Adjust `librechat.imageVolume.size` according to the storage space you anticipate needing.

### Deployment of Optional Components

The `librechat-rag-api`, `meilisearch`, `postgresql`, and `mongodb` subcharts are enabled by default to provide a complete LibreChat experience. If you already have external instances of these services or do not need certain functionalities (e.g., RAG or search), you can disable the corresponding subcharts to reduce resource consumption.

**Example (disabling Meilisearch and PostgreSQL if you use external services):**

```yaml
librechat-rag-api:
  enabled: false
meilisearch:
  enabled: false
postgresql:
  enabled: false
```

# Deployment Strategy

## From Artifact Hub

1. Login with oc login (required cluster-admin scope)

2. Helm add Repo

```bash
helm repo add librechat-openshift https://maximilianopizarro.github.io/librechat/
```

3.  Helm install

```bash
helm install librechat librechat-openshift/librechat --version 1.8.10 -f values.yaml --create-namespace --namespace librechat
```

## From Helm Chart Source

1. Login with oc login (required cluster-admin scope)

2. Helm package

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm dependency build
helm package -u . -d charts
```

## Helm install

```bash
helm install librechat charts/librechat-0.1.0.tgz --namespace librechat --create-namespace --set route.host="librechat.apps.rosa.nhmnt-wdmof-wez.1742.p3.openshiftapps.com"
```

## Helm uninstall

```bash
helm uninstall librechat --namespace librechat
```