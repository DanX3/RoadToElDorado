shader_type canvas_item;

uniform sampler2D smoke_tex;
uniform vec2[3] speed;
uniform float[3] opacities;
uniform float[3] scales;
uniform float darkness_radius = 1.0;


void fragment() {
	vec4 smokes = vec4(0.0);
	for (int i = 0; i<speed.length(); i++) {
		vec2 uv_moving = fract(scales[i] * UV + TIME * speed[i]);
		smokes += opacities[i] * texture(smoke_tex, uv_moving);
	}
	
	float distance_from_center = length(vec2(0.5, 0.5) - UV);
	
	COLOR = smokes;
	COLOR.a = COLOR.r;
	COLOR.a = smoothstep(0.0, darkness_radius, distance_from_center);
}
