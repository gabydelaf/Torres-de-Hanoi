#Integrantes:
#Gabriela Alejandra de la Fuente Chavez
#Daniel Gutierrez Bustos

.data
.eqv discos 3
adress: .word 0



.text
addi s1 zero 0 #Apuntador a la torre origen
addi s2 zero 0 #Apuntador a la torre aux
addi s3 zero 0 #Apuntador a la torre destino



addi a1 zero discos #número de elementos
addi a0 zero discos #contador llenado
addi s5 zero 1 #1 para comparar



   #main    
    jal ra init
    jal ra hanoi
    jal zero end
    
init:    lui s1 %hi(adress) #crear apuntadores
    addi s1 s1 %lo(adress)    
    slli s2 a1 2
    add s2 s1 s2
    slli s3 a1 2
    add s3 s2 s3
    
    
fill:    sw a0 0(s1)#se añade el disco
    addi a0 a0 -1 #se decrementa el numero de discos
    addi s1 s1 4 #se aumenta el apuntador
    addi a3 a3 1 #se aumenta el contador
    blt zero a0 fill #mientras no se hayan cargado todos los discos vuelve a hacerlo
    addi s1 s1 -4 #regresa a apuntar al ultimo disco
    jalr zero ra 0 #retorna al main
    
hanoi:     blt a3 s5 loop # si el numero de discos es mayor a 1 pasa al loop recursivo
    addi sp sp -8 #Se le resta 8 al sp
    sw ra 0(sp)  #push ra
    sw a3 4 (sp) #push a3  #siempre problemas aqui
    jal zero return_hanoi #si es igual a 1 comienza a retornar
    
loop:    addi a1 a1 -1 #decrementar el numero de elementos
    addi a3 a3 -1
    add t0 zero s2 #primer cambio
    add s2 zero s3
    add s3 zero t0
    
    jal ra hanoi
    
    add t0 zero s2 #desawp
    add s2 zero s3
    add s3 zero t0



   add t0 zero s1 #segundo cambio
    add s1 zero s3
    add s3 zero t0
    
    jal ra hanoi
    
    add t0 zero s1 #segundo deswap
    add s1 zero s3
    add s3 zero t0
            
return_hanoi:
    lw ra  0(sp) #Pop primero se lee y luego se incrementa
    lw a3 4 (sp) #pop a3
    addi sp sp 8
    jalr zero ra 0
end:
