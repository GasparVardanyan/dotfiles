#!/usr/bin/env bash

echo building bgutil
pushd /src/worktrees/bgutil-ytdlp-pot-provider/1.2.2/server
	npm install
	npm fund
	npm audit fix
	npx tsc
popd
