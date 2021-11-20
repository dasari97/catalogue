{{/*
Expand the name of the catalogue.
*/}}
{{- define "catalogue.name" -}}
{{- default .catalogue.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains catalogue name it will be used as a full name.
*/}}
{{- define "catalogue.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .catalogue.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create catalogue name and version as used by the catalogue label.
*/}}
{{- define "catalogue.catalogue" -}}
{{- printf "%s-%s" .catalogue.Name .catalogue.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "catalogue.labels" -}}
helm.sh/catalogue: {{ include "catalogue.catalogue" . }}
{{ include "catalogue.selectorLabels" . }}
{{- if .catalogue.AppVersion }}
app.kubernetes.io/version: {{ .catalogue.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "catalogue.selectorLabels" -}}
app.kubernetes.io/name: {{ include "catalogue.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "catalogue.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "catalogue.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
