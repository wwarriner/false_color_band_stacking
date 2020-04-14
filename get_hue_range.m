function hue_range = get_hue_range(count)

if nargin < 1
    count = 360;
end
hue_range = linspace(-pi, pi, count).';

end