        .global _start
        .text

        .equ HEX0_BASE, 0xFF200020
        .equ SW_BASE,   0xFF200040
        .equ KEY_BASE,  0xFF200050

/* r8 = ones digit */
/* r9 = tens digit */
/* r7 = seven-seg table */

_start:
        LDR r7, =SEG_PATTERNS
        MOV r8, #0
        MOV r9, #0

/* ---------- DISPLAY 00 ---------- */
display:
        LDR r4, =HEX0_BASE
        LDR r5, [r7, r9, LSL #2]
        LSL r5, r5, #8
        LDR r6, [r7, r8, LSL #2]
        ADD r5, r5, r6
        STR r5, [r4]

/* ============ MAIN LOOP ============ */
main_loop:

/* ---------- RESET (KEY1) ---------- */
        LDR r0, =KEY_BASE
        LDR r1, [r0]
        AND r1, r1, #0x02
        CMP r1, #0
        BEQ reset_counter

/* ---------- WAIT FOR KEY0 ---------- */
wait_key0:
        LDR r1, [r0]
        AND r1, r1, #1
        CMP r1, #0
        BEQ wait_key0

/* ---------- DEBOUNCE ---------- */
        LDR r2, =40000
debounce:
        SUBS r2, r2, #1
        BNE debounce

/* ---------- DELAY 1s ---------- */
        LDR r2, =10000000
delay1s:
        SUBS r2, r2, #2
        BNE delay1s

/* ---------- READ SWITCH ---------- */
        LDR r0, =SW_BASE
        LDR r1, [r0]
        AND r1, r1, #1
        CMP r1, #1
        BEQ count_up

/* ---------- COUNT DOWN ---------- */
        SUB r8, r8, #1
        CMP r8, #0
        BGE update_display

        MOV r8, #9
        SUB r9, r9, #1
        CMP r9, #0
        BGE update_display

        MOV r9, #5
        B update_display

/* ---------- COUNT UP ---------- */
count_up:
        ADD r8, r8, #1
        CMP r8, #10
        BLT update_display

        MOV r8, #0
        ADD r9, r9, #1
        CMP r9, #6
        BLT update_display

        MOV r8, #0
        MOV r9, #0

/* ---------- UPDATE DISPLAY ---------- */
update_display:
        LDR r4, =HEX0_BASE
        LDR r5, [r7, r9, LSL #2]
        LSL r5, r5, #8
        LDR r6, [r7, r8, LSL #2]
        ADD r5, r5, r6
        STR r5, [r4]

        B main_loop

/* ---------- RESET COUNTER ---------- */
reset_counter:
        MOV r8, #0
        MOV r9, #0
        B display

/* ---------- SEGMENT TABLE ---------- */
SEG_PATTERNS:
        .word 0x3F   @ 0
        .word 0x06   @ 1
        .word 0x5B   @ 2
        .word 0x4F   @ 3
        .word 0x66   @ 4
        .word 0x6D   @ 5
        .word 0x7D   @ 6
        .word 0x07   @ 7
        .word 0x7F   @ 8
        .word 0x6F   @ 9
