function rr = get_cone_radii(luminance_range, r)

rr = abs(luminance_range - 50) ./ 50; % rescale
rr = 1 - rr; % peak at L = 50
rr = r .* rr;

end