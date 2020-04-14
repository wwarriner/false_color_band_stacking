%folder = "path/to/stack/as/separate/images"
contents = get_files_with_extension(get_contents(folder), ".png");
rgb_file = string(contents.name) == "rgb.png";
files = get_full_paths(contents);
files(rgb_file) = [];
files = sort(files);

count = numel(files);
info = imfinfo(files(1));
shape = [info.Height info.Width];
stack = zeros([shape count]);
for i = 1 : count
    stack(:, :, i) = imread(files(i));
end

SCALE_MODE = "all";
HUES = ((0:5)*pi/3) + pi/18;
% PREFERRED_ORDER = [1 3 4 5 6 2]
ORDER = [4 2 3 5 6 1];
rgb = stack_to_rgb(stack, SCALE_MODE, HUES(ORDER), 90);
imtool(rgb);

[path, name, ext] = fileparts(files(i));
imwrite(rgb, fullfile(path, "rgb.png"));
