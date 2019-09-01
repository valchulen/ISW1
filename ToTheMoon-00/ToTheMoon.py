def sentidoOpuesto(sentido):
    return 'antihorario' if sentido == 'horario' else 'horario'

def usarMecha(sentido, rpm, duracion):
    print("Girando mecha en sentido " + sentido + " con una velocidad de " + str(rpm) + " por " + str(duracion) + " minutos.")

def perforacionCompleta(sentido, rpm, duracion):
    usarMecha(sentido, rpm, duracion)
    print("Cerrando pinzas")
    usarMecha(sentidoOpuesto(sentido), rpm, duracion)
    print("Recoleccion terminada. \n")

def manejarBrazoExcavador(esSueloDuro, esSueloPoroso):
    if (esSueloDuro and not esSueloPoroso):
        print("Recogiendo muestras de suelo duro y compacto:")
        perforacionCompleta('horario', 150, 10)
    elif(not esSueloDuro and esSueloPoroso):
        print("Recogiendo muestras de suelo blando y poroso:")
        perforacionCompleta('horario', 100, 5)
    else:
        print("No se reconocio el tipo de suelo \n")

manejarBrazoExcavador(True, False)
manejarBrazoExcavador(False, True)
manejarBrazoExcavador(True, True)
manejarBrazoExcavador(False, False)
