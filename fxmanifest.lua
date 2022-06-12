
fx_version "adamant"

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

games {"rdr3"}

this_is_a_map "yes"

client_scripts {
    'warmenu.lua',
    'client.lua',
    'config.lua'
}

shared_script 'config.lua'

server_scripts {
    'config.lua',
    'server.lua'
}
