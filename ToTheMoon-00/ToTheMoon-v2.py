def sentidoOpuesto(sentido):
    return 'antihorario' if sentido == 'horario' else 'horario'

def usarMecha(sentido, rpm, duracion):
    print("Girando mecha en sentido " + sentido + " con una velocidad de " + str(rpm) + " por " + str(duracion) + " minutos.")

def perforacionCompleta(sentidoEntrada, rpmEntrada, duracionEntrada, rpmExtraccion, duracionExtraccion):
    usarMecha(sentidoEntrada, rpmEntrada, duracionEntrada)
    print("Cerrando pinzas")
    usarMecha(sentidoOpuesto(sentidoEntrada), rpmExtraccion, duracionExtraccion)
    print("Recoleccion terminada. \n")

def manejarBrazoExcavador(dureza, porosidad):
    if (dureza > 0.66 and porosidad < 0.33):
        print("Recogiendo muestras de suelo duro y compacto:")
        perforacionCompleta('horario', 150, 10, 150, 10)
    elif(dureza < 0.33 and porosidad > 0.66):
        print("Recogiendo muestras de suelo blando y poroso:")
        perforacionCompleta('antihorario', 100, 5, 100, 5)
    elif(0.33 <= dureza and dureza <= 0.66 and 0.33 <= porosidad and porosidad <= 0.66):
        print("Recogiendo muestras de suelo con dureza y porosidad intermedias::")
        perforacionCompleta('antihorario', 150, 5, 100, 10)
    else:
        print("No se reconocio el tipo de suelo")


manejarBrazoExcavador(0.9, 0.1)
manejarBrazoExcavador(0.1, 0.9)
manejarBrazoExcavador(0.4, 0.4)
manejarBrazoExcavador(0.9, 0.9)
manejarBrazoExcavador(0.1, 0.1)
