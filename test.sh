#!/bin/bash

$path_test = "$PWD/runTest.iex"

# iex --erl "+S 1" --dot-iex "$path_test/runTest.iex" -S mix
iex --erl "+S 2" --dot-iex "$path_test/runTest.iex" -S mix
# iex --erl "+S 3" --dot-iex "$path_test/runTest.iex" -S mix
# iex --erl "+S 4" --dot-iex "$path_test/runTest.iex" -S mix
