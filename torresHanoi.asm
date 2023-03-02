.data
	torreOrigen: .word 0

.text
	addi s0, zero, 3
	addi a0, zero, 0
	lui a1, %hi(torreOrigen)
	addi a1, a1, %lo(torreOrigen)
	slli t1, s0, 2
	add a3, a1, t1
	add a2, a3, t1
	#definicion de torres
	#a1 torre origen 
	#a2 torre destino
	#a3 torre auxiliar
llenar:	
	beq s0, zero, iniciar
	slli t1, a0, 2
	add t1, t1, a1
	sw s0, 0(t1) 
	addi a0, a0, 1
	addi s0, s0, -1
	j llenar
	
iniciar:	
	
	jal torresHanoi
	j end

torresHanoi:
	slti t0, a0, 1
	beq t0, zero, loop
	jalr ra
	
loop:
	
	addi sp, sp, -20
	sw ra, 16(sp)
	sw a0, 12(sp)
	sw a1, 8(sp)
	sw a2, 4(sp)
	sw a3, 0(sp)
	addi a0, a0, -1
	
	add t0 zero a2  #Se intercambian destino y auxiliar
	add a2 zero a3			
	add a3 zero t0	
	
	#primera 
	
	jal torresHanoi
	
	
	jal moverDisco
	
	addi s0, s0, 1 #count de movimientos
	
	#swap 
	add t2, zero, a1		
	add a1 zero a2	
	add a2 zero a3	
	add a3 zero t2
	
	
	#segunda llamad aa torres de hanoi
	
	#borrar arriba
	jal torresHanoi
	
	lw a3, 0(sp)
	lw a2, 4(sp)
	lw a1, 8(sp)
	lw a0, 12(sp)
	lw ra, 16(sp)
	addi sp, sp, 20
	jalr ra
	

moverDisco:
	addi a0, a0, 1
	addi t2, zero, 0
buscarPos:
	slli t1, t2, 2  		#shift para recorrer la direccion del arreglo
	add t1, t1, a1 			#se suma la direccion del arreglo origen 
	lw t0, 0(t1)			# se carga el valor en una 
	addi t2, t2, 1 			#se aumenta el contador del ciclo de busqueda 
	bne t0, a0, buscarPos 		#si el disco no esta en el array, error
	sw zero, 0(t1)
	addi sp, sp, -4
	sw t0, 0(sp)	
	addi t2, zero, 0
buscarVacio:		
	slli t1, t2, 2
	add t1, t1, a3
	lw t0, 0(t1)
	addi t2, t2, 1
	bne t0, zero, buscarVacio
	lw t0, 0(sp)
	addi sp, sp, 4
	sw t0, 0(t1)
	addi a0, a0, -1
	
	
	jalr ra
	
end:

	
	
