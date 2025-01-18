; Project Title: Inventory Management System





.MODEL SMALL
.STACK 100H
.DATA

PRODUCT_DATA    DB 'Rice$$$$$$$$$$$$$$$$', '00100', '00050'  ; Price: 100, Qty: 50
                DB 'Dal$$$$$$$$$$$$$$$$$', '00080', '00040'  ; Price: 80, Qty: 40
                DB 'Sugar$$$$$$$$$$$$$$$', '00120', '00030'  ; Price: 120, Qty: 30
                DB 500 DUP('$')  ; Space for new products
PRODUCT_COUNT   DW 3

; Messages for Add Product
ADD_PROD_NAME   DB 13, 10, 'Enter product name: $'
ADD_PROD_PRICE  DB 13, 10, 'Enter product price: $'
ADD_PROD_QTY    DB 13, 10, 'Enter product quantity: $'
ADD_SUCCESS     DB 13, 10, 'Product added successfully!$'

; Messages for View Product
VIEW_HEADER     DB 13, 10, 'Products List:', 13, 10
                DB 'Name                 Price  Quantity$'
VIEW_SEPARATOR  DB 13, 10, '-------------------------------------------------$'
NEW_LINE        DB 13, 10, '$'
SPACE           DB ' $'


NAME_BUFFER     DB 20
                DB ?
                DB 20 DUP('$')
PRICE_BUFFER    DB 5
                DB ?
                DB 5 DUP('$')
QTY_BUFFER      DB 5
                DB ?
                DB 5 DUP('$')
ADMIN_MENU      DB 13, 10, '1. Add Product', 13, 10
                DB '2. View Product', 13, 10
                ;DB '3. Order History', 13, 10
                DB '3. Exit', 13, 10
                DB 'Enter your choice: $'

USER_MENU       DB 13, 10, '1. View Product', 13, 10
                DB '2. Order', 13, 10
                DB '3. View Cart', 13, 10
                DB '4. Discard Item', 13, 10
                DB '5. Cancel Order', 13, 10
                DB '6. Exit', 13, 10
                DB 'Enter your choice: $'

INVALID_CHOICE  DB 13, 10, 'Invalid choice! Try again.$'
ADMIN_USER      DB 'Admin$'         ; For comparison
CHOICE          DB ?
EXISTING_PROMPT DB 'Are you an existing user? (Y/N): $'
USERNAME_PROMPT DB 13, 10, 'Enter username: $'
PASSWORD_PROMPT DB 13, 10, 'Enter password: $'
LOGIN_SUCCESS DB 13, 10, 'Login successful!$'
LOGIN_FAILURE DB 13, 10, 'Invalid credentials!$'
SIGNUP_SUCCESS DB 13, 10, 'User successfully registered!$'
LOGIN_PROMPT DB 13, 10, 'Please log in with your new credentials.$'
WELCOME_PROMPT DB 'WELCOME TO INVENTORY MANAGEMENT SYSTEM$'
SIGNUP_PROMPT DB 'Then sign up with your name and password!!$'


DISCARD_PROMPT    DB 13, 10, 'Enter item number to discard : $'
DISCARD_SUCCESS   DB 13, 10, 'Item discarded successfully!$'
DISCARD_INVALID   DB 13, 10, 'Invalid item number!$'
CANCEL_CONFIRM    DB 13, 10, 'Are you sure you want to cancel the order? (Y/N): $'
CANCEL_SUCCESS    DB 13, 10, 'Order cancelled successfully!$'


USER_RESPONSE DB ?
USERNAME_BUFFER DB 20
               DB ?
               DB 20 DUP('$')
PASSWORD_BUFFER DB 20
               DB ?
               DB 20 DUP('$')
;each user takes 40 bytes (20 for username, 20 for password)
USER_DATA DB 'user1$$$$$$$$$$$$$$$', '111$$$$$$$$$$$$$$$$$'
         DB 'Admin$$$$$$$$$$$$$$$', 'moo$$$$$$$$$$$$$$$$$'
         DB 'user2$$$$$$$$$$$$$$$', '132$$$$$$$$$$$$$$$$$' 
         DB 'Fahad$$$$$$$$$$$$$$$', '123$$$$$$$$$$$$$$$$$'
         DB 200 DUP('$')

SELECT_PRODUCT  DB 13, 10, 'Select product to order:', 13, 10, '$'
                DB '1. Rice', 13, 10
                DB '2. Dal', 13, 10
                DB '3. Sugar', 13, 10
                DB 'Enter choice (1-3): $'
QTY_PROMPT      DB 13, 10, 'Enter quantity: $'
COST_MSG        DB 13, 10, 'Cost for this item: $'
TOTAL_MSG       DB 13, 10, 'Total cost of order: $'
INVALID_CHOICE1  DB 13, 10, 'Invalid choice! Please try again.$'
ADD_MORE       DB 13, 10, 'Add more items? (Y/N): $'

