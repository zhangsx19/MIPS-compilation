.data
  in_buff:.space 512
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

addi $v0,$zero,0#v0=val_max
addi $s1 $zero,0#$s1 is state_cnt
addi $t2,$zero,1
sllv $t2,$t2,$t1#t2=0x1 << item_num
JUDGE_FOR1:beq $s1,$t2,END_FOR1#state_cnt < (0x1 << item_num)

FOR1:
addi $t3,$zero,0#t3 is weight
addi $t4,$zero,0#t4 is val
addi $s2,$zero,0#$s2 is i
JUDGE_FOR2:beq $s2,$t1,END_FOR2#i=item_num����ѭ��
FOR2:srav $s3,$s1,$s2#state_cnt >> i
andi $s3,$s3,1#s3 is flag
beqz $s3,END_IF#flag=0 j to END_IF,weight=weight,val=val,��û�в���
IF:sll $t5,$s2,3#s2 is i, t5=8*i
add $t5,$s0,$t5#t5:&item_list[i]
lw $t6,0($t5)#t6=item_list[i].weight
lw $t7,4($t5)#t7=item_list[i].value
add $t3,$t3,$t6#weight=weight + item_list[i].weight
add $t4,$t4,$t7#val=val + item_list[i].value
END_IF:addi $s2,$s2,1#i++
j JUDGE_FOR2

END_FOR2:sle $s4,$t3,$t0#weight <= knapsack_capacity,s4=1
sgt $s5,$t4,$v0#val>val_max s5=1
and $s4,$s4,$s5#weight <= knapsack_capacity&&val>val_max,s4=1
beqz $s4,END_IF1#s4=1 j to IF1
IF1:addi $v0,$t4,0#val_max = val
END_IF1:addi $s1,$s1,1#++state_cnt

j JUDGE_FOR1
END_FOR1:#return val_max


