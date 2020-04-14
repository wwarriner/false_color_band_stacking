function colors = accessible_colors(n, original_order)
%{
Colors drawn from the palette available in the poster at 
http://mkweb.bcgsc.ca/biovis2012
https://www.somersault1824.com/tips-for-designing-scientific-figures-for-color-blind-readers/
https://ux.stackexchange.com/a/94699/77545

There are 15 colors in the set. Note that the pairs (3,7) and (4,13) in the
original set appear very similar for people with tritanopia. Users can choose to
move colors 7 and 13 to the end of the set before returning. It is recommended
to only use the first 13 colors in the reordered set.

Input:

n - [optional] the nth color in the set, may be a vector, values must be in the
range 1 to 15. If not supplied, or empty, all colors are returned.

original_order - [optional, default true] if true, returns colors in the
original order, otherwise returns them in the trianopia-safe order.

Output:

colors - Colors from the set in an m-by-3 array.
%}

if nargin < 2
    original_order = true;
end
if nargin < 1
    n = [];
end

assert(isnumeric(n));
assert(isempty(n) || isvector(n));
if isvector(n)
    assert(all(1 <= n & n <= 15));
end

COLOR_DEF = [...
    0 0 0; ...
    0 73 73; ...
    0 146 146; ...
    255 109 182; ...
    255 182 119; ...
    73 0 146; ...
    0 109 219; ...
    182 109 255; ...
    109 182 255; ...
    182 219 255; ...
    146 0 0; ...
    146 73 0; ...
    219 209 0; ...
    36 255 36; ...
    255 255 109 ...
    ];
TRIT_SAFE_ORDER = [1:6 8:12 14 15 7 13];

if original_order
    colors = COLOR_DEF;
else
    colors = COLOR_DEF( TRIT_SAFE_ORDER, :);
end

if isempty(n)
    return;
end

colors = colors(n, :);

end

