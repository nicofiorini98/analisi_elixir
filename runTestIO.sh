#!/bin/bash

iex --erl "+S 1" --dot-iex "runTestIO.iex" -S mix
iex --erl "+S 2" --dot-iex "runTestIO.iex" -S mix
iex --erl "+S 3" --dot-iex "runTestIO.iex" -S mix
iex --erl "+S 4" --dot-iex "runTestIO.iex" -S mix
iex --erl "+S 5" --dot-iex "runTestIO.iex" -S mix
iex --erl "+S 6" --dot-iex "runTestIO.iex" -S mix
iex --erl "+S 7" --dot-iex "runTestIO.iex" -S mix
iex --erl "+S 8" --dot-iex "runTestIO.iex" -S mix
iex --erl "+S 9 +sbt db" --dot-iex "runTestIO.iex" -S mix
iex --erl "+S 10 +sbt db" --dot-iex "runTestIO.iex" -S mix
iex --erl "+S 11 +sbt db" --dot-iex "runTestIO.iex" -S mix
iex --erl "+S 12 +sbt db" --dot-iex "runTestIO.iex" -S mix
iex --erl "+S 13 +sbt db" --dot-iex "runTestIO.iex" -S mix
iex --erl "+S 14 +sbt db" --dot-iex "runTestIO.iex" -S mix
iex --erl "+S 15 +sbt db" --dot-iex "runTestIO.iex" -S mix
iex --erl "+S 16 +sbt db" --dot-iex "runTestIO.iex" -S mix