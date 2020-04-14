function L = get_luminance_range(count, range)

if nargin < 1
    count = 101;
end
if nargin < 2
    range = [0, 100];
end
L = linspace(range(1), range(2), count).';

end