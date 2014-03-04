{% if phase=="prepare" %}
	{% if argument|is_argument%}
	{{type}} {{carg}};
		{% if typedef|getNth:1=="float" %}
	double {{carg}}_helper;
		{% endif %}
	{% endif %}

	{% if argument|is_return %}
	{{type}} c_retval;
	ERL_NIF_TERM retval;
	{% endif %}

	{% if argument|is_field %}
		{% if record=="to_record" %}
	ERL_NIF_TERM {{erlarg}};
		{% endif %}
	{% endif %}
{% endif %}

{% if phase=="to_c" %}
	{% if typedef|getNth:1=="float" %}
	err = enif_get_double(env, {{erlarg}}, &{{carg}}_helper);
	{{carg}}=({{type}}){{carg}}_helper;
	{% else %}
	err = enif_get_double(env, {{erlarg}}, &{{carg}});
	{% endif %}
{% endif %}

{% if phase=="argument" %}
{% if argument|is_argument %}
({{raw_type}}){{carg}}
{% else %}
({{type}})
{% endif %}
{% endif %}

{% if phase=="to_erl"%}
	{{erlarg}} = ({{type}})enif_make_double(env, {{carg}});
{% endif %}

{# no cleanup phase #}
