shader_type canvas_item;

uniform sampler2D water_tex;

void fragment() {
	vec2 moved_uv = fract(UV + 0.1 * vec2(cos(TIME), sin(TIME)));
	COLOR = texture(water_tex, moved_uv);
}
