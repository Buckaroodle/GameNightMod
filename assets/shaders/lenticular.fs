#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define MY_HIGHP_OR_MEDIUMP highp
#else
    #define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec2 lenticular;
extern MY_HIGHP_OR_MEDIUMP number dissolve;
extern MY_HIGHP_OR_MEDIUMP number time;
extern MY_HIGHP_OR_MEDIUMP vec4 texture_details;
extern MY_HIGHP_OR_MEDIUMP vec2 image_details;
extern bool shadow;
extern MY_HIGHP_OR_MEDIUMP vec4 burn_colour_1;
extern MY_HIGHP_OR_MEDIUMP vec4 burn_colour_2;

// --- Optical Constants ---
#define LENS_IOR 1.49           // Standard PETG lenticular plastic Index of Refraction
#define LENS_LPI 24.0           // Number of strictly vertical ridges across the card
#define SUBSTRATE_RATIO 0.75    // Thickness-to-pitch ratio (t / P)

// Snell's Law + Cylindrical Lens Focal Projection
number sample_lenticule_phase(number view_sin, number u_local) {
    // 1. Cylindrical surface normal across the vertical ridge: u_local is [-0.5, 0.5]
    // Strictly a function of X so the ridges remain 100% vertical
    number sin_phi = clamp(u_local * 1.25, -0.80, 0.80);
    number cos_phi = sqrt(max(0.01, 1.0 - sin_phi * sin_phi));
    
    // 2. Local incident angle relative to the cylinder normal
    number cos_view = sqrt(max(0.01, 1.0 - view_sin * view_sin));
    number sin_incident = clamp(view_sin * cos_phi + cos_view * sin_phi, -0.95, 0.95);
    
    // 3. Snell's Law: n_air * sin(theta_i) = n_plastic * sin(theta_r)
    number sin_refracted = sin_incident / LENS_IOR;
    number cos_refracted = sqrt(max(0.01, 1.0 - sin_refracted * sin_refracted));
    
    // 4. Ray angle inside the plastic relative to the flat card normal: (theta_r - phi)
    number sin_internal = sin_refracted * cos_phi - cos_refracted * sin_phi;
    number cos_internal = max(0.05, cos_refracted * cos_phi + sin_refracted * sin_phi);
    number tan_internal = sin_internal / cos_internal;
    
    // 5. Project down to the ink focal plane at depth t/P
    number focal_hit = u_local + SUBSTRATE_RATIO * tan_internal;
    return fract(focal_hit + 0.5);
}

// Cylindrical Specular Highlight (Purely vertical glossy plastic ridges)
number lenticule_specular(number u_local, number view_sin) {
    number nx = u_local * 1.7;
    number nz = sqrt(max(0.01, 1.0 - nx * nx));
    
    number hx = clamp(view_sin, -0.9, 0.9);
    number hz = sqrt(max(0.01, 1.0 - hx * hx));
    number ndoth = max(0.0, nx * hx + nz * hz);
    
    // Crisp vertical specular line along the crest of each cylinder
    number spec = pow(ndoth, 32.0);
    number fresnel = 0.04 + 0.96 * pow(1.0 - nz, 3.0);
    return spec * (0.4 + 0.6 * fresnel);
}

// Clean HSV helper so the alternate lenticular state keeps natural saturation/brightness
vec3 rgb2hsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
    number d = q.x - min(q.w, q.y);
    number e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv) {
    if (dissolve < 0.001) {
        return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, shadow ? tex.a*0.3: tex.a);
    }
    number adjusted_dissolve = (dissolve*dissolve*(3.-2.*dissolve))*1.02 - 0.01;
    number t = time * 10.0 + 2003.;
    vec2 floored_uv = (floor((uv*texture_details.ba)))/max(texture_details.b, texture_details.a);
    vec2 uv_scaled_centered = (floored_uv - 0.5) * 2.3 * max(texture_details.b, texture_details.a);
    
    vec2 field_part1 = uv_scaled_centered + 50.*vec2(sin(-t / 143.6340), cos(-t / 99.4324));
    vec2 field_part2 = uv_scaled_centered + 50.*vec2(cos( t / 53.1532),  cos( t / 61.4532));
    vec2 field_part3 = uv_scaled_centered + 50.*vec2(sin(-t / 87.53218), sin(-t / 49.0000));

    number field = (1.+ (
        cos(length(field_part1) / 19.483) + sin(length(field_part2) / 33.155) * cos(field_part2.y / 15.73) +
        cos(length(field_part3) / 27.193) * sin(field_part3.x / 21.92) ))/2.;
    vec2 borders = vec2(0.2, 0.8);

    number res = (.5 + .5* cos( (adjusted_dissolve) / 82.612 + ( field + -.5 ) *3.14))
        - (floored_uv.x > borders.y ? (floored_uv.x - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
        - (floored_uv.y > borders.y ? (floored_uv.y - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
        - (floored_uv.x < borders.x ? (borders.x - floored_uv.x)*(5. + 5.*dissolve) : 0.)*(dissolve)
        - (floored_uv.y < borders.x ? (borders.x - floored_uv.y)*(5. + 5.*dissolve) : 0.)*(dissolve);

    if (tex.a > 0.01 && burn_colour_1.a > 0.01 && !shadow && res < adjusted_dissolve + 0.8*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
        if (!shadow && res < adjusted_dissolve + 0.5*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
            tex.rgba = burn_colour_1.rgba;
        } else if (burn_colour_2.a > 0.01) {
            tex.rgba = burn_colour_2.rgba;
        }
    }
    return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, res > adjusted_dissolve ? (shadow ? tex.a*0.3: tex.a) : .0);
}

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords ) {
    // 1. Card-local UV [0, 1]
    vec2 uv = (((texture_coords)*(image_details)) - texture_details.xy*texture_details.ba)/texture_details.ba;
    
    vec4 base_tex = Texel(texture, texture_coords);
    if (base_tex.a <= 0.001) {
        return dissolve_mask(base_tex * colour, texture_coords, uv);
    }

    // 2. Strictly Vertical Lenticular Grid (Only depends on uv.x!)
    number lens_coord = uv.x * LENS_LPI;
    number lens_id = floor(lens_coord);       // Integer ID of each vertical stripe
    number u_local = fract(lens_coord) - 0.5; // [-0.5, 0.5] across the width of a single vertical ridge
    number ridge_center_uv_x = (lens_id + 0.5) / LENS_LPI;

    // 3. Viewing angle (quantized per vertical ridge so every ridge is a solid vertical column)
    number perspective_fan = (ridge_center_uv_x - 0.5) * 0.05;
    number view_angle_x = clamp(sin(lenticular.x * 2.0 + lenticular.y * 0.35) + perspective_fan, -0.92, 0.92);

    // 4. Unified Optical Phase (no per-channel RGB splitting that muddies card colors)
    number phase = sample_lenticule_phase(view_angle_x, u_local);

    // Sharp, clean transition between interlaced strips inside each vertical lens
    number frame_blend = smoothstep(0.38, 0.62, phase);

    // 5. Purely Horizontal Lens Offset (keeps vertical lines 100% straight, zero Y-distortion)
    number atlas_px_x = 1.0 / image_details.x;
    vec2 shift_a = vec2(-u_local * 0.5 * atlas_px_x, 0.0);
    vec2 shift_b = vec2((view_angle_x * 1.2 - u_local * 0.5) * atlas_px_x, 0.0);

    // Frame A: Original card colors
    vec4 frame_a = Texel(texture, texture_coords + shift_a);

    // Frame B: Shifted card sample with a clean, natural foil/iridescent sheen
    // Preserves white, black, and luminance so the card never looks inverted or muddy
    vec4 sample_b = Texel(texture, texture_coords + shift_b);
    vec3 hsv = rgb2hsv(sample_b.rgb);
    
    // Gently shift hue along the vertical ridges and boost vibrance slightly for colored pixels
    number ridge_hue_offset = 0.12 * sin(ridge_center_uv_x * 6.28318 + lenticular.x * 2.5);
    hsv.x = fract(hsv.x + ridge_hue_offset);
    hsv.y = clamp(hsv.y * 1.15, 0.0, 1.0);
    hsv.z = clamp(hsv.z * 1.08, 0.0, 1.0);
    
    // Cool silver-blue metallic sheen on neutral/white areas so white card backgrounds stay clean
    vec3 clean_sheen = vec3(0.88, 0.94, 1.05) * sample_b.rgb;
    vec3 col_b = mix(clean_sheen, hsv2rgb(hsv), smoothstep(0.05, 0.25, hsv.y));

    // 6. Mix Frame A and Frame B cleanly
    vec3 final_rgb = mix(frame_a.rgb, col_b, frame_blend);

    // 7. Crisp Vertical Corduroy Ridges (Groove shadow + Vertical Specular Line)
    // Darkens the narrow seams at u_local = -0.5 and +0.5 so the vertical lines are always clearly visible
    number groove_seam = smoothstep(0.32, 0.50, abs(u_local));
    number valley_occlusion = 1.0 - 0.28 * groove_seam;
    number ridge_glint = lenticule_specular(u_local, view_angle_x);

    final_rgb = final_rgb * valley_occlusion + vec3(ridge_glint * 0.32);

    vec4 out_col = vec4(clamp(final_rgb, 0.0, 1.0), base_tex.a);
    return dissolve_mask(out_col * colour, texture_coords, uv);
}

extern MY_HIGHP_OR_MEDIUMP vec2 mouse_screen_pos;
extern MY_HIGHP_OR_MEDIUMP float hovering;
extern MY_HIGHP_OR_MEDIUMP float screen_scale;

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position ) {
    if (hovering <= 0.){
        return transform_projection * vertex_position;
    }
    float mid_dist = length(vertex_position.xy - 0.5*love_ScreenSize.xy)/length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy)/screen_scale;
    float scale = 0.2*(-0.03 - 0.3*max(0., 0.3-mid_dist))
                *hovering*(length(mouse_offset)*length(mouse_offset))/(2.-mid_dist);

    return transform_projection * vertex_position + vec4(0,0,0,scale);
}
#endif