Fs = 10; % Frecuencia de muestreo
Ts = 1 / Fs; % Periodo de muestreo
t = -0.5:Ts:0.5; % Vector tiempo

rolloff1 = 0;
rolloff2 = 0.25;
rolloff3 = 0.75;
rolloff4 = 1;

f0 = 6; % dB
ft = rolloff1.*f0;
f1 = f0-ft;

B = ft+f0;
% dmB = -0.5:Ts:0.5;

ft1 = rolloff1.*f0;
ft2 = rolloff2.*f0;
ft3 = rolloff3.*f0;
ft4 = rolloff4.*f0;

%respuesta impulso
ht1 = 2.*f0.*(sinc(2*f0.*t)).*(cos(2*pi*ft1.*t)./(1-(4*ft1.*t).^2));
ht2 = 2.*f0.*(sinc(2*f0.*t)).*(cos(2*pi*ft2.*t)./(1-(4*ft2.*t).^2));
ht3 = 2.*f0.*(sinc(2*f0.*t)).*(cos(2*pi*ft3.*t)./(1-(4*ft3.*t).^2));
ht4 = 2.*f0.*(sinc(2*f0.*t)).*(cos(2*pi*ft4.*t)./(1-(4*ft4.*t).^2));

% figure("Name","Respuesta impulso");
% hold on;
% title('Respuesta al impulso');
% plot(t, ht1, 'b');
% plot(t, ht2, 'r');
% plot(t, ht3, 'g');
% plot(t, ht4, 'cyan');
% legend('RollOff 0.00','RollOff 0.25', 'RollOff 0.75', 'RollOff 1.00');
% hold off;

% respuesta en frequencia
hf = zeros(1,length(ht1));

f = 1./t;
for i = 1 : length(hf)
    if (abs(f(i))<f1)
        hf(i) = 1;
    elseif (abs(f(i))>f1 && abs(f(i))<B)
        hf(i) = 0.5.*(1+cos(pi*(abs(f(i))-f1)./(2*ft)));
    end
end
% figure("Name","No estoy seguro");
% plot(t,hf);


% Generamos valores aleatorios binarios de 1 hasta 10*4
n = 10000;
binaryRand = randi([0,1], [1,n]);
% Al utilizar la codificación el linea NRZ-L, vamos a utilizar los 10V
% como alto
binaryRand = 10.*binaryRand;

% cosenoAlzado1 = rcosdesign(rolloff1,f0,2);
% cosenoAlzado2 = rcosdesign(rolloff2,f0,2);
% cosenoAlzado3 = rcosdesign(rolloff3,f0,2);
% cosenoAlzado4 = rcosdesign(rolloff4,f0,2);

cosenoAlzado1 = rcosdesign(rolloff1,f0,Fs);
cosenoAlzado2 = rcosdesign(rolloff2,f0,Fs);
cosenoAlzado3 = rcosdesign(rolloff3,f0,Fs);
cosenoAlzado4 = rcosdesign(rolloff4,f0,Fs);



figure("Name","Coseno Alzado en frecuencia");
hold on;
plot(cosenoAlzado1, 'b');
plot(cosenoAlzado1, 'r');
plot(cosenoAlzado3, 'g');
plot(cosenoAlzado4, 'cyan');
legend('RollOff 0.00','RollOff 0.25', 'RollOff 0.75', 'RollOff 1.00');
hold off;

senal1 = upfirdn(binaryRand, cosenoAlzado1,2);
senal2 = upfirdn(binaryRand, cosenoAlzado2,2);
senal3 = upfirdn(binaryRand, cosenoAlzado3,2);
senal4 = upfirdn(binaryRand, cosenoAlzado4,2);

% figure("Name","coseno alzado");
% hold on;
% plot(senal1, 'b');
% plot(senal2, 'r');
% plot(senal3, 'g');
% plot(senal4, 'cyan');
% legend('RollOff 0.00','RollOff 0.25', 'RollOff 0.75', 'RollOff 1.00');
% hold off;

senalRuido1= awgn(senal1,10);
senalRuido2 = awgn(senal2,10);
senalRuido3 = awgn(senal3,10);
senalRuido4 = awgn(senal4,10);

% figure("Name","coseno alzado con ruido");
% hold on;
% plot(senalRuido1);
% plot(senalRuido2);
% plot(senalRuido3);
% plot(senalRuido4);
% hold off;


eyediagram(senalRuido1,2);
title('Diagrama de ojo con señal 1');
eyediagram(senalRuido2,2);
title('Diagrama de ojo con señal 2');
eyediagram(senalRuido3,2);
title('Diagrama de ojo con señal 3');
eyediagram(senalRuido4,2);
title('Diagrama de ojo con señal 4');


