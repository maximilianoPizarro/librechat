{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "rag.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}

{{- define "rag.fullname" -}}
{{- if $.Values.fullnameOverride }}
{{- $.Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "rag.labels" -}}
helm.sh/chart: {{ include "rag.chart" . }}
{{ include "rag.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: {{ include "rag.fullname" . }}
app.kubernetes.io/part-of: {{ include "rag.fullname" . }}
app: librechat
app.kubernetes.io/name: {{ include "rag.fullname" . }}
app.openshift.io/runtime: python
{{- end }}


{{/*
OpenShift annotations for the main librechat deployment
*/}}
{{- define "rag.openshiftAnnotations" -}}
app.openshift.io/connects-to: '[{"apiVersion":"apps/v1","kind":"StatefulSet","name":"librechat-postgresql"}]' 
argocd.argoproj.io/sync-wave: "2"
{{- end }}



{{/*
RAG Selector labels
*/}}
{{- define "rag.selectorLabels" -}}
app.kubernetes.io/name: {{ include "rag.fullname" . }}-rag
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "rag.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "rag.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{- define "rag.dbsecretValue" -}}
{{- $secret :=  .Values.postgresql.auth.existingSecret -}}
{{- $key := "password" -}}
{{- printf "%s" (include "exec" (dict "command" "kubectl" "args" (list "get" "secret" $secret "-o=jsonpath={.data." $key "}"))) | b64enc -}}
{{- end -}}