#!/bin/bash

cd /home/nico/project/tesi/analisi_elixir
iex --erl "+S 1" --dot-iex "runTest.iex" -S mix
iex --erl "+S 2" --dot-iex "runTest.iex" -S mix
iex --erl "+S 3" --dot-iex "runTest.iex" -S mix
iex --erl "+S 4" --dot-iex "runTest.iex" -S mix
iex --erl "+S 5" --dot-iex "runTest.iex" -S mix
iex --erl "+S 6" --dot-iex "runTest.iex" -S mix
iex --erl "+S 7" --dot-iex "runTest.iex" -S mix
iex --erl "+S 8" --dot-iex "runTest.iex" -S mix



# Replace with actual paths
# iex_path="/path/to/iex"
# run_test_path="/path/to/runTest.iex"

# # Loop through +S values
# for s in {1..1}; do
#   # Add +sbt db for values 8 and above
#   if [[ $s -gt 8 ]]; then
#     iex_command="$iex_path --erl \"+S $s\" --erl \"+sbt db\""
#   else
#     iex_command="$iex_path --erl \"+S $s\""
#   fi

#   $iex_command --dot-iex "$run_test_path" -S mix
# done
