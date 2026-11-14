shader_type canvas_item;

uniform float blur_strength : hint_range(0.0, 5.0) = 1.0;
uniform float darkness : hint_range(0.0, 1.0) = 0.25;

void fragment() {
    vec2 pixel_size = TEXTURE_PIXEL_SIZE * blur_strength;

    vec4 color = texture(TEXTURE, UV);

    color += texture(TEXTURE, UV + vec2(pixel_size.x, 0.0));
    color += texture(TEXTURE, UV - vec2(pixel_size.x, 0.0));
    color += texture(TEXTURE, UV + vec2(0.0, pixel_size.y));
    color += texture(TEXTURE, UV - vec2(0.0, pixel_size.y));

    color /= 5.0;

    color.rgb *= (1.0 - darkness);

    COLOR = color;
}