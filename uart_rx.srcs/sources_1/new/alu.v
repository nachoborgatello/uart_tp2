`timescale 1ns / 1ps

module alu
    #(
        parameter tamanioEntrada=8,
        parameter tamanioSalida=8,
        parameter tamanioOperacion=8
    )
    (   
        input wire [tamanioEntrada-1:0] operandoA,
        input wire [tamanioEntrada-1:0] operandoB,
        input wire [tamanioOperacion-1:0] operacion,
        output wire [tamanioSalida-1:0] resultado
    );

    // Operaciones
    localparam ADD      =   8'b11111000;
    localparam SUB      =   8'b11111001;
    localparam AND      =   8'b11111010; 
    localparam OR       =   8'b11111011; 
    localparam XOR      =   8'b11111100;
    localparam SRA      =   8'b11111101;
    localparam SRL      =   8'b11111110;
    localparam NOR      =   8'b11111111;
    
    reg signed [tamanioSalida-1:0] temp; // Se define como signed para SRA

    always @(*)
        begin
            case(operacion)      
                ADD : temp = operandoA + operandoB;
                SUB : temp = operandoA - operandoB;
                AND : temp = operandoA & operandoB;
                OR  : temp = operandoA | operandoB;
                XOR : temp = operandoA ^ operandoB;
                SRA : temp = $signed(operandoA) >>> operandoB;
                SRL : temp = operandoA >> operandoB;
                NOR : temp = ~(operandoA | operandoB);
                default : temp = {tamanioSalida{1'b0}};   
            endcase
        end   
    assign resultado = temp;
endmodule
