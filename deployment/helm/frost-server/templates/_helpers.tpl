{{/*
Get the application name
*/}}
{{- define "app" -}}
{{- default .Chart.Name .Values.app | trunc 50 | trimSuffix "-" -}}
{{- end -}}

{{/*
Get the chart name
*/}}
{{- define "chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end -}}

{{/*
Get the HTTP service API version
*/}}
{{- define "apiVersion" -}}
v1.0
{{- end -}}

{{/*
Get the HTTP service root URL
*/}}
{{- define "serviceRootUrl" -}}
http://{{ .Values.cluster.host }}{{ if not .Values.ingress.enabled }}:{{ .Values.frost.http.ports.http.nodePort }}{{ end }}
{{- end -}}