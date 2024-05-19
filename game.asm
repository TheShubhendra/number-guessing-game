.model small
.stack 100h
.data
    msg_welcome db 'Hi welcome to this game: $'
    msg_start db 'Guess the number between 0 and 9: $'
    msg_higher db 'Higher! Jyada udo mat: $'
    msg_lower db 'Lower! todha bada socho life me: $'
    msg_correct db 'Correct! You guessed the number! $'
    newline db 0Dh, 0Ah, '$' ; Carriage return and line feed for new line
    guess db 0
    secret db 0

.code
start:
    ; Initialize the data segment
    mov ax, @data
    mov ds, ax

    ; Print the welcome message
    lea dx, msg_welcome
    mov ah, 09h
    int 21h
    ; Print new line
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Generate a random number between 0 and 9
    mov ah, 2Ch          ; Get system time
    int 21h              ; Call DOS interrupt
    mov al, dh           ; Use hour value (0-23)
    xor ah, ah           ; Clear upper part of AX
    xor dx, dx           ; Clear DX
    mov cx, 10           ; Divisor 10
    div cx               ; Divide AX by 10, remainder in DX
    mov [secret], dl     ; Store remainder as the secret number

guess_loop:
    ; Print the start message
    lea dx, msg_start
    mov ah, 09h          ; DOS print string
    int 21h

    ; Read user input (one character)
    mov ah, 01h          ; DOS read character
    int 21h
    sub al, '0'          ; Convert ASCII to number
    mov [guess], al

    ; Print new line (as DOS read character already echoes the input)
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Compare guess with secret number
    mov al, [guess]
    cmp al, [secret]
    je correct_guess

    ; If guess is lower
    jb lower_guess

higher_guess:
    ; Print "Higher" message
    lea dx, msg_higher
    mov ah, 09h          ; DOS print string
    int 21h
    ; Print new line
    lea dx, newline
    mov ah, 09h
    int 21h
    jmp guess_loop

lower_guess:
    ; Print "Lower" message
    lea dx, msg_lower
    mov ah, 09h          ; DOS print string
    int 21h
    ; Print new line
    lea dx, newline
    mov ah, 09h
    int 21h
    jmp guess_loop

correct_guess:
    ; Print "Correct" message
    lea dx, msg_correct
    mov ah, 09h          ; DOS print string
    int 21h
    ; Print new line
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Exit program
    mov ah, 4Ch          ; DOS terminate program
    int 21h

end start
