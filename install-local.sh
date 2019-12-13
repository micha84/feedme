#!/usr/bin/env bash

ln -snf docker-sync.unison.yml docker-sync.yml
ln -snf docker-compose.local.yml docker-compose.yml
ln -snf .environment/.env.dist .env
#cd htdocs
#ln -snf .env.local .env
#cd app/config
#ln -snf config.local.php config.php
#cd ../../
