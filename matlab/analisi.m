opts = detectImportOptions('/home/nico/project/tesi/analisi_elixir/File/test_concorrenza2.csv');
opts.DataLine = 2;
data = readtable('/home/nico/project/tesi/analisi_elixir/File/test_concorrenza2.csv', opts);

%colors_names = ['red', 'green', 'blue', 'cyan', 'magenta', 'yellow', 'black'];
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
processes = [1,2,3,4,5,6,7,8,16,32,64,128,256];

for n = 1:1

    figure;

    for i = 1:length(processes)

        num_processes = processes(i);

        % Filtra i dati per N_Processes = 1 e N_Products = 1
        filteredData = data(data.N_Processes == num_processes & data.N_Scheduler==n,:);

        filteredTime = ...
             (filteredData.Time ./filteredData.N_Products);
        %filteredTime = (filteredData.Time);
        plot(filteredData.N_Products, filteredTime, 'Color', colors(i, :));

        hold on

    end
    xlabel('N_Products');
    ylabel('Time/Products');

    title('Grafico per n. Scheduler: ',n);

    legend('1 process','2 processes','3 processes','4 processes', ...
        '5 processes','6 processes','7 processes','8 processes', ...
        '16 processes','32 processes','64 processes','128 processes','256 processes');

end