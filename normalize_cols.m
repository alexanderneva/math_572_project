% File: Helper function to normalize columns of a matrix
function norm = normalize_cols(A,B)
  L = hypot(A,B)
  L == 0) = 1;
  A_norm = A ./ L;
  B_norm = B ./ L;
  norm = [A_norm,B_norm];
endfunction
