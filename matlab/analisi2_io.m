opts = detectImportOptions(['C:\Users\1dnic\Desktop\Tesi\analisi_elixir\matlab\file_test\n_file_IO\fileIO1.csv']);
opts.DataLine = 2;
data = readtable(['C:\Users\1dnic\Desktop\Tesi\analisi_elixir\matlab\file_test\n_file_IO\fileIO1.csv'], opts);

data2 = readtable(['C:\Users\1dnic\Desktop\Tesi\analisi_elixir\matlab\file_test\n_file_IO\fileIO2.csv'], opts);

data3 = readtable(['C:\Users\1dnic\Desktop\Tesi\analisi_elixir\matlab\file_test\n_file_IO\fileIO3.csv'], opts);

data4 = readtable(['C:\Users\1dnic\Desktop\Tesi\analisi_elixir\matlab\file_test\n_file_IO\fileIO3.csv'], opts);

data5 = readtable(['C:\Users\1dnic\Desktop\Tesi\analisi_elixir\matlab\file_test\n_file_IO\fileIO5.csv'], opts);

data6 = readtable(['C:\Users\1dnic\Desktop\Tesi\analisi_elixir\matlab\file_test\n_file_IO\fileIO6.csv'], opts);

data7 = readtable(['C:\Users\1dnic\Desktop\Tesi\analisi_elixir\matlab\file_test\n_file_IO\fileIO7.csv'], opts);

data8 = readtable(['C:\Users\1dnic\Desktop\Tesi\analisi_elixir\matlab\file_test\n_file_IO\fileIO8.csv'], opts);

data9 = readtable(['C:\Users\1dnic\Desktop\Tesi\analisi_elixir\matlab\file_test\n_file_IO\fileIO9.csv'], opts);

data10 = readtable(['C:\Users\1dnic\Desktop\Tesi\analisi_elixir\matlab\file_test\n_file_IO\fileIO10.csv'], opts);

datimediati = (data(:, 3) + data2(:, 3) + data3(:,3) + data4(:,3) + data5(:, 3) ...
    + data6(:,3) + data7(:, 3) + data8(:, 3) + data9(:,3) + data10(:,3)) ./ 10;

data(:,3) = datimediati;

byte_a_operazione = table2array(data(:,5) .* 17);
un_mega = 1048576;
tempo_secondi = table2array(data(:,3) .* 10^-6);

mega_sec = (byte_a_operazione / un_mega) ./ tempo_secondi;

data(:,3) = array2table(test);

% data(:,3) = ((data(:,5) .* 17 ) ./ 1048576) ./ (data(:,3) .* 10^-6);
% qui devo vedere i byte scritti su disco.


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
%processes = [1,2,3,4,5,6,7,8,16,32,64,128,256,512];
processes = [1,2,3,4,5,6,7,8,16,32,64,128,256,512];

for n =8:8

    figure;

    for i = 1:length(processes)

        num_processes = processes(i);

        % Filtra i dati per N_Processes = 1 e N_Products = 1
        filteredData = data(data.N_Processes == num_processes & data.N_Scheduler==n,:);

        filteredTime = (filteredData.Time);
        plot(filteredData.N_Products, filteredTime, 'Color', colors(i, :));

        hold on

    end
    xlabel('N. Operazioni IO');
    ylabel('Time/operazione(microsec)');

    title('Grafico per n. Scheduler: ',n);

    legend('1 process','2 processes','3 processes','4 processes', ...
        '5 processes','6 processes','7 processes','8 processes', ...
        '16 processes','32 processes','64 processes','128 processes',...
        '256 processes','512 processes');
    % legend('1 process','2 processes','3 processes','4 processes', ...
    %      '5 processes','6 processes','7 processes','8 processes', ...
    %      '16 processes','128 processes','256 processes');


end