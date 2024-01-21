shader_type canvas_item;
uniform float scan_line_count : hint_range(0.0, 1000080) = 100021.392;
uniform bool is_grayscale = false;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	vec4 current = texture(SCREEN_TEXTURE, SCREEN_UV);
	ivec2 pixel_pos = ivec2(UV / SCREEN_PIXEL_SIZE);
	
	float pos_x = float(pixel_pos.x);
	float pos_y = float(pixel_pos.y);
	
	float r = current.r + sin(pos_y + pow(pos_x, 2));
	float g = current.g + sin(pos_x + pow(pos_y,2));
	float b = current.b + tan(pos_y + pos_x); 
	
	COLOR = vec4( r ,g, b,.025);
}
/*
void old_grainy(){
	vec4 current = texture(SCREEN_TEXTURE, SCREEN_UV);
	ivec2 pixel_pos = ivec2(UV / SCREEN_PIXEL_SIZE);
	
	float pos_x = float(pixel_pos.x);
	float pos_y = float(pixel_pos.y);
	
	float r = current.r + sin(pos_y + pos_x);
	float g = current.g + sin(pos_y + pos_x);
	float b = current.b + sin(pos_y + pos_x); 
	
	COLOR = vec4( r ,g, b,.025);
}

void old_old_grainy(){
	
	vec4 current = texture(SCREEN_TEXTURE, SCREEN_UV ,1.0);

	float s = sin(SCREEN_UV.y * scan_line_count *  20.0);
	float c = sin(SCREEN_UV.x * scan_line_count / 4.00 *  20.0);
	vec4 scan_line = vec4(vec3(pow(c * s,.9)),.05);
	COLOR = vec4(current.r,current.g,current.b,.9) * scan_line;
	
}
*/