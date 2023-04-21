% Definir los parámetros de la señal
N = 10;
data = randi([0 1], [1 N]);  % Generar señal de datos aleatoria
sps = 10;                   % Tasa de muestreo
span = 6;                   % Duración del pulso de coseno alzado
rolloff = 0.5;              % Factor de roll-off

% Construir el filtro de transmisión
filt = rcosdesign(rolloff, span, sps);

% Transmitir la señal a través del canal
tx = upsample(data, sps);   % Interpolar la señal de datos
tx = filter(filt, 1, tx);   % Aplicar el filtro de transmisión
rx = awgn(tx, 10, 'measured'); % Agregar ruido blanco gaussiano

% Graficar el diagrama de ojo
eyediagram(rx, sps);
ylim([-2 2]);              % Ajustar los límites del eje y
xlabel('Tiempo (muestras)'); % Etiqueta del eje x
ylabel('Amplitud');           % Etiqueta del eje y
title('Diagrama de ojo de la señal recibida'); % Título de la figura