QUANTITY        DW ?
ITEM_COST      DW ?
TOTAL_COST     DW 0

VIEW_CART_ARR    DB 500 DUP('$')  ; Array to store cart items
CART_COUNT      DW 0             ; Number of items in cart
VIEW_CART_MSG   DB 13, 10, 'Your Cart:', 13, 10, '$'
CART_EMPTY      DB 13, 10, 'Cart is empty!$'
          
USER_COUNT DW 4

.CODE


MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 09H
    LEA DX, WELCOME_PROMPT
    INT 21H
    
    MOV AH, 02
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H
    
    MOV AH, 09H
    LEA DX, EXISTING_PROMPT
    INT 21H
    
    MOV AH, 01H
    INT 21H
    MOV USER_RESPONSE, AL
    
    CMP USER_RESPONSE, 'Y'
    JE LOGIN_FLOW
    CMP USER_RESPONSE, 'y'
    JE LOGIN_FLOW
    
    CMP USER_RESPONSE, 'N'
    JE SIGNUP_FLOW
    CMP USER_RESPONSE, 'n'
    JE SIGNUP_FLOW
    JMP EXIT
    
SIGNUP_FLOW:
    CALL SIGNUP
    
    MOV AH, 00H
    MOV AL, 02H
    INT 10H
    
    CALL MAIN
    
LOGIN_FLOW:
    MOV AH, 09H
    LEA DX, LOGIN_PROMPT
    INT 21H
    
    MOV AH, 09H
    LEA DX, USERNAME_PROMPT
    INT 21H
    
    MOV AH, 0AH
    LEA DX, USERNAME_BUFFER
    INT 21H
    
    MOV AH, 09H
    LEA DX, PASSWORD_PROMPT
    INT 21H
    
    CALL READ_PASSWORD
    
    CALL VERIFY_LOGIN
    CMP AL, 1
    JE SUCCESS
    
    MOV AH, 09H
    LEA DX, LOGIN_FAILURE
    INT 21H
    JMP EXIT
    
SUCCESS:
    MOV AH, 09H
    LEA DX, LOGIN_SUCCESS
    INT 21H
    
    LEA SI, USERNAME_BUFFER + 2
    LEA DI, ADMIN_USER
    CALL IS_ADMIN
    CMP AL, 1
    JE SHOW_ADMIN_MENU
    JMP SHOW_USER_MENU
    
EXIT:
    MOV AH, 4CH
    INT 21H
MAIN ENDP


READ_PASSWORD PROC
    PUSH BX
    PUSH CX
    
    MOV BX, 2    ; Start storing from PASSWORD_BUFFER + 2
    MOV CX, 0    ; Character counter
    
READ_CHAR:
    MOV AH, 08H
    INT 21H
    
    CMP AL, 13   ; Check for Enter key
    JE DONE_READING
    
    CMP AL, 8    ; Check for Backspace
    JE HANDLE_BACKSPACE
    
    CMP CX, 19   ; Check if maximum length reached
    JE READ_CHAR
    
    MOV PASSWORD_BUFFER[BX], AL
    INC BX
    INC CX
    
    MOV AH, 02H  ; Display character
    MOV DL, '*'  ; Show asterisk instead of actual character
    INT 21H
    
    JMP READ_CHAR
    
HANDLE_BACKSPACE:
    CMP CX, 0    ; Check if buffer is empty
    JE READ_CHAR
    
    DEC BX
    DEC CX
    
    ; Erase character from screen
    MOV AH, 02H
    MOV DL, 8    ; Backspace
    INT 21H
    MOV DL, 32   ; Space
    INT 21H
    MOV DL, 8    ; Backspace
    INT 21H
    
    JMP READ_CHAR
    
DONE_READING:
    MOV PASSWORD_BUFFER[BX], 13  ; Add carriage return
    MOV PASSWORD_BUFFER[1], CL   ; Store length
    
    MOV AH, 02H
    MOV DL, 13   ; Carriage return
    INT 21H
    MOV DL, 10   ; Line
    INT 21H
    
    POP CX
    POP BX
    RET
READ_PASSWORD ENDP

VERIFY_LOGIN PROC
    MOV CX, USER_COUNT
    LEA SI, USER_DATA
    
CHECK_NEXT_USER:
    PUSH CX
    PUSH SI
    
    LEA DI, USERNAME_BUFFER + 2
    CALL COMPARE_STRING
    POP SI
    PUSH SI
    CMP AL, 1
    JNE TRY_NEXT_USER
    
    ADD SI, 20
    LEA DI, PASSWORD_BUFFER + 2
    CALL COMPARE_STRING
    CMP AL, 1
    JE LOGIN_FOUND
    
