# window-api-in-x86-asm

Note this is windows specific

To begin you will need to include window.asm into your assembly program, or you may choose to link it to a .lib/.dll and add it like this
then you will need to make sure you are linking with the libraries User32.lib Kerenel32.lib Gdi32.lib

main.asm is an example file and shows how to use the api
