function rgb = generate_srgb_safe_pu_cmap(hue, luminance, chroma, white_point)
%{
Generates an intensity colormap ranging from the CIELab black point to the point
in CIELab with the given hue and luminance along the surface of a double cone. 
The range of possible output values fits into a circular cone in CIELab space
whose axis lies on the L axis and whose apex is the black point. The base of the
cones lies in the L50 plane. The radius of the circle, i.e. chroma, is chosen so
that the mapping of the cones fits into sRGB space.

Hue is represented by radians about the L axis, starting at the positive a axis.
Whitepoint is assumed to be D65 unless otherwise specified. See the following
link for more details.
https://www.mathworks.com/help/images/ref/lab2rgb.html#namevaluepairarguments
%}

if nargin < 4
    white_point = "d65";
end
if nargin < 3
    chroma = [];
end
if nargin < 2
    luminance = 80;
end
white_point = lower(white_point);

% Determined by find_safe_lab_cones();
SAFE_CHROMA = { ...
    "a" 33.0042; ...
    "c" 28.5363; ...
    "d50" 32.1115; ...
    "d55" 31.2787; ...
    "d65" 29.5854; ...
    "e" 30.2178; ...
    "icc" 32.1115 ...
    };
SAFE_CHROMA = containers.Map(cellstr(SAFE_CHROMA(:, 1)), SAFE_CHROMA(:, 2));
if isempty(chroma)
    chroma = SAFE_CHROMA(white_point);
end

LUMINANCE_COUNT = 101;
luminance_range = get_luminance_range(LUMINANCE_COUNT, [0 luminance]);
ab = get_ab_points_on_cone_surface(hue, luminance_range, chroma);
Lab = [luminance_range ab];
rgb = lab2rgb(Lab, 'whitepoint', white_point);

end

