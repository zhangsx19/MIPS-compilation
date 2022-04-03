li $v0,5
syscall
move $a0,$v0#键盘输入n
Fib:#将参数n放入$a0
addi $sp,$sp,-12
sw $s0,0($sp)
sw $s1,4($sp)
sw $ra,8($sp)#保护现场

addi $s0 $a0 0#s0=n

slti $t0 $s0 3
beqz $t0 Next
addi $v0 $0 1 # 返回1
lw $s0,0($sp)
lw $s1,4($sp)
lw $ra,8($sp)
addi $sp,$sp,12#恢复现场
jr $ra

Next:
addi $s1 $0 0
subi $t1,$s0,1
move $a0, $t1
jal Fib
add $s1 $v0 $s1
subi $t2,$s0,2
move $a0, $t2
jal Fib
add $s1 $v0 $s1
addi $v0 $s1 0
lw $s0,0($sp)
lw $s1,4($sp)
lw $ra,8($sp)
addi $sp,$sp,12#恢复现场
jr $ra