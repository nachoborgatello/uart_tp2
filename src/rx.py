import serial

# Configuración del puerto serie
puerto = 'COM6'  # Cambia esto al puerto correcto (en Windows es COMX, en Linux /dev/ttyUSBX o /dev/ttySX)
baud_rate = 19200  # Ajusta el baud rate según tu configuración

try:
    # Abrir el puerto serie
    ser = serial.Serial(puerto, baud_rate)
    print(f"Receptor UART iniciado en {puerto} a {baud_rate} bauds.")
    print("Esperando datos...")

    while True:
        # Leer un byte desde el puerto serie
        dato_recibido = ser.read(1)  # Lee 1 byte (8 bits)
        
        if dato_recibido:
            # Convertir el byte recibido a un valor numérico
            valor_numerico = int.from_bytes(dato_recibido, byteorder='big')
            
            # Imprimir el valor recibido en diferentes formatos
            print(f"Byte recibido: {dato_recibido}")
            print(f"Valor numérico: {valor_numerico}")
            print(f"Valor binario: {bin(valor_numerico)}")
            print(f"Valor hexadecimal: {hex(valor_numerico)}")
            print("------")
        else:
            # Si no se reciben datos, salir del bucle
            print("No se recibieron datos. Cerrando receptor...")
            break

except serial.SerialException as e:
    print(f"Error al abrir el puerto serie: {e}")

finally:
    # Cerrar el puerto serie
    if 'ser' in locals() and ser.is_open:
        ser.close()
        print("Puerto serie cerrado.")