close all
clear all

% Initialize tax
taXinit;

% Simple open end tube
sys = tax('flame.slx', 700);
% sys = tax('flame.slx', 1400);

AcVec = getAcVec(sys);
close all;

X = sys.state.f.x;

% Plot
u = AcVec{2};

c = sys.state.f.c';
% c = ones(length(c),1);

figure;
plot(X, abs(u)./c);
ylabel('u (m/s)');
xlabel('x (m)');

numberOfModes = size(u,2);



for i=1:numberOfModes
    for j=1:numberOfModes
        u_i = u(:,i);
        u_j = u(:,j);
        
        % % Normalizing vectors
        % u_i = u_i / sqrt(innerProduct(X, u_i, u_i));
        % u_j = u_j / sqrt(innerProduct(X, u_j, u_j));
        % couplingMatrix(i,j) = innerProduct(X, u_i,u_j);

        u_i = u_i / sqrt(weightedInnerProduct(X, c, u_i, u_i));
        u_j = u_j / sqrt(weightedInnerProduct(X, c, u_j, u_j));
        couplingMatrix(i,j) = weightedInnerProduct(X, c, u_i,u_j);
    end
end

% couplingMatrix = couplingMatrix/couplingMatrix(1,1);
% couplingMatrix = round(couplingMatrix,2);

figure;
heatmap(abs(couplingMatrix));
title("Inner Product between modes");
