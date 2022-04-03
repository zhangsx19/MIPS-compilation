.data
  in_buff:.space 8#申请一个8byte整数的内存空间
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
li $a1,0#a1=0为读取，1为写入
li $a2,0#a2 is mode
li $v0 13#13为打开文件的编号
syscall#v0存储文件
move $a0,$v0#将v0代表的文件载入到$a0中去
la $a1,in_buff#in_buff读入数据存储的地址
li $a2,8#读入数据的byte
li $v0,14#读取文件
syscall 

li $v0 16#关闭文件
syscall 

li $v0,5#从键盘读入一个整数，存到v0中
syscall

li $t2,0#t2 is id, for的初始化
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
sw $v0,0($s0)#存字，将结果从寄存器中取到内存out_buff


#打印整数
move $a0,$v0
li $v0,1
syscall

la $a0,output_file
li $a1,1#flag=1为写入状态
li $a2,0#mode is ingnored
li $v0,13#如果打开成功，文件描述符返回
syscall 

move $a0,$v0#将文件描述符载入到$a0中
la $a1,out_buff
li $a2,4#写入4byte
li $v0,15#写入文件
syscall


 li $v0 16#关闭文件
syscall
