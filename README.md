# LibreChat Helm Chart — Multi-Model AI Chat for OpenShift

<p align="left">
<img src="https://img.shields.io/badge/redhat-CC0000?style=for-the-badge&logo=redhat&logoColor=white" alt="Redhat">
<img src="https://img.shields.io/badge/openshift-EE0000?style=for-the-badge&logo=redhatopenshift&logoColor=white" alt="OpenShift">
<img src="https://img.shields.io/badge/helm-0db7ed?style=for-the-badge&logo=helm&logoColor=white" alt="Helm">
<a href="https://artifacthub.io/packages/search?repo=librechat"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/librechat" alt="Artifact Hub" /></a>
</p>

> **Documentation & Screenshots**: [maximilianopizarro.github.io/librechat](https://maximilianopizarro.github.io/librechat/)

A community Helm chart that deploys [LibreChat](https://www.librechat.ai/) as a unified chat interface for your existing inference services on **Red Hat OpenShift** — Granite, Qwen, Nemotron, or any vLLM model — with Red Hat UBI 9 certified images and Developer Sandbox support.

**This Helm chart is designed exclusively for Red Hat OpenShift.**

## Key Features (v1.8.16)

- **Red Hat UBI 9 Container Image** — 3-stage build on `ubi9/nodejs-20-minimal` pushed to `quay.io/maximilianopizarro/librechat`
- **LiteLLM Proxy Integration** — Built-in OpenAI-compatible proxy for vLLM/KServe InferenceServices
- **Developer Sandbox Ready** — Pre-configured for restricted SCCs, random UIDs, `gp3-csi` storage
- **OpenShift AI Models** — Connects to IBM Granite 3.1 8B, Qwen 3 8B, NVIDIA Nemotron Nano 9B v2
- **Chart Verifier Compliant** — CI pipeline validates with Red Hat community chart-verifier
- **Full Stack** — MongoDB, PostgreSQL (pgvector), Meilisearch, RAG API, optional Ollama

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    OpenShift Cluster                         │
│                                                             │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐  │
│  │   LibreChat   │───▶│   LiteLLM    │───▶│  vLLM/KServe │  │
│  │   (UBI 9)     │    │   Proxy      │    │  Models      │  │
│  │   Port 3080   │    │   Port 4000  │    │  Port 8443   │  │
│  └──────┬───────┘    └──────────────┘    └──────────────┘  │
│         │                                                   │
│    ┌────┴────┐  ┌───────────┐  ┌────────────┐              │
│    │ MongoDB  │  │ PostgreSQL│  │ Meilisearch│              │
│    │  27017   │  │ (pgvector)│  │   7700     │              │
│    └─────────┘  │   5432    │  └────────────┘              │
│                 └─────┬─────┘                               │
│                       │                                     │
│                 ┌─────┴─────┐                               │
│                 │  RAG API   │                               │
│                 │   8000     │                               │
│                 └───────────┘                               │
└─────────────────────────────────────────────────────────────┘
```

## Quick Start

### Install on OpenShift

```bash
helm repo add librechat https://maximilianopizarro.github.io/librechat/
helm repo update
helm install librechat librechat/librechat
```

### Install on Developer Sandbox

```bash
oc login --token=<your-token> --server=https://api.<cluster>.openshiftapps.com:6443

helm repo add librechat https://maximilianopizarro.github.io/librechat/
helm install librechat librechat/librechat -f values-sandbox.yaml
```

The sandbox deployment uses `useServiceAccountToken: true` by default, which auto-mounts the pod's ServiceAccount token for authenticating to the shared AI models (Granite, Qwen, Nemotron) via LiteLLM proxy. No manual token management required.

### Install from Source

```bash
git clone https://github.com/maximilianoPizarro/librechat.git
cd librechat
helm repo add bitnami https://charts.bitnami.com/bitnami
helm dependency build
helm install librechat . -f values-sandbox.yaml
```

## Container Image (Red Hat UBI 9)

A Red Hat UBI 9-based container image is available at `quay.io/maximilianopizarro/librechat`. It uses a 3-stage build: extracts the app from the official LibreChat image, rebuilds native modules on `ubi9/nodejs-20`, and packages on `ubi9/nodejs-20-minimal`.

| Property | Value |
|----------|-------|
| Image | `quay.io/maximilianopizarro/librechat` |
| Base | `registry.access.redhat.com/ubi9/nodejs-20-minimal` |
| Source | `ghcr.io/danny-avila/librechat:v0.8.4` |
| Build | 3-stage: extract → rebuild native modules → minimal runtime |
| SCC | Runs as non-root (UID 1000), `restricted` SCC compatible |
| CI | GitHub Actions with `redhat-actions/buildah-build` |

### Build locally

```bash
podman build -t quay.io/maximilianopizarro/librechat:v0.8.4 \
  -f container/Containerfile \
  --build-arg LIBRECHAT_VERSION=v0.8.4 .
```

## AI Model Configuration

### LiteLLM Proxy (recommended)

LiteLLM is integrated into the Helm chart as an OpenAI-compatible proxy for vLLM/KServe InferenceServices. Enable it and configure your models:

```yaml
litellm:
  enabled: true
  masterKey: "sk-litellm-1234"
  apiKey: "$(oc whoami -t)"
  models:
    - name: granite-3.1-8b
      modelId: isvc-granite-31-8b-fp8
      apiBase: "https://isvc-predictor.namespace.svc.cluster.local:8443/v1"
```

### Cluster with ServiceAccount token (recommended)

Uses the pod's auto-mounted ServiceAccount token. No manual token management — the token refreshes automatically:

```yaml
litellm:
  enabled: true
  useServiceAccountToken: true
```

The ServiceAccount needs permissions to access the InferenceService endpoints. For manual token override:

```bash
helm install librechat librechat/librechat \
  --set litellm.enabled=true \
  --set litellm.useServiceAccountToken=false \
  --set litellm.apiKey=$(oc whoami -t)
```

### Developer Sandbox Models

The sandbox includes pre-configured models:

| Model | ID | Endpoint |
|-------|----|----------|
| IBM Granite 3.1 8B | `isvc-granite-31-8b-fp8` | `sandbox-shared-models.svc.cluster.local:8443` |
| Qwen 3 8B | `isvc-qwen3-8b-fp8` | `sandbox-shared-models.svc.cluster.local:8443` |
| NVIDIA Nemotron Nano 9B v2 | `isvc-nemotron-nano-9b-v2-fp8` | `sandbox-shared-models.svc.cluster.local:8443` |

### Ollama (optional, local models)

```yaml
ollama:
  enabled: true
# Then add to librechat.configYamlContent endpoints.custom:
#   - name: "Ollama"
#     apiKey: "${OPENAI_API_KEY}"
#     baseURL: "http://librechat-ollama:11434/v1"
#     models:
#       default: ["llama3.2"]
#       fetch: true
```

## Developer Sandbox Configuration

| Setting | Value | Reason |
|---------|-------|--------|
| `enableServiceLinks` | `false` | Avoids environment variable conflicts |
| `route.sccRoleDisabled` | `true` | Sandbox users cannot create SCC Roles |
| `podSecurityContext` | `{}` | No fsGroup (restricted SCC assigns random UID) |
| `securityContext.runAsNonRoot` | `true` | Required by restricted SCC |
| `litellm.enabled` | `true` | Connects to sandbox shared models |
| `ollama.enabled` | `false` | Saves resources; uses LiteLLM models |
| `*.persistence.storageClass` | `gp3-csi` | Sandbox default StorageClass |

## Chart Components

| Component | Version | Default | Description |
|-----------|---------|---------|-------------|
| PostgreSQL (Bitnami) | 15.5.38 | Enabled | PostgreSQL with pgvector for RAG embeddings |
| MongoDB (Bitnami) | 16.5.45 | Enabled | Application data storage |
| Ollama | 1.26.0 | **Disabled** | Local LLM inference |
| Meilisearch | 0.7.0 | Enabled | Full-text search engine |
| RAG API | 0.5.1 | Enabled | Retrieval Augmented Generation |
| LiteLLM | v1.82.3 | **Disabled** | OpenAI-compatible proxy for vLLM/KServe |

## Chart Verification

Red Hat Community Helm Chart verification status (profile: community v1.1):

| Check | Status |
|-------|--------|
| chart-testing | Pass |
| has-readme | Pass |
| contains-test | Pass |
| has-kubeversion | Pass |
| not-contains-crds | Pass |
| helm-lint | Pass |
| not-contain-csi-objects | Pass |
| images-are-certified | Exempt (non-Red Hat app image) |
| contains-values | Pass |
| contains-values-schema | Pass |
| required-annotations-present | Pass |

## ArgoCD Deployment

```yaml
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
  template:
    metadata:
      name: '{{name}}'
    spec:
      project: default
      source:
        repoURL: 'https://github.com/maximilianoPizarro/librechat.git'
        targetRevision: main
        path: '.'
        helm:
          valueFiles:
            - values-sandbox.yaml
      destination:
        server: 'https://kubernetes.default.svc'
        namespace: '{{namespace}}'
      syncPolicy:
        automated:
          selfHeal: true
          prune: true
        syncOptions:
          - CreateNamespace=true
```

## Requirements

| Requirement | Version |
|-------------|---------|
| OpenShift | >= 4.12 |
| Helm | >= 3.8 |

## Links

- [LibreChat](https://www.librechat.ai/) — Official documentation
- [OpenShift MCP Server](https://maximilianopizarro.github.io/openshift-mcp-server/) — AI model proxy
- [n8n Helm Chart](https://maximilianopizarro.github.io/n8n-helm-chart/) — Workflow automation companion
- [Artifact Hub](https://artifacthub.io/packages/helm/librechat/librechat) — Helm chart registry
- [Developer Sandbox](https://developers.redhat.com/developer-sandbox) — Free OpenShift environment

---

**LibreChat Helm Chart** — Maintained by [maximilianoPizarro](https://github.com/maximilianoPizarro)

LibreChat is licensed under [MIT License](https://github.com/danny-avila/LibreChat/blob/main/LICENSE). IBM Granite models are licensed under Apache 2.0.