TRY_NEXT_USER:
    POP SI
    POP CX
    ADD SI, 40  ; Move to next user (40 bytes = 20 for username + 20 for password)
    LOOP CHECK_NEXT_USER
    
    MOV AL, 0
    RET
    
LOGIN_FOUND:
    POP SI
    POP CX
    MOV AL, 1
    RET
VERIFY_LOGIN ENDP

COMPARE_STRING PROC
    PUSH BX
    PUSH CX
    MOV CX, 0
    
COMPARE_LOOP:
    MOV BX, CX
    MOV AL, [SI][BX]
    MOV BL, [DI][BX]
    
    CMP BL, 13
    JE INPUT_END
    CMP AL, '$'
    JE MISMATCH
    
    CMP AL, BL
    JNE MISMATCH
    
    INC CX
    CMP CX, 19
    JLE COMPARE_LOOP
    
MISMATCH:
    POP CX
    POP BX
    MOV AL, 0
    RET
    
INPUT_END:
    CMP AL, '$'
    JNE MISMATCH
    POP CX
    POP BX
    MOV AL, 1
    RET
COMPARE_STRING ENDP

SIGNUP PROC
    MOV AH,02
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    
    MOV AH,09H
    LEA DX,SIGNUP_PROMPT
    INT 21H
    
    MOV AX, USER_COUNT
    MOV BX, 40
    MUL BX
    LEA DI, USER_DATA
    ADD DI, AX
    
    MOV AH, 09H
    LEA DX, USERNAME_PROMPT
    INT 21H
    
    MOV AH, 0AH
    LEA DX, USERNAME_BUFFER
    INT 21H
    
    LEA SI, USERNAME_BUFFER + 2
    MOV CX, 0
STORE_USERNAME:
    MOV BX, CX
    MOV AL, [SI][BX]
    CMP AL, 13
    JE PAD_USERNAME
    MOV [DI][BX], AL
    INC CX
    CMP CX, 19
    JL STORE_USERNAME
    
PAD_USERNAME:
    MOV AL, '$'
PADDING_LOOP_U1:
    MOV BX, CX
    MOV [DI][BX], AL
    INC CX
    CMP CX, 20
    JL PADDING_LOOP_U1
    
    MOV AH, 09H
    LEA DX, PASSWORD_PROMPT
    INT 21H
    
    CALL READ_PASSWORD
    
    ADD DI, 20
    LEA SI, PASSWORD_BUFFER + 2
    MOV CX, 0
STORE_PASSWORD:
    MOV BX, CX
    MOV AL, [SI][BX]
    CMP AL, 13
    JE PAD_PASSWORD
    MOV [DI][BX], AL
    INC CX
    CMP CX, 19
    JL STORE_PASSWORD
    
PAD_PASSWORD:
    MOV AL, '$'
PADDING_LOOP_P:
    MOV BX, CX
    MOV [DI][BX], AL
    INC CX
    CMP CX, 20
    JL PADDING_LOOP_P
    
    INC USER_COUNT
    
    MOV AH, 09H
    LEA DX, SIGNUP_SUCCESS
    INT 21H
    RET
SIGNUP ENDP



SHOW_ADMIN_MENU:
    
    ; Display menu
    MOV AH, 09H
    LEA DX, ADMIN_MENU
    INT 21H
    
    ; Get choice
    MOV AH, 01H   ; input of admin
    INT 21H
    SUB AL, '0'
    MOV CHOICE, AL
    
    ; Process choice
    CMP CHOICE, 1
    JE ADMIN_OPTION_1   ; if admin chooses option 1
    CMP CHOICE, 2
    JE ADMIN_OPTION_2   ; if admin chooses option 2
    CMP CHOICE, 3
    JE ADMIN_OPTION_3   ; if admin chooses option 3
    JMP INVALID_ADMIN_CHOICE    ; if admin chooses wrong or invalid option

ADMIN_OPTION_1:
    CALL ADD_PRODUCT      ; When admin chooses option 1 for adding product, the function "ADD_PRODUCT" is being called
    JMP SHOW_ADMIN_MENU

ADMIN_OPTION_2:    
    CALL VIEW_PRODUCTS    ; When admin chooses option 2 for viewing products, the function "VIEW_PRODUCTS" is being called
    JMP SHOW_ADMIN_MENU

ADMIN_OPTION_3:           ; When admin chooses option 3 to exit
    MOV AH, 00H
    MOV AL, 02H
    INT 10H
    CALL MAIN             ; After exiting from the options for admin, the "MAIN" function is being called
                          ;  and the introductory screen is displayed again.

