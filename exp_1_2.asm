.data
  in_buff:.space 8#����һ��8byte�������ڴ�ռ�
  out_buff:.space 4
  input_file:.asciiz"D:/a.in"
  output_file:.asciiz"D:/a.out"
  space:.asciiz" "
  comma: .asciiz ", "
.word
.text
.globl main
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

li $v0 16#�ر��ļ�
syscall 

li $v0,5#�Ӽ��̶���һ���������浽v0��
syscall

li $t2,0#t2 is id, for�ĳ�ʼ��
slti $s0,$t2,2#id<2 s0=1
beqz $s0,FOR_END
FOR:la $s0,in_buff#&buffer[0]
sll $t3,$t2,2
add $s1,$s0,$t3#&buffer[id]
lw $t1,0($s1)#t1=buffer[id]
sub $s2,$v0,$t1

bltz $s2,IF#if max_num-buffer[id]<0
j ENDIF
IF:add $v0,$t1,$0#max_num=buffer[id]
ENDIF:addi $t2,$t2,1
slti $s0,$t2,2#id<2 s0=1
bnez $s0,FOR
FOR_END:la $s0,out_buff
sw $v0,0($s0)#���֣�������ӼĴ�����ȡ���ڴ�out_buff


#��ӡ����
move $a0,$v0
li $v0,1
syscall

la $a0,output_file
li $a1,1#flag=1Ϊд��״̬
li $a2,0#mode is ingnored
li $v0,13#����򿪳ɹ����ļ�����������
syscall 

move $a0,$v0#���ļ����������뵽$a0��
la $a1,out_buff
li $a2,4#д��4byte
li $v0,15#д���ļ�
syscall


 li $v0 16#�ر��ļ�
syscall
