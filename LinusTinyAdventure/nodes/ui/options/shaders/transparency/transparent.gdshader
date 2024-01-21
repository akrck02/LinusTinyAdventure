shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
void fragment() {
	vec4 pixelColor = texture(SCREEN_TEXTURE, UV);
	vec4 grayscale = vec4(0,0,0,0);
	COLOR = grayscale;
}
