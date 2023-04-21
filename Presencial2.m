clc;
A = 1; % Amplitud de la señal mensaje

fc = 20000;
fm =1000;
fs = 1000000;
t=1;
lX = [0.0 0.001];

n = [0:1/fs:t];
n = n(1:end-1); % Se elimina la última muestra del vector para que quede par en la cantidad de elementos

d = 50; % Ciclo de trabajo. Corresponde a un 50%

s = square(2*pi*fc*n,d); % Señal cuadrada
s(find(s<0))=0;   % Se toman solo los valores positivos, por que así es como se comportan los pulsos de la señal portadora

m = A*sin(2*pi*fm*n); % Señal Moduladora
period_sam = length(n)/fc;     % Número de muestras que tiene la señal transportadora
ind = 1:period_sam:length(n);   %
on_samp = ceil(period_sam * d/100);   %
pam_gate = zeros(1,length(n));
for i =1:length(ind)
    pam_gate(ind(i):ind(i)+on_samp) = m(ind(i));
end


% Cálculo de la fourier de la señal sinusoidal
fr_m = fft(m); % Fourier de Sinoudal, con frecuencia de señal = fm; 
N = length(fr_m);
fr_m_f = (-N/2:N/2-1)/(N*1 / 1); 
fr_m_f_s = fftshift(fr_m_f);

%Calculo de fourier de la señal PAM instantanea
pam_flat = m.*s;
fr_flat = fft(pam_flat);
N = length(fr_flat);
fr_flat_f = (-N/2:N/2-1)/(N*1 / 1); 
fr_flat_f_s = fftshift(fr_flat_f);

% z = (0:length(fourier_sinoudal) - 1) * fs/length(fourier_sinoudal);

figure("Name","Sin, Natural and Instant");

subplot(3,1,1);
stem(fr_m_f_s, abs(fr_m))
title("Fourier de sinusoidal");
xlabel("Frecuencia");
% ylabel("Amplitud");
figure("Name","Modulación Natural");



subplot(3,1,2);
stem(fr_flat_f_s,abs(fr_flat_f));
title("Fourier de PAM instantanea");
xlabel("Frecuencia");

%{
figure("Name","Modulación Instantanea");
subplot(4,1,1);
plot(n,s);
title("Señal Transportadora");
xlabel("Tiempo");
ylabel("Amplitud");
ylim([-0.2 1.2]);
xlim(lX);

subplot(4,1,2);
plot(n,m);
title("Señal Moduladora");
xlabel("Tiempo");
ylabel("Amplitud");
ylim([-1.2 1.2]);
xlim(lX);

%}




%{
subplot(3,1,1);
plot(n,s);
title("Señal Transportadora");
xlabel("Tiempo");
ylabel("Amplitud");
ylim([-0.2 1.2]);
xlim(lX);

subplot(3,1,2);
plot(n,m);
xlim(lX);
title("Señal Moduladora");
xlabel("Tiempo");
ylabel("Amplitud");
ylim([-1.2 1.2]);

subplot(3,1,3);
plot(n,pam_flat);
title("Señal Modulada");
xlabel("Tiempo");
ylabel("Amplitud");
ylim([-1.2 1.2]);
xlim(lX);
%}
