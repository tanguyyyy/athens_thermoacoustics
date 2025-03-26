function inner_product = innerProduct(x, u1,u2)
% Compute inner product
u1_conj = conj(u1);

integrand = u1_conj .* u2;

inner_product = trapz(x, integrand);
end