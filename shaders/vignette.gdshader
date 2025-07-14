shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_nearest;
uniform sampler2D map: filter_nearest;
uniform float percentage : hint_range(0.0, 1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float value = (percentage*2.) - 1.;
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV) * clamp((texture(map, SCREEN_UV)-vec4(value, value, value, 0.)), vec4(0., 0., 0., 0.), vec4(1., 1., 1., 1.));
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
