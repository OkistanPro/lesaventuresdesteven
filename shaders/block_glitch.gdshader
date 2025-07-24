shader_type canvas_item;

float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 new_uv = vec2(UV.x+random(vec2(ivec2(vec2(UV.y, UV.y + TIME*0.01)*40.0))*0.01)*0.1, UV.y);
	if (random(vec2(TIME, TIME)) > 0.2) {
		COLOR.rgb = texture(TEXTURE, new_uv).rgb;
	} else {
		COLOR.rgb = texture(TEXTURE, UV).rgb*random(UV);
	}
	COLOR.a = 1.0;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
