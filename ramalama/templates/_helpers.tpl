{{- define "ramalama.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "ramalama.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{- define "ramalama.labels" -}}
helm.sh/chart: {{ include "ramalama.chart" . }}
{{ include "ramalama.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: ramalama
app.kubernetes.io/part-of: librechat
app.openshift.io/runtime: python
{{- end }}

{{- define "ramalama.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ramalama.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "ramalama.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ramalama.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
