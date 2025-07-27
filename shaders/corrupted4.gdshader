shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 new_uv = vec2(fract(UV.x*0.2 + fract(TIME)), UV.y);
	COLOR = pow(texture(TEXTURE, new_uv), vec4(0.5,2.,2., 1.0))*2.;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
