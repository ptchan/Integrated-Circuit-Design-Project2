`timescale 1ns/1ps

module poker(type, i0, i1, i2, i3, i4);
//DO NOT CHANGE!
	input  [5:0] i0, i1, i2, i3, i4;
	output [3:0] type;
//---------------------------------------------------
	wire same_suit_out, straight_out, pair_out, one_pair, two_pair, three_kind, full_house, four_kind, straight_flush, only_straight, invert1, invert2, only_flush;
    wire [3:0] straight_output, straight_flush_output, high_card_output, flush_output, four_kind_output, full_house_output, three_kind_output, 
    two_pair_output, one_pair_output;

    wire [3:0] t1, t2;

    wire [3:0] if_flush, if_straight, if_high_card, if_straight_flush, if_pair, if_full_house, if_three_kind, if_two_pair, if_one_pair;
    //wire [15:0] test;

    same_suit samesuit(same_suit_out, i0, i1, i2, i3, i4);
	straight straight_(straight_out, i0, i1, i2, i3, i4);
	pair pair_(pair_out, one_pair, two_pair, three_kind, full_house, four_kind, i0, i1, i2, i3, i4);

	AN2 straight_flush_an1(straight_flush, straight_out, same_suit_out);

    IV iv1(invert1, same_suit_out);
    IV iv2(invert2, straight_out);
    AN2 os1(only_straight, invert1, straight_out);
    AN2 of1(only_flush, invert2, same_suit_out);

    AN2 ff1(four_kind_output[0], four_kind, 1'b1);
    AN2 ff2(four_kind_output[1], four_kind, 1'b1);
    AN2 ff3(four_kind_output[2], four_kind, 1'b1);
    AN2 ff4(four_kind_output[3], four_kind, 1'b0);

    AN2 fu1(full_house_output[0], full_house, 1'b0);
    AN2 fu2(full_house_output[1], full_house, 1'b1);
    AN2 fu3(full_house_output[2], full_house, 1'b1);
    AN2 fu4(full_house_output[3], full_house, 1'b0);

    AN2 thr1(three_kind_output[0], three_kind, 1'b1);
    AN2 thr2(three_kind_output[1], three_kind, 1'b1);
    AN2 thr3(three_kind_output[2], three_kind, 1'b0);
    AN2 thr4(three_kind_output[3], three_kind, 1'b0);

    AN2 tw1(two_pair_output[0], two_pair, 1'b0);
    AN2 tw2(two_pair_output[1], two_pair, 1'b1);
    AN2 tw3(two_pair_output[2], two_pair, 1'b0);
    AN2 tw4(two_pair_output[3], two_pair, 1'b0);

    AN2 on1(one_pair_output[0], one_pair, 1'b1);
    AN2 on2(one_pair_output[1], one_pair, 1'b0);
    AN2 on3(one_pair_output[2], one_pair, 1'b0);
    AN2 on4(one_pair_output[3], one_pair, 1'b0);

    AN2 sf1(straight_flush_output[0], straight_flush, 1'b0);
    AN2 sf2(straight_flush_output[1], straight_flush, 1'b0);
    AN2 sf3(straight_flush_output[2], straight_flush, 1'b0);
    AN2 sf4(straight_flush_output[3], straight_flush, 1'b1);

    AN2 fo1(flush_output[0], only_flush, 1'b1);
    AN2 fo2(flush_output[1], only_flush, 1'b0);
    AN2 fo3(flush_output[2], only_flush, 1'b1);
    AN2 fo4(flush_output[3], only_flush, 1'b0);

    AN2 so1(straight_output[0], only_straight, 1'b0);
    AN2 so2(straight_output[1], only_straight, 1'b0);
    AN2 so3(straight_output[2], only_straight, 1'b1);
    AN2 so4(straight_output[3], only_straight, 1'b0);

    NR4 total1(t1[0], four_kind_output[0], full_house_output[0], three_kind_output[0], two_pair_output[0]);
    NR4 total2(t1[1], four_kind_output[1], full_house_output[1], three_kind_output[1], two_pair_output[1]);
    NR4 total3(t1[2], four_kind_output[2], full_house_output[2], three_kind_output[2], two_pair_output[2]);
    NR4 total4(t1[3], four_kind_output[3], full_house_output[3], three_kind_output[3], two_pair_output[3]);

    NR4 total5(t2[0], one_pair_output[0], straight_flush_output[0], flush_output[0], straight_output[0]);
    NR4 total6(t2[1], one_pair_output[1], straight_flush_output[1], flush_output[1], straight_output[1]);
    NR4 total7(t2[2], one_pair_output[2], straight_flush_output[2], flush_output[2], straight_output[2]);
    NR4 total8(t2[3], one_pair_output[3], straight_flush_output[3], flush_output[3], straight_output[3]);

    ND2 total9(type[0], t1[0], t2[0]);
    ND2 total10(type[1], t1[1], t2[1]);
    ND2 total11(type[2], t1[2], t2[2]);
    ND2 total12(type[3], t1[3], t2[3]);

endmodule

module same_suit(same_suit_out, i0, i1, i2, i3, i4);	//determine if the cards have same suit
		input [5:0] i0, i1, i2, i3, i4;
		output same_suit_out;
		wire out1, out2, out3, out4, out5, out6, out7, out8, out9, out10;

		EO en1(out1, i0[5], i1[5]);
		EO en2(out2, i1[5], i2[5]);
		EO en3(out3, i2[5], i3[5]);
		EO en4(out4, i3[5], i4[5]);
		EO en5(out5, i0[4], i1[4]);
		EO en6(out6, i1[4], i2[4]);
		EO en7(out7, i2[4], i3[4]);
		EO en8(out8, i3[4], i4[4]);

		NR4 an1(out9, out1, out2, out3, out4);
		NR4 an2(out10, out5, out6, out7, out8);
        AN2 an3(same_suit_out, out9, out10);
endmodule


module transform (out, i);
input [3:0] i;
output [12:0] out;
wire iv1, iv2, iv3, iv4; 

IV iv_1(iv1, i[0]);
IV iv_2(iv2, i[1]);
IV iv_3(iv3, i[2]);
IV iv_4(iv4, i[3]);

//out[x] = 0 only when i = x, else out[x] = 1
ND4 nd1(out[0], iv4, iv3, iv2, i[0]);
ND4 nd2(out[1], iv4, iv3, i[1], iv1);
ND4 nd3(out[2], iv4, iv3, i[1], i[0]);
ND4 nd4(out[3], iv4, i[2], iv2, iv1);
ND4 nd5(out[4], iv4, i[2], iv2, i[0]);
ND4 nd6(out[5], iv4, i[2], i[1], iv1);
ND4 nd7(out[6], iv4, i[2], i[1], i[0]);
ND4 nd8(out[7], i[3], iv3, iv2, iv1);
ND4 nd9(out[8], i[3], iv3, iv2, i[0]);
ND4 nd10(out[9], i[3], iv3, i[1], iv1);
ND4 nd11(out[10], i[3], iv3, i[1], i[0]);
ND4 nd12(out[11], i[3], i[2], iv2, iv1);
ND4 nd13(out[12], i[3], i[2], iv2, i[0]);

endmodule

module straight(straight_out, i0, i1, i2, i3, i4);	//determine if the cards are straight

		input [3:0] i0, i1, i2, i3, i4;
		output straight_out;

        wire [12:0] i0_transform, i1_transform, i2_transform, i3_transform, i4_transform, out1, out2, total;
        wire [9:0] result1, result2;
        wire [12:0] result3;

        transform transform1(i0_transform, i0); 
        transform transform2(i1_transform, i1); 
        transform transform3(i2_transform, i2); 
        transform transform4(i3_transform, i3); 
        transform transform5(i4_transform, i4); 

        //determine the value of i0 i1 i2 i3 i4
        AN3 an1_1(out1[0], i0_transform[0], i1_transform[0], i2_transform[0]);
        AN2 an1_2(out2[0], i3_transform[0], i4_transform[0]);
        ND2 nand1(total[0], out1[0], out2[0]);

        AN3 an2_1(out1[1], i0_transform[1], i1_transform[1], i2_transform[1]);
        AN2 an2_2(out2[1], i3_transform[1], i4_transform[1]);
        ND2 nand2(total[1], out1[1], out2[1]);

        AN3 an3_1(out1[2], i0_transform[2], i1_transform[2], i2_transform[2]);
        AN2 an3_2(out2[2], i3_transform[2], i4_transform[2]);
        ND2 nand3(total[2], out1[2], out2[2]);

        AN3 an4_1(out1[3], i0_transform[3], i1_transform[3], i2_transform[3]);
        AN2 an4_2(out2[3], i3_transform[3], i4_transform[3]);
        ND2 nand4(total[3], out1[3], out2[3]);

        AN3 an5_1(out1[4], i0_transform[4], i1_transform[4], i2_transform[4]);
        AN2 an5_2(out2[4], i3_transform[4], i4_transform[4]);
        ND2 nand5(total[4], out1[4], out2[4]);

        AN3 an6_1(out1[5], i0_transform[5], i1_transform[5], i2_transform[5]);
        AN2 an6_2(out2[5], i3_transform[5], i4_transform[5]);
        ND2 nand6(total[5], out1[5], out2[5]);

        AN3 an7_1(out1[6], i0_transform[6], i1_transform[6], i2_transform[6]);
        AN2 an7_2(out2[6], i3_transform[6], i4_transform[6]);
        ND2 nand7(total[6], out1[6], out2[6]);

        AN3 an8_1(out1[7], i0_transform[7], i1_transform[7], i2_transform[7]);
        AN2 an8_2(out2[7], i3_transform[7], i4_transform[7]);
        ND2 nand8(total[7], out1[7], out2[7]);

        AN3 an9_1(out1[8], i0_transform[8], i1_transform[8], i2_transform[8]);
        AN2 an9_2(out2[8], i3_transform[8], i4_transform[8]);
        ND2 nand9(total[8], out1[8], out2[8]);

        AN3 an10_1(out1[9], i0_transform[9], i1_transform[9], i2_transform[9]);
        AN2 an10_2(out2[9], i3_transform[9], i4_transform[9]);
        ND2 nand10(total[9], out1[9], out2[9]);

        AN3 an11_1(out1[10], i0_transform[10], i1_transform[10], i2_transform[10]);
        AN2 an11_2(out2[10], i3_transform[10], i4_transform[10]);
        ND2 nand11(total[10], out1[10], out2[10]);

        AN3 an12_1(out1[11], i0_transform[11], i1_transform[11], i2_transform[11]);
        AN2 an12_2(out2[11], i3_transform[11], i4_transform[11]);
        ND2 nand12(total[11], out1[11], out2[11]);

        AN3 an13_1(out1[12], i0_transform[12], i1_transform[12], i2_transform[12]);
        AN2 an13_2(out2[12], i3_transform[12], i4_transform[12]);
        ND2 nand13(total[12], out1[12], out2[12]);

        //detect if i0 i1 i2 i3 i4 is A 2 3 4 5 - 10 J Q K A
        ND3 n1_1(result1[0], total[0], total[1], total[2]);
        ND2 n1_2(result2[0], total[4], total[3]);
        NR2 n1_3(result3[0], result1[0], result2[0]);

        ND3 n2_1(result1[1], total[2], total[3], total[1]);
        ND2 n2_2(result2[1], total[5], total[4]);
        NR2 n2_3(result3[1], result1[1], result2[1]);

        ND3 n3_1(result1[2], total[3], total[4], total[2]);
        ND2 n3_2(result2[2], total[6], total[5]);
        NR2 n3_3(result3[2], result1[2], result2[2]); 

        ND3 n4_1(result1[3], total[4], total[5], total[3]);
        ND2 n4_2(result2[3], total[7], total[6]);
        NR2 n4_3(result3[3], result1[3], result2[3]);

        ND3 n5_1(result1[4], total[5], total[6], total[4]);
        ND2 n5_2(result2[4], total[8], total[7]);
        NR2 n5_3(result3[4], result1[4], result2[4]);

        ND3 n6_1(result1[5], total[6], total[7], total[5]);
        ND2 n6_2(result2[5], total[9], total[8]);
        NR2 n6_3(result3[5], result1[5], result2[5]);     

        ND3 n7_1(result1[6], total[7], total[8], total[6]);
        ND2 n7_2(result2[6], total[9], total[10]);
        NR2 n7_3(result3[6], result1[6], result2[6]);

        ND3 n8_1(result1[7], total[8], total[7], total[9]);
        ND2 n8_2(result2[7], total[10], total[11]);
        NR2 n8_3(result3[7], result1[7], result2[7]);   

        ND3 n9_1(result1[8], total[9], total[10], total[8]);
        ND2 n9_2(result2[8], total[12], total[11]);
        NR2 n9_3(result3[8], result1[8], result2[8]);   

        ND3 n10_1(result1[9], total[10], total[11], total[9]);
        ND2 n10_2(result2[9], total[0], total[12]);
        NR2 n10_3(result3[9], result1[9], result2[9]);                                                    

        NR4 nr1(result3[10], result3[0], result3[1], result3[2], result3[3]);
        NR4 nr2(result3[11], result3[4], result3[5], result3[6], result3[7]);
        NR2 nr3(result3[12], result3[8], result3[9]);
        ND3 nd1(straight_out, result3[10], result3[11], result3[12]);

	endmodule

module same_value (out, i, j);	//determine if two values are same
	output out;
	input [3:0] i;
	input [3:0] j;
	wire out1, out2, out3, out4;

	EO en1(out1, i[3], j[3]);
	EO en2(out2, i[2], j[2]);
	EO en3(out3, i[1], j[1]);
	EO en4(out4, i[0], j[0]);
	NR4 an1(out, out1, out2, out3, out4);	//if out = 1, two values are same
endmodule

module four_kind_detector (out, i0, i1, i2, i3, i4);

input [3:0] i0, i1, i2, i3, i4;
output out;
wire [7:0] w1, w2, w3, w4, w5;
wire [3:0] result1, result2, result3, result4, result5;
wire [4:0] result;
wire result6, reuslt7;

AN4 an1_1(w1[0], i0[0], i1[0], i2[0], i3[0]);
AN4 an1_2(w1[1], i0[1], i1[1], i2[1], i3[1]);
AN4 an1_3(w1[2], i0[2], i1[2], i2[2], i3[2]);
AN4 an1_4(w1[3], i0[3], i1[3], i2[3], i3[3]);
NR4 nor1_1(w1[4], i0[0], i1[0], i2[0], i3[0]);
NR4 nor1_2(w1[5], i0[1], i1[1], i2[1], i3[1]);
NR4 nor1_3(w1[6], i0[2], i1[2], i2[2], i3[2]);
NR4 nor1_4(w1[7], i0[3], i1[3], i2[3], i3[3]);
NR2 or1_1(result1[0], w1[0], w1[4]);
NR2 or1_2(result1[1], w1[1], w1[5]);
NR2 or1_3(result1[2], w1[2], w1[6]);
NR2 or1_4(result1[3], w1[3], w1[7]);
NR4 an1_5(result[0], result1[0], result1[1], result1[2], result1[3]);

AN4 an2_1(w2[0], i4[0], i1[0], i2[0], i3[0]);
AN4 an2_2(w2[1], i4[1], i1[1], i2[1], i3[1]);
AN4 an2_3(w2[2], i4[2], i1[2], i2[2], i3[2]);
AN4 an2_4(w2[3], i4[3], i1[3], i2[3], i3[3]);
NR4 nor2_1(w2[4], i4[0], i1[0], i2[0], i3[0]);
NR4 nor2_2(w2[5], i4[1], i1[1], i2[1], i3[1]);
NR4 nor2_3(w2[6], i4[2], i1[2], i2[2], i3[2]);
NR4 nor2_4(w2[7], i4[3], i1[3], i2[3], i3[3]);
NR2 or2_1(result2[0], w2[0], w2[4]);
NR2 or2_2(result2[1], w2[1], w2[5]);
NR2 or2_3(result2[2], w2[2], w2[6]);
NR2 or2_4(result2[3], w2[3], w2[7]);
NR4 an2_5(result[1], result2[0], result2[1], result2[2], result2[3]);

AN4 an3_1(w3[0], i0[0], i4[0], i2[0], i3[0]);
AN4 an3_2(w3[1], i0[1], i4[1], i2[1], i3[1]);
AN4 an3_3(w3[2], i0[2], i4[2], i2[2], i3[2]);
AN4 an3_4(w3[3], i0[3], i4[3], i2[3], i3[3]);
NR4 nor3_1(w3[4], i0[0], i4[0], i2[0], i3[0]);
NR4 nor3_2(w3[5], i0[1], i4[1], i2[1], i3[1]);
NR4 nor3_3(w3[6], i0[2], i4[2], i2[2], i3[2]);
NR4 nor3_4(w3[7], i0[3], i4[3], i2[3], i3[3]);
NR2 or3_1(result3[0], w3[0], w3[4]);
NR2 or3_2(result3[1], w3[1], w3[5]);
NR2 or3_3(result3[2], w3[2], w3[6]);
NR2 or3_4(result3[3], w3[3], w3[7]);
NR4 an3_5(result[2], result3[0], result3[1], result3[2], result3[3]);

AN4 an4_1(w4[0], i0[0], i1[0], i4[0], i3[0]);
AN4 an4_2(w4[1], i0[1], i1[1], i4[1], i3[1]);
AN4 an4_3(w4[2], i0[2], i1[2], i4[2], i3[2]);
AN4 an4_4(w4[3], i0[3], i1[3], i4[3], i3[3]);
NR4 nor4_1(w4[4], i0[0], i1[0], i4[0], i3[0]);
NR4 nor4_2(w4[5], i0[1], i1[1], i4[1], i3[1]);
NR4 nor4_3(w4[6], i0[2], i1[2], i4[2], i3[2]);
NR4 nor4_4(w4[7], i0[3], i1[3], i4[3], i3[3]);
NR2 or4_1(result4[0], w4[0], w4[4]);
NR2 or4_2(result4[1], w4[1], w4[5]);
NR2 or4_3(result4[2], w4[2], w4[6]);
NR2 or4_4(result4[3], w4[3], w4[7]);
NR4 an4_5(result[3], result4[0], result4[1], result4[2], result4[3]);

AN4 an5_1(w5[0], i0[0], i1[0], i2[0], i4[0]);
AN4 an5_2(w5[1], i0[1], i1[1], i2[1], i4[1]);
AN4 an5_3(w5[2], i0[2], i1[2], i2[2], i4[2]);
AN4 an5_4(w5[3], i0[3], i1[3], i2[3], i4[3]);
NR4 nor5_1(w5[4], i0[0], i1[0], i2[0], i4[0]);
NR4 nor5_2(w5[5], i0[1], i1[1], i2[1], i4[1]);
NR4 nor5_3(w5[6], i0[2], i1[2], i2[2], i4[2]);
NR4 nor5_4(w5[7], i0[3], i1[3], i2[3], i4[3]);
NR2 or5_1(result5[0], w5[0], w5[4]);
NR2 or5_2(result5[1], w5[1], w5[5]);
NR2 or5_3(result5[2], w5[2], w5[6]);
NR2 or5_4(result5[3], w5[3], w5[7]);
NR4 an5_5(result[4], result5[0], result5[1], result5[2], result5[3]);

NR4 or6(result6, result[0], result[1], result[2], result[3]);
IV in1(result7, result[4]);
ND2 or7(out, result6, result7);
endmodule

module three_kind_detector (out, i0, i1, i2, i3, i4);

input [3:0] i0, i1, i2, i3, i4;
output out;
wire [7:0] w1, w2, w3, w4, w5, w6, w7, w8, w9, w10;
wire [3:0] result1, result2, result3, result4, result5, result6, result7, result8, result9, result10;
wire [9:0] result;
wire result11, result12, result13;

AN3 an1_1(w1[0], i0[0], i1[0], i2[0]);
AN3 an1_2(w1[1], i0[1], i1[1], i2[1]);
AN3 an1_3(w1[2], i0[2], i1[2], i2[2]);
AN3 an1_4(w1[3], i0[3], i1[3], i2[3]);
NR3 nor1_1(w1[4], i0[0], i1[0], i2[0]);
NR3 nor1_2(w1[5], i0[1], i1[1], i2[1]);
NR3 nor1_3(w1[6], i0[2], i1[2], i2[2]);
NR3 nor1_4(w1[7], i0[3], i1[3], i2[3]);
NR2 or1_1(result1[0], w1[0], w1[4]);
NR2 or1_2(result1[1], w1[1], w1[5]);
NR2 or1_3(result1[2], w1[2], w1[6]);
NR2 or1_4(result1[3], w1[3], w1[7]);
NR4 an1_5(result[0], result1[0], result1[1], result1[2], result1[3]);

AN3 an2_1(w2[0], i0[0], i1[0], i3[0]);
AN3 an2_2(w2[1], i0[1], i1[1], i3[1]);
AN3 an2_3(w2[2], i0[2], i1[2], i3[2]);
AN3 an2_4(w2[3], i0[3], i1[3], i3[3]);
NR3 nor2_1(w2[4], i0[0], i1[0], i3[0]);
NR3 nor2_2(w2[5], i0[1], i1[1], i3[1]);
NR3 nor2_3(w2[6], i0[2], i1[2], i3[2]);
NR3 nor2_4(w2[7], i0[3], i1[3], i3[3]);
NR2 or2_1(result2[0], w2[0], w2[4]);
NR2 or2_2(result2[1], w2[1], w2[5]);
NR2 or2_3(result2[2], w2[2], w2[6]);
NR2 or2_4(result2[3], w2[3], w2[7]);
NR4 an2_5(result[1], result2[0], result2[1], result2[2], result2[3]);

AN3 an3_1(w3[0], i0[0], i1[0], i4[0]);
AN3 an3_2(w3[1], i0[1], i1[1], i4[1]);
AN3 an3_3(w3[2], i0[2], i1[2], i4[2]);
AN3 an3_4(w3[3], i0[3], i1[3], i4[3]);
NR3 nor3_1(w3[4], i0[0], i1[0], i4[0]);
NR3 nor3_2(w3[5], i0[1], i1[1], i4[1]);
NR3 nor3_3(w3[6], i0[2], i1[2], i4[2]);
NR3 nor3_4(w3[7], i0[3], i1[3], i4[3]);
NR2 or3_1(result3[0], w3[0], w3[4]);
NR2 or3_2(result3[1], w3[1], w3[5]);
NR2 or3_3(result3[2], w3[2], w3[6]);
NR2 or3_4(result3[3], w3[3], w3[7]);
NR4 an3_5(result[2], result3[0], result3[1], result3[2], result3[3]);

AN3 an4_1(w4[0], i0[0], i3[0], i2[0]);
AN3 an4_2(w4[1], i0[1], i3[1], i2[1]);
AN3 an4_3(w4[2], i0[2], i3[2], i2[2]);
AN3 an4_4(w4[3], i0[3], i3[3], i2[3]);
NR3 nor4_1(w4[4], i0[0], i3[0], i2[0]);
NR3 nor4_2(w4[5], i0[1], i3[1], i2[1]);
NR3 nor4_3(w4[6], i0[2], i3[2], i2[2]);
NR3 nor4_4(w4[7], i0[3], i3[3], i2[3]);
NR2 or4_1(result4[0], w4[0], w4[4]);
NR2 or4_2(result4[1], w4[1], w4[5]);
NR2 or4_3(result4[2], w4[2], w4[6]);
NR2 or4_4(result4[3], w4[3], w4[7]);
NR4 an4_5(result[3], result4[0], result4[1], result4[2], result4[3]);

AN3 an5_1(w5[0], i0[0], i4[0], i2[0]);
AN3 an5_2(w5[1], i0[1], i4[1], i2[1]);
AN3 an5_3(w5[2], i0[2], i4[2], i2[2]);
AN3 an5_4(w5[3], i0[3], i4[3], i2[3]);
NR3 nor5_1(w5[4], i0[0], i4[0], i2[0]);
NR3 nor5_2(w5[5], i0[1], i4[1], i2[1]);
NR3 nor5_3(w5[6], i0[2], i4[2], i2[2]);
NR3 nor5_4(w5[7], i0[3], i4[3], i2[3]);
NR2 or5_1(result5[0], w5[0], w5[4]);
NR2 or5_2(result5[1], w5[1], w5[5]);
NR2 or5_3(result5[2], w5[2], w5[6]);
NR2 or5_4(result5[3], w5[3], w5[7]);
NR4 an5_5(result[4], result5[0], result5[1], result5[2], result5[3]);

AN3 an6_1(w6[0], i0[0], i3[0], i4[0]);
AN3 an6_2(w6[1], i0[1], i3[1], i4[1]);
AN3 an6_3(w6[2], i0[2], i3[2], i4[2]);
AN3 an6_4(w6[3], i0[3], i3[3], i4[3]);
NR3 nor6_1(w6[4], i0[0], i3[0], i4[0]);
NR3 nor6_2(w6[5], i0[1], i3[1], i4[1]);
NR3 nor6_3(w6[6], i0[2], i3[2], i4[2]);
NR3 nor6_4(w6[7], i0[3], i3[3], i4[3]);
NR2 or6_1(result6[0], w6[0], w6[4]);
NR2 or6_2(result6[1], w6[1], w6[5]);
NR2 or6_3(result6[2], w6[2], w6[6]);
NR2 or6_4(result6[3], w6[3], w6[7]);
NR4 an6_5(result[5], result6[0], result6[1], result6[2], result6[3]);

AN3 an7_1(w7[0], i3[0], i1[0], i2[0]);
AN3 an7_2(w7[1], i3[1], i1[1], i2[1]);
AN3 an7_3(w7[2], i3[2], i1[2], i2[2]);
AN3 an7_4(w7[3], i3[3], i1[3], i2[3]);
NR3 nor7_1(w7[4], i3[0], i1[0], i2[0]);
NR3 nor7_2(w7[5], i3[1], i1[1], i2[1]);
NR3 nor7_3(w7[6], i3[2], i1[2], i2[2]);
NR3 nor7_4(w7[7], i3[3], i1[3], i2[3]);
NR2 or7_1(result7[0], w7[0], w7[4]);
NR2 or7_2(result7[1], w7[1], w7[5]);
NR2 or7_3(result7[2], w7[2], w7[6]);
NR2 or7_4(result7[3], w7[3], w7[7]);
NR4 an7_5(result[6], result7[0], result7[1], result7[2], result7[3]);

AN3 an8_1(w8[0], i4[0], i1[0], i2[0]);
AN3 an8_2(w8[1], i4[1], i1[1], i2[1]);
AN3 an8_3(w8[2], i4[2], i1[2], i2[2]);
AN3 an8_4(w8[3], i4[3], i1[3], i2[3]);
NR3 nor8_1(w8[4], i4[0], i1[0], i2[0]);
NR3 nor8_2(w8[5], i4[1], i1[1], i2[1]);
NR3 nor8_3(w8[6], i4[2], i1[2], i2[2]);
NR3 nor8_4(w8[7], i4[3], i1[3], i2[3]);
NR2 or8_1(result8[0], w8[0], w8[4]);
NR2 or8_2(result8[1], w8[1], w8[5]);
NR2 or8_3(result8[2], w8[2], w8[6]);
NR2 or8_4(result8[3], w8[3], w8[7]);
NR4 an8_5(result[7], result8[0], result8[1], result8[2], result8[3]);

AN3 an9_1(w9[0], i4[0], i1[0], i3[0]);
AN3 an9_2(w9[1], i4[1], i1[1], i3[1]);
AN3 an9_3(w9[2], i4[2], i1[2], i3[2]);
AN3 an9_4(w9[3], i4[3], i1[3], i3[3]);
NR3 nor9_1(w9[4], i4[0], i1[0], i3[0]);
NR3 nor9_2(w9[5], i4[1], i1[1], i3[1]);
NR3 nor9_3(w9[6], i4[2], i1[2], i3[2]);
NR3 nor9_4(w9[7], i4[3], i1[3], i3[3]);
NR2 or9_1(result9[0], w9[0], w9[4]);
NR2 or9_2(result9[1], w9[1], w9[5]);
NR2 or9_3(result9[2], w9[2], w9[6]);
NR2 or9_4(result9[3], w9[3], w9[7]);
NR4 an9_5(result[8], result9[0], result9[1], result9[2], result9[3]);

AN3 an10_1(w10[0], i3[0], i4[0], i2[0]);
AN3 an10_2(w10[1], i3[1], i4[1], i2[1]);
AN3 an10_3(w10[2], i3[2], i4[2], i2[2]);
AN3 an10_4(w10[3], i3[3], i4[3], i2[3]);
NR3 nor10_1(w10[4], i3[0], i4[0], i2[0]);
NR3 nor10_2(w10[5], i3[1], i4[1], i2[1]);
NR3 nor10_3(w10[6], i3[2], i4[2], i2[2]);
NR3 nor10_4(w10[7], i3[3], i4[3], i2[3]);
NR2 or10_1(result10[0], w10[0], w10[4]);
NR2 or10_2(result10[1], w10[1], w10[5]);
NR2 or10_3(result10[2], w10[2], w10[6]);
NR2 or10_4(result10[3], w10[3], w10[7]);
NR4 an10_5(result[9], result10[0], result10[1], result10[2], result10[3]);

NR4 or6(result11, result[0], result[1], result[2], result[3]);
NR4 or7(result12, result[4], result[5], result[6], result[7]);
NR2 or8(result13, result[8], result[9]);
ND3 or9(out, result11, result12, result13);

endmodule

module pair(pair_out, one_pair, two_pair, three_kind, full_house, four_kind, i0, i1, i2, i3, i4);	//determine if the cards have pair

		input [3:0] i0, i1, i2, i3, i4;
		output pair_out, one_pair, two_pair, three_kind, full_house, four_kind;	// 1 means pair

		wire [4:0] out1, out2, out3, out4, out5, out6, out7, out8, out9, out10;
		wire out11, out12, out13, out14, out15, out16, out17, out18, out19, out20, out21, out22, out23, out24, out25, out26, out27, out28, out29, out30, out31;
		wire [4:0] four_kind_wire;
		wire [9:0] full_house_wire, three_kind_wire;
		wire [14:0] two_pair_output;
        wire threekind, twopair;

        same_value s1(out1[4], i0, i1);
        same_value s2(out2[4], i0, i2);
        same_value s3(out3[4], i0, i3);
        same_value s4(out4[4], i0, i4);
        same_value s5(out5[4], i1, i2);
        same_value s6(out6[4], i1, i3);
        same_value s7(out7[4], i1, i4);
        same_value s8(out8[4], i2, i3);
        same_value s9(out9[4], i2, i4);
        same_value s10(out10[4], i3, i4);

		NR4 or1(out11, out1[4], out2[4], out3[4], out4[4]);
		NR4 or2(out12, out5[4], out6[4], out7[4], out8[4]);
        NR2 or4(out13, out9[4], out10[4]);
		ND3 or3(pair_out, out11, out12, out13);

		//determine four_kind
        four_kind_detector four1(four_kind, i0, i1, i2, i3, i4);
        three_kind_detector three1(threekind, i0, i1, i2, i3, i4);
        
		ND3 four_kind_an1(four_kind_wire[0], out1[4], out5[4], out8[4]);
		ND3 four_kind_an2(four_kind_wire[1], out5[4], out8[4], out10[4]);
		ND3 four_kind_an3(four_kind_wire[2], out1[4], out5[4], out9[4]);
		ND3 four_kind_an4(four_kind_wire[3], out2[4], out10[4], out8[4]);
		ND3 four_kind_an5(four_kind_wire[4], out1[4], out6[4], out10[4]);
		ND3 four_kind_or(out30, four_kind_wire[0], four_kind_wire[1], four_kind_wire[2]);
        ND2 four_kind_or3(out31, four_kind_wire[3], four_kind_wire[4]);
		OR2 four_kind_or2(four_kind, out30, out31);

        AN2 three_kind_an11(three_kind_wire[0], out1[4], out5[4]);
		AN2 three_kind_an12(three_kind_wire[1], out5[4], out8[4]);
		AN2 three_kind_an13(three_kind_wire[2], out8[4], out10[4]);
		AN2 three_kind_an14(three_kind_wire[3], out1[4], out6[4]);
		AN2 three_kind_an15(three_kind_wire[4], out1[4], out7[4]);
		AN2 three_kind_an16(three_kind_wire[5], out2[4], out8[4]);
		AN2 three_kind_an17(three_kind_wire[6], out2[4], out9[4]);
		AN2 three_kind_an18(three_kind_wire[7], out3[4], out10[4]);
		AN2 three_kind_an19(three_kind_wire[8], out6[4], out10[4]);
		AN2 three_kind_an20(three_kind_wire[9], out5[4], out9[4]);

        NR4 three_kind_or1(out17, three_kind_wire[0], three_kind_wire[1], three_kind_wire[2], three_kind_wire[3]);
		NR4 three_kind_or2(out18, three_kind_wire[4], three_kind_wire[5], three_kind_wire[6], three_kind_wire[7]);
        NR2 three_kind_or4(out19, three_kind_wire[8], three_kind_wire[9]);
        ND3 three_kind_or3(threekind, out17, out18, out19);

        AN2 two_pair_an1(two_pair_output[0], out5[4], out10[4]);
		AN2 two_pair_an2(two_pair_output[1], out6[4], out9[4]);
		AN2 two_pair_an3(two_pair_output[2], out7[4], out8[4]);
		AN2 two_pair_an4(two_pair_output[3], out4[4], out8[4]);
		AN2 two_pair_an5(two_pair_output[4], out3[4], out9[4]);
		AN2 two_pair_an6(two_pair_output[5], out2[4], out10[4]);
		AN2 two_pair_an7(two_pair_output[6], out1[4], out10[4]);
		AN2 two_pair_an8(two_pair_output[7], out4[4], out6[4]);
		AN2 two_pair_an9(two_pair_output[8], out3[4], out7[4]);
		AN2 two_pair_an10(two_pair_output[9], out5[4], out4[4]);
		AN2 two_pair_an11(two_pair_output[10], out2[4], out7[4]);
		AN2 two_pair_an12(two_pair_output[11], out9[4], out1[4]);
		AN2 two_pair_an13(two_pair_output[12], out3[4], out5[4]);
		AN2 two_pair_an14(two_pair_output[13], out6[4], out2[4]);
		AN2 two_pair_an15(two_pair_output[14], out8[4], out1[4]);

		NR4 two_pair_or1(out23, two_pair_output[0], two_pair_output[1], two_pair_output[2], two_pair_output[3]);
		NR4 two_pair_or2(out24, two_pair_output[4], two_pair_output[5], two_pair_output[6], two_pair_output[7]);
		NR4 two_pair_or3(out25, two_pair_output[8], two_pair_output[9], two_pair_output[10], two_pair_output[11]);
		NR3 two_pair_or4(out26, two_pair_output[12], two_pair_output[13], two_pair_output[14]);
		ND4 two_pair_or5(twopair, out23, out24, out25, out26);

        IV iv1(out14, pair_out);
        NR3 nr1(one_pair, threekind, twopair, out14);
        IV in2(out15, twopair);
        NR3 nr2(two_pair, threekind, out15, four_kind);
        IV iv3(out16, threekind);
        NR2 nr3(three_kind, out16, twopair);
        NR3 nr4(full_house, out15, out16, four_kind);


	endmodule