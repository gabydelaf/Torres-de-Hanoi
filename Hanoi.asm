#Integrantes:
#Gabriela Alejandra de la Fuente Chavez
#Daniel Gutierrez Bustos

.data
.text
addi s1 zero 3#numero de discos
addi a1 zero 3#copia
addi s2 zero 1#número para comparar

addi s3 zero 0#Apuntador a la torre A
addi s4 zero 0#Apuntador a la torre B
addi s5 zero 0#Apuntador a la torre C

#MAIN
jal ra INIT#se manda llamar a la función para inicializar torres
jal ra HANOI#se llama la función recursiva
jal zero END


INIT:	
	addi sp sp -36 #se reserva stack para las tres torres
	lw s3 0(sp)#se carga la direccion de las torres vacías
	lw s4 12(sp)#en los apuntadores
	lw s5 24(sp)
	#Se comienza a llenar la torre A
FILL:	sw a1 0(s3)#se añade el disco
	addi a1 a1 -1 #se decrementa el número de discos
	addi s3 s3 4 #se aumenta el apuntador
	blt zero a1 FILL#mientras no se hayan cargado todos los discos vuelve a hacerlo
	
	addi s3 s3 -4 #regresa a apuntar al último disco
	jalr zero ra 0 #retorna a la función padre


HANOI: 
	addi sp sp -12 #se reserva stack
	sw ra 0(sp)#se almacenan los valores
	sw s1 4(sp)#en el stack
	sw s2 8(sp)	
	blt s2 s1 LOOP # si el numero de discos es mayor a 1 pasa al loop recursivo
	jal zero RETURN#si es igual a 1 comienza a retornar
LOOP:	sub s1 s1 s2 #Cada vez del loop se resta número de discos menos 1
	jal ra HANOI#se llama de nuevo la función
RETURN:	#addi s3 s3 1#resultado +1
	lw ra 0(sp) #se retornan los valores
	lw s1 4(sp)#del stack
	lw s2 8(sp)#a los registros
	addi sp sp 12 
	jalr zero ra 0 #retorna a la funcion padre
END:	
