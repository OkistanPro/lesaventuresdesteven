shader_type canvas_item;
uniform float luminosity: hint_range(-1.0, 1.0) = 0.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR.rgb += luminosity;
	COLOR.a += clamp(luminosity, -1.0, 0.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
