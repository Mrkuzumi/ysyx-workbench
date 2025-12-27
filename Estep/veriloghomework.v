/*欢迎来到mika的E2作业本,里面记录了从Circuits/Combinational Logic/Basic gates/Ring or vibrate
开始写的所有verilog代码，因为直到写这个我才意识到应该用某种方式记录下我的学习痕迹，于是想到了这个方法*/
//Ring or vibrate
module top_module (
    input ring,
    input vibrate_mode,
    output ringer,       // Make sound
    output motor         // Vibrate
);
    assign motor = ring && vibrate_mode;
    assign ringer = (~vibrate_mode) && ring;

endmodule




//Thermostat

module top_module (
    input too_cold,
    input too_hot,
    input mode,
    input fan_on,
    output heater,
    output aircon,
    output fan
); 
    assign fan = (too_cold & mode)|(~mode & too_hot )|(too_cold&mode&too_hot) | fan_on;
    assign heater = mode & too_cold;
    assign aircon = ~mode & too_hot;

endmodule


//Popcount3
module top_module( 
    input [2:0] in,
    output [1:0] out );
    always@(*)begin
        case(in)
                3'b000:out = 2'b00;
                3'b001:out = 2'b01;
                3'b010:out = 2'b01;
                3'b100:out = 2'b01;
                3'b011:out = 2'b10;
                3'b101:out = 2'b10;
                3'b110:out = 2'b10;
                3'b111:out = 2'b11;
        endcase
                
    end

endmodule


//不推荐写屎山故此处有另解
module top_module( 
    input [2:0] in,
    output [1:0] out );
    always @(*) begin
    out = 2'd0; // 必须先清零，否则会变成累加器（产生锁存器）
    for (int i = 0; i < 3; i = i + 1) begin
        out = out + in[i];
    end
end

endmodule

//GatesV
/*给你一个四位输入向量 in [3:0]。我们想了解每个位与其相邻位之间的一些关系：
out_both：此输出向量的每个位应指示对应输入位及其左侧（更高索引）的相邻位是否都为 “1”。例如，out_both [2] 应指示 in [2] 和 in [3] 是否都为 1。由于 in [3] 没有左侧相邻位，答案很明显，因此我们无需知道 out_both [3]。
out_any：此输出向量的每个位应指示对应输入位及其右侧的相邻位中是否有任何一个为 “1”。例如，out_any [2] 应指示 in [2] 或 in [1] 是否为 1。由于 in [0] 没有右侧相邻位，答案很明显，因此我们无需知道 out_any [0]。
out_different：此输出向量的每个位应指示对应输入位与其左侧相邻位是否不同。例如，out_different [2] 应指示 in [2] 与 in [3] 是否不同。对于这部分，将向量视为循环的，因此 in [3] 的左侧相邻位是 in [0]。*/
module top_module( 
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different );
    assign out_both[2] = in[2]&in[3];
    assign out_both[1] = in[1]&in[2];
    assign out_both[0] = in[0]&in[1];
    assign out_any[3] = in[3]|in[2];
    assign out_any[2] = in[2]|in[1];
    assign out_any[1] = in[1]|in[0];
    assign out_different[3] = in[3]^in[0];
    assign out_different[2] = in[3]^in[2];
    assign out_different[1] = in[2]^in[1];
    assign out_different[0] = in[1]^in[0];

endmodule





//除了屎山外的标准答案：切片法
module top_module( 
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different );
   // 每一位与它的左边一位相与
    assign out_both = in[2:0] & in[3:1];
    
    // 每一位与它的左边一位相或
    assign out_any = in[3:1] | in[2:0];
    
    // 每一位与它的左边一位异或，最后一位与第0位异或（循环相邻位异或）
    assign out_different = in ^ {in[0], in[3:1]};

endmodule




//Gatesv100
/*你会得到一个 100 位的输入向量 in [99:0]。我们想了解每个位与其相邻位之间的一些关系：
out_both：这个输出向量的每个位都应表示对应的输入位及其左侧相邻位是否都为 “1”。例如，out_both [98] 应表示 in [98] 和 in [99] 是否都为 1。由于 in [99] 没有左侧相邻位，答案很明显，所以我们不需要知道 out_both [99]。
out_any：这个输出向量的每个位都应表示对应的输入位及其右侧相邻位中是否有任何一个为 “1”。例如，out_any [2] 应表示 in [2] 或 in [1] 是否有一个为 1。由于 in [0] 没有右侧相邻位，答案很明显，所以我们不需要知道 out_any [0]。
out_different：这个输出向量的每个位都应表示对应的输入位与其左侧相邻位是否不同。例如，out_different [98] 应表示 in [98] 与 in [99] 是否不同。对于这部分，将向量视为循环的，因此 in [99] 的左侧相邻位是 in [0]。*/
module top_module( 
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different );
    assign out_both = in[98:0]&in[99:1];
    assign out_any = in[99:1]|in[98:0];
    assign out_different = in^{in[0],in[99:1]};
    

endmodule



/*至此我已经一共写完了60道verilog题目！！！------2025.12.25*/






