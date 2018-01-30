%Abrindo a música no matlab
[y,fs] = audioread('pds.wav');
%Criando o objeto de áudio
player = audioplayer (y, fs);  
%Tocando a música original
play(player);

%Loop para criar ruídos com SNR de -10, 0 e 0 db
for snruido = -10:10:10
    %Adicionado ruído branco ao sinal original
    j = awgn(y, snruido, 'measured');
    %Criando objeto de áudio com ruído
    player2 = audioplayer(j, fs);
    
    disp("Sinal com ruído branco com " + snruido + "db");
    %Calculando SNR entre o sinal original e o sinal com ruído
    ruidoj = snr(y, j);
    disp("SNR do ruído original: " + ruidoj);
    
    %Tocando o áudio com ruído
    play(player2);
    
    %Definindo frequência de corte
    fc = 700;

    %Definindo os coeficientes do filtro de Butterworth com ordem 9
    [b,a] = butter(9,fc/(fs/2),'high');
    %Filtrando o áudio com ruído no filtro Butterworth
    k = filter(b,a,j);

    %Criando objeto de áudio
    player3 = audioplayer(k, fs);

    disp("Filtro ButterWorth passa-alta com Frequência de corte de 700Hz");
    %Calculando SNR entre o sinal original e o sinal com ruído após o
    %filtro Butterworth
    ruidok = snr(y, k);
    disp("SNR com filtro ButterWorth: " + ruidok);

    %Tocando o áudio após passar pelo filtro Butterworth
    play(player3);

    %Definindo o tamanho das janelas
    windowSize = 10; 
    %Definindo os coeficientes para o método das janelas
    b = (1/windowSize)*ones(1,windowSize);
    a = 1;
    
    %Filtrando o sinal com ruído no método de janelas
    q = filter(b,a,j);

    %Criando objeto de áudio
    player4 = audioplayer(q, fs);

    disp("Método das janelas com tamanho 10");
    %Calculando SNR entre o sinal original e o sinal com ruído após o
    %método das janelas
    ruidoq = snr(y, q);
    disp("SNR com o método de janelas: " + ruidoq);
    
    %Tocando o áudio após passar pelo método das janelas (com média móvel)
    play(player4); 
end