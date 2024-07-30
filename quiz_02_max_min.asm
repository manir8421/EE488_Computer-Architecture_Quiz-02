.data
prompt: .asciiz "Enter an integer: "
max_prompt: .asciiz "\nThe maximum value is: "
min_prompt: .asciiz "\nThe minimum value is: "
newline: .asciiz "\n"

.text
.globl main

main:
  li $t0, 0
  li $t1, -2147483648
  li $t2, 2147483647

get_input_loop:
  beq $t0, 5, display_result
  li $v0, 4
  la $a0, prompt
  syscall

  li $v0, 5
  syscall

  move $t3, $v0
  bgt $t3, $t1, update_max
  j check_min

update_max:
  move $t1, $t3
  j check_min

check_min:
  blt $t3, $t2, update_min
  j increment_counter

update_min:
  move $t2, $t3
  j increment_counter

increment_counter:
  addi $t0, $t0, 1
  j get_input_loop

display_result:
  li $v0, 4
  la $a0, max_prompt
  syscall

  li $v0, 1
  move $a0, $t1
  syscall

  li $v0, 4
  la $a0, min_prompt
  syscall

  li $v0, 1
  move $a0, $t2
  syscall

  li $v0, 10
  syscall
