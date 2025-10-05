shader_type canvas_item;

float rand(float n){return fract(sin(n) * 43758.5453123);}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float val_rand = rand(TIME);
	if (val_rand < 0.05) {
		COLOR = texture(TEXTURE, UV);
	} else {
		vec4 base_color = texture(TEXTURE, UV);
		COLOR = vec4(1.-base_color.r, 1.-base_color.g, 1.-base_color.b, base_color.a);
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
