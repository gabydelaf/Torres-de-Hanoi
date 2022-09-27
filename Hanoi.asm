#Integrantes:
#Gabriela Alejandra de la Fuente Chavez
#Daniel Gutierrez Bustos
.data
address: .word 0
.text
addi s1 zero 3#numero de discos
add a0 zero s1#copia
addi s2 zero 1#numero para comparar

addi a1 zero 0#apuntador a los discos

addi s3 zero 0#Apuntador a la torre A
addi s4 zero 0#Apuntador a la torre B
addi s5 zero 0#Apuntador a la torre C

addi t0 zero 0#Registro auxiliar para hacer cambio de torre

#MAIN
jal ra INIT#se manda llamar a la funcion para inicializar torres
jal ra HANOI#se llama la funcion recursiva
jal zero END


INIT:	
	lui sp %hi(address)#se reserva stack para las tres torres
	addi sp sp %lo(address)
	add s3 s3 sp#se carga la direccion de las torres vacias
	addi sp sp 32#en los apuntadores
	add s4 s4 sp
	addi sp sp 32
	add s5 s5 sp
	#Se comienza a llenar la torre A
FILL:	sw a0 0(s3)#se añade el disco
	addi a0 a0 -1 #se decrementa el nÃºmero de discos
	addi s3 s3 4 #se aumenta el apuntador
	blt zero a0 FILL#mientras no se hayan cargado todos los discos vuelve a hacerlo
	
	addi s3 s3 -4 #regresa a apuntar al ultimo disco
	jalr zero ra 0 #retorna a la funcion padre


HANOI: 
	addi sp sp 32 #se reserva stack
	sw ra 0(sp)#se almacenan los valores
	sw s3 4(sp)#en el stack
	sw s4 8(sp)
	sw s5 12(sp)	
	blt s2 s1 LOOP # si el nÃºmero de discos es mayor a 1 pasa al loop recursivo
	jal zero RETURN#si es igual a 1 comienza a retornar
LOOP:	sub s1 s1 s2 #Cada vez del loop se resta numero de discos menos 1
	add t0 zero s5#Se cambia de 
	add s5 zero s4#torres
	add s4 zero t0
	jal ra HANOI#se llama de nuevo la funcion
	add t0 zero s3#Se cambia de 
	add s3 zero s4#torres
	add s4 zero t0
	jal ra HANOI
RETURN:	lw a1 0(s3)
	sw zero 0(s3)
	addi s3 s3 -4
	sw a1 0(s5)
	addi s5 s5 4
	lw ra 0(sp) #se retornan los valores
	lw s1 4(sp)#del stack
	lw s2 8(sp)#a los registros
	addi sp sp -32 
	jalr zero ra 0 #retorna a la funcion padre
END:	
