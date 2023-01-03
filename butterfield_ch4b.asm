// Takes an input of one number 
// If greater or equal to 5 it divides by 2 and outputs with no remainder
// If less than 5 it will multiply by 2 and output

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
    lda #GreaterThan
    jsr ChOut 
    jsr getNumber       // get first number
    sta $033c           //store
    cmp #$5
    bcs geFive         // branch if greater than or equal to '5'
leFive:
    lda $033c
    asl                 // multiply by '2'
    ora #$30            // convert to ASCII
    jsr ChOut           // print result
    rts
geFive:
    lda $033c
    lsr                 // divide by '2'
    ora #$30            // convert to ASCII
    jsr ChOut           // print result
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