.data
  in_buff:.space 512
  input_file:.asciiz"D:/test.dat"
  comma: .asciiz ", "
.text
main:
la $a0,input_file
li $a1,0#a1=0为读取，1为写入
li $a2,0#a2 is mode
li $v0 13#13为打开文件的编号
syscall#v0存储文件
move $a0,$v0#将v0代表的文件载入到$a0中去
la $a1,in_buff#in_buff读入数据存储的地址
li $a2,8#读入数据的byte
li $v0,14#读取文件
syscall 
la $t1,in_buff
lw $t2,0($t1)#t2 is knapsack_capacity 最大重量
lw $t0,4($t1)#t0 is item_num
sll $t3,$t0,3#还要读入的数据的byte
addi $a1,$a1,8#读入数据存储的地址
add $a2,$t3,$0#读入数据的byte
li $v0,14#读取文件
syscall 
li $v0 16#关闭文件
addi $t1,$t1,8#t1 is item_list  8 byte
move $a0,$t0
move $a1,$t1
move $a2,$t2#传参
jal dp
j END

dp:#$a0:item_num,$a1:item_list,$a2:knapsack_capacity
addi $sp,$sp,-24
sw $s0,0($sp)
sw $s1,4($sp)
sw $s2,8($sp)
sw $s3,12($sp)
sw $s4,16($sp)
sw $ra,20($sp)#保护现场

addi $s0,$a0,0
addi $s1,$a1,0
addi $s2,$a2,0

bnez $s0 Next1#if(item_num == 0)
addi $v0 $0 0 # 返回0
lw $s0,0($sp)
lw $s1,4($sp)
lw $s2,8($sp)
lw $s3,12($sp)
lw $s4,16($sp)
lw $ra,20($sp)
addi $sp,$sp,24#恢复现场
jr $ra
Next1:
subi $t0,$s0,1#if(item_num == 1),t0=0
bnez $t0 Next2
lw $t1,0($s1)#t1 is item_list[0].weight
sge $t0,$s2,$t1#knapsack_capacity >= item_list[0].weight t0=1
beqz $t0,ELSE1
IF1:lw $t2,4($s1)#t2 is item_list[0].value
addi $v0,$t2,0#返回item_list[0].value
j END_IF1
ELSE1:addi $v0 $0 0 # 返回0
END_IF1:lw $s0,0($sp)
lw $s1,4($sp)
lw $s2,8($sp)
lw $s3,12($sp)
lw $s4,16($sp)
lw $ra,20($sp)
addi $sp,$sp,24#恢复现场
jr $ra

Next2:
subi $a0,$s0,1
addi $a1,$s1,8#1个item_list=8byte,k_cap不变
addi $a2,$s2,0
jal dp
addi $s3 $v0 0#s3 is val_out

subi $a0,$s0,1
addi $a1,$s1,8#1个item_list=8byte,k_cap不变
lw $t1,0($s1)#t1 is item_list[0].weight
sub $a2,$s2,$t1#knapsack_capacity - item_list[0].weight
jal dp
lw $t1,0($s1)#t1 is item_list[0].weight
lw $t2,4($s1)#t2 is item_list[0].value
add $s4 $v0 $t2#s4 is val_in=返回值+item_list[0].value

slt $t0,$s2,$t1#knapsack_capacity < item_list[0].weight,t0=1
beqz $t0,ELSE2
IF2:addi $v0,$s3,0#return val_out
j END_IF2
ELSE2:
sgt $t0,$s3,$s4#val_out > val_in,t0=1
beqz $t0,ELSE3
IF3:addi $v0,$s3,0#return val_out
j END_IF3
ELSE3:
addi $v0,$s4,0#return val_in
END_IF3:
END_IF2:
lw $s0,0($sp)
lw $s1,4($sp)
lw $s2,8($sp)
lw $s3,12($sp)
lw $s4,16($sp)
lw $ra,20($sp)
addi $sp,$sp,24#恢复现场
jr $ra
END:



