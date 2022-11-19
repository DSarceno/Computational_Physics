# 2017-08-02
# Makefile
# Giovanni Ramírez (ramirez@ecfm.usac.edu.gt)

# Lista de reglas para make.  Permite la simplificación de la compilación y de
# la actualización de los códigos y ejecutables.

# Codificación del texto: UTF8
# Versión de make probadas: GNU Make 4.0
# Instrucciones de ejecución: usar make para ver la ayuda

FF=gfortran
OPTS=-Wall -pedantic -std=f95
#LDOPTS=-lblas -llapack
#OBJS=types.o funciones.o factorial.o besselJ.o pool.o
EXT=f90

all:
	@echo "USE: make file.x"
	@echo "where file.f90 is a file available in the same directory"


%.o: %.$(EXT)
	$(FF) $(OPTS) -c -o $@ $<


%.x: $(OBJS) %.o
	$(FF) -o $@ $(OBJS) $(*F).$(EXT) $(LDOPTS)


.PHONY: clean
clean:
	$(foreach i,$(wildcard *.o *.mod), rm $(i);)

.PHONY: cleanall
cleanall: clean
	$(foreach i,$(wildcard *.x), rm $(i);)
