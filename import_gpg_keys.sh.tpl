#!/usr/bin/env bash

gpg --import .public.key
gpg --passphrase {{ twdps/di/svc/gpg/passphrase }} --import .private.key
