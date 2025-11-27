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
| `global.librechat.existingSecretName` | Name of the K8s secret containing API keys and other credentials. | `librechat-librechat-librechat-configenv` |
| `librechat.configYamlContent` | Inline configuration for `librechat.yaml`. | (See `values.yaml`) |
| `librechat.imageVolume.enabled` | Enables a PersistentVolume for user-uploaded images. | `true` |
| `librechat.imageVolume.size` | Size of the persistent volume for images. | `10G` |
| `librechat-rag-api.enabled` | Deploys the LibreChat RAG API subchart. | `true` |
| `meilisearch.enabled` | Deploys the Meilisearch subchart for search functionality. | `true` |
| `postgresql.enabled` | Deploys the PostgreSQL (pgvector) subchart for vector storage. | `true` |
| `mongodb.enabled` | Deploys the MongoDB subchart for application data. | `true` |
| `resources` | Defines resource requests and limits (CPU, memory, GPU) for the LibreChat pod. | `{}` |

### Environment Variables Configuration

Environment variables are configured in `librechat.configEnv` section of `values.yaml`. These variables are passed to the LibreChat container and control various aspects of the application behavior.

#### General Configuration Variables

| Parameter | Description | Required | Example |
|---|---|---|---|
| `OPENAI_API_KEY` | API key for OpenAI services. Can be used for multiple providers. | Yes | Base64 encoded value |
| `NODE_TLS_REJECT_UNAUTHORIZED` | Disable TLS certificate validation (for development only). | No | `'0'` or `'1'` |
| `CREDS_IV` | Initialization vector for encryption. Generate using `openssl rand -hex 16`. | Yes | `118a16ffe26a8712d0adb5b3cf8229ca` |
| `CREDS_KEY` | Encryption key for credentials. Generate using `openssl rand -hex 32`. | Yes | `99f12ba0ea72257aa78df8e99c9be801716a7e16fe77e7510a914112528aa05c` |
| `JWT_SECRET` | Secret key for JWT token signing. Generate using `openssl rand -hex 32`. | Yes | `83096493d70e22561f84191c24f459d72e9b41f4c8657fe43aae8cb9b0fe1fa4` |
| `JWT_REFRESH_SECRET` | Secret key for JWT refresh tokens. Generate using `openssl rand -hex 32`. | Yes | `8a447c316c171f5df8e304c085187b6d10e4eeef5174137d4ad4d2cdd956f5e7` |
| `DEBUG_PLUGINS` | Enable debug mode for plugins. | No | `'true'` or `'false'` |
| `PLUGIN_MODELS` | Comma-separated list of models that support plugins. | No | `gpt-4,gpt-3.5-turbo,llama-3-1-8b-instruct` |
| `DOMAIN_SERVER` | Server domain URL for LibreChat. | Yes | `http://0.0.0.0:3080` or `https://librechat.example.com` |

#### Authentication and Registration Variables

| Parameter | Description | Required | Example |
|---|---|---|---|
| `ALLOW_EMAIL_LOGIN` | Enable email-based login. | No | `'true'` or `'false'` |
| `ALLOW_REGISTRATION` | Allow new user registration. | No | `'true'` or `'false'` |
| `ALLOW_SOCIAL_LOGIN` | Enable social login providers. | No | `'true'` or `'false'` |

#### OpenID Connect Configuration Variables

OpenID Connect authentication is configured through environment variables in `librechat.configEnv`. These variables enable integration with identity providers like Red Hat SSO, Keycloak, or other OIDC-compliant providers.

| Parameter | Description | Required | Example |
|---|---|---|---|
| `OPENID_LOGIN_ENABLED` | Enable OpenID Connect authentication. | No | `'true'` or `'false'` |
| `OPENID_ISSUER` | OpenID Connect issuer URL (authority URL). | Yes (if OpenID enabled) | `https://auth.redhat.com/realms/librechat` |
| `OPENID_CLIENT_ID` | OpenID Connect client ID registered with the identity provider. | Yes (if OpenID enabled) | `librechat-client` |
| `OPENID_CLIENT_SECRET` | OpenID Connect client secret from the identity provider. | Yes (if OpenID enabled) | `your-client-secret` |
| `OPENID_CALLBACK_URL` | Callback URL path for OAuth redirect. | Yes (if OpenID enabled) | `/oauth/openid/callback` |
| `OPENID_SCOPE` | OpenID Connect scopes to request. | No | `openid profile email` |
| `OPENID_SESSION_SECRET` | Secret for encrypting session data. | Yes (if OpenID enabled) | `your-session-secret` |
| `OPENID_USE_END_SESSION_ENDPOINT` | Use OpenID Connect end session endpoint for logout. | No | `'true'` or `'false'` |
| `OPENID_REQUIRED_ROLE_TOKEN_KIND` | Token type to check for roles (access or id_token). | No | `access` |
| `OPENID_REQUIRED_ROLE_PARAMETER_PATH` | JSON path to roles in the token. | No | `realm_access.roles` |
| `SOCIAL_LOGIN_ENABLED` | Enable social login integration. | No | `'true'` or `'false'` |

