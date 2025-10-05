shader_type canvas_item;

float rand(float n){return fract(sin(n) * 43758.5453123);}

void vertex() {
	VERTEX.y += rand(TIME)*5.;
}

void fragment() {
	COLOR.a -= rand(TIME)*0.5;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