SHOW_USER_MENU:
    MOV AH, 09H
    LEA DX, USER_MENU
    INT 21H
    
    MOV AH, 01H   ; user input
    INT 21H
    SUB AL, '0'
    MOV CHOICE, AL
    
    CMP CHOICE, 1
    JE USER_OPTION_1    ; When user chooses option 1 for viewing the available products in the inventory
    CMP CHOICE, 2
    JE USER_OPTION_2    ; When user chooses option 2 for ordering items, which gets added to the cart
    CMP CHOICE, 3
    JE USER_OPTION_3    ; When user chooses option 3 for viewing the items in the cart
    CMP CHOICE, 4
    JE USER_OPTION_4    ; When user chooses option 4 for discarding item(s) from the cart
    CMP CHOICE, 5
    JE USER_OPTION_5    ; When user chooses option 5 for cancelling the order
    CMP CHOICE, 6       ; When user chooses option 6 for exiting the menu
    JE EXIT
    JMP INVALID_USER_CHOICE  ; if user chooses any wrong option than the available options

USER_OPTION_1:
    CALL VIEW_PRODUCTS    ; VIEW_PRODUCTS function is called and then when the function's work is done,
    JMP SHOW_USER_MENU    ;  the 'user menu' is displayed again

USER_OPTION_2:
    CALL PLACE_ORDER      ; CALL_ORDER function is called and after completion, 
    JMP SHOW_USER_MENU    ;   the 'user menu' is displayed again

USER_OPTION_3:
    CALL VIEW_CART        ; VIEW_CART function is called and after completion,
    JMP SHOW_USER_MENU    ;    the 'user menu' is displayed again

USER_OPTION_4:
    CALL DISCARD_ITEM     ; DISCARD_ITEMf function is called and after completion,
    JMP SHOW_USER_MENU    ;   the 'user menu' is displayed again

USER_OPTION_5:
    CALL CANCEL_ORDER     ; CANCEL_ORDER function is called and after completion,
    JMP SHOW_USER_MENU    ;   the 'user menu' is displayed again


INVALID_ADMIN_CHOICE:
    MOV AH, 09H
    LEA DX, INVALID_CHOICE  ; for invalid choice of admin options, an error message stored in "INVALID_CHOICE"
    INT 21H                 ;   is displayed and then again
    JMP SHOW_ADMIN_MENU     ;     the 'admin menu' is displayed

INVALID_USER_CHOICE:
    MOV AH, 09H
    LEA DX, INVALID_CHOICE  ; for invalid choice of user options, an error message stored in "INVALID_CHOICE"
    INT 21H                 ;   is displayed and then agin
    JMP SHOW_USER_MENU      ;     the 'user menu' is displayed


IS_ADMIN PROC
    PUSH CX
    MOV CX, 5  ; Length of "Admin"
COMPARE_ADMIN:
    MOV AL, [SI]
    MOV BL, [DI]
    CMP AL, BL
    JNE NOT_ADMIN
    INC SI
    INC DI
    LOOP COMPARE_ADMIN
    MOV AL, 1  ; Is Admin
    JMP ADMIN_CHECK_DONE
NOT_ADMIN:
    MOV AL, 0  ; Not Admin
ADMIN_CHECK_DONE:
    POP CX
    RET
IS_ADMIN ENDP

ADD_PRODUCT PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    
    MOV AX, PRODUCT_COUNT
    MOV BX, 30
    MUL BX
    LEA DI, PRODUCT_DATA
    ADD DI, AX
    
    ; Get and store product name
    MOV AH, 09H
    LEA DX, ADD_PROD_NAME
    INT 21H
    
    MOV AH, 0AH
    LEA DX, NAME_BUFFER
    INT 21H
    
    ; Clear the product name area with spaces first
    MOV CX, 20
    MOV AL, ' '    ; Space character
CLEAR_NAME:
    MOV [DI], AL
    INC DI
    LOOP CLEAR_NAME
    
    SUB DI, 20     ; Reset DI to start of name field
    
    ; Copy entered name
    LEA SI, NAME_BUFFER + 2
    XOR CX, CX     ; Clear counter
STORE_NAME:
    MOV AL, [SI]
    CMP AL, 13     ; Check for Enter key
    JE PRICE_INPUT
    MOV [DI], AL
    INC SI
    INC DI
    INC CX
    CMP CX, 19     ; Maximum 19 characters (leave room for $)
    JL STORE_NAME
    
PRICE_INPUT:
    LEA DI, PRODUCT_DATA  ; Reset DI to start
    MOV AX, PRODUCT_COUNT
    MOV BX, 30
    MUL BX
    ADD DI, AX     ; Point to current product
    ADD DI, 20     ; Move to price field
    
    ; Get and store price
    MOV AH, 09H
    LEA DX, ADD_PROD_PRICE
    INT 21H
    
    MOV AH, 0AH
    LEA DX, PRICE_BUFFER
    INT 21H
    
    ; Initialize price with zeros
    MOV CX, 5
    MOV AL, '0'
CLEAR_PRICE:
    MOV [DI], AL
    INC DI
    LOOP CLEAR_PRICE
    
    SUB DI, 5      ; Reset to start of price field
    
    ; Store price right-aligned
    LEA SI, PRICE_BUFFER + 2
    XOR CX, CX
    MOV BX, 0
