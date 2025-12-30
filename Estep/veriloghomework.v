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





/*dectect both edge*/
module top_module (
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);
always@(posedge clk)begin

           
           anyedge <= in ^in_last;//唯一的区别就是把判断依据改为异或^
  
           
         in_last <= in;	
	
	
end
endmodule

/*Edge capture register*/
module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);
    reg [31:0] in_last;
    reg [31:0] tmp;
    always@(posedge clk)begin
        in_last <= in;
        if(reset)begin
        out <= 32'b0;
        end else begin
    tmp = (~in)&in_last;//本道题监测的是由1->0的变化
            
            out <= out | tmp;//若有某一位变化就用那某一位变化通过或门来覆盖掉out
            
           
      end
        
        
    end
    

endmodule


/*Dual-edge triggered flip-flop*/
module top_module (
    input clk,
    input d,
    output  reg q
);
    reg tmp1;
    reg tmp2;
    always@(posedge clk )begin//上升沿监测，监测0-》1
        tmp1 <= d;         
    end
    always@(negedge clk)begin//下降沿监测，监测1-》0
        tmp2 <= d;     
    end
    always@(*)begin
        if(clk)begin
            q= tmp1;
        end else begin
            q = tmp2;
        end
    end
endmodule
//重新审视此题：为什么我的思维逻辑错了呢？没有读清楚题目，本题要制作一个D触发器，但是这个触发器是上下沿都要执行一次存储的触发器
//与最普通最初级最常见的D触发器不同在于多了一个还对negadege响应的步骤
/*而我一开始想要通过if(d&(~tmp1)) 和 if(~d&tmp2)来制作的是一个单纯
用来捕获信号上升或下降变化的模块，根本就是和题目南辕北辙！！！*/

/*至此我已经完成了82道题！*/
/*latches and 人字拖章节结束*/

/*decade counter again*/
module top_module (
    input clk,
    input reset,
    output reg [3:0] q);
    always@(posedge clk)begin
        if(reset)begin
            q<=1'b1;
        end else begin
            q <= q +1'b1;
            end
        if(q == 4'b1010)begin
                q<=1'b1;
            end
    end
endmodule


/*slow decade counter*/
module top_module (
    input clk,
    input slowena,
    input reset,
    output  reg [3:0] q);
    always@(posedge clk)begin
        if (reset)begin
            q<=1'b0;
        end else begin
            if(slowena)begin
                q<= q+1'b1;
                if(q==4'b1001)begin
                q<=0;
            end
            end else begin
                q<= q;
            end
        end
    end
endmodule


/*counter 1000*/
/*终于出现了！这道题让我设计的思路就是和我f3最终的大作业设计计时器是一样的思路：
所有计数器共用一个时钟信号那他们怎样保证什么时候该累加什么时候不该呢？答案就是上一级（低位）
该进位的时候就给一个使能信号给更高一级就可以了*/
module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //因为题目给的BCD计数器（就是我说的计数器）是0->9循环的，所以10*10*10就可以满足题目需求
//下面注释为BCD计数器的代码
/*module bcdcount (
	input clk,
	input reset,
	input enable,
	output reg [3:0] Q
);*/
    wire [3:0] q0, q1, q2;
    assign c_enable[0] = 1'b1;
    bcdcount bcd1(
        .clk(clk),
        .reset(reset),
        .enable(c_enable[0]),
        .Q(q0)
    );
    assign c_enable[1]= (q0==4'b1001);
       bcdcount bcd2(
        .clk(clk),
        .reset(reset),
        .enable(c_enable[1]),
        .Q(q1)
    );
    assign c_enable[2]= (q0==4'b1001)&(q1==4'b1001);
    bcdcount bcd3(
        .clk(clk),
        .reset(reset),
        .enable(c_enable[2]),
        .Q(q2)
    );
    assign OneHertz = (q0==4'b1001)&(q1==4'b1001)&(q2==4'b1001);
endmodule


/*count clock*/
/*创建一组适用于12小时制时钟（带有上午/下午指示器）的计数器。你的计数器由一个快速运行的clk时钟控制，每当时钟需要递增时（即每秒一次），ena会产生一个脉冲。

复位（reset）会将时钟重置为12:00 AM。pm为0表示上午（AM），为1表示下午（PM）。hh、mm和ss分别是小时（01-12）、分钟（00-59）和秒（00-59）的两位BCD（二进制编码的十进制）数字。复位的优先级高于使能，即使在未使能的情况下也能发生。

以下时序图展示了从11:59:59 AM到12:00:00 PM的翻转行为，以及同步复位和使能行为。*/

module bcd9 (
	input clk,
	input reset,
	input enable,
	output reg [3:0] Q
);
always @(posedge clk) begin
    if (reset) begin
        Q <= 4'b0000 ;//reset if needed to be reset
    end else if (enable) begin
        if (Q >= 4'b1001) begin  
            Q <= 4'b0000;//reset when arrive to 9
        end else begin
            Q <= Q + 1'b1;
        end
    end
end
//create a bcd first which can count 0->9
endmodule
module bcd5 (
	input clk,
	input reset,
	input enable,
	output reg [3:0] Q
);
always @(posedge clk) begin
    if (reset) begin
        Q <= 4'b0000 ;//reset if needed to be reset
    end else if (enable) begin
        if (Q >= 4'b0101) begin  
            Q <= 4'b0000;//reset when arrive to 9
        end else begin
            Q <= Q + 1'b1;
        end
    end
end
//create a bcd first which can count 0->9and 0->5
endmodule
module top_module(
    input clk,
    input reset,
    input ena,
    output  reg pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    //pm0-上午，pm1-》下午
    wire [3:0] q0, q1, q2,q3,q4,q5;
    wire [5:0] en;
            
            assign ss[3:0] = q0;
            assign ss[7:4] = q1;
            assign mm[3:0] = q2;
            assign mm[7:4] = q3;                     
            assign en[0]= ena;
            assign en[1] = (q0 == 4'b1001);//当个位为9给十位一个进位信号（使能）
            assign en[2] = (q0==4'b1001)&(q1==4'b0101);//十位为5，个位为9
            assign en[3] = (q2==4'b1001)&(q0==4'b1001)&(q1==4'b0101);//秒十位为5，个位为9 ，分的个位为9
            assign en[4] = (q3==4'b0101)&(q2==4'b1001)&(q0==4'b1001)&(q1==4'b0101);//秒十位为5，个位为9 ，分的个位为9,十位为5
            assign en[5] = (q4==4'b0010)&(q3==4'b0101)&(q2==4'b1001)&(q0==4'b1001)&(q1==4'b0101);//秒十位为5，个位为9 ，分的个位为9,十位为5，时的个位为9 



    
        

            
            bcd9 ssdegewei(//秒的个位
                .clk(clk),
                .reset(reset),
                .enable(en[0]),
                .Q(q0)
            );
             
             bcd5 ssdeshiwei(//秒的十位
                .clk(clk),
                .reset(reset),
                .enable(en[1]),
                .Q(q1)
            );
            
            //接下来要把十位复位，怎么复位呢
           
            bcd9 mmdegewei(//分的个位
                .clk(clk),
                .reset(reset),
                .enable(en[2]),
                .Q(q2)
            );


            
            bcd5 mmdeshiwei(//分的十位
                .clk(clk),
                .reset(reset),
                .enable(en[3]),
                .Q(q3)
            );


                                
            always @(posedge clk) begin
            if(reset)begin
                hh<=8'h12;
                pm<=1'b0;
            end else if(en[4])begin
                if(hh==8'h12)begin//from 12:59:59->01:00:00
                    hh<=8'h01; 
                end else if(hh==8'h11)begin//11:59:59 ->12:00:00
                    pm<=~pm;
                    hh<=8'h12;
                end else if(hh[3:0] == 4'h9)begin//from 09:59:59 ->10:00:00
                    hh[7:4] <= hh[7:4] + 1'b1;
                    hh[3:0] <= 4'h0;

                
                end else begin
                    hh[3:0]<=hh[3:0] +1'b1;
                end

            end
            

            end
            

endmodule
/*1. 为什么 hh 显示的是 c？
在第一张图（Minute roll-over）中：

Ref（参考）: hh 显示为 12。

Yours（你的）: hh 显示为 c。

原因： 在 Verilog 中，8'b00001100（即十进制的 12）在仿真器的十六进制视图下会显示为 0c。而题目要求的是 BCD 码。BCD 码要求每一位十进制数占用 4 个位。

12 的 BCD 码应该是：0001 (1) 和 0010 (2)，拼起来是 8'h12。

你的代码里写的是：hh <= 8'b00001100;（这是纯二进制的 12）。*/
