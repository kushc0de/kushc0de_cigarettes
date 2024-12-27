fx_version 'adamant'

author 'kushc0de'

game 'gta5'

shared_scripts {
    'config.lua',
	'@es_extended/locale.lua',
	'locales/de.lua'
}

client_script {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'client.lua'
}

server_script {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'server.lua'
}

dependency 'es_extended'