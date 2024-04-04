opts = detectImportOptions('/home/nico/project/tesi/analisi_elixir/File/test_nico.csv');
opts.DataLine = 2;
data = readtable('/home/nico/project/tesi/analisi_elixir/File/test_nico.csv', opts);

inizio = 0;  % Variabile di esempio
valore1=1;
array = 500:500:100000;  % Array da 501 a 1000000 con passo 500
range= horzcat(inizio, valore1, array);
processes= [2,3,4,5,6,7,8,16,32,64,128];

%h = fir1(10, 0.1);
for n=1:16%scheduler
    Data1proc = data(data.N_Processes == 1 & data.N_Scheduler==n, :);
    %Data1procfiltered = filter(h, 1,Data1proc.Time./ Data1proc.N_Products);
    Data1procfiltered = Data1proc.Time./ Data1proc.N_Products;

    % Creazione del grafico
    figure
    xlabel('N_Products');
    ylabel('Time/Products');
    title('Guadagno per num scheduler', n);

    colori = lines(21); % Genera una matrice di 10 colori distinti
    for k=1:length(processes)
        datifinali = [];
        colore = colori(k, :); % Seleziona il colore in base all'indice del ciclo

        Data2proc = data(data.N_Processes == processes(k) & data.N_Scheduler==n , :);
        %Data2procfiltered = filter(h, 1,Data2proc.Time ./ Data2proc.N_Products);
        Data2procfiltered = Data2proc.Time ./ Data2proc.N_Products;

        %scorre la matrice Data2proc per riga
        for i=1:height(Data2proc)
            riga = Data2proc(i,:);
            if any(range ==(riga.N_Products/processes(k))) % (Data2proc(i).N_Products/2))
                %qui devo plottare il valore rispetto a un processo
                tmp = find(Data1proc.Time == Data1proc.Time(Data1proc.N_Products == (riga.N_Products/processes(k))) & Data1proc.N_Products == (riga.N_Products/processes(k)));
                % tmp1 valore normalizzato
                tmp1=  Data2procfiltered(i)./ Data1procfiltered(tmp);
                %tmp1 = tmp ./ (riga.Time)/(riga.N_Products./2);


                datifinali(i,1)=(riga.N_Products); %/k
                datifinali(i,2)=tmp1;
                % plot((riga.N_Products./2),((riga.Time./riga.N_Products)./tmp1), 'Color', 'red');


            else
                differenza=[];
                for j=1:length(range)
                    tmp = abs(range(j) - (riga.N_Products/processes(k)));
                    differenza = [differenza, tmp];
                end
                val_min(1) = min(differenza);

                index_min = find(differenza == val_min(1));  %qui io voglio che sia solo uno il minimo ma se ci sono due valori uguali che sono il minimo ho un array
                %disp("index min");
                %  disp(index_min(1));


                if index_min(1)==1
                    %disp("ecco");
                    val_succ=1;
                    val_prec=0;
                elseif (range(index_min(1)) > (riga.N_Products/processes(k)))
                    val_succ=range(index_min);
                    val_prec=range(index_min-1);
                else
                    val_succ=range(index_min+1);
                    val_prec=range(index_min);
                end
                

                if index_min(1)==1
                    % disp("qui");
                    y0=0;
                    %y1=(Data1proc.Time(Data1proc.N_Products== 1))./ (Data1proc.N_Products(Data1proc.N_Products== 1));
                    y1=Data1procfiltered(1);
                else
                    % disp(Data1proc.Time(Data1proc.N_Products==val_prec(1)));
                    valore = (Data1proc.Time(Data1proc.N_Products==val_prec(1)));
                    %disp(valore);
                    tmp= find(Data1proc.Time == valore &  Data1proc.N_Products == val_prec(1));
                    %disp(tmp);

                    y0=  Data1procfiltered(tmp);
                    %disp(y0);
                    valore=(Data1proc.Time(Data1proc.N_Products==val_succ(1)));
                    tmp= find(Data1proc.Time== valore   &  Data1proc.N_Products == val_succ(1));
                    % disp(tmp);
                    y1= Data1procfiltered(tmp);
                    %disp(y1);
                    %y0= (Data1proc.Time(Data1proc.N_Products==val_prec(1)))./(Data1proc.N_Products(Data1proc.N_Products== val_prec(1)));
                    %y1= (Data1proc.Time(Data1proc.N_Products==val_succ(1)))./ (Data1proc.N_Products(Data1proc.N_Products== val_succ(1)));
                end

                Ax=[val_prec(1), val_succ(1)];
                By=[y0, y1];
                y_interp= interp1(Ax,By, riga.N_Products/processes(k),'linear');

                datifinali(i,1)=(riga.N_Products);% /k
                datifinali(i,2)= Data2procfiltered(i)/y_interp;%(riga.Time./riga.N_Products)/y_interp;
                %plot(riga.N_Products, (riga.Time./riga.N_Products)/y_interp, 'color','red');%non plotta nulla


            end


        end


        hold on;

        plot(datifinali(1:1:end,1), datifinali(1:1:end,2), 'Color',colore, 'DisplayName', sprintf('Linea %d', processes(k)));

    end
    legend;
end