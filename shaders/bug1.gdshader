shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_nearest;

float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 new_uv = vec2(SCREEN_UV.x, SCREEN_UV.y+(random(vec2(SCREEN_UV.y, SCREEN_UV.y) + TIME))*0.1);
	COLOR = texture(SCREEN_TEXTURE, new_uv);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
