function rgb = stack_to_rgb(stack, scale_mode, hues, chroma)
%{
Collapses a stack of monochromatic images into an rgb visualization by assigning
an sRGB safe, perceptually uniform color to each image in the stack.

scale_mode - [optional, default "none"] Controls how scaling is
    performed using builtin rescale(). If "channel", scales each channel
    independently. If "all", scales the entire stack as a unit. If "none",
    channels are not scaled.

hues - [optional] Hues to draw from as a vector whose values are in the
    range [0 360].
%}

if nargin < 2
    scale_mode = "none";
end
if nargin < 3
    hues = [];
end
if nargin < 4
    chroma = [];
end

scale_mode = lower(scale_mode);
switch scale_mode
    case "all"
        stack = rescale(stack);
    case "channel"
        stack = scale_per_channel(stack);
    case "none"
        % noop
    otherwise
        assert(false);
end

stack_component_count = size(stack, 3);
if isempty(hues)
    hues = linspace(-pi, pi, stack_component_count + 1);
    hues = hues(1 : end - 1);
end

RGB_COMPONENT_COUNT = 3;
MAX_LUMINANCE = 35;
rgb = zeros([size(stack, [1 2]), RGB_COMPONENT_COUNT]);
for i = 1 : stack_component_count
    cmap = generate_srgb_safe_pu_cmap(hues(i), MAX_LUMINANCE, chroma);
    height = size(cmap, 1);
    
    image = stack(:, :, i);
    image_range = [min(image, [], "all"), max(image, [], "all")];
    x = split_up(image_range, height);
    for component = 1 : RGB_COMPONENT_COUNT
        c = interp1(x, cmap(:, component), image);
        rgb(:, :, component) = rgb(:, :, component) + c;
    end
end


end


function stack = scale_per_channel(stack)

for i = 1 : size(stack, 3)
    stack(:, :, i) = rescale(stack(:, :, i));
end

end


function values = split_up(range, count)

values = linspace(range(1), range(2), count);

end
