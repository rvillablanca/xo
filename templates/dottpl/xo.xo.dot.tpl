{{ $s := .Data -}}
// Generated by XO.
digraph {{ $s.Name }} {
	{{ if defaults -}}
	// Defaults
	{{ range defaults -}}
	{{ . }}
	{{ end }}
	{{ end -}}

	// Nodes (tables)
	{{- range $s.Tables }}
	{{ schema .Name }} [ label=<
		<table border="0" cellborder="1" cellspacing="0" cellpadding="4">
		<tr>{{ header (schema .Name) }}</tr>
		{{ range .Columns -}}
		<tr>{{ row . }}</tr>
		{{ end -}}
		</table>> ]
	{{ end }}

	{{ range $s.Tables -}}
	{{- $t := .  -}}
	{{- range $t.ForeignKeys -}}
		{{ edge (schema $t.Name) (quotes .Field.Name) (schema .RefTable) (quotes .RefField.Name) }} [
		headlabel={{ quotes .ResolvedName }}]
	{{- end }}
	{{- end }}
}
