#!/bin/bash

cd /home/nico/project/tesi/analisi_elixir

elixir --erl "+S 1" -S mix run --no-halt
elixir --erl "+S 2" -S mix run --no-halt
elixir --erl "+S 3" -S mix run --no-halt
elixir --erl "+S 4" -S mix run --no-halt
elixir --erl "+S 5" -S mix run --no-halt
elixir --erl "+S 6" -S mix run --no-halt
elixir --erl "+S 7" -S mix run --no-halt
elixir --erl "+S 8" -S mix run --no-halt
elixir --erl "+S 8 " -S mix run --no-halt
elixir --erl "+S 9 +sbt db" -S mix run
elixir --erl "+S 10 +sbt db" -S mix run
elixir --erl "+S 11 +sbt db" -S mix run
elixir --erl "+S 12 +sbt db" -S mix run
elixir --erl "+S 13 +sbt db" -S mix run
elixir --erl "+S 14 +sbt db" -S mix run
elixir --erl "+S 15 +sbt db" -S mix run
elixir --erl "+S 16 +sbt db" -S mix run
