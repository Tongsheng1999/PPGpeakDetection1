%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% MODELO DE PULSO PPG %%%%%%%%%%%%%%%%%%
% Sumatoria de una Función LogNormal y una Gaussiana
% Valores por defecto de una función PPG común
% Sigma = 0.4;
% mu = 2.5;
% AmplitudGaussiana = 0.12;
% Sigma2 = 1;
% mu2 = 0.7;
% AmplLogNormal = 1.23;
function PPGSignal1 = ppgSignalModel(mu,mu2,Sigma,Sigma2,AmplLogNormal,AmplitudGaussiana,xi,xf)
%% Función Gaussiana
figure(1)
a = AmplitudGaussiana/sqrt(2*pi*Sigma.^2);
% x = 0:0.1:10;
x = linspace(xi,xf,100);
g = ((x-mu)/Sigma).^2;
f = a*exp(-0.5*g);

%% Función LogNormal
% Y = lognpdf(X,mu,sigma) returns values at X of the 
% lognormal pdf with distribution parameters mu and 
% sigma. mu and sigma are the mean and standard deviation,
% respectively, of the associated normal distribution
% a1 = x1.*sqrt(2*pi*c1.^2);
% g1 = log(((x1-b1)/2*c1).^2);2% f1 = a1*exp(-0.5*g1);
% plot(f1)
% % Amplitud LogNormal
 y2 = AmplLogNormal.*lognpdf(x,mu2,Sigma2);

 PPGSignal1 = y2+f;
 plot(PPGSignal1), grid on
end