COUNT_PRICE:
    MOV AL, [SI + BX]
    CMP AL, 13
    JE END_COUNT_PRICE
    INC BX
    CMP BX, 5
    JL COUNT_PRICE
END_COUNT_PRICE:
    MOV CX, BX     ; CX = length of input
    
    ADD DI, 5      ; Move to end of price field
    SUB DI, CX     ; Move back by length of input
    
    XOR BX, BX     ; Reset counter
STORE_PRICE:
    CMP BX, CX
    JE QTY_INPUT
    MOV AL, [SI + BX]
    MOV [DI + BX], AL
    INC BX
    JMP STORE_PRICE
    
QTY_INPUT:
    LEA DI, PRODUCT_DATA  ; Reset DI
    MOV AX, PRODUCT_COUNT
    MOV BX, 30
    MUL BX
    ADD DI, AX
    ADD DI, 25     ; Move to quantity field
    
    ; Get and store quantity
    MOV AH, 09H
    LEA DX, ADD_PROD_QTY
    INT 21H
    
    MOV AH, 0AH
    LEA DX, QTY_BUFFER
    INT 21H
    
    ; Initialize quantity with zeros
    MOV CX, 5
    MOV AL, '0'
CLEAR_QTY:
    MOV [DI], AL
    INC DI
    LOOP CLEAR_QTY
    
    SUB DI, 5      ; Reset to start of quantity field
    
    ; Store quantity right-aligned
    LEA SI, QTY_BUFFER + 2
    XOR CX, CX
    MOV BX, 0
COUNT_QTY:
    MOV AL, [SI + BX]
    CMP AL, 13
    JE END_COUNT_QTY
    INC BX
    CMP BX, 5
    JL COUNT_QTY
END_COUNT_QTY:
    MOV CX, BX     ; CX = length of input
    
    ADD DI, 5      ; Move to end of quantity field
    SUB DI, CX     ; Move back by length of input
    
    XOR BX, BX     ; Reset counter
STORE_QTY:
    CMP BX, CX
    JE FINISH_ADD
    MOV AL, [SI + BX]
    MOV [DI + BX], AL
    INC BX
    JMP STORE_QTY
    
FINISH_ADD:
    INC PRODUCT_COUNT
    MOV AH, 09H
    LEA DX, ADD_SUCCESS
    INT 21H
    
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
ADD_PRODUCT ENDP

VIEW_PRODUCTS PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

    ; Display header
    MOV AH, 09H
    LEA DX, VIEW_HEADER
    INT 21H
    
    LEA DX, VIEW_SEPARATOR
    INT 21H

    ; Initialize counter and pointer
    MOV CX, PRODUCT_COUNT
    LEA SI, PRODUCT_DATA

DISPLAY_LOOP:
    PUSH CX
    
    ; Display new line
    MOV AH, 09H
    LEA DX, NEW_LINE
    INT 21H

    ; Display name (up to 20 bytes, stop at $)
    MOV CX, 20      ; Maximum width for name
    PUSH SI         ; Save SI for later
PRINT_NAME:
    MOV DL, [SI]    ; Get character
    CMP DL, '$'     ; Check if it's a $ character
    JE PAD_SPACES   ; If $, pad with spaces instead
    MOV AH, 02H     ; Function to print character
    INT 21H         ; Print it
    INC SI          ; Move to next character
    LOOP PRINT_NAME
    JMP NAME_DONE

PAD_SPACES:
    MOV DL, ' '     ; Space character
    MOV AH, 02H     ; Function to print character
    INT 21H         ; Print space
    LOOP PAD_SPACES

NAME_DONE:
    POP SI          ; Restore SI
    ADD SI, 20      ; Move to price field

    ; Display spaces after name
    MOV AH, 09H
    LEA DX, SPACE
    INT 21H
    INT 21H         ; Extra space for better spacing

    ; Display price (5 bytes)
    MOV CX, 5       ; Fixed width for price
PRINT_PRICE:
    MOV DL, [SI]    ; Get character
    MOV AH, 02H     ; Function to print character
    INT 21H         ; Print it
    INC SI          ; Move to next character
    LOOP PRINT_PRICE

    ; Display spaces after price
    MOV AH, 09H
    LEA DX, SPACE
    INT 21H
    INT 21H         ; Extra space for better spacing

    ; Display quantity (5 bytes)
    MOV CX, 5       ; Fixed width for quantity
PRINT_QTY:
    MOV DL, [SI]    ; Get character
    MOV AH, 02H     ; Function to print character
    INT 21H         ; Print it
    INC SI          ; Move to next character
    LOOP PRINT_QTY

    POP CX
    LOOP DISPLAY_LOOP

    ; Display final separator
    MOV AH, 09H
    LEA DX, NEW_LINE
    INT 21H
    LEA DX, VIEW_SEPARATOR
    INT 21H

    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
