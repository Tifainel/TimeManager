#!/bin/ash

env

$APP_BIN eval "SrcWeb.Release.migrate"
$APP_BIN start