shader_type canvas_item;

float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}

float random_split(float value) {
	if (value > 0.3) {
		return 1.0;
	} else {
		return 0.0;
	}
}

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
	float random_y = random(vec2(UV.y, UV.y) + TIME);
	float random_y_b = random(vec2(UV.y, UV.y) + 100.0 + TIME);
	float random_s = random_split(random_y);
	vec2 uv_stretch;
	if (noise(UV.y*10.0) < 0.7) {
		uv_stretch = vec2(UV.x*random(vec2(UV.y, UV.y) + TIME), UV.y);
	} else {
		uv_stretch = vec2(UV.x, UV.y);
	}


	if (noise(UV.y*2. + TIME*1000.) < 0.4) {
		COLOR = vec4(0., 0., 0., 1.0);
	} else {
		COLOR = texture(TEXTURE, uv_stretch);
		COLOR.g = 0.0;
		COLOR.b = 0.0;
		// COLOR = vec4(1.0, 1.0, 1.0, 1.0);
	}
	// COLOR = texture(TEXTURE, UV)*random(UV);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
