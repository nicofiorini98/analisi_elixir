# AnalisiElixir

## Esecuzione test

1. Sostituire la versione di elixir installata nel file mix.exs
2. Scaricare dipendenze con `mix deps.get`
3. ./runtest.sh(linux) ||  runtest.bat (windows)

## Concurrent Task

Nel modulo ConcurrentTask si trova il test relativo al
calcolo dei prodotti distribuiti su più processi.

Si può eseguire il test in più modi:

Con lo script dedicato per eseguire il test con diversi scheduler:
Per eseguire il test si può usare lo script
`./runTest.sh` per linux o `runTest.bat` per windows.

Oppure si può eseguire direttamente la funzione ConcurrentTask.run/1
direttamente avviando l'ambiente iex nel contesto dell'applicazione.

```bash
iex -S mix
ConcurrentTask.run # specify the file path if needed
```

## Concurrent IO

Nel modulo TaskIO viene effettuato il Test simile a Concurrent Task, ma
viene testata una funzione distribuibile che fa operazioni di Input dal
file ".File/read.json", vengono calcolati i risultati degli attributi e
stampati i risulati su un file csv chiamato "./File/write.csv",
questo per simulare operazioni di IO massive.

Per eseguire usare lo script `runTestIO.sh` se si vuole eseguire il test
utilizzando diversi scheduler da 1 a 16, oppure avviare iex nel contesto
dell'applicazione:

```bash
iex -S mix
TaskIO.run # specify the file path if needed
```

## Personalizzazione script

Se si vuole eseguire il test per un range di processi diversi,
modificare la tupla processes nella funzione run dei rispettivi
moduli.

Se si uvole eseguire il test per un range di operazioni o prodotti diversi,
modificare la variabile products_number e lo step da eseguire.

## File di riferimento

I risultati a cui si fa riferimento nella tesi si trovano nei file

- "./matlab/file_test/n_file2/": questa cartella contiene 20 test relativi ai prodotti

- "./matlab/file_test/n_fileIO2/": questa cartella contiene 20 relativi alle operazioni IO

## Matlab

Nella cartella Matlab sono presenti gli script utilizzati per analizzare i test.

- `analisi2.m` stampa il grafico delle performance dei prodotti, mediando i campioni di tempo presi
da 20 test effettuati, presenti nella cartella "./matlab/file_test/n_file2"

- `guadagno_mediato_products.m` stampa il grafico del guadagno nell'eseguire i prodotti con più processi rispetto
ad utilizzarne uno solo

- `analisi2_io.m` stampa il grafico delle performance dei prodotti, mediando i campioni di tempo presi
da 20 test effettuati, presenti nella cartella "./matlab/file_test/n_fileIO2"

- `guadagno_mediato_io.m` stampa il grafico del guadagno nell'eseguire le operazioni di IO con più processi rispetto
ad utilizzarne uno solo

- `gradiente.m` Stampa il grafico del gradiente nell'eseguire le operazioni di IO su m processi rispetto ad utilizzarne (m-k).

### Warning Matlab
Se si usa matlab con test eseguiti e non quelli presenti, fare attenzione ad inserire l'header
nel file csv, ovvero la riga:

```csv
N_Scheduler,N_Available_Scheduler,Time,N_Processes,N_Products,Time/N_Products
```
