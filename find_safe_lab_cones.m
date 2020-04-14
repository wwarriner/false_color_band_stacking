function radii = find_safe_lab_cones()

LUMINANCE_RANGE = get_luminance_range(101, [0 100]);
HUE_RANGE = get_hue_range(360);
WHITE_POINTS = ["a" "c" "e" "d50" "d55" "d65" "icc"];
radii = containers.Map();
for wp = WHITE_POINTS
    radii(char(wp)) = fminbnd(...
        @(r)compute_cost(wp, HUE_RANGE, LUMINANCE_RANGE, r), ...
        0, 128 ...
        );
end

end


function cost = compute_cost(white_point, hue_range, luminance_range, r)

initial_colors = get_cone_surface_colors(hue_range, luminance_range, r);
image_colors = lab2rgb(initial_colors, 'whitepoint', white_point);
image_colors = clip(image_colors);
preimage_colors = rgb2lab(image_colors, 'whitepoint', white_point);
preimage_colors = round(preimage_colors);

rmse = compute_rmse(initial_colors, preimage_colors);
if rmse == 0
    cost = -r;
else
    cost = rmse;
end
% fprintf(1, "RADIUS: % 6.2f, COST: % 6.2f" + newline, r, cost);

% fh = figure();
% axh = axes(fh);
% hold(axh, "on");
% plot3(axh, preimage_colors(:,2), preimage_colors(:,3), preimage_colors(:,1), 'k.');
% axh.XLim = [-128 127];
% axh.YLim = [-128 127];
% axh.ZLim = [0 100];
% axis(axh, 'square', 'vis3d');

end


function rmse = compute_rmse(lhs, rhs)

rmse = (lhs - rhs) .^ 2;
rmse = mean(rmse, "all");
rmse = sum(rmse);

end


function colors = clip(colors)

colors(colors > 1.0) = 1.0;
colors(colors < 0.0) = 0.0;

end


function colors = get_cone_surface_colors(hue_range, luminance_range, r)

hue_count = numel(hue_range);
luminance_count = numel(luminance_range);
colors = cat(...
    3, ...
    repmat(get_luminance_range(luminance_count), [1 hue_count 1]), ...
    get_ab_points_on_cone_surface(hue_range, luminance_range, r) ...
    );
colors = reshape(colors, [hue_count * luminance_count 3]);
colors = round(colors);
colors = unique(colors, "stable", "rows");

end
