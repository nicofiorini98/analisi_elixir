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

% media = (data(:, 3) + data2(:, 3)) ./ 2;
% 
data(:,3) = media;

% byte_a_operazione = table2array(data(:,5) .* 17);
% un_mega = 1048576;
% tempo_secondi = table2array(data(:,3) .* 10^-6);
% 
% mega_sec = (byte_a_operazione / un_mega) ./ tempo_secondi;
% 
% data(:,3) = array2table(test);

% data(:,3) = ((data(:,5) .* 17 ) ./ 1048576) ./ (data(:,3) .* 10^-6);
% qui devo vedere i byte scritti su disco.


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
    ];
colors = colors / 255;
%processes = [1,2,3,4,5,6,7,8,16,32,64,128,256,512];
processes = [1,2,4,8,64,256];

for n =8:8

    figure;

    for i = 1:length(processes)

        num_processes = processes(i);

        % Filtra i dati per N_Processes = 1 e N_Products = 1
        filteredData = data(data.N_Processes == num_processes & data.N_Scheduler==n,:);

        filteredTime = (filteredData.Time ./ filteredData.N_Products);
        plot(filteredData.N_Products, filteredTime, 'Color', colors(i, :),'LineWidth',2);

        hold on

    end
    xlabel('N. Operazioni IO');
    ylabel('Time/operazione(microsec)');

    title('Grafico per n. Scheduler: ',n);
    

    % legend('1 process','2 processes','3 processes','4 processes', ...
    %     '5 processes','6 processes','7 processes','8 processes', ...
    %     '16 processes','32 processes','64 processes','128 processes',...
    %     '256 processes','512 processes');
    legend('1 process','2 processes','4 processes', ...
         '8 processes','64 processes', ...
         '256 processes');


end