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








