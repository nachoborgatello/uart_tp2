Valores Reservados: Los últimos 11 valores están reservados para operaciones y funciones internas del sistema.

Operaciones Aritméticas: Los siguientes 8 valores están destinados a las operaciones aritméticas:

ADD: 248 (11111000)
SUB: 249 (11111001)
AND: 250 (11111010)
OR: 251 (11111011)
XOR: 252 (11111100)
SRA: 253 (11111101)
SRL: 254 (11111110)
NOR: 255 (11111111)
Definición de los Primeros 3 Valores: Los 3 primeros valores se utilizan para definir la posición de los operandos y el código de operación:

Operando A: 245 (11110101)
Operando B: 246 (11110110)
Operación: 247 (11110111)
Procedimiento:
Enviar la Posición: Primero, se debe enviar la posición correspondiente (A, B o la operación).
Enviar el Valor del Operando: Luego, se enviará el valor del operando relacionado.
NOTA IMPORTANTE:

Enviar la posición del operando (Operando A, Operando B, u Operación).
Después, enviar el valor correspondiente al operando.