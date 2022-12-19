BasicUpstart2(main)

* = $0810               // SYS 2064
.const GETIN = $ffe4
.const CHROUT = $ffd2
.const STOP = $ffe1

main:
    jsr STOP
    beq end
    jsr GETIN
    // ascii numbers are $30 to $39
    cmp #$30        // if less than 30 it is not a number 
    bcc main 
    cmp #$3A        //if hex is greater $3A it is not a number
    bcs main
    jsr CHROUT
    and #$0f        //mask high bits to convert ASCII to binary
end:
    rts