/*Mux2to1*/
module top_module( 
    input a, b, sel,
    output out ); 
    assign out =  (sel == 1'b1) ? b:a;
endmodule


/*Mux2to1v*/
module top_module( 
    input [99:0] a, b,
    input sel,
    output [99:0] out );
    assign out = (sel == 1) ? b:a;

endmodule

/*Mux9to1v*/

module top_module( 
    input [15:0] a, b, c, d, e, f, g, h, i,
    input [3:0] sel,
    output [15:0] out );
    always@(*)begin
        case(sel)
            3'b000:out = a;
            3'b001:out = b;
            3'b010:out = c;
            3'b011:out = d;
            3'b100:out = e;
            3'b101:out = f;
            3'b110:out = g;
            3'b111:out = h;
            4'b1000:out =i;
            default:out = 16'b1111111111111111;
                endcase
                end
endmodule


/*Mux256to1*/
module top_module( 
    input [255:0] in,
    input [7:0] sel,
    output out );
    assign out = in[sel];
            
endmodule


/*Mux256to1v*/
module top_module( 
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out );
    assign out = in[sel*4+:4];
endmodule


/*Hadd*/
module top_module( 
    input a, b,
    output cout, sum );

endmodule

/*Fadd*/
module top_module( 
    input a, b, cin,
    output cout, sum );
    assign sum = cin^(a^b)  ;
    assign cout = ((a^b)&cin)|(a&b);

endmodule


/*Adder3*/
module fadd( 
    input a, b, cin,
    output cout, sum );
    assign sum = cin^(a^b)  ;
    assign cout = ((a^b)&cin)|(a&b);

endmodule
module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
    fadd fa0(
        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .cout(cout[0]),
        .sum(sum[0]));
    fadd fa1(
        .a(a[1]),
        .b(b[1]),
        .cin(cout[0]),
        .cout(cout[1]),
        .sum(sum[1]));
    fadd fa2(
        .a(a[2]),
        .b(b[2]),
        .cin(cout[1]),
        .cout(cout[2]),
        .sum(sum[2]));
endmodule


/*Adder*/
module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
assign sum = x+y;
endmodule


/*Exams/ece241 2014 q1c*/
module top_module (
    input signed [7:0] a,
    input signed [7:0] b,
    output signed [7:0] s,
    output overflow
); //
 
     assign s = a+b;
    assign overflow = (a[7]==b[7])&&(s[7] != a[7]);
endmodule


/*Adder100*/
module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );
    assign {cout, sum} = a+b+cin;
endmodule

/*DFF*/
module top_module (
    input clk,    // Clocks are used in sequential circuits
    input d,
    output reg q );//
    always@(posedge clk)begin
        q=d;
    end
    // Use a clocked always block
    //   copy d to q at every positive edge of clk
    //   Clocked always blocks should use non-blocking assignments

endmodule

/*DFF with reset value*//*同步复位*/
module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output reg [7:0] q
);
    always@(negedge  clk)begin
        if(reset)begin
            q <= 8'h34;
        end else begin
            q <= d;
            
            end
    end

endmodule


/*DFFwith asynchronous reset*//*异步复位*/
module top_module (
    input clk,
    input areset,   // active high asynchronous reset
    input [7:0] d,
    output [7:0] q
);
    always@(posedge clk,posedge areset)begin
        if(areset)begin
        q <= 0;
        end else begin
        q <= d;
        end
    end
    

endmodule


/*DFF with byte enable*/
module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q
);
    always@(posedge clk)begin
        if(!resetn)begin
            q <= 16'b0;
        end else begin
            if(byteena[0])begin
                q[7:0]<=d[7:0];
            end
            
            if(byteena[1])begin
                q[15:8]<=d[15:8];
            end
    end
    end
             
   
endmodule

/*MUX and DFF*/
module register(input D,input clk,output Q);
always@(posedge clk)begin
Q<=D;
end
endmodule
module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
    always@(posedge clk)begin
	Q <= L ? r_in : q_in;
    end
endmodule


/*MUX AND DFF*/

module register(input D,input clk,output Q);
always@(posedge clk)begin
Q<=D;
end
endmodule
module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
wire  x,y;
assign x = E ? w:Q;
assign y = L ? R:x;
register u1(
    .clk(clk),
    .D(y),
    .Q(Q)

);
endmodule




/*create circuit from truth table*/
module top_module (
    input clk,
    input j,
    input k,
    output reg Q); 
    always @(posedge clk) begin
    case ({j, k})  // 将 j 和 k 拼接成两位信号：00, 01, 10, 11
        2'b00: Q <= Q;
        2'b01: Q <= 1'b0;
        2'b10: Q <= 1'b1;
        2'b11: Q <= ~Q;
    endcase
end
    

endmodule


/*Detect an edge*/
module top_module (
    input clk,
    input [7:0] in,
    output reg [7:0] pedge  // 注意：这里必须是 reg
);

    reg [7:0] in_last;

    always @(posedge clk) begin
        // 关键：在这一拍里，in 是当下的，in_last 是上一拍存下来的。
        // 用这两个算出的结果直接赋给 pedge 寄存器。
        pedge <= in & ~in_last; 
        
        // 这一拍结束时，in_last 更新
        in_last <= in;
    end

endmodule
