# False Color Band Stacking

A method of turning a stack of monochromatic images into a false-color sRGB-safe, perceptually uniform image. Note that uniformity severely constrains the available color options, especially when the images have overlapping intensity, so it is recommended to sacrifice some perceptual uniformity for higher chroma and lower luminance.

The file `transform_stack.m` has an example of usage of the main entry-point `stack_to_rgb.m`.
