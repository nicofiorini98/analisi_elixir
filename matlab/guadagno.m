opts = detectImportOptions('C:\Users\Utente\TestElixir\analisi_elixir\File\testIO.csv');
opts.DataLine = 2;
data = readtable('C:\Users\Utente\TestElixir\analisi_elixir\File\testIO.csv', opts);

valore1=500;
range = 500:500:100000;  % Array da 501 a 1000000 con passo 500
processes= [2,3,4,5,6,7,8,16,32,64,128];


for n=1:1%scheduler

    Data1proc = data(data.N_Processes == 1 & data.N_Scheduler==n, :);

    % Creazione del grafico
    figure
    xlabel('N_Products');
    ylabel('Time/Products');
    title('Guadagno per num scheduler', n);

    colori = lines(21); % Genera una matrice di 10 colori distinti

    for k=1:length(processes)
        %datifinali = zeros(size(range));

        colore = colori(k, :); % Seleziona il colore in base all'indice del ciclo
        Data2proc = data(data.N_Processes == processes(k) & data.N_Scheduler==n , :);
        %Data2procfiltered = filter(h, 1,Data2proc.Time ./ Data2proc.N_Products);
        %Data2procfiltered = Data2proc.Time ./ Data2proc.N_Products;
        %scorre la matrice Data2proc per riga
        %for i=1:height(Data2proc)
           
        datifinali = Data1procfiltered./Data2procfiltered;

        %end
        plot(range, datifinali, 'Color',colore);
        hold on;
    end
    legend;
end
