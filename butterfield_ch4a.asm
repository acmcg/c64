BasicUpstart2(main)

* = $0810               // SYS 2064
.const GetIn    = $ffe4
.const ChOut    = $ffd2
.const Stop     = $ffe1
.const Plus     = $2b
.const Equals   = $3d
.const Return   = $0d
.const One      = $31
.const GreaterThan = $3e

main:
    jsr printGreaterThan 
    jsr getNumber       // get first number
    sta $033c           // store first number
    jsr printPlus       // print + character
    jsr getNumber       // get second number
    tax                 // store in X
    jsr printEquals     // print equals sign
    txa                 // transfer second number back into A
    clc                 // clear carry in preparation for addition
    adc $033c           // add to first number
    sta $033c           // store result
    cmp #$a             // is the number greater than or equal to 10
    bcc singleDigit     // jump to single digit if < 10
twoDigits:
    lda #One             // load '1'
    jsr ChOut           // and print
    sec                 
    lda $033c           // load the result
    sbc #$a             // subtract 10
singleDigit:      
    ora #$30            // convert to ASCII
    jsr ChOut           // print result
    lda Return          // ascsii for return
    jsr ChOut           // print RETURN
    rts

printPlus:
    lda #Plus            // + in PETSCII. # to convert the constant into an immediate value
    jsr ChOut
    rts

printGreaterThan:
    lda #GreaterThan            // > in PETSCII. # to convert the constant into an immediate value
    jsr ChOut
    rts

printEquals:
    lda #Equals            // - in PETSCII # to convert the constant into an immediate value
    jsr ChOut
    rts

getNumber:
    jsr Stop            
    beq end             // if runStop
    jsr GetIn
    cmp #$30            // Valid digit is greater than ASCII #$30
    bcc getNumber
    cmp #$3A            // but less than #$3A
    bcs getNumber
    jsr ChOut          //mask high bits to convert ASCII to binary
    and #$0f
    rts

end:        
    rts