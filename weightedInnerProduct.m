function inner_product = weightedInnerProduct(x,c,u1,u2)
% Compute inner product
u1_conj = conj(u1);

integrand = u1_conj .* u2 ./c;

inner_product = trapz(x, integrand);
end