VIEW_PRODUCTS ENDP



PLACE_ORDER PROC  
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI

    MOV TOTAL_COST, 0

ORDER_LOOP:
    ; Display available products with numbers
    MOV AH, 09H
    LEA DX, SELECT_PRODUCT
    INT 21H
    
    ; Display products dynamically
    LEA SI, PRODUCT_DATA
    MOV CX, PRODUCT_COUNT
    MOV BX, 1      ; Counter for product numbers
    
DISPLAY_PRODUCTS:
    PUSH CX
    
    ; Display product number
    MOV AH, 02H
    MOV DL, BL
    ADD DL, '0'
    INT 21H
    
    ; Display dot and space
    MOV DL, '.'
    INT 21H
    MOV DL, ' '
    INT 21H
    
    ; Display product name (max 20 chars, stop at space or $)
    MOV CX, 20     ; Maximum name length
PRINT_NAME1:
    MOV AL, [SI]
    CMP AL, '$'    ; Check for end of string
    JE PRINT_NAME_DONE
    CMP AL, ' '    ; Check for space (which might indicate padding)
    JE PRINT_NAME_DONE
    
    MOV DL, AL
    MOV AH, 02H
    INT 21H
    
    INC SI
    LOOP PRINT_NAME1
    JMP NAME_PRINTED
    
PRINT_NAME_DONE:
    ; Skip remaining characters of name field
    ADD SI, CX     ; Skip remaining characters
    
NAME_PRINTED:
    ; Move SI to the start of next product
    SUB SI, 20     ; Move back to start of current product
    ADD SI, 30     ; Move to next product
    
    MOV AH, 09H
    LEA DX, NEW_LINE
    INT 21H
    
    INC BL         ; Increment product counter
    POP CX
    LOOP DISPLAY_PRODUCTS
    
    MOV AH, 02H
    MOV DL, 13
    INT 21H
    MOV DL, 10
    INT 21H
    
    ; Get user choice
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    
    ; Validate choice against current product count
    CMP AL, 1
    JL INVALID_PRODUCT
    MOV BL, BYTE PTR PRODUCT_COUNT
    CMP AL, BL
    JG INVALID_PRODUCT
    
    ; Calculate product offset
    DEC AL          
    MOV BL, 30
    MUL BL
    LEA SI, PRODUCT_DATA
    ADD SI, AX      
    
    ; Get quantity
    MOV AH, 09H
    LEA DX, QTY_PROMPT
    INT 21H
    
    CALL READ_NUMBER
    MOV QUANTITY, AX
    
    ; Get product price 
    PUSH SI
    ADD SI, 20      ; Move to price field
    CALL STR_TO_NUM ; Get price in AX
    MOV BX, AX      ; Save price in BX
    POP SI
    
    ; Calculate cost (price * quantity)
    MOV AX, BX      ; Price in AX
    MOV BX, QUANTITY
    MUL BX          ; AX = price * quantity
    MOV ITEM_COST, AX
    
    ; Add to total cost
    ADD TOTAL_COST, AX

    ; Add to cart 
    PUSH SI         ; Save SI
    LEA DI, VIEW_CART_ARR
    MOV AX, CART_COUNT
    MOV BX, 30      ; Each cart item record size
    MUL BX
    ADD DI, AX      ; Point to next empty slot
    
    ; Copy product data to cart
    MOV CX, 30      ; Copy entire product record
COPY_TO_CART:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    LOOP COPY_TO_CART
    
    INC CART_COUNT
    POP SI          ; Restore SI
    
    ; Display cost for this item
    MOV AH, 09H
    LEA DX, COST_MSG
    INT 21H
    
    MOV AX, ITEM_COST
    CALL DISPLAY_NUMBER
    
    ; Ask if user wants to add more items
    MOV AH, 09H
    LEA DX, ADD_MORE
    INT 21H
    
    MOV AH, 01H
    INT 21H
    
    CMP AL, 'Y'
    JE ORDER_LOOP
    CMP AL, 'y'
    JE ORDER_LOOP
    
    ; Display total cost
    MOV AH, 09H
    LEA DX, TOTAL_MSG
    INT 21H
    
    MOV AX, TOTAL_COST
    CALL DISPLAY_NUMBER
    
    JMP ORDER_DONE

INVALID_PRODUCT:
    MOV AH, 09H
    LEA DX, INVALID_CHOICE1
    INT 21H
    JMP ORDER_LOOP

ORDER_DONE:
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PLACE_ORDER ENDP

DISPLAY_NUMBER PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV BX, 10      ; Divisor
    XOR CX, CX      ; Digit counter
    
