function value = outer(lhs, rhs)

value = lhs(:) * rhs(:).';
value = reshape(value, [size(lhs) size(rhs)]);
value = squeeze(value);

end

