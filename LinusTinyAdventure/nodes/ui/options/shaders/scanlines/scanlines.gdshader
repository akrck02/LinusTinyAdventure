shader_type canvas_item;
 //236
uniform bool is_grayscale = false;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	float scan_line_count = 256.00;
	scan_line_count = SCREEN_PIXEL_SIZE.y - scan_line_count;
	
	float blur = 0.00;
	vec4 current = texture(SCREEN_TEXTURE, SCREEN_UV, blur);
	float s = sin(SCREEN_UV.y * scan_line_count * 20.00);

	float transparency = .95;
	vec4 scan_line = vec4(vec3(pow(s,.8)),transparency);
	COLOR = vec4(current.r,current.g,current.b,.1) * scan_line;

}