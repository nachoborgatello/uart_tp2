import serial

# Configuración del puerto serie
puerto = 'COM3'  # Cambia esto al puerto correcto (en Windows es COMX, en Linux /dev/ttyUSBX o /dev/ttySX)
baud_rate = 19200  # Ajusta el baud rate según tu configuración

try:
    # Abrir el puerto serie
    ser = serial.Serial(puerto, baud_rate, timeout=1)
    print(f"Conexión establecida en {puerto} a {baud_rate} bauds.")

    # Simulación de recepción de datos UART (cadena ASCII)
    dato_uart = input("Ingresa un número (0-255): ")

    # Verificar si la cadena es un número válido
    if dato_uart.isdigit():
        # Convertir la cadena ASCII a su valor numérico
        valor_numerico = int(dato_uart)
        
        # Limitar el valor a 8 bits (0-255)
        if 0 <= valor_numerico <= 255:
            # Convertir el valor numérico a un byte (8 bits)
            dato_byte = valor_numerico.to_bytes(1, byteorder='big')
            
            # Imprimir resultados
            print(f"Valor numérico: {valor_numerico}")
            print(f"Valor binario (8 bits): {bin(valor_numerico)}")
            
            # Enviar el byte a través de UART
            ser.write(dato_byte)
            print(f"Enviando a la ALU: {dato_byte}")
        else:
            print("Error: El número debe estar en el rango de 0 a 255.")
    else:
        print("Error: Debes ingresar un número válido.")

except serial.SerialException as e:
    print(f"Error al abrir el puerto serie: {e}")

finally:
    # Cerrar el puerto serie
    if 'ser' in locals() and ser.is_open:
        ser.close()
        print("Puerto serie cerrado.")