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


% range = 500:250:20000;

range = 2000:2000:20000;

processes = [1,2,3,4,5,6,7,8,16,32,64,128,256,512];

colors = [
    255 0   0   % Red
    0   255 0   % Green
    0   0   255 % Blue
    % 255 255 0   % Yellow
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
    255 140 0   % Dark Orange
 ];

colors = colors / 255;


colonna_dati = data.N_Products;


% Trova gli indici degli elementi nell'array che soddisfano le condizioni
indici = find(data.N_Products >= 2000 & data.N_Products <= 20000 & mod(data.N_Products, 2000) == 0);

% Filtra l'array utilizzando gli indici trovati
data = data(indici,:);



for n = 8:8 % Scheduler

    figure
    xlabel('N_Products');
    ylabel('Time/Products');


  

    for r = 1:length(range')
        colore = colors(r,:);
        
        indice_r = find(data.N_Products == range(r));

        datar = data(indice_r,:);

        datar.gain = zeros(height(datar), 1);
        
        for k = 2:length(processes)

            differenza = (datar(k,3) - datar(1,3));

            datar(k,7) = differenza ./ datar(1,3);
        end

        datar = datar(2:end, :);
        processes2 = processes(1,2:end);

        plot(processes2, datar.gain , 'Color', colore, 'LineWidth',2);
        hold on;
    end

    % for k = 2:length(processes)
    % 
    %     colore = colors(k,:);
    % 
    %     Data1proc = data(data.N_Processes == processes(k-1) & data.N_Scheduler == n, :);
    % 
    %     Data1procfiltered = Data1proc.Time ./ Data1proc.N_Products;
    % 
    % 
    %     datifinali = zeros(size(range)); % Inizializza l'array dei dati finali per il processo corrente
    % 
    %     Data2proc = data(data.N_Processes == processes(k) & data.N_Scheduler == n, :);
    % 
    %     Data2procfiltered = Data2proc.Time ./ Data2proc.N_Products;
    % 
    %     % Calcola i dati finali per ciascun valore di N_Products
    % 
    %     datifinali = ((Data2procfiltered - Data1procfiltered)./Data1procfiltered);
    %     % datifinali = gradient(datisemifinali');
    % 
    % 
    % 
    %     % Traccia i dati finali per il processo corrente
    %     plot(range, datifinali, 'Color', colore, 'LineWidth',2);
    %     hold on;
    % end

    title('Guadagno per num scheduler', n);

    legend('2000 operations','4000 operations',...
        '6000 operations', '8000 processes','10000 processes', ...
        '12000 operations','14000 operations','16000 operations','18000 operations','20000 operations');
    % legend_entries = arrayfun(@(x) sprintf('Processi %d', x), processes, 'UniformOutput', false);
    % legend(legend_entries);
end