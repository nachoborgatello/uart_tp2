`timescale 1us/1ns  // Ajustar escala de tiempo para la simulación del UART

module top_tb;
   // Parámetros
   parameter DBIT = 8;
   parameter SB_TICK = 16;
   parameter DVSR = 163;
   parameter DVSR_BIT = 8;
   parameter FIFO_W = 4;

   // Señales del testbench
   reg clk, reset;
   reg rd_uart;
   reg rx;
   wire rx_empty;
   wire [7:0] r_data;
   integer i;
   reg [7:0] data;  // Almacenar el byte a enviar
   
   // Instancia del módulo top
   top #(.DBIT(DBIT), .SB_TICK(SB_TICK), .DVSR(DVSR), .DVSR_BIT(DVSR_BIT), .FIFO_W(FIFO_W))
   uut (
      .clk(clk), 
      .reset(reset), 
      .rd_uart(rd_uart), 
      .rx(rx), 
      .rx_empty(rx_empty), 
      .r_data(r_data)
   );

   // Generación de reloj (50 MHz)
   always #10 clk = ~clk;  // Periodo de 20 ns

   // Secuencia de prueba
   initial begin
      // Inicialización
      clk = 0;
      reset = 1;
      rd_uart = 0;
      rx = 1; // Línea RX en estado inactivo (UART idle)
      #20 reset = 0;  // Desactivar reset
      
      #500
      // Simulación de trama UART (envío de un byte)
      data = 8'b10010101;
      rx = 0;  // Bit de inicio
      #51041;  // Esperar un ciclo de baud
      for (i = 0; i < 8; i = i + 1) begin
         rx = data[i];  // Enviar cada bit de datos
         #51041;  // Esperar un ciclo de baud entre bits
      end
      rx = 1;  // Bit de parada
      #51041;  // Esperar tiempo de stop bit
      
      #50000
      // Simulación de trama UART (envío de un byte)
      data = 8'b11011101;
      rx = 0;  // Bit de inicio
      #51041;  // Esperar un ciclo de baud
      for (i = 0; i < 8; i = i + 1) begin
         rx = data[i];  // Enviar cada bit de datos
         #51041;  // Esperar un ciclo de baud entre bits
      end
      rx = 1;  // Bit de parada
      #51041;  // Esperar tiempo de stop bit
      
      #500
      rd_uart = 1;
      #500
      rd_uart = 0;
     
      // Finalizar simulación
      #500;
      $finish;
   end

   // Monitoreo de señales
   initial begin
      $monitor("Time=%0t, rx=%b, rx_empty=%b, r_data=%h", $time, rx, rx_empty, r_data);
   end
endmodule
