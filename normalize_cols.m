% File: Helper function to normalize columns of a matrix
function A_norm = normalize_cols(A)
  norms = sqrt(sum(A.^2, 1));
  norms(norms == 0) = 1;
  A_norm = A ./ norms;
endfunction
