li $v0,5
syscall#scanf("%d",&n);
move $t0,$v0#t0 is n

sll $t1,$t0,2#t0=t0*4,the number of the bytes
move $a0,$t1
li $v0,9
syscall#int *a = new int[n];
move $s0,$v0#s0=&a[0]

addi $s1,$zero,0#$s1 is i
JUDGE_FOR:beq $s1,$t0,END_FOR

FOR:sll $t1,$s1,2#s1 is i, t1=4*i
add $t2,$s0,$t1#t2:&a[i]
li $v0,5
syscall
sw $v0,0($t2)
addi $s1,$s1,1
j JUDGE_FOR#for(i=0;i<n;i++){ scanf("%d",arr[i]);}

END_FOR:addi $s1,$zero,0#$s1 is i
sra $s2,$t0,1#s2=n/2
JUDGE_FOR_R:beq $s1,$s2,END_FOR_R#i<n/2

FOR_R:sll $t1,$s1,2#s1 is i, t1=4*i
add $t2,$s0,$t1#t2:&a[i]
lw $t3,0($t2)#t=a[i] t3 is t
sub $t4,$t0,$s1
subi $t4,$t4,1#t4=n-i-1
sll $t5,$t4,2#t5=4*(n-i-1)
add $t6,$s0,$t5#t6:&a[n-i-1]
lw $t7,0($t6)#t7=a[n-i-1]
sw $t7,0($t2)#a[i]=a[n-i-1]
sw $t3,0($t6)#a[n-i-1]=t
addi $s1,$s1,1
j JUDGE_FOR_R
END_FOR_R:addi $s1,$zero,0#$s1 is i

JUDGE_FOR_P:beq $s1,$t0,END_FOR_P#i<n
FOR_P:sll $t1,$s1,2#s1 is i, t1=4*i
add $t2,$s0,$t1#t2:&a[i]
lw $a0,0($t2)#$a0=a[i]
li $v0,1
syscall  # printf("%d",a[i]);
addi $s1,$s1,1
j JUDGE_FOR_P
END_FOR_P: