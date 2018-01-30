%Abrindo a m�sica no matlab
[y,fs] = audioread('pds.wav');
%Criando o objeto de �udio
player = audioplayer (y, fs);  
%Tocando a m�sica original
play(player);

%Loop para criar ru�dos com SNR de -10, 0 e 0 db
for snruido = -10:10:10
    %Adicionado ru�do branco ao sinal original
    j = awgn(y, snruido, 'measured');
    %Criando objeto de �udio com ru�do
    player2 = audioplayer(j, fs);
    
    disp("Sinal com ru�do branco com " + snruido + "db");
    %Calculando SNR entre o sinal original e o sinal com ru�do
    ruidoj = snr(y, j);
    disp("SNR do ru�do original: " + ruidoj);
    
    %Tocando o �udio com ru�do
    play(player2);
    
    %Definindo frequ�ncia de corte
    fc = 700;

    %Definindo os coeficientes do filtro de Butterworth com ordem 9
    [b,a] = butter(9,fc/(fs/2),'high');
    %Filtrando o �udio com ru�do no filtro Butterworth
    k = filter(b,a,j);

    %Criando objeto de �udio
    player3 = audioplayer(k, fs);

    disp("Filtro ButterWorth passa-alta com Frequ�ncia de corte de 700Hz");
    %Calculando SNR entre o sinal original e o sinal com ru�do ap�s o
    %filtro Butterworth
    ruidok = snr(y, k);
    disp("SNR com filtro ButterWorth: " + ruidok);

    %Tocando o �udio ap�s passar pelo filtro Butterworth
    play(player3);

    %Definindo o tamanho das janelas
    windowSize = 10; 
    %Definindo os coeficientes para o m�todo das janelas
    b = (1/windowSize)*ones(1,windowSize);
    a = 1;
    
    %Filtrando o sinal com ru�do no m�todo de janelas
    q = filter(b,a,j);

    %Criando objeto de �udio
    player4 = audioplayer(q, fs);

    disp("M�todo das janelas com tamanho 10");
    %Calculando SNR entre o sinal original e o sinal com ru�do ap�s o
    %m�todo das janelas
    ruidoq = snr(y, q);
    disp("SNR com o m�todo de janelas: " + ruidoq);
    
    %Tocando o �udio ap�s passar pelo m�todo das janelas (com m�dia m�vel)
    play(player4); 
end