{{/*
Return the appropriate apiVersion for Ingress.

It expects a dictionary with three entries:
  - `global` which contains global ingress settings, e.g. .Values.global.ingress
  - `local` which contains local ingress settings, e.g. .Values.ingress
  - `context` which is the parent context (either `.` or `$`)

Example usage:
{{- $ingressCfg := dict "global" .Values.global.ingress "local" .Values.ingress "context" . -}}
kubernetes.io/ingress.provider: "{{ template "wandb.ingress.provider" $ingressCfg }}"
*/}}
{{- define "wandb.ingress.apiVersion" -}}
{{-   if .local.apiVersion -}}
{{-     .local.apiVersion -}}
{{-   else if .global.apiVersion -}}
{{-     .global.apiVersion -}}
{{-   else if .context.Capabilities.APIVersions.Has "networking.k8s.io/v1/Ingress" -}}
{{-     print "networking.k8s.io/v1" -}}
{{-   else if .context.Capabilities.APIVersions.Has "networking.k8s.io/v1beta1/Ingress" -}}
{{-     print "networking.k8s.io/v1beta1" -}}
{{-   else -}}
{{-     print "extensions/v1beta1" -}}
{{-   end -}}
{{- end -}}

{{/*
Returns the ingress provider

It expects a dictionary with two entries:
  - `global` which contains global ingress settings, e.g. .Values.global.ingress
  - `local` which contains local ingress settings, e.g. .Values.ingress
*/}}
{{- define "wandb.ingress.provider" -}}
{{- default .global.provider .local.provider -}}
{{- end -}}
