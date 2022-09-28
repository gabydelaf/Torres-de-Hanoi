#Integrantes:
#Gabriela Alejandra de la Fuente Chavez
#Daniel Gutierrez Bustos
.data
address: .word 0
.text
addi s1 zero 3#numero de discos
add a0 zero s1#copia/contador
addi s2 zero 1#numero para comparar

addi a1 zero 0#apuntador a los discos

addi s3 zero 0#Apuntador a la torre A
addi s4 zero 0#Apuntador a la torre B
addi s5 zero 0#Apuntador a la torre C

addi t0 zero 0#Registro auxiliar para hacer cambio de torre

#MAIN
add t1 zero sp#se guarda el valor del sp
jal ra INIT#se manda llamar a la funcion para inicializar torres
add sp zero t1#se recupera el valor guardado
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
	addi a0 a0 -1 #se decrementa el numero de discos
	addi s3 s3 4 #se aumenta el apuntador
	blt zero a0 FILL#mientras no se hayan cargado todos los discos vuelve a hacerlo
	
	addi s3 s3 -4 #regresa a apuntar al ultimo disco
	jalr zero ra 0 #retorna a la funcion padre

HANOI: 
	addi sp sp -16 #se reserva stack
	sw ra 0(sp)#se almacenan los valores
	sw s3 4(sp)#en el stack
	sw s5 8(sp)
	sw s4 12(sp)	
	blt s2 s1 LOOP # si el numero de discos es mayor a 1 pasa al loop recursivo
	
	jal zero RETURN#si es igual a 1 comienza a retornar
	
LOOP:	sub s1 s1 s2 #Cada vez del loop se resta numero de discos menos 1
	add t0 zero s5#Se cambia de 
	add s5 zero s4#torres
	add s4 zero t0
	jal ra HANOI
	add t0 zero s5#Se cambia de 
	add s5 zero s4#torres
	add s4 zero t0
	
	lw a1 0(s3)	#se mueve el disco x de torre de origen a torre destino
	sw zero 0(s3)
	addi s3 s3 -4
	sw a1 0(s5)
	addi s5 s5 4
	
	add t0 zero s3#Se cambia de 
	add s3 zero s4#torres
	add s4 zero t0
	
	addi sp sp -16 #se reserva stack
	sw ra 0(sp)#se almacenan los valores
	sw s3 4(sp)#en el stack
	sw s5 8(sp)
	sw s4 12(sp)
	
	
	
	
	jal ra HANOI#se llama de nuevo la funcion
	
	
RETURN:	lw ra 0(sp) #se retornan los valores
	lw s3 4(sp)#del stack
	lw s5 8(sp)#a los registros
	lw s4 12(sp)
	addi sp sp 16
	lw a1 0(s3)	#se mueve el disco 1 de torre de origen a torre destino
	sw zero 0(s3)
	addi s3 s3 -4
	sw a1 0(s5)
	
	
	jalr zero ra 0 #retorna a la funcion padre
END:	
