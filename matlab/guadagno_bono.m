opts = detectImportOptions('/home/nico/project/tesi/analisi_elixir/File/test_concorrenza2.csv');
opts.DataLine = 2;
data = readtable('/home/nico/project/tesi/analisi_elixir/File/test_concorrenza.csv', opts);
valore1 = 500;
range = 500:500:100000;
processes = [2, 3, 4, 5, 6, 7, 8, 16, 32, 64, 128];
for n = 1:16 % Scheduler
    Data1proc = data(data.N_Processes == 1 & data.N_Scheduler == n, :);
    Data1procfiltered = Data1proc.Time ./ Data1proc.N_Products;
    figure
    xlabel('N_Products');
    ylabel('Time/Products');
   
    colori = lines(length(processes));

    for k = 1:length(processes)
        datifinali = zeros(size(range)); % Inizializza l'array dei dati finali per il processo corrente
        Data2proc = data(data.N_Processes == processes(k) & data.N_Scheduler == n, :);
        Data2procfiltered = Data2proc.Time ./ Data2proc.N_Products;
        % Calcola i dati finali per ciascun valore di N_Products
        for i = 1:height(Data2proc)
            riga = Data2proc(i, :);
            idx = find(range == riga.N_Products);
            datifinali(idx) = Data1procfiltered(i) ./ Data2procfiltered(i); % Calcola e assegna il dato finale all'indice corrispondente di range
        end
        
        % Traccia i dati finali per il processo corrente
        plot(range, datifinali, 'Color', colori(k, :));
        hold on;
    end

    title('Guadagno per num scheduler', n);
    legend_entries = arrayfun(@(x) sprintf('Processo %d', x), processes, 'UniformOutput', false);
    legend(legend_entries);
end