SRC += IRPF90_temp/irp_stack.irp.F90 IRPF90_temp/irp_touches.irp.F90 IRPF90_temp/c.irp.F90 IRPF90_temp/c.irp.module.F90 IRPF90_temp/diagon.irp.F90 IRPF90_temp/diagon.irp.module.F90 IRPF90_temp/rank.irp.F90 IRPF90_temp/rank.irp.module.F90 IRPF90_temp/project.irp.F90 IRPF90_temp/project.irp.module.F90
OBJ += IRPF90_temp/irp_stack.irp.o IRPF90_temp/c.irp.o IRPF90_temp/c.irp.module.o IRPF90_temp/diagon.irp.o IRPF90_temp/diagon.irp.module.o IRPF90_temp/rank.irp.o IRPF90_temp/rank.irp.module.o
OBJ1 = $(patsubst %, IRPF90_temp/%,$(notdir $(OBJ))) IRPF90_temp/irp_touches.irp.o 
ALL = project
ALL_OBJ = project.irp.module.o project.irp.o
ALL_OBJ1 = $(patsubst %, IRPF90_temp/%,$(notdir $(ALL_OBJ)))
all:$(ALL)
	@$(MAKE) -s move
project: IRPF90_temp/project.irp.o IRPF90_temp/project.irp.module.o $(OBJ1)
	$(FC) -o $@ IRPF90_temp/$@.irp.o IRPF90_temp/$@.irp.module.o $(OBJ1) $(LIB)
	@$(MAKE) -s move
IRPF90_temp/c.irp.o: IRPF90_temp/c.irp.module.o  IRPF90_temp/rank.irp.module.o 
IRPF90_temp/diagon.irp.o: IRPF90_temp/diagon.irp.module.o  IRPF90_temp/rank.irp.module.o  IRPF90_temp/c.irp.module.o 
IRPF90_temp/rank.irp.o: IRPF90_temp/rank.irp.module.o  
IRPF90_temp/project.irp.o: IRPF90_temp/project.irp.module.o  IRPF90_temp/rank.irp.module.o  IRPF90_temp/diagon.irp.module.o  IRPF90_temp/c.irp.module.o 
IRPF90_temp/irp_touches.irp.o:  IRPF90_temp/c.irp.o IRPF90_temp/c.irp.o  IRPF90_temp/diagon.irp.o IRPF90_temp/diagon.irp.o  IRPF90_temp/rank.irp.o IRPF90_temp/rank.irp.o
IRPF90_temp/%.irp.module.o: IRPF90_temp/%.irp.module.F90
	$(FC) $(FCFLAGS) -c IRPF90_temp/$*.irp.module.F90 -o IRPF90_temp/$*.irp.module.o
IRPF90_temp/%.irp.o: IRPF90_temp/%.irp.module.o IRPF90_temp/%.irp.F90
	$(FC) $(FCFLAGS) -c IRPF90_temp/$*.irp.F90 -o IRPF90_temp/$*.irp.o
IRPF90_temp/%.irp.o: IRPF90_temp/%.irp.F90
	$(FC) $(FCFLAGS) -c IRPF90_temp/$*.irp.F90 -o IRPF90_temp/$*.irp.o
IRPF90_temp/%.o: %.F90
	$(FC) $(FCFLAGS) -c $*.F90 -o IRPF90_temp/$*.o
IRPF90_temp/%.o: %.f90
	$(FC) $(FCFLAGS) -c $*.f90 -o IRPF90_temp/$*.o
IRPF90_temp/%.o: %.f
	$(FC) $(FCFLAGS) -c $*.f -o IRPF90_temp/$*.o
IRPF90_temp/%.o: %.F
	$(FC) $(FCFLAGS) -c $*.F -o IRPF90_temp/$*.o
IRPF90_temp/%.irp.F90: irpf90.make

move:
	@mv -f *.mod IRPF90_temp/ 2> /dev/null | DO_NOTHING=

clean:
	rm -rf $(EXE) $(OBJ1) $(ALL_OBJ1) $(ALL)

veryclean:
	- $(MAKE) clean

	- rm -rf IRPF90_temp/ IRPF90_man/ irpf90.make irpf90_variables dist

