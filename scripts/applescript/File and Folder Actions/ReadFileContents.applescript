set ffile to (choose file with prompt "Which file should be convertedÉ" of type {"txt", "md", "markdown", "rtf"})
set ffcont to read ffile
set ffcont to ffcont as Unicode text
set the clipboard to ffcont
do shell script "sed '/^Unknown$/d; /^[[:space:]]*$/d; /^[0-9].*[0-9]$/d' $(pbpaste) > $HOME/Desktop/new_file.txt"