#Alexandros Bletsis 3210134
#Konstantinos Labropoulos 3210099

    .text
	.globl main
main:
    li $s1, 0 #i = 0
    li $s2, 0 #result = 0
    la $a0, msg_input #printStr ("Postfix (input): ")
    li $v0, 4
    syscall

    do:
        li $v0, 12
        syscall
        move $s0, $v0 #ch = (int)System.in.read();

        beq $s0, ' ', end_if1 #if (ch != ' ') //IF1
        li $s3, 0 #number = 0
        
        while:
            blt $s0, '0',end_while    #while (ch >='0') 
            bgt $s0, '9',end_while    #&& (ch<='9')
            
            mul $s3, $s3, 10     #number = number * 10
            add $s3, $s3, $s0    #number = number + ch
            sub $s3, $s3, 48        #number = number - 48

            li $v0,12
            syscall
            move $s0,$v0 #ch = (int)System.in.read();
            j while

        end_while:

        beq $s0, '+', if2 #if ((ch == '+') || (ch == '-') ||(ch == '*')||(ch == '/')) //IF2
        beq $s0, '-', if2
        beq $s0, '*', if2
        beq $s0, '/', if2
        j end_if2

        if2:
            jal pop
            move $a3, $v0 #x2 = pop ()

            jal pop
            move $a1, $v0 #x1 = pop ()
            
            move $a2, $s0 #result = calc(x1,ch,x2)
            jal calc
            
            move $s2, $v0
            move $a1, $s2 
            jal push #push (result)
            j end_else_if 
        end_if2:

        else_if:
            beq $s0,'=',end_else_if
            move $a1, $s3
            jal push

        end_else_if:
        end_if1: #//END_IF1
        
    
        do_while:
            bne $s0,'=', do #while (ch != '=') goto do
            
        li $t1,1
        bne $s1,$t1, Invalid_Postfix #IF3
        j Postfix_Evalutation 
        
     pop:
        beqz $s1, Invalid_Postfix # if (i==0) goto Invalid_Postfix
        
        lw $v0,($sp) # return (p[i])
        sub $s1, $s1, 1 # i-=1
        add $sp, $sp, 4
        jr $ra

    push: 
        #$a1 = result
        add $s1, $s1, 1 # i+=1
        sub $sp,$sp,4
        sw $a1,($sp) #p[i] = result
        jr $ra
    
    calc:
        li $t0, 0 #int total = 0
        
        #$a1 = x1, $a3 = x2, $a2 = ch 

        beq $a2,'+',addition #if telestis == '+' goto addition
				
        beq $a2,'-',subtraction #if telestis == '-' goto subtraction
				
	    beq $a2,'*',multiplication #if telestis == '*' goto multiplication
				
	    beq $a2,'/',division #if telestis == '/' goto division

        j Invalid_Postfix

        addition:
            add $t0, $a1, $a3 #total = x1+x2
            j return_calc #break
        subtraction:
            sub $t0, $a1, $a3 #total = x1-x2
            j return_calc #break
        multiplication:
            mul $t0, $a1, $a3 #total = x1*x2 
            j return_calc #break
        division:
            beqz $a3, error_message_0_div #if (x2 == 0) goto error_message
            div $t0, $a1, $a3 #total = x1/x2
            j return_calc #break

        error_message_0_div:	
            la $a0,error_msg_zero_division #printStr ("Error: Divide by zero.")
            li $v0,4
            syscall
            j exit #goto exit

        Invalid_Postfix:
            la $a0,error_msg_postfix #printStr ("Invalid Postfix!")
            li $v0,4
            syscall
            j exit

        return_calc:
            move $v0,$t0 #return total
            jr $ra
            
    Postfix_Evalutation:

    la $a0, msg_evaluation #printStr ("Postfix Evaluation: ")
    li $v0, 4
    syscall

    lw $t1, ($sp)
    move $a0,$t1 #printInt (p[0])
    li $v0, 1
    syscall

    exit:
    li $v0,10
    syscall
    .data
    
#mhnymata emfanishs pros ton xrhsth

msg_input: .asciiz "\nPostfix (input): "
msg_evaluation: .asciiz "\nPostfix Evaluation: "
error_msg_postfix: .asciiz "\nInvalid Postfix!\n"
error_msg_zero_division: .asciiz "\nError: Divide by zero.\n"