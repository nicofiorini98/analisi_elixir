clear;
opts = detectImportOptions(['/home/nico/project/tesi/analisi_elixir/matlab/file_test/n_file_IO2/fileIO1.csv']);
opts.DataLine = 2;
data = readtable(['/home/nico/project/tesi/analisi_elixir/matlab/file_test/n_file_IO2/fileIO1.csv'], opts);

data2 = readtable(['/home/nico/project/tesi/analisi_elixir/matlab/file_test/n_file_IO2/fileIO2.csv'], opts);

data3 = readtable(['/home/nico/project/tesi/analisi_elixir/matlab/file_test/n_file_IO2/fileIO3.csv'], opts);

data4 = readtable(['/home/nico/project/tesi/analisi_elixir/matlab/file_test/n_file_IO2/fileIO4.csv'], opts);

data5 = readtable(['/home/nico/project/tesi/analisi_elixir/matlab/file_test/n_file_IO2/fileIO5.csv'], opts);

data6 = readtable(['/home/nico/project/tesi/analisi_elixir/matlab/file_test/n_file_IO2/fileIO6.csv'], opts);

data7 = readtable(['/home/nico/project/tesi/analisi_elixir/matlab/file_test/n_file_IO2/fileIO7.csv'], opts);

data8 = readtable(['/home/nico/project/tesi/analisi_elixir/matlab/file_test/n_file_IO2/fileIO8.csv'], opts);

data9 = readtable(['/home/nico/project/tesi/analisi_elixir/matlab/file_test/n_file_IO2/fileIO9.csv'], opts);

data10 = readtable(['/home/nico/project/tesi/analisi_elixir/matlab/file_test/n_file_IO2/fileIO10.csv'], opts);

data11 = readtable(['/home/nico/project/tesi/analisi_elixir/matlab/file_test/n_file_IO2/fileIO11.csv'], opts);

data12 = readtable(['/home/nico/project/tesi/analisi_elixir/matlab/file_test/n_file_IO2/fileIO12.csv'], opts);

data13 = readtable(['/home/nico/project/tesi/analisi_elixir/matlab/file_test/n_file_IO2/fileIO13.csv'], opts);

data14 = readtable(['/home/nico/project/tesi/analisi_elixir/matlab/file_test/n_file_IO2/fileIO14.csv'], opts);

data15 = readtable(['/home/nico/project/tesi/analisi_elixir/matlab/file_test/n_file_IO2/fileIO15.csv'], opts);

data16 = readtable(['/home/nico/project/tesi/analisi_elixir/matlab/file_test/n_file_IO2/fileIO16.csv'], opts);

data17 = readtable(['/home/nico/project/tesi/analisi_elixir/matlab/file_test/n_file_IO2/fileIO17.csv'], opts);

data18 = readtable(['/home/nico/project/tesi/analisi_elixir/matlab/file_test/n_file_IO2/fileIO18.csv'], opts);

data19 = readtable(['/home/nico/project/tesi/analisi_elixir/matlab/file_test/n_file_IO2/fileIO19.csv'], opts);

data20 = readtable(['/home/nico/project/tesi/analisi_elixir/matlab/file_test/n_file_IO2/fileIO20.csv'], opts);

media = (data(:, 3) + data2(:, 3) + data3(:,3) + data4(:,3) + data5(:, 3) ...
    + data6(:,3) + data7(:, 3) + data8(:, 3) + data9(:,3) + data10(:,3) + data11(:, 3) + data12(:, 3) ...
    + data13(:,3) + data14(:,3) + data15(:, 3) ...
    + data16(:,3) + data17(:, 3) + data18(:, 3) + data19(:,3) + data20(:,3)) ./ 20;

data(:,3) = media;


range = 500:250:20000;
%processes = [2,3,4,5,6,7,8,16,32,64,128,256,512];
processes = [2,3,4,5,6,7,8,16,32,64,128,256,512];
colors = [
    255 0   0   % Red
    0   255 0   % Green
    0   0   255 % Blue
    255 255 0   % Yellow
    0   255 255 % Cyan
    255 0   255 % Magenta
    128 128 128 % Gray
    255 128 0   % Orange
    128 0   128 % Purple
    0   128 128 % Teal
    128 128 0   % Olive
    255 165 0   % Orange (Web Color)
    0   255 127 % Spring Green % da togliere
    218 112 214 % Orchid
    70  130 180 % Steel Blue
    255 20  147 % Deep Pink
    0   255 255 % Aqua
    255 215 0   % Gold
    255 105 180 % Hot Pink
    255 140 0   % Dark Orange
    ];

colors = colors / 255;

for n = 8:8 % Scheduler
    Data1proc = data(data.N_Processes == 1 & data.N_Scheduler == n, :);
    Data1procfiltered = Data1proc.Time ./ Data1proc.N_Products;
    figure
    xlabel('N_Products');
    ylabel('Time/Products');

    for k = 1:length(processes)
        
        colore = colors(k,:);
        
        datifinali = zeros(size(range)); % Inizializza l'array dei dati finali per il processo corrente
        Data2proc = data(data.N_Processes == processes(k) & data.N_Scheduler == n, :);
        Data2procfiltered = Data2proc.Time ./ Data2proc.N_Products;

        % Calcola i dati finali per ciascun valore di N_Products

        datifinali = ((Data2procfiltered - Data1procfiltered)./Data1procfiltered)*100;
        %datifinali = Data2procfiltered ./ Data1procfiltered;

       
        
        % Traccia i dati finali per il processo corrente
        plot(range, datifinali, 'Color', colore);
        hold on;
    end

    title('Guadagno per num scheduler', n);
    legend_entries = arrayfun(@(x) sprintf('Processi %d', x), processes, 'UniformOutput', false);
    legend(legend_entries);
end