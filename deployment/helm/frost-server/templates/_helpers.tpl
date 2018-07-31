{{/*
Get the application name
*/}}
{{- define "app" -}}
{{- default .Chart.Name .Values.app | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Get the chart name
*/}}
{{- define "chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end -}}

{{/*
Get the required configured external IP
*/}}
{{- define "externalIp" -}}
{{ required "\n[MISSING CONFIGURATION VALUE] The external IP (IP of the target Kubernetes cluster) is required to install FROST-Server. Please define as the 'externalIp' configuration value.\nYou can set it by either using 'helm --set externalIp=<IP of your target Kubernetes cluster> install' or 'helm --values myvalues.yaml install', where the 'myvalues.yaml' file is containing the 'externalIp' configuration key and its associated value." .Values.externalIp }}
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
http://{{ template "externalIp" . }}{{ if ne (.Values.components.http.ports.externals.http | int) 80 }}:{{ .Values.components.http.ports.externals.http }}{{ end }}/FROST-Server
{{- end -}}