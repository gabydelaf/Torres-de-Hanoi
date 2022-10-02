#Integrantes:
#Gabriela Alejandra de la Fuente Chavez
#Daniel Gutierrez Bustos
.data
.eqv discos 4
adress: .word 0



.text
addi s1 zero 0 #Apuntador a la torre origen
addi s2 zero 0 #Apuntador a la torre aux
addi s3 zero 0 #Apuntador a la torre destino

addi s9 zero 0#contador de discos


addi a1 zero discos #número de elementos
addi a0 zero discos #contador llenado
addi s5 zero 1 #1 para comparar



#main    
    jal ra init
    jal ra hanoi
    jal zero end
    
init:   lui s1 %hi(adress) #crear apuntadores
    	addi s1 s1 %lo(adress)    
   	slli s2 a1 2
    	add s2 s1 s2
    	slli s3 a1 2
    	add s3 s2 s3
    	add s11 zero s1
    
fill:   sw a0 0(s1) #se añade el disco
    	addi a0 a0 -1 #se decrementa el numero de discos
    	addi s1 s1 4 #se aumenta el apuntador
    	addi a3 a3 1 #se aumenta el contador
    	blt zero a0 fill #mientras no se hayan cargado todos los discos vuelve a hacerlo
    	addi s1 s1 -4 #regresa a apuntar al ultimo disco
    	add s1 zero s11
    	jalr zero ra 0 #retorna al main	
    	
    
hanoi:	addi sp sp -20	#se reserva stack		
	sw a3 0(sp)	#y se almacena el número de 		
	sw s1 4(sp)	#discos 		
	sw s2 8(sp)	#y los apuntadores a las bases de 		
	sw s3 12(sp)	#las torres		
	sw ra 16(sp)	#Se almacena el return address			
	bne a3 zero loop
	
	jal ra return_hanoi #Cuando ya no haya discos comienza a retornar
	
loop:	addi a3 a3 -1	#se decrementa n	
	add t0 zero s2  #Se intercambian destino y auxiliar
	add s2 zero s3			
	add s3 zero t0					
	
	jal ra hanoi	#Se vuelve a llamar a la función		
	addi a3 a3 1	#Cuando retorna n= n-1
			#entonces se incrementa para compensar	
			
			
#Bloque para mover el disco
	add t6 zero s1 #se guarda la dirección de la base origen
search:	lw s9 0(s1) #Busca el valor que tiene que mover
	addi s1 s1 4 #incrementando la dirección hasta 
	bne s9 a3 search #encontrar el valor que sea igual a a3
	addi s1 s1 -4
	
    	sw zero 0(s1) #Mueve el disco 
    	add s1 zero t6 #se recupera la dirección de la base
    
    	add t6 zero s3 #se guarda la dirección de la base destino
empty:	lw s9 0(s3)	#Busca el espacio vacío de la torre destino
	addi s3 s3 4
	bne s9 zero empty #Mientras no esté vacía, busca
	addi s3 s3 -4
	
    	sw a3 0(s3) #se coloca el valor en la dirección que se quedó
	add s3 zero t6 #se recupera la dirección de la base
#Termina MOVE
			
	addi a3 a3 -1 #se vuelve a decrementar n
	add t0 zero s1	#Se intercambian 		
	add s1 zero s2	#Origen es aux
	add s2 zero s3	#aux es destino
	add s3 zero t0	#destino es origen
	jal ra hanoi			

return_hanoi:	lw a3 0(sp) #Se cargan los valores almacenados
	lw s1 4(sp) #al retornar
	lw s2 8(sp)			
	lw s3 12(sp)			
	lw ra 16(sp)			
	addi sp sp 20 #se apunta al top del stack			
	jalr zero ra 0 #retorna a función padre			

end: add x0 x0 x0
