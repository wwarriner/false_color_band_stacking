function cs = get_ab_points_on_cone_surface(hue_range, luminance_range, r)

circle = to_circle(hue_range);
cs = outer(get_cone_radii(luminance_range, r), circle);

end