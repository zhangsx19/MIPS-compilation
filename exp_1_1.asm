.text 
li $v0,5
syscall
move $t0,$v0#t0=i
li $v0,5
syscall
move $t1,$v0#t1=j
slt $s0,$t0,$zero#i<0 则s0=1,else s0=0 i is signed
bne $s0,$zero,IF1#if s0==1,jump to IF1
j ENDIF1
IF1:sub $t0,$zero,$t0#i=-i;
ENDIF1:slt $s0,$t1,$zero#j<0则s0=1,else s0=0
bne $s0,$zero,IF2
j ENDIF2
IF2:sub $t1,$zero,$t1#j=-j
ENDIF2:slt $s0,$t0,$t1#if i<j,s0=1
bne $s0,$zero,IF# if s0!=0(i<j),jump to IF
j ENDIF
IF:add $t2,$zero,$t0#t2 is temp,temp=i
add $t0,$zero,$t1#i=j
add $t1,$zero,$t2#j=temp
ENDIF:li $s1,0#s1 is sum
li $t2,0#t2 is temp,temp=0 for的初始化
slt $s0,$t1,$t2
bnez $s0,FOR_END#if j<temp,s0=1(for end)
FOR:add $s1,$s1,$t2#sum += temp
addi $t2,$t2,1#temp++
slt $s0,$t1,$t2#if j<temp,s0=1(for end)
beqz $s0,FOR#if temp<=j,s0=0(for continue)
FOR_END:move $a0,$s1
li $v0,1
syscall#printf("%d",sum);

