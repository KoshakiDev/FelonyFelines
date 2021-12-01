shader_type canvas_item;

uniform sampler2D mask_texture;
uniform bool is_control = false;

void fragment()
{
	vec4 colour = texture(TEXTURE, UV);
	if(is_control == false){
		colour.a *= texture(mask_texture, UV).a;
	}
	COLOR = colour;
}
	