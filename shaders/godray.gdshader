
shader_type canvas_item;
render_mode blend_add;

uniform vec2 sun_position = vec2(0.5, 0.05);

uniform vec4 ray_color : source_color = vec4(1.0, 0.88, 0.65, 1.0);

uniform float intensity : hint_range(0.0, 1.0) = 0.18;
uniform float ray_count : hint_range(1.0, 40.0) = 18.0;
uniform float sharpness : hint_range(1.0, 30.0) = 12.0;
uniform float animation_speed : hint_range(0.0, 2.0) = 0.15;

void fragment() {
    vec2 delta = UV - sun_position;


    float angle = atan(delta.x, max(delta.y, 0.0001));


    float movement = sin(TIME * animation_speed) * 0.15;


    float rays = cos(angle * ray_count + movement);
    rays = pow(max(rays, 0.0), sharpness);


    float vertical_fade = smoothstep(0.0, 0.12, delta.y);
    vertical_fade *= 1.0 - smoothstep(0.2, 1.0, delta.y);

    float alpha = rays * vertical_fade * intensity;

    COLOR = vec4(ray_color.rgb, alpha);
}
