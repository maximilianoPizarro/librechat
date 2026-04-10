---
layout: default
title: LibreChat Helm Chart for Red Hat OpenShift
---

<style>
:root {
  --rh-red: #ee0000;
  --rh-red-dark: #a60000;
  --rh-black: #151515;
  --rh-white: #ffffff;
  --rh-gray-100: #f5f5f5;
  --rh-gray-200: #e0e0e0;
  --rh-gray-300: #d2d2d2;
  --rh-gray-600: #3c3f42;
  --rh-gray-900: #151515;
  --rh-blue: #0066cc;
  --rh-blue-dark: #004080;
  --rh-purple: #5e40be;
  --rh-teal: #009596;
  --rh-green: #3e8635;
  --rh-font: 'Red Hat Display', 'Red Hat Text', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  --rh-font-mono: 'Red Hat Mono', 'Fira Code', 'Consolas', monospace;
  --rh-radius: 8px;
  --rh-shadow: 0 2px 8px rgba(0,0,0,0.08);
  --rh-shadow-lg: 0 8px 24px rgba(0,0,0,0.12);
  --rh-transition: 0.2s ease;
}
* { margin: 0; padding: 0; box-sizing: border-box; }
body {
  font-family: var(--rh-font);
  color: var(--rh-gray-900);
  background: var(--rh-white);
  line-height: 1.6;
  -webkit-font-smoothing: antialiased;
}
a { color: var(--rh-blue); text-decoration: none; transition: color var(--rh-transition); }
a:hover { color: var(--rh-blue-dark); }
code, pre {
  font-family: var(--rh-font-mono);
  font-size: 0.875rem;
}
pre {
  background: var(--rh-black) !important;
  color: #f0f0f0 !important;
  padding: 1.25rem !important;
  border-radius: var(--rh-radius) !important;
  border: 1px solid #333 !important;
  overflow-x: auto;
  margin: 1rem 0;
  line-height: 1.5;
}
code {
  background: #e8e8e8 !important;
  padding: 0.15rem 0.4rem;
  border-radius: 4px;
  color: var(--rh-black) !important;
  font-size: 0.85rem;
}
pre code { background: none !important; padding: 0; color: #f0f0f0 !important; }

/* Navbar */
.navbar {
  background: var(--rh-black);
  padding: 0 2rem;
  height: 64px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  position: sticky;
  top: 0;
  z-index: 100;
}
.navbar-brand {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  color: var(--rh-white);
  font-size: 1.2rem;
  font-weight: 700;
}
.navbar-brand svg { height: 28px; width: 28px; }
.navbar-links { display: flex; gap: 1.5rem; }
.navbar-links a { color: var(--rh-gray-300); font-size: 0.875rem; font-weight: 500; }
.navbar-links a:hover { color: var(--rh-white); }

/* Hero */
.hero {
  background: linear-gradient(135deg, var(--rh-black) 0%, #1a1a2e 50%, #16213e 100%);
  color: var(--rh-white);
  padding: 6rem 2rem 5rem;
  text-align: center;
}
.hero h1 {
  font-size: 3.2rem;
  font-weight: 800;
  line-height: 1.15;
  margin-bottom: 1.25rem;
  letter-spacing: -0.02em;
}
.hero h1 span { color: var(--rh-red); }
.hero p {
  font-size: 1.2rem;
  color: var(--rh-gray-300);
  max-width: 640px;
  margin: 0 auto 2.5rem;
}
.hero-badges { display: flex; gap: 0.75rem; justify-content: center; flex-wrap: wrap; margin-bottom: 2rem; }
.badge {
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  padding: 0.35rem 0.85rem;
  border-radius: 20px;
  font-size: 0.8rem;
  font-weight: 600;
  border: 1px solid rgba(255,255,255,0.15);
  background: rgba(255,255,255,0.06);
  color: var(--rh-gray-200);
}
.badge-red { border-color: var(--rh-red); color: #ff6b6b; }
.badge-teal { border-color: var(--rh-teal); color: #4dd0e1; }
.badge-purple { border-color: var(--rh-purple); color: #b39ddb; }
.hero-buttons { display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap; }
.btn {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.75rem;
  border-radius: var(--rh-radius);
  font-weight: 600;
  font-size: 0.95rem;
  transition: all var(--rh-transition);
  border: 2px solid transparent;
}
.btn-primary { background: var(--rh-red); color: var(--rh-white); }
.btn-primary:hover { background: var(--rh-red-dark); color: var(--rh-white); }
.btn-outline { border-color: var(--rh-gray-300); color: var(--rh-white); background: transparent; }
.btn-outline:hover { border-color: var(--rh-white); background: rgba(255,255,255,0.05); color: var(--rh-white); }

/* Sections */
.section { padding: 5rem 2rem; max-width: 1200px; margin: 0 auto; }
.section-alt { background: var(--rh-gray-100); }
.section-dark { background: var(--rh-black); color: var(--rh-white); }
.section h2 {
  font-size: 2.2rem;
  font-weight: 700;
  margin-bottom: 0.75rem;
  letter-spacing: -0.01em;
}
.section h2 span { color: var(--rh-red); }
.section .subtitle { color: var(--rh-gray-600); font-size: 1.1rem; margin-bottom: 3rem; }

/* Cards */
.card-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
  gap: 1.5rem;
}
.card {
  background: var(--rh-white);
  border: 1px solid var(--rh-gray-200);
  border-radius: var(--rh-radius);
  padding: 2rem;
  transition: all var(--rh-transition);
}
.card:hover { box-shadow: var(--rh-shadow-lg); border-color: var(--rh-gray-300); transform: translateY(-2px); }
.card-icon {
  width: 48px;
  height: 48px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 1.25rem;
  font-size: 1.5rem;
}
.card-icon-red { background: #fde8e8; color: var(--rh-red); }
.card-icon-blue { background: #e8f0fe; color: var(--rh-blue); }
.card-icon-teal { background: #e0f7f7; color: var(--rh-teal); }
.card-icon-purple { background: #f0ebff; color: var(--rh-purple); }
.card-icon-green { background: #e8f5e3; color: var(--rh-green); }
.card h3 { font-size: 1.15rem; font-weight: 600; margin-bottom: 0.5rem; }
.card p { color: var(--rh-gray-600); font-size: 0.925rem; line-height: 1.55; }

/* Steps */
.steps { counter-reset: step; }
.step {
  display: flex;
  gap: 1.5rem;
  margin-bottom: 2.5rem;
  align-items: flex-start;
}
.step-number {
  counter-increment: step;
  flex-shrink: 0;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: var(--rh-red);
  color: var(--rh-white);
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  font-size: 1rem;
}
.step-content { flex: 1; }
.step-content h3 { font-size: 1.1rem; font-weight: 600; margin-bottom: 0.5rem; }
.step-content p { color: var(--rh-gray-600); font-size: 0.925rem; }

/* Table */
table {
  width: 100%;
  border-collapse: collapse;
  margin: 1.5rem 0;
  font-size: 0.9rem;
}
th, td { padding: 0.75rem 1rem; text-align: left; border-bottom: 1px solid var(--rh-gray-200); }
th { background: var(--rh-gray-100); font-weight: 600; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.05em; color: var(--rh-gray-900); }
tr:hover td { background: #f9f9f9; }

/* Status badge */
.status { display: inline-flex; align-items: center; gap: 0.3rem; font-size: 0.8rem; font-weight: 600; }
.status-pass { color: var(--rh-green); }
.status-pass::before { content: '✓'; font-weight: 700; }
.status-exempt { color: var(--rh-gray-600); }
.status-exempt::before { content: '—'; }

/* Mermaid diagram */
.mermaid {
  background: var(--rh-gray-100);
  border: 1px solid var(--rh-gray-200);
  border-radius: var(--rh-radius);
  padding: 2rem;
  margin: 2rem 0;
  text-align: center;
  overflow-x: auto;
}

/* Footer */
.footer {
  background: var(--rh-black);
  color: var(--rh-gray-300);
  padding: 3rem 2rem;
  text-align: center;
  font-size: 0.875rem;
}
.footer a { color: var(--rh-gray-200); }
.footer-links { display: flex; gap: 2rem; justify-content: center; margin-bottom: 1.5rem; flex-wrap: wrap; }

/* Responsive */
@media (max-width: 768px) {
  .hero h1 { font-size: 2.2rem; }
  .hero p { font-size: 1rem; }
  .section h2 { font-size: 1.7rem; }
  .card-grid { grid-template-columns: 1fr; }
  .navbar-links { display: none; }
}
</style>

<nav class="navbar">
  <div class="navbar-brand">
    <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="12" cy="12" r="10" stroke="#ee0000" stroke-width="2"/><path d="M8 12h8M12 8v8" stroke="#ee0000" stroke-width="2" stroke-linecap="round"/></svg>
    LibreChat on OpenShift
  </div>
  <div class="navbar-links">
    <a href="#features">Features</a>
    <a href="#quickstart">Quick Start</a>
    <a href="#sandbox">Developer Sandbox</a>
    <a href="#models">AI Models</a>
    <a href="#container">Container</a>
    <a href="https://github.com/maximilianoPizarro/librechat">GitHub</a>
  </div>
</nav>

<section class="hero">
  <div class="hero-badges">
    <span class="badge badge-red">OpenShift Exclusive</span>
    <span class="badge badge-teal">Red Hat UBI 9</span>
    <span class="badge badge-purple">LiteLLM Proxy</span>
  </div>
  <h1>Multi-Model AI Chat<br>for <span>OpenShift</span></h1>
  <p>A community Helm chart that deploys LibreChat v0.8.5-rc1 as a unified chat interface for your existing inference services — Granite, Qwen, Nemotron, or any vLLM model — on Red Hat UBI 9.</p>
  <div class="hero-buttons">
    <a href="#quickstart" class="btn btn-primary">Get Started</a>
    <a href="https://github.com/maximilianoPizarro/librechat" class="btn btn-outline">View on GitHub</a>
    <a href="https://artifacthub.io/packages/helm/librechat/librechat" class="btn btn-outline">Artifact Hub</a>
  </div>
</section>

<section class="section" id="features">
  <h2>Built for <span>OpenShift</span></h2>
  <p class="subtitle">Enterprise-ready AI chat platform with Red Hat certified components</p>
  <div class="card-grid">
    <div class="card">
      <div class="card-icon card-icon-red">🏗️</div>
      <h3>Red Hat UBI 9 Runtime</h3>
      <p>Container image built on <code>ubi9/nodejs-20-minimal</code> from the official Red Hat registry. Compliant with restricted Security Context Constraints.</p>
    </div>
    <div class="card">
      <div class="card-icon card-icon-blue">🤖</div>
      <h3>OpenShift AI Integration</h3>
      <p>Built-in LiteLLM proxy connects to vLLM/KServe InferenceServices. Access Granite, Qwen, Nemotron and any model served in your cluster.</p>
    </div>
    <div class="card">
      <div class="card-icon card-icon-teal">🔒</div>
      <h3>Restricted SCC Compatible</h3>
      <p>Runs with <code>restricted</code> SCC out of the box. No privilege escalation, random UIDs, dropped capabilities. Developer Sandbox ready.</p>
    </div>
    <div class="card">
      <div class="card-icon card-icon-purple">🔌</div>
      <h3>MCP, Agents &amp; Admin Panel</h3>
      <p>MCP with 3-tier architecture and OAuth, AI agents with context compaction, admin panel with per-principal config overrides, custom roles and groups.</p>
    </div>
    <div class="card">
      <div class="card-icon card-icon-green">📦</div>
      <h3>Complete Stack</h3>
      <p>Includes MongoDB, PostgreSQL (pgvector), Meilisearch, RAG API, and optional Ollama. All subcharts configurable via values.</p>
    </div>
    <div class="card">
      <div class="card-icon card-icon-red">✅</div>
      <h3>Chart Verifier Compliant</h3>
      <p>Passes Red Hat Community Helm Chart verification. CI pipeline validates every release with the official chart-verifier tool.</p>
    </div>
  </div>
</section>

<div class="section-alt">
<section class="section" id="architecture">
  <h2>Architecture</h2>
  <p class="subtitle">How LibreChat connects to your OpenShift AI models</p>
  <div class="mermaid">
graph LR
    subgraph OpenShift Cluster
        A["LibreChat<br/>(UBI 9 · 3080)"] -->|API| B["LiteLLM<br/>Proxy · 4000"]
        B -->|SA Token| C["vLLM / KServe<br/>Models · 8443"]
        A --> D["MongoDB<br/>27017"]
        A --> E["Meilisearch<br/>7700"]
        F["PostgreSQL<br/>pgvector · 5432"] --> G["RAG API<br/>8000"]
        A --> G
    end
    style A fill:#ee0000,stroke:#a60000,color:#fff
    style B fill:#5e40be,stroke:#3d2a7c,color:#fff
    style C fill:#009596,stroke:#006d6e,color:#fff
    style D fill:#3e8635,stroke:#2d6327,color:#fff
    style E fill:#0066cc,stroke:#004080,color:#fff
    style F fill:#3e8635,stroke:#2d6327,color:#fff
    style G fill:#0066cc,stroke:#004080,color:#fff
  </div>
</section>
</div>

<section class="section" id="quickstart">
  <h2>Quick <span>Start</span></h2>
  <p class="subtitle">Deploy LibreChat on your OpenShift cluster in minutes</p>
  <div class="steps">
    <div class="step">
      <div class="step-number">1</div>
      <div class="step-content">
        <h3>Add the Helm repository</h3>
<pre>helm repo add librechat https://maximilianopizarro.github.io/librechat/
helm repo update</pre>
      </div>
    </div>
    <div class="step">
      <div class="step-number">2</div>
      <div class="step-content">
        <h3>Install on OpenShift</h3>
<pre>helm install librechat librechat/librechat</pre>
        <p>This deploys LibreChat with MongoDB, PostgreSQL, Meilisearch, and RAG API. LiteLLM is disabled by default.</p>
      </div>
    </div>
    <div class="step">
      <div class="step-number">3</div>
      <div class="step-content">
        <h3>Enable LiteLLM proxy (optional)</h3>
        <p>To connect LibreChat with vLLM/KServe inference services in your cluster:</p>
<pre>helm upgrade librechat librechat/librechat \
  --set litellm.enabled=true \
  --set litellm.useServiceAccountToken=true \
  --set litellm.models[0].name=my-model \
  --set litellm.models[0].modelId=my-isvc-name \
  --set litellm.models[0].apiBase=https://my-isvc-predictor.ns.svc.cluster.local:8443/v1</pre>
      </div>
    </div>
    <div class="step">
      <div class="step-number">4</div>
      <div class="step-content">
        <h3>Access LibreChat</h3>
<pre>oc get route librechat-librechat -o jsonpath='{.spec.host}'</pre>
        <p>Open the URL in your browser. Register a new account and start chatting.</p>
      </div>
    </div>
  </div>
</section>

<div class="section-alt">
<section class="section" id="sandbox">
  <h2>Developer <span>Sandbox</span></h2>
  <p class="subtitle">Free hosted OpenShift environment — no cluster required</p>
  <div class="card-grid">
    <div class="card">
      <div class="card-icon card-icon-red">🚀</div>
      <h3>One-command deploy</h3>
      <p>The <code>values-sandbox.yaml</code> file pre-configures everything for the Developer Sandbox: restricted SCC, <code>gp3-csi</code> storage, service links disabled, and LiteLLM enabled with the sandbox shared models.</p>
    </div>
    <div class="card">
      <div class="card-icon card-icon-blue">🧠</div>
      <h3>Pre-configured AI models</h3>
      <p>Connects automatically to IBM Granite 3.1 8B, Qwen 3 8B, and NVIDIA Nemotron Nano 9B v2 via LiteLLM proxy. All models run as shared vLLM InferenceServices in the sandbox.</p>
    </div>
  </div>

  <h3 style="margin-top:2.5rem;">Deploy on Developer Sandbox</h3>
  <div class="steps" style="margin-top:1.5rem;">
    <div class="step">
      <div class="step-number">1</div>
      <div class="step-content">
        <h3>Get a free sandbox</h3>
        <p>Sign up at <a href="https://developers.redhat.com/developer-sandbox">developers.redhat.com/developer-sandbox</a> and copy your <code>oc login</code> command.</p>
      </div>
    </div>
    <div class="step">
      <div class="step-number">2</div>
      <div class="step-content">
        <h3>Login and install</h3>
<pre>oc login --token=sha256~YOUR_TOKEN --server=https://api.YOUR_CLUSTER:6443

helm repo add librechat https://maximilianopizarro.github.io/librechat/
helm install librechat librechat/librechat -f values-sandbox.yaml</pre>
      </div>
    </div>
    <div class="step">
      <div class="step-number">3</div>
      <div class="step-content">
        <h3>Automatic model authentication</h3>
        <p>The sandbox uses <code>useServiceAccountToken: true</code> by default — the pod's ServiceAccount token authenticates to the shared models automatically. No manual token management needed.</p>
      </div>
    </div>
  </div>

  <h3 style="margin-top:2.5rem;">Sandbox shared models</h3>
  <table>
    <thead>
      <tr><th>Model</th><th>ID</th><th>Endpoint</th></tr>
    </thead>
    <tbody>
      <tr>
        <td><strong>IBM Granite 3.1 8B</strong></td>
        <td><code>isvc-granite-31-8b-fp8</code></td>
        <td><code>sandbox-shared-models.svc.cluster.local:8443</code></td>
      </tr>
      <tr>
        <td><strong>Qwen 3 8B</strong></td>
        <td><code>isvc-qwen3-8b-fp8</code></td>
        <td><code>sandbox-shared-models.svc.cluster.local:8443</code></td>
      </tr>
      <tr>
        <td><strong>NVIDIA Nemotron Nano 9B v2</strong></td>
        <td><code>isvc-nemotron-nano-9b-v2-fp8</code></td>
        <td><code>sandbox-shared-models.svc.cluster.local:8443</code></td>
      </tr>
    </tbody>
  </table>
</section>
</div>

<section class="section" id="models">
  <h2>AI Model <span>Configuration</span></h2>
  <p class="subtitle">Connect to any OpenAI-compatible model endpoint</p>

  <h3>LiteLLM Proxy (recommended for OpenShift)</h3>
  <p>LiteLLM acts as an OpenAI-compatible proxy between LibreChat and your vLLM/KServe InferenceServices. It handles authentication, SSL, and model routing. An OpenShift Route is created by default for external access to the LiteLLM admin UI.</p>

  <table>
    <thead>
      <tr><th>Setting</th><th>Default</th><th>Description</th></tr>
    </thead>
    <tbody>
      <tr><td><code>litellm.masterKey</code></td><td><code>sk-litellm-1234</code></td><td>Master key for LiteLLM admin API. <strong>Change in production.</strong></td></tr>
      <tr><td><code>litellm.route.enabled</code></td><td><code>true</code></td><td>Creates an OpenShift Route for external access</td></tr>
      <tr><td><code>litellm.route.host</code></td><td><code>''</code> (auto)</td><td>Custom hostname for the route</td></tr>
    </tbody>
  </table>

<pre>litellm:
  enabled: true
  route:
    enabled: true
  masterKey: "sk-litellm-1234"
  useServiceAccountToken: true
  models:
    - name: granite-3.1-8b
      modelId: isvc-granite-31-8b-fp8
      apiBase: "https://isvc-predictor.namespace.svc.cluster.local:8443/v1"</pre>

  <p style="margin-top:1rem;">Access the LiteLLM admin UI via the route:</p>
<pre>oc get route librechat-litellm -o jsonpath='{.spec.host}'</pre>

  <h3 style="margin-top:2.5rem;">ServiceAccount token (recommended)</h3>
  <p>Uses the pod's auto-mounted ServiceAccount token. No manual token management — it refreshes automatically:</p>
<pre>litellm:
  enabled: true
  useServiceAccountToken: true</pre>
  <p style="margin-top:1rem;">For manual token override, set <code>useServiceAccountToken: false</code> and pass <code>--set litellm.apiKey=$(oc whoami -t)</code>.</p>

  <h3 style="margin-top:2.5rem;">Ollama (optional, local models)</h3>
  <p>For running local models with Ollama. Disabled by default to save resources.</p>
<pre>ollama:
  enabled: true
# Add to librechat.configYamlContent endpoints.custom:
#   - name: "Ollama"
#     apiKey: "${OPENAI_API_KEY}"
#     baseURL: "http://librechat-ollama:11434/v1"
#     models:
#       default: ["llama3.2"]
#       fetch: true</pre>
</section>

<div class="section-alt">
<section class="section" id="container">
  <h2>Container <span>Image</span></h2>
  <p class="subtitle">Red Hat UBI 9 certified runtime</p>

  <table>
    <thead>
      <tr><th>Property</th><th>Value</th></tr>
    </thead>
    <tbody>
      <tr><td><strong>Image</strong></td><td><code>quay.io/maximilianopizarro/librechat</code></td></tr>
      <tr><td><strong>Base</strong></td><td><code>registry.access.redhat.com/ubi9/nodejs-20-minimal</code></td></tr>
      <tr><td><strong>Source</strong></td><td><code>ghcr.io/danny-avila/librechat:v0.8.5-rc1</code></td></tr>
      <tr><td><strong>Build</strong></td><td>3-stage: extract → rebuild native modules → minimal runtime</td></tr>
      <tr><td><strong>SCC</strong></td><td>Runs as non-root (UID 1000), <code>restricted</code> SCC compatible</td></tr>
      <tr><td><strong>CI</strong></td><td>GitHub Actions with <code>redhat-actions/buildah-build</code></td></tr>
    </tbody>
  </table>

  <h3 style="margin-top:2rem;">Build locally</h3>
<pre>podman build -t quay.io/maximilianopizarro/librechat:v0.8.5-rc1 \
  -f container/Containerfile \
  --build-arg LIBRECHAT_VERSION=v0.8.5-rc1 .</pre>

  <h3 style="margin-top:2rem;">Run locally</h3>
<pre>podman run -d --name librechat \
  -p 3080:3080 \
  quay.io/maximilianopizarro/librechat:v0.8.5-rc1</pre>
</section>
</div>

<section class="section" id="components">
  <h2>Chart <span>Components</span></h2>
  <p class="subtitle">Subchart dependencies and versions</p>
  <table>
    <thead>
      <tr><th>Component</th><th>Version</th><th>Condition</th><th>Description</th></tr>
    </thead>
    <tbody>
      <tr><td><strong>PostgreSQL</strong></td><td>15.5.38</td><td><code>postgresql.enabled</code></td><td>Bitnami PostgreSQL with pgvector for RAG embeddings</td></tr>
      <tr><td><strong>MongoDB</strong></td><td>16.5.45</td><td><code>mongodb.enabled</code></td><td>Bitnami MongoDB for LibreChat data storage</td></tr>
      <tr><td><strong>Ollama</strong></td><td>1.26.0</td><td><code>ollama.enabled</code></td><td>Local LLM inference (disabled by default)</td></tr>
      <tr><td><strong>Meilisearch</strong></td><td>0.7.0</td><td><code>meilisearch.enabled</code></td><td>Full-text search engine for messages</td></tr>
      <tr><td><strong>RAG API</strong></td><td>0.5.1</td><td><code>librechat-rag-api.enabled</code></td><td>Retrieval Augmented Generation API</td></tr>
      <tr><td><strong>LiteLLM</strong></td><td>v1.82.3</td><td><code>litellm.enabled</code></td><td>OpenAI-compatible proxy for vLLM/KServe models</td></tr>
      <tr><td><strong>MongoDB image</strong></td><td>8.0.20</td><td>—</td><td>Updated from 8.0.13 matching upstream</td></tr>
    </tbody>
  </table>
</section>

<section class="section" id="release">
  <h2>Release <span>Notes</span> — v1.8.17</h2>
  <ul style="list-style:none;padding:0;">
    <li style="padding:0.5rem 0;border-bottom:1px solid var(--rh-gray-200);">🚀 <strong>LibreChat v0.8.5-rc1</strong> — Admin Panel, Context Compaction/Summarization, redesigned sidebar and tool call UI</li>
    <li style="padding:0.5rem 0;border-bottom:1px solid var(--rh-gray-200);">🛡️ <strong>Admin Panel</strong> — Per-principal config overrides, custom roles and groups, system grants for access control</li>
    <li style="padding:0.5rem 0;border-bottom:1px solid var(--rh-gray-200);">🧠 <strong>Context Compaction</strong> — Auto-summarizes long agent conversations to stay within context limits (Config v1.3.8)</li>
    <li style="padding:0.5rem 0;border-bottom:1px solid var(--rh-gray-200);">🔌 <strong>MCP improvements</strong> — 3-tier architecture, lazy init, OAuth improvements, domain allowlisting</li>
    <li style="padding:0.5rem 0;border-bottom:1px solid var(--rh-gray-200);">📦 <strong>MongoDB 8.0.20</strong> — Updated from 8.0.13 matching upstream Docker Compose files</li>
    <li style="padding:0.5rem 0;border-bottom:1px solid var(--rh-gray-200);">📌 <strong>Pinned Model Specs</strong> — Users can pin favorite model specs for quick access</li>
    <li style="padding:0.5rem 0;">🏗️ <strong>Red Hat UBI 9</strong> — Container image on <code>ubi9/nodejs-20-minimal</code> with LiteLLM proxy and SA token auth</li>
  </ul>
</section>

<footer class="footer">
  <div class="footer-links">
    <a href="https://github.com/maximilianoPizarro/librechat">GitHub</a>
    <a href="https://artifacthub.io/packages/helm/librechat/librechat">Artifact Hub</a>
    <a href="https://www.librechat.ai">LibreChat</a>
    <a href="https://developers.redhat.com/developer-sandbox">Developer Sandbox</a>
  </div>
  <p>Built for Red Hat OpenShift · Maintained by <a href="https://github.com/maximilianoPizarro">Maximiliano Pizarro</a> &amp; <a href="#">Carlos Estay</a></p>
  <p style="margin-top:0.5rem;">© 2026 LibreChat Helm Chart · Apache 2.0 License</p>
</footer>

<script type="module">
import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs';
mermaid.initialize({ startOnLoad: true, theme: 'neutral', flowchart: { useMaxWidth: true, htmlLabels: true } });
</script>
