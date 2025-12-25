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