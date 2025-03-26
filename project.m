% Initialize tax
taXinit;

% Simple open end tube
sys = tax('qwResonator.slx', 700);

AcVec = getAcVec(sys);
close all;

X = sys.state.f.x;

% Plot
u = AcVec{2};
figure;
plot(X, abs(u));
ylabel('u (m/s)');
xlabel('x (m)');
