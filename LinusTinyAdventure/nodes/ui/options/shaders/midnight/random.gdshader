shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment() {
	vec4 pixelColor = texture(SCREEN_TEXTURE, UV);
	
	vec4 grayscale = vec4(rand(vec2(1,255)), rand(vec2(1,255)), pixelColor.b + rand(vec2(1,255)), pixelColor.a + rand(vec2(1,255)));
	COLOR = grayscale;
	
	
}

