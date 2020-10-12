.data
    array: .space 20
    n: .word 0 #numri i antareve ne array
    newline: .asciiz "\n"
    messageNumri: .asciiz "Jep numrin e antareve te vektorit(max 5): "
    messageAntaret: .asciiz "\nJep antaret nje nga nje: \n"
    messagePrinto: .asciiz "\nAntaret e sortuar(asc): \n"
.text
    .globl main
    main:
    la $a0, array 
    lw $a1, n
    jal popullovektorin

    move $t0, $v1 
    la $a1, n 
    sw $t0, 0($a1)

    la $a0, array 
    lw $a1, n 
    jal unazaKalimit

    #e mbyllim programin 
    li $v0, 10
    syscall 

    popullovektorin:
        move $s0, $a0 
        move $s1, $a1 

        li $v0, 4
        la $a0, messageNumri
        syscall 

        li $v0 , 5
        syscall
        move $s1, $v0 
        move $v1, $s1

        li $v0, 4
        la $a0, messageAntaret
        syscall

        lexonumrin:
            li $v0, 5
            syscall 
            sw $v0, 0($s0)
            addi $s0, $s0, 4
            addi $s1, $s1, -1
            bnez $s1, lexonumrin

        jr $ra

    unazaKalimit:
        addi $sp, $sp, -4
        sw $ra,  0($sp)

        move $s0, $a0 #adresa e array
        move $s1, $a1 #vlera e n
        addi $s1, $s1, -1 # n = n - 1, s1 = 4 , pasi qe p i merr vlerat 0 1 2 3 
        li $t0, 0 # ne t0 ruhet p

        for1:
            beq $t0, $s1, exitfor1 #kur p e merr vleren 4 e mbyll for1 loopen 

            li $t3,  4
            mul $t4, $t0, $t3 
            add $t5, $s0, $t4 #offseti 
            lw $t1, 0($t5) # min = a[p] 
            move $s7, $t1  # e rujme a[p]-ne ne s7 
           
            move $t2, $t0 #loc
            move $a2, $t0 #e dergojme p si parameter

            jal unazaVlerave

            move $t9, $s7 #temp = a[p]

            li $t3,  4
            mul $t4, $t0, $t3 
            add $t5, $s0, $t4 #offseti 
            sw $t1, 0($t5) #a[p]=min

            mul $t4, $t2, $t3 #offseti per lokacionin
            add $t5, $s0, $t4
            sw $t9, 0($t5) #a[k] = temp
            

            addi $t0, $t0, 1
            j for1

    exitfor1:
        li $v0, 4
        la $a0, messagePrinto
        syscall

        lw $t0, n
        printo:
            li $v0, 1
            lw $a0, 0($s0)
            syscall 

            addi $s0, $s0, 4
            addi $t0, $t0, -1
        
            li $v0, 4 
            la $a0, newline 
            syscall
        
            bnez $t0, printo 
           
        lw $ra, 0($sp)
        addi $sp, $sp, 4
        jr $ra


    unazaVlerave: 
        move $s2, $a0 #adresa e array
        move $s3, $a1 # n 
        move $s4, $a2 #p 

     
        # ne t2 e rujme loc
        # ne t1 e kemi min
        addi $t4, $s4, 1 # e rujme k
    for2:
        beq $t4, $s3, exitfor2 
        li $t5,  4 
        mul $t6, $t4, $t5 # k * 4 
        add $t7, $s0, $t6 # offseti 
        lw $t8, 0($t7)
        
        bgt $t8, $t1, continue
            addi $t1, $t8, 0
            addi $t2, $t4, 0

        continue:
            addi $t4, $t4, 1
            j for2

    exitfor2:
        jr $ra
