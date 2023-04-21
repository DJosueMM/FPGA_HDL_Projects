`timescale 1ns / 1ps

module module_debouncer_syncr#(		
    parameter        N = 1
    )(
    input logic      clk_i,        // Clock de entrada
    input logic      reset_i,      // Reset 
    input logic      debouncer_i,  // Entrada del debouncer 
    output logic     debouncer_o   // salida del debouncer 
    );
	//Varibles internas
	logic  [N-1 : 0] reg1;						
	logic  [N-1 : 0] next;
	logic            DFF1;
	logic            DFF2;									
	logic            add;											
	logic            resett;
	assign resett =  (DFF1  ^ DFF2);		
	assign add    =  ~(reg1[N-1]);			
	

    always_ff @ ( resett, add, reg1 ) begin

		case( { resett, add } )//Evalua resett y add
			2'b00 : //Si el valor es cero haga:
				next <= reg1; //next va a valer reg1
			2'b01 : //Si el valor es uno haga:
			    next <= reg1 + 1; //next va a valer reg1+1
			default : //El de default:
				next <= { N {1'b0} };//Vale M ceros
		endcase 	
	end
	
    always_ff @ ( posedge clk_i ) begin //Se analiza el flanco positivo del clock de entrada

	    
		if(reset_i ==  1'b0) begin//Si el reset vale 0 todos se vuelven cero
			DFF1 <= 1'b0;
			DFF2 <= 1'b0; 
			reg1 <= { N {1'b0} };

		end else begin //Si no hace esto:
			DFF1 <= debouncer_i;
			DFF2 <= DFF1; //DDF2 vale DFF1
			reg1 <= next; //reg1 vale next
		end
	end
	
    always_ff @ ( posedge clk_i ) begin//Se analiza el flanco positivo del clock de entrada
        
        if(reg1[N-1] == 1'b1) //Si reg1 llega a ese valor hace lo sienguiente:
			debouncer_o <= DFF2;

		else //Si no
			debouncer_o <= debouncer_o; //La salida va a tener el valor de la salida
	end

endmodule

