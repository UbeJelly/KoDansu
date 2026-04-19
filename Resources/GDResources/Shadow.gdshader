shader_type canvas_item;

uniform vec4 drop_shadow_color : hint_color = vec4(0, 0, 0, 0.5);
uniform vec2 shadow_offset = vec2(0.025);
varying float max_offset;


void vertex() {
	max_offset = max(
		abs(shadow_offset.x),
		abs(shadow_offset.y)
	);
	VERTEX -= 1. + 2. * max_offset;
}


vec4 sample_texture(sampler2D texture, vec2 uv)  {
	float true_x_lt = step(uv.x, 0.);
	float true_y_lt = step(uv.y, 0.);
	float true_x_gt = step(1.0, uv.x);
	float true_y_gt = step(1.0, uv.y);
	float multiplier = 1.0 - max(true_y_gt, max(true_y_lt, max(true_x_gt, true_x_lt)));
	return texture(texture, uv) * vec4(multiplier);
}


vec4 mixcolor(vec4 colA, vec4 colB)  {
	return vec4(
		colA.rgb + colB.a * (colB.rgb - colA.rgb),
		max(colA.a, colB.a)
	);
}


void fragment()  {
	vec2 uv = UV * (1. + 2. * max_offset) - vec2(max_offset);
	vec4 original_color = sample_texture(TEXTURE, uv);
	vec4 shadow_color = sample_texture(TEXTURE, uv - shadow_offset).a * drop_shadow_color;
	float gate = step(0.0001, shadow_color.a);
	COLOR = mix(
		original_color,
		mixcolor(shadow_color, original_color),
		gate
	);
}