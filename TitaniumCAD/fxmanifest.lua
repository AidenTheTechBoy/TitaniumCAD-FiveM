fx_version 'cerulean'
games { 'gta5' }

author 'Titanium Development'
description 'In-game integration for TitaniumCAD!'

version '1.0.0'

client_scripts {
    '/client/client.lua'
}

server_scripts {
    'config.lua',
    '/server/server.lua'
}

files {
    '/ui/index.html',
    '/ui/main.js',
    '/ui/iPad-Frame.png'
}

ui_page '/ui/index.html'