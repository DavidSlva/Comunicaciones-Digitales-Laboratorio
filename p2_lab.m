clc;
A = 1; % Amplitud de la señal mensaje

fc = 20000;
fm =1000;
fs = 10000000;
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
figure("Name","Modulación Instantanea")
subplot(3,1,1);
plot(n,s);
title("Señal Transportadora");
xlabel("Tiempo");
ylabel("Amplitud");
ylim([-0.2 1.2]);
xlim(lX);

subplot(3,1,2);
plot(n,m);
title("Señal Moduladora");
xlabel("Tiempo");
ylabel("Amplitud");
ylim([-1.2 1.2]);
xlim(lX);

subplot(3,1,3);
plot(n,pam_gate);
title("Señal Modulada");
xlabel("Tiempo");
ylabel("Amplitud");
ylim([-1.2 1.2]);
xlim(lX);

%_______________________________
figure("Name","Modulación Natural");

pam_flat = m.*s;

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



