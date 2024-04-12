clear;
opts = detectImportOptions(['C:\Users\1dnic\Desktop\Tesi\analisi_elixir\matlab\file_test\n_file_IO\fileIO1.csv']);
opts.DataLine = 2;
data = readtable(['C:\Users\1dnic\Desktop\Tesi\analisi_elixir\matlab\file_test\n_file_IO\fileIO1.csv'], opts);



byte_a_operazione = table2array(data(:,5) .* 17);
un_mega = 1048576;
tempo_secondi = table2array(data(:,3) .* 10^-6);

megabyte_sec= (byte_a_operazione / un_mega) ./ tempo_secondi;

data(:,3) = array2table(megabyte_sec);
