shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment() {
	vec4 pixelColor = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	float level = 0.1;
	
	vec4 grayscale = vec4(level,level, pixelColor.b, pixelColor.a);
	COLOR = grayscale;
	
	
}

