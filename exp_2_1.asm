.data
  in_buff:.space 512
  cache_ptr:.space 64
  input_file:.asciiz"D:/test.dat"
  comma: .asciiz ", "
.text
main:
la $a0,input_file
li $a1,0#a1=0Ϊ��ȡ��1Ϊд��
li $a2,0#a2 is mode
li $v0 13#13Ϊ���ļ��ı��
syscall#v0�洢�ļ�
move $a0,$v0#��v0������ļ����뵽$a0��ȥ
la $a1,in_buff#in_buff�������ݴ洢�ĵ�ַ
li $a2,8#�������ݵ�byte
li $v0,14#��ȡ�ļ�
syscall 
la $s0,in_buff
lw $t0,0($s0)#t0 is knapsack_capacity �������
lw $t1,4($s0)#t1 is item_num
sll $t2,$t1,3#��Ҫ��������ݵ�byte
addi $a1,$a1,8#�������ݴ洢�ĵ�ַ
add $a2,$t2,$0#�������ݵ�byte
li $v0,14#��ȡ�ļ�
syscall 
li $v0 16#�ر��ļ�
addi $s0,$s0,8#item_list is 8 byte
la $s1,cache_ptr#cache_ptr[]

addi $s2,$zero,0#$s2 is i
JUDGE_FOR1:beq $s2,$t1,END_FOR1

FOR1:sll $t2,$s2,3#s2 is i, t2=8*i
add $t3,$s0,$t2#t3:&item_list[i]
lw $t4,0($t3)#t4=item_list[i].weight
lw $t5,4($t3)#t5=item_list[i].value

addi $s3,$t0,0#$s3 is j
JUDGE_FOR2:bltz $s3,END_FOR2#j<0����ѭ��
FOR2:sge $s5,$s3,$t4#j>=weight s5=1
bnez $s5,IF
j END_IF
IF:sll $t6,$s3,2#t6=j*4
add $t7,$s1,$t6#t7 is &cache_ptr[j]
sub $t2,$s3,$t4#j-weight
sll $t2,$t2,2#(j-weight)*4
add $t8,$s1,$t2#t8 is &cache_ptr[j-weight]
lw $t2,0($t7)#t2 is cache_ptr[j]
lw $t3,0($t8)#t3 is cache_ptr[j-weight]
add $t9,$t3,$t5#t9 is cache_ptr[j - weight] + val
sgt $s6,$t2,$t9#cache_ptr[j] > cache_ptr[j - weight] + val s6=1
bnez $s6,IF1
j ELSE1
IF1:sw $t2,0($t7)
j END_IF
ELSE1:sw $t9,0($t7)
END_IF:subi $s3,$s3,1
j JUDGE_FOR2

END_FOR2:addi $s2,$s2,1
j JUDGE_FOR1

END_FOR1:sll $t9,$t0,2
add $s7,$s1,$t9
lw $v0,0($s7)


