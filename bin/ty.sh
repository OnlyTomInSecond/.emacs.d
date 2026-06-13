#!/bin/bash

ty_bin=$(whereis ty | cut -d ':' -f 2)
exec ${ty_bin} server
