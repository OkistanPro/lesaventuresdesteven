shader_type canvas_item;

float rand(float n){return fract(sin(n) * 43758.5453123);}

float noise(float p){
	float fl = floor(p);
  float fc = fract(p);
	return mix(rand(fl), rand(fl + 1.0), fc);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 new_uv = vec2(UV.x, UV.y+noise(TIME*100.)*0.005);
	COLOR.rgb = texture(TEXTURE, new_uv).rgb*(0.5+noise(TIME*100.));
	COLOR.a = texture(TEXTURE, new_uv).a;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