DIVIDE_LOOP:
    XOR DX, DX
    DIV BX          ; Divide AX by 10
    PUSH DX         ; Save remainder
    INC CX
    TEST AX, AX     ; Check if quotient is 0
    JNZ DIVIDE_LOOP
    
DISPLAY_LOOP1:
    POP DX
    ADD DL, '0'     ; Convert to ASCII
    MOV AH, 02H
    INT 21H
    LOOP DISPLAY_LOOP1
    
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DISPLAY_NUMBER ENDP

STR_TO_NUM PROC
    PUSH BX
    PUSH CX
    PUSH DX
    
    XOR AX, AX      ; Clear result
    MOV CX, 5       ; Price is 5 digits
    
CONVERT_LOOP:
    MOV BL, [SI]    ; Get digit
    SUB BL, '0'     ; Convert to number
    MOV DX, 10
    MUL DX          ; AX = AX * 10
    XOR BH, BH      ; Clear BH to ensure only BL is added
    ADD AX, BX      ; Add new digit
    INC SI
    LOOP CONVERT_LOOP
    
    POP DX
    POP CX
    POP BX
    RET
STR_TO_NUM ENDP

READ_NUMBER PROC
    PUSH BX
    PUSH CX
    PUSH DX
    
    XOR AX, AX      ; Clear result
    XOR CX, CX      ; Clear digit counter
    
READ_DIGIT:
    MOV AH, 01H
    INT 21H
    
    CMP AL, 13      ; Check for Enter key
    JE READ_DONE
    
    SUB AL, '0'     ; Convert ASCII to number
    MOV BL, AL
    MOV AL, 10
    MUL CX          ; AX = CX * 10
    ADD AL, BL      ; Add new digit
    MOV CX, AX
    JMP READ_DIGIT
    
READ_DONE:
    MOV AX, CX
    POP DX
    POP CX
    POP BX
    RET
READ_NUMBER ENDP 




VIEW_CART PROC   
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    
    CMP CART_COUNT, 0
    JE EMPTY_CART
    
    MOV AH, 09H
    LEA DX, VIEW_CART_MSG
    INT 21H
    
    LEA SI, VIEW_CART_ARR
    MOV CX, CART_COUNT
    MOV BX, 1      ; Counter for item numbers
    
DISPLAY_CART:
    PUSH CX
    
    ; Display item number
    MOV AH, 02H
    MOV DL, BH     ; Check if number is > 9
    OR DL, DL
    JZ SINGLE_DIGIT
    ADD DL, '0'
    INT 21H
SINGLE_DIGIT:
    MOV DL, BL
    ADD DL, '0'
    INT 21H
    
    ; Display dot and space
    MOV DL, '.'
    INT 21H
    MOV DL, ' '
    INT 21H
    
    ; Display item name
    MOV AH, 09H
    MOV DX, SI
    INT 21H
    
    MOV AH, 09H
    LEA DX, NEW_LINE
    INT 21H
    
    ADD SI, 30  ; Move to next cart item
    INC BL      ; Increment counter
    CMP BL, 10  ; If counter reaches 10
    JNE SKIP_TENS
    MOV BL, 0   ; Reset ones
    INC BH      ; Increment tens
SKIP_TENS:
    POP CX
    LOOP DISPLAY_CART
    JMP VIEW_CART_END
    
EMPTY_CART:
    
    MOV AH, 09H
    LEA DX, VIEW_SEPARATOR
    INT 21H
    
    MOV AH, 09H
    LEA DX, CART_EMPTY
    INT 21H
    
    
    MOV AH, 09H
    LEA DX, VIEW_SEPARATOR
    INT 21H
    
    
    
VIEW_CART_END:
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
VIEW_CART ENDP



DISCARD_ITEM PROC      
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    
 
    CMP CART_COUNT, 0       
    JE EMPTY_CART_DISCARD
    

    MOV AH, 09H
    LEA DX, NEW_LINE
    INT 21H
    LEA DX, VIEW_CART_MSG
    INT 21H
    
    LEA SI, VIEW_CART_ARR
    MOV CX, CART_COUNT
    MOV BX, 1      ; Counter for item numbers
    
DISPLAY_FOR_DISCARD:
    PUSH CX
    
    ; Display item number
    MOV AH, 02H
    MOV DL, BH     ; Check if number is > 9
    OR DL, DL
    JZ SINGLE_DIGIT_DISCARD
    ADD DL, '0'
    INT 21H
SINGLE_DIGIT_DISCARD:
    MOV DL, BL
    ADD DL, '0'
    INT 21H
    

    MOV DL, '.'
    INT 21H
    MOV DL, ' '
    INT 21H
    

    MOV AH, 09H     ; Display item name
    MOV DX, SI
    INT 21H
    
    MOV AH, 09H
    LEA DX, NEW_LINE
    INT 21H
    
    ADD SI, 30  ; Move to next cart item
    INC BL      ; Increment counter
    CMP BL, 10  ; If counter reaches 10
    JNE SKIP_TENS_DISCARD
    MOV BL, 0   ; Reset ones
    INC BH      ; Increment tens
