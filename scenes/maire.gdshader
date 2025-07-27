shader_type canvas_item;

float rand(float n){return fract(sin(n) * 43758.5453123);}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (rand(TIME) < 0.04) {
		COLOR = texture(TEXTURE, UV);
	} else {
		COLOR = vec4(0.0, 0.0, 0.0, 1.0);
	}

}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
