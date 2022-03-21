#!/bin/bash

export $(cat .env | xargs) && iex -S mix phx.server
