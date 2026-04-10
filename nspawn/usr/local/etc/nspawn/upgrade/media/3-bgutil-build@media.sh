#!/usr/bin/env bash

echo building bgutil
pushd /src/worktrees/bgutil-ytdlp-pot-provider/master/server
	npm install
	npm fund
	npm audit fix
	npx tsc
popd