SKIP_TENS_DISCARD:
    POP CX
    LOOP DISPLAY_FOR_DISCARD

    MOV AH, 09H
    LEA DX, DISCARD_PROMPT
    INT 21H
    

    CALL READ_NUMBER       ; Read item number
    

    CMP AX, 0           ; Check if user wants to cancel
    JE DISCARD_DONE
    

    CMP AX, 1        ; item number validity check korbe
    JL INVALID_DISCARD
    CMP AX, CART_COUNT
    JG INVALID_DISCARD
    

    DEC AX         
    MOV BX, 30      
    MUL BX
    LEA DI, VIEW_CART_ARR
    ADD DI, AX    
    
   
    LEA SI, VIEW_CART_ARR
    ADD SI, AX
    ADD SI, 30      
    
   
    MOV AX, CART_COUNT
    DEC AX          
    MOV BX, 30
    MUL BX          
    
   
    MOV BX, DI
    SUB BX, OFFSET VIEW_CART_ARR  
    SUB AX, BX      
    
  
    MOV CX, AX
    CMP CX, 0       
    JLE SKIP_MOVE
    
MOVE_ITEMS:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    LOOP MOVE_ITEMS
    
SKIP_MOVE:

    DEC CART_COUNT        ; Decrease cart count
    

    MOV AH, 09H
    LEA DX, DISCARD_SUCCESS
    INT 21H
    

    MOV AH, 09H
    LEA DX, NEW_LINE
    INT 21H
    
   
    CMP CART_COUNT, 0      
    JE CART_NOW_EMPTY
    
    ; Display updated cart with numbers
    MOV AH, 09H
    LEA DX, VIEW_CART_MSG
    INT 21H
    
    LEA SI, VIEW_CART_ARR
    MOV CX, CART_COUNT
    MOV BX, 1      ; Reset counter for item numbers
    
DISPLAY_UPDATED:
    PUSH CX
    

    MOV AH, 02H         ; Display item number
    MOV DL, BH     ; Check if number is > 9
    OR DL, DL
    JZ SINGLE_DIGIT_UPDATE
    ADD DL, '0'
    INT 21H
SINGLE_DIGIT_UPDATE:
    MOV DL, BL
    ADD DL, '0'
    INT 21H
    

    MOV DL, '.'
    INT 21H
    MOV DL, ' '
    INT 21H
    
   
    MOV AH, 09H
    MOV DX, SI
    INT 21H
    
    MOV AH, 09H
    LEA DX, NEW_LINE
    INT 21H
    
    ADD SI, 30  ; Move to next cart item
    INC BL      ; Increment counter
    CMP BL, 10  ; If counter reaches 10
    JNE SKIP_TENS_UPDATE
    MOV BL, 0   ; Reset ones
    INC BH      ; Increment tens
SKIP_TENS_UPDATE:
    POP CX
    LOOP DISPLAY_UPDATED
    JMP DISCARD_DONE
    
CART_NOW_EMPTY:
    MOV AH, 09H
    LEA DX, VIEW_SEPARATOR
    INT 21H

    MOV AH, 09H
    LEA DX, CART_EMPTY
    INT 21H
    
    MOV AH, 09H
    LEA DX, VIEW_SEPARATOR
    INT 21H
        
    JMP DISCARD_DONE
    
EMPTY_CART_DISCARD:
    MOV AH, 09H
    LEA DX, VIEW_SEPARATOR
    INT 21H

    MOV AH, 09H
    LEA DX, CART_EMPTY
    INT 21H
    
    MOV AH, 09H
    LEA DX, VIEW_SEPARATOR
    INT 21H    
    JMP DISCARD_DONE
    
INVALID_DISCARD:
    MOV AH, 09H
    LEA DX, DISCARD_INVALID
    INT 21H
    
DISCARD_DONE:
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DISCARD_ITEM ENDP

CANCEL_ORDER PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    ; Confirm cancellation
    MOV AH, 09H
    LEA DX, CANCEL_CONFIRM
    INT 21H
    

    MOV AH, 01H
    INT 21H
    

    CMP AL, 'Y'
    JE DO_CANCEL
    CMP AL, 'y'
    JE DO_CANCEL
    JMP CANCEL_DONE
    
DO_CANCEL:
    
    MOV CART_COUNT, 0    ; Clear cart count
    
    
    MOV TOTAL_COST, 0 ; Clear total cost
    
    
    MOV AH, 09H
    LEA DX, CANCEL_SUCCESS
    INT 21H
    
CANCEL_DONE:
    POP DX
    POP CX
    POP BX
    POP AX
    RET
CANCEL_ORDER ENDP

END MAIN