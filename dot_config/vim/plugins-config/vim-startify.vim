" ASCII header
let g:startify_custom_header = [
\ [
\ '                                                                               ',
\ '                                                                               ',
\ '                   __                 .__                                      ',
\ '          |  | __ ____   ____ |__| ______                                      ',
\ '          |  |/ // __ \ /    \|  |/  ___/                                      ',
\ '          |    <\  ___/|   |  \  |\___ \                                       ',
\ '          |__|_ \\___  >___|  /__/____  >                                      ',
\ '               \/    \/     \/        \/                                       ',
\ '                         blog:http://kenis1108.github.io/  ',
\ '                                                                               ',
\ '                                                                               ',
\ ],
\ [
\ '                                                                               ',
\ '                                                                               ',
\ '          /$$   /$$                     /$$                                    ',
\ '         | $$  /$$/                    |__/                                    ',
\ '         | $$ /$$/   /$$$$$$  /$$$$$$$  /$$  /$$$$$$$                          ',
\ '         | $$$$$/   /$$__  $$| $$__  $$| $$ /$$_____/                          ',
\ '         | $$  $$  | $$$$$$$$| $$  \ $$| $$|  $$$$$$                           ',
\ '         | $$\  $$ | $$_____/| $$  | $$| $$ \____  $$                          ',
\ '         | $$ \  $$|  $$$$$$$| $$  | $$| $$ /$$$$$$$/                          ',
\ '         |__/  \__/ \_______/|__/  |__/|__/|_______/                           ',
\ '                                                                               ',
\ '                         blog:http://kenis1108.github.io/  ',
\ '                                                                               ',
\ ],
\ [
\ '',
\ '',
\ "     .-. .-')     ('-.       .-') _          .-')                              ",
\ "     \\  ( OO )  _(  OO)     ( OO ) )        ( OO ).  ",
\ "     ,--. ,--. (,------.,--./ ,--,' ,-.-') (_)---\\_) ",
\ "     |  .'   /  |  .---'|   \\ |  |\\ |  |OO)/    _ |  ",
\ "     |      /,  |  |    |    \\|  | )|  |  \\\\  :` `.  ",
\ "     |     ' _)(|  '--. |  .     |/ |  |(_/ '..`''.) ",
\ "     |  .   \\   |  .--' |  |\\    | ,|  |_.'.-._)   \\ ",
\ "     |  |\\   \\  |  `---.|  | \\   |(_|  |   \\       / ",
\ "     `--' '--'  `------'`--'  `--'  `--'    `-----'  ",
\ "",
\ "",
\ "",
\ '     blog:http://kenis1108.github.io/          ',
\ "",
\ ]
\ ][2]

function s:fzfFiles()
  return [
    \ { 'line': 'Find File', 'cmd': 'Files' },
    \ { 'line': 'Rg',    'cmd': 'Rg'    },
    \ ]
endfunction

let g:startify_commands = [
  \ {'f': ['Find File', 'Files']},
  \ {'r': ['Recent File', 'History']},
  \ ]

let g:startify_lists = [
  \ { 'type': 'commands',              'header': ['   Commands']      },
  \ { 'type': function('s:fzfFiles'),  'header': ['   Fzf']           },
  \ { 'type': 'sessions',              'header': ['   Sessions']      },
  \ { 'type': 'files',                 'header': ['   Recent Files']  },
  \ ]

let g:startify_session_dir = g:custom_packpath . '/session'
