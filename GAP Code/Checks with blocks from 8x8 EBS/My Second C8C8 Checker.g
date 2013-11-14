# Read("C:/Users/Gavin/Desktop/GAP Code/My Second C8C8 Checker.g");

ex:=E(8);
et:=[];
for i in [1..8] do
    Append( et, [ex^i] );
od;

G:=[];

for x in et do
    for y in et do 
        D1 := [x , x^2 , x^3 , x^5 , x^6 , x^7 , x *y , x^5 *y , x^2 *y^2 , x^6 *y^2 , x^3 *y^3 , x^7 *y^3 , x *y^4 , x^2 *y^4 , x^3 *y^4 , x^5 *y^4 , x^6 *y^4 , x^7 *y^4 , x *y^5 , x^5 *y^5 , x^2 *y^6 , x^6 *y^6 , x^3 *y^7 , x^7 *y^7];
        D2 := [x^0 , x , x^2 , x^3 , y , x *y , x^3 *y , x^6 *y , y^2 , x^2 *y^2 , x^5 *y^2 , x^7 *y^2 , y^3 , x^5 *y^3 , x^6 *y^3 , x^7 *y^3 , y^4 , x *y^4 , x^2 *y^4 , x^3 *y^4 , y^5 , x *y^5 , x^3 *y^5 , x^6 *y^5 , y^6 , x^2 *y^6 , x^5 *y^6 , x^7 *y^6 , y^7 , x^5 *y^7 , x^6 *y^7 , x^7 *y^7];
        D3 := [x^0 , x , x^2 , x^3 , x^4 , x^5 , x^6 , x^7 , y , x *y , x^4 *y , x^5 *y , y^2 , x^2 *y^2 , x^4 *y^2 , x^6 *y^2 , y^3 , x *y^3 , x^4 *y^3 , x^5 *y^3 , x^2 *y^5 , x^3 *y^5 , x^6 *y^5 , x^7 *y^5 , x *y^6 , x^3 *y^6 , x^5 *y^6 , x^7 *y^6 , x^2 *y^7 ,x^3 *y^7 , x^6 *y^7 , x^7 *y^7];
        D4 := [x^0 , y , x *y , y^2 , x *y^2 , x^2 *y^2 , y^3 , x^3 *y^3 , x *y^4 , x^2 *y^4 , x^4 *y^4 , x^4 *y^5 , x^5 *y^5 , x^4 *y^6 , x^5 *y^6 , x^6 *y^6 , x *y^7 , x^2 *y^7 ,x^4 *y^7 , x^7 *y^7 , x^3 *y^8 , x^5 *y^8 , x^6 *y^8 , x^2 *y^9 , x^3 *y^9 , x^3 *y^10 , x^5 *y^11 , x^6 *y^11 , x^7 *y^12 , x^6 *y^13 , x^7 *y^13 , x^7 *y^14 ];
        s1:=0;
        s2:=0;
        s3:=0;
        s4:=0;
        for i in D1 do
            s1 := s1 + i;
        od;
        for i in D2 do
            s2 := s2 + i;
        od;
        for i in D3 do
            s3 := s3 + i;
        od;
        for i in D4 do
            s4 := s4 + i;
        od;
        Print([s1,s2,s3,s4],"\n");
    od;
od;