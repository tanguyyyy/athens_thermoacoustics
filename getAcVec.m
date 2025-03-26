function AcVec = getAcVec(varargin)
% Plot eigenvalues and eigenvectors of system.
% ------------------------------------------------------------------
% This file is part of tax, a code designed to investigate
% thermoacoustic network systems. It is developed by the
% Professur fuer Thermofluiddynamik, Technische Universitaet Muenchen
% For updates and further information please visit www.tfd.mw.tum.de
% ------------------------------------------------------------------
% plotEigenModes(sys, MinGrowthMaxfreq)
% Input:        * sys: thermoacoustic network (tax) model object
%      optional * MinGrowthMaxfreq: Limit display to range
%
% ------------------------------------------------------------------
% Authors:      Thomas Emmert, Felix Schily (schily@tfd.mw.tum.de)
% Last Change:  27 Oct 2017
% ------------------------------------------------------------------

sys = varargin{1};
numfMax = max(cellfun(@(x) sys.fMax.(x), sys.waves));

if nargin>=2
    MinGrowthMaxfreq = varargin{2};
else
    MinGrowthMaxfreq = -numfMax*2*pi+1i*numfMax*2*pi;
end

% [result.V, D, flag] = eigs(sys, 10, 150*2i*pi); % Sparse eigs command
[result.V, D, result.W] = eig(sys);
D = diag(D);
result.D = D;

% figure('name','Eigenvalues limited by MinGrowthMaxfreq in [Hz]')
% plot(real(result.D)/(2*pi), imag(result.D)/(2*pi),'.k','MarkerSize',7,'LineWidth', 1)
% ylim([0, numfMax]);xlim([-numfMax, max(real(result.D)/(2*pi))]);
% xlabel('Growth rate [1/s]')
% ylabel('Frequency [Hz]')

% figure('name','All eigenvalues in [rad/s]')
% pzmap(ss(sys))

C_f = sys.c(sys.OutputGroup.f,:);
C_g = sys.c(sys.OutputGroup.g,:);

f = C_f*result.V;
g = C_g*result.V;
[AcVec, name, unit] = sys.calcProperty(f, g, sys.property);

% Limit modes to be plotted to frequency range
idxOmega = (imag(D)<imag(MinGrowthMaxfreq))&(real(D)>real(MinGrowthMaxfreq))&(imag(D)>0);
if isempty(idxOmega)
    error('No frequency is in the MinGrowthMaxfreq range. Plotting aborted')
end
omega= D(idxOmega);
for i = 1:length(AcVec)
    AcVec{i} = AcVec{i}(:,idxOmega);
end

% [result.axis, result.linkedaxis] = sys.plotStateVector(AcVec, name, unit, omega, 'eigenmodes');