shader_type canvas_item;

float random(float seed)
{
	return fract(sin(seed) * 1231534.9);
}

float random_coord(vec2 coord) {
	return random(dot(coord, vec2(21.97898, 7809.33123)));
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR.rgb = texture(TEXTURE, UV-(random(TIME)*0.01)).rgb * random_coord(UV + random(TIME)) * (random(TIME*50.)+0.5);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
