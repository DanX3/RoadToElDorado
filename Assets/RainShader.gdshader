shader_type canvas_item;

uniform sampler2D screen_tex: hint_screen_texture;

vec2 offset_from_center(vec2 center, float radius, vec2 uv) {
	float distance_from_center = length(uv - center);
	float distance_factor = radius - distance_from_center / radius;
	return vec2(distance_factor, distance_factor);
}

void fragment() {
	vec2 uv_offset = offset_from_center(vec2(0.5, 0.5), 0.5, UV);
//	COLOR = texture(screen_tex, UV + uv_offset);
	COLOR = vec4(uv_offset.x, uv_offset.y, 0.0, 1.0);
}