**Example OpenID Connect Configuration:**

```yaml
librechat:
  configEnv:
    OPENID_LOGIN_ENABLED: 'true'
    OPENID_ISSUER: 'https://auth.redhat.com/realms/librechat'
    OPENID_CLIENT_ID: 'librechat-client'
    OPENID_CLIENT_SECRET: 'your-client-secret'
    OPENID_CALLBACK_URL: /oauth/openid/callback
    OPENID_SCOPE: openid profile email
    OPENID_SESSION_SECRET: your-session-secret
    OPENID_USE_END_SESSION_ENDPOINT: 'true'
    OPENID_REQUIRED_ROLE_TOKEN_KIND: access
    OPENID_REQUIRED_ROLE_PARAMETER_PATH: realm_access.roles
    SOCIAL_LOGIN_ENABLED: 'true'
```

### LLM Model Endpoint Configuration

**Important:** Endpoint configuration for LLM models is done in the `librechat.configYamlContent.endpoints` section, not through environment variables. The `configYamlContent` allows you to configure custom endpoints, model settings, file upload limits, rate limits, and other advanced features.

The endpoints section should be configured within `librechat.configYamlContent` in your `values.yaml` file:

```yaml
librechat:
  configYamlContent: |
    version: 1.0.3
    cache: true
    endpoints:
      assistants:
        disableBuilder: false
        pollIntervalMs: 750
        timeoutMs: 180000
        supportedIds: ["asst_supportedAssistantId1", "asst_supportedAssistantId2"]
      custom:
        # Ollama (Local/Open Source)
        - name: "Ollama"
          apiKey: "${OPENAI_API_KEY}"
          baseURL: "http://librechat-ollama:11434/v1"
          models:
            default: ["llama2"]
            fetch: true
          titleConvo: true
          titleModel: "llama2"
          summarize: false
          summaryModel: "llama2"
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
```

**Endpoint Configuration Parameters:**

| Parameter | Description | Required | Example |
|---|---|---|---|
| `name` | Display name for the endpoint. | Yes | `"Ollama"`, `"OpenAI"` |
| `apiKey` | API key for the endpoint. Can reference environment variables using `${VAR_NAME}`. | Yes | `"${OPENAI_API_KEY}"` |
| `baseURL` | Base URL for the API endpoint. | Yes | `"http://librechat-ollama:11434/v1"` |
| `models.default` | Array of default model names to use. | Yes | `["llama2"]`, `["gpt-4o", "gpt-3.5-turbo"]` |
| `models.fetch` | Whether to fetch available models from the API. | No | `true` or `false` |
| `titleConvo` | Enable automatic conversation title generation. | No | `true` or `false` |
| `titleModel` | Model to use for generating conversation titles. | No | `"llama2"`, `"gpt-4o"` |
| `summarize` | Enable conversation summarization. | No | `true` or `false` |
| `summaryModel` | Model to use for summarization. | No | `"llama2"`, `"gpt-3.5-turbo"` |

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

### Secret librechat-librechat-librechat-configenv

In this Chart, LibreChat will only work with environment Variables. You can Specify Vars and Secret using an existing Secret (This can be generated by [creating an Env File and converting it to a Kubernetes Secret](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-secret-em-) `--from-env-file`)  

1. Generate Variables
Generate `CREDS_KEY`, `JWT_SECRET`, `JWT_REFRESH_SECRET`  and `MEILI_MASTER_KEY`  using `openssl rand -hex 32` and `CREDS_IV` using openssl rand -hex 16.
place them in a secret like this (If you want to change the secret name, remember to change it in your helm values):

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: librechat-librechat-librechat-configenv
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
helm install librechat librechat-openshift/librechat --version 1.8.14 -f values.yaml --create-namespace --namespace librechat
```

## From Helm Chart Source

1. Login with oc login (required cluster-admin scope)

2. Helm package

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm dependency build
helm package -u . -d docs
```

## Helm install

```bash
helm install librechat docs/librechat-1.8.14.tgz --namespace librechat --create-namespace --set route.host="librechat.apps.rosa.xcr72-yro5x-2iv.vjzc.p3.openshiftapps.com/dashboards"
```

## Helm uninstall

```bash
helm uninstall librechat --namespace librechat
```

# Deployment Strategy ArgoCD


```bash
apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: librechat
  namespace: openshift-gitops
spec:
  generators:
    - list:
        elements:
          - name: librechat
            namespace: librechat
            path: librechat
  template:
    metadata:
      name: '{{name}}'
    spec:
      project: default
      source:
        repoURL: 'https://github.com/maximilianoPizarro/ia-developement-gitops.git'
        targetRevision: main
        path: '{{path}}'
        helm:
          valueFiles:
            - helm-values.yaml
      destination:
        server: 'https://kubernetes.default.svc'
        namespace: '{{namespace}}'
      syncPolicy:
        automated:
          selfHeal: true
          prune: true
        syncOptions:
          - CreateNamespace=true
          - PruneLast=true
```
Visite this page for more information 
https://maximilianopizarro.github.io/ia-developement-gitops/