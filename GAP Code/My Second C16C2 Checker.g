# Read("C:/Users/Gavin/Desktop/GAP Code/My Second C16C2 Checker.g");
LoadPackage("rds");

thisBetterNotBeEmpty:=[];

haveDS:=[ 369, 370, 372, 375, 376, 379, 433, 435, 437, 439, 442, 450, 452, 509, 522, 5331, 5422, 5423, 6631, 6639, 6641, 6676, 6678, 6696, 6712, 6714, 6715, 6718, 6721 ];

haveZ16Z2:=[323, 351, 353, 367, 368, 369, 370, 372, 373, 374, 375, 376, 379, 380, 381, 408, 409, 433, 434, 435, 436, 437, 439, 440, 442, 449, 450, 452, 501, 532, 536, 5421, 5422, 5423, 5427, 5430, 6620, 6629, 6631, 6639, 6641, 6642, 6647, 6648, 6674, 6676, 6678, 6693, 6696, 6700, 6701, 6704, 6709, 6711, 6712, 6714, 6715, 6716, 6717, 6718, 6720, 6721];

checkAll := [];

for i in haveZ16Z2 do
    if not i in haveDS then
        Add(checkAll,i);
    fi;
od;

haveDS := [];

check := [];

numThreads := 1;
threadId := 1;
while 1=1 do
    Add(check,checkAll[threadId]);
    threadId:=threadId+numThreads;
    if threadId > Length(checkAll) then
        break;
    fi;
od;

Print("Checking ", Length(check), " groups for a DS with C16 x C2. \n");

maxPerms := 5038; #no more than 5038
for di in check do
    Print("Checking group ",di, "\n");
    dsfound:=false;

    G:=SmallGroup(256,di);
    NS:=NormalSubgroups(G);
    H:=0;
    for jjj in NS do
        H:=0;
        if (Size(jjj)=32) then
            if (StructureDescription(jjj)="C16 x C2") then
                H:=jjj;
            fi;
        fi;
       
        if not H = 0 then
            currentPerm:=[1,  2,  3,  4,  5,  6,  7,  8];
            x:=0;
            y:=0;
            for i in Elements(H) do

                if Order(i)=16 then

                    for j in Elements(H) do 

                        if Order(j)=2 then

                            if(GroupWithGenerators([i,j]) = H) then
                                x:=i;
                                y:=j;
                            fi;
                        fi;
                    od;
                fi;
            od;

            if ( ( not ( x = 0 ) ) and ( not ( y = 0 ) ) ) then
                cosets:=CosetDecomposition(G,H);

                r1:=cosets[1][1];
                r2:=cosets[2][1];
                r3:=cosets[3][1];
                r4:=cosets[4][1];
                r5:=cosets[5][1];
                r6:=cosets[6][1];
                r7:=cosets[7][1];
                r8:=cosets[8][1];

                cosetReps:=[r1,  r2,  r3,  r4,  r5,  r6,  r7,  r8];

                bb1:=[ [ 0, 0 ], [ 6, 1 ], [ 12, 0 ], [ 8, 0 ], [ 2, 1 ], [ 15, 0 ], [ 14, 0 ], [ 5, 1 ], [ 7, 0 ], [ 10, 0 ], [ 12, 1 ], [ 1, 1 ], [ 3, 1 ], [ 5, 0 ], [ 11, 1 ], [ 1, 0 ] ];

                bb2:=[ [ 0, 0 ], [ 6, 1 ], [ 12, 0 ], [ 8, 0 ], [ 15, 0 ], [ 2, 1 ], [ 8, 1 ], [ 4, 0 ], [ 11, 0 ], [ 7, 0 ], [ 14, 0 ], [ 4, 1 ], [ 0, 1 ], [ 11, 1 ], [ 10, 0 ], [ 12, 1 ] ];

                bb3:=[ [ 0, 0 ], [ 6, 1 ], [ 12, 0 ], [ 8, 0 ], [ 7, 1 ], [ 2, 1 ], [ 13, 0 ], [ 3, 1 ], [ 15, 1 ], [ 14, 0 ], [ 9, 0 ], [ 13, 1 ], [ 11, 1 ], [ 10, 0 ], [ 12, 1 ], [ 9, 1 ] ];

                bb4:=[ [ 0, 0 ], [ 12, 0 ], [ 8, 0 ], [ 6, 0 ], [ 14, 1 ], [ 12, 1 ], [ 7, 1 ], [ 2, 0 ], [ 10, 1 ], [ 13, 0 ], [ 15, 1 ], [ 11, 0 ], [ 9, 0 ], [ 13, 1 ], [ 3, 0 ], [ 9, 1 ] ];

                bb5:=[ [ 7, 1 ], [ 13, 0 ], [ 3, 1 ], [ 15, 1 ], [ 0, 0 ], [ 5, 0 ], [ 6, 1 ], [ 8, 0 ], [ 5, 1 ], [ 8, 1 ], [ 13, 1 ], [ 3, 0 ], [ 14, 0 ], [ 10, 1 ], [ 0, 1 ], [ 2, 0 ] ];

                bb6:=[ [ 14, 0 ], [ 6, 1 ], [ 15, 0 ], [ 11, 1 ], [ 10, 0 ], [ 2, 1 ], [ 11, 0 ], [ 7, 0 ] ];

                bb7:=[ [ 15, 0 ], [ 0, 0 ], [ 5, 1 ], [ 11, 0 ], [ 7, 0 ], [ 12, 0 ], [ 8, 0 ], [ 1, 1 ], [ 3, 0 ], [ 6, 0 ], [ 14, 1 ], [ 12, 1 ], [ 2, 0 ], [ 10, 1 ], [ 5, 0 ], [ 1, 0 ] ];

                bb8:=[ [ 7, 1 ], [ 5, 1 ], [ 13, 0 ], [ 3, 1 ], [ 15, 1 ], [ 13, 1 ], [ 5, 0 ], [ 3, 0 ], [ 14, 0 ], [ 6, 1 ], [ 4, 1 ], [ 12, 0 ], [ 12, 1 ], [ 4, 0 ], [ 2, 0 ], [ 10, 1 ] ];


                b1:=[];
                b2:=[];
                b3:=[];
                b4:=[];
                b5:=[];
                b6:=[];
                b7:=[];
                b8:=[];

                for i in bb1 do
                    Add(b1,x^i[1]*y^i[2]);
                od;
                for i in bb2 do
                    Add(b2,x^i[1]*y^i[2]);
                od;
                for i in bb3 do
                    Add(b3,x^i[1]*y^i[2]);
                od;
                for i in bb4 do
                    Add(b4,x^i[1]*y^i[2]);
                od;
                for i in bb5 do
                    Add(b5,x^i[1]*y^i[2]);
                od;
                for i in bb6 do
                    Add(b6,x^i[1]*y^i[2]);
                od;
                for i in bb7 do
                    Add(b7,x^i[1]*y^i[2]);
                od;
                for i in bb8 do
                    Add(b8,x^i[1]*y^i[2]);
                od;

                legos:=[b1,b2,b3,b4,b5,b6,b7,b8];

                count := 0;
                while dsfound=false do
                    diffset := [];

                    for jj in [1..Length(legos)] do
                        for kk in legos[jj] do
                            Add(diffset,  cosetReps[currentPerm[jj]]*kk);
                        od;
                    od;

                    ds:=[];
                    for ii in [2..Length(diffset)] do
                        x:=diffset[ii]*(diffset[1]^(-1));
                        if not(x = Elements(G)[1]) then
                            Add(ds,  x);
                        fi;
                    od;

                    if Length(ds) = 119 then
                        if IsDiffset( ds,  G,  56 ) then
                            dsfound := true;
                            Print("\n \n \n \n");
                            Print( diffset,  "\n" );
                            Print("Found one! \n");
                            Add(thisBetterNotBeEmpty,[di,diffset]);
                            Add(haveDS,di);
                        fi;
                    fi;

                    if count>maxPerms then
                        dsfound:=true;
                        Print("No difference sets found.\n");
                    fi;

                    if dsfound=false then
                        count:=count+1;

                        a:= 9;
                        b:= a-2;
                        while currentPerm[b]>currentPerm[b+1] do
                            b:=b-1;
                        od;

                        c:= a-1;
                        while currentPerm[b]>currentPerm[c] do
                            c:=c-1;
                        od;

                        temp:= currentPerm[b];
                        currentPerm[b]:=currentPerm[c];
                        currentPerm[c]:=temp;

                        d:= a-1;
                        e:= b+1;

                        while d>e do
                            temp:= currentPerm[d];
                            currentPerm[d]:=currentPerm[e];
                            currentPerm[e]:=temp;
                            d:=d-1;
                            e:=e+1;
                        od;
                    fi;
                    if (count mod 100 = 0) then
                    Print(count,  " iterations done. \n");
                    fi;
                od;
            fi;
            if di in haveDS then
                break;
            fi;
        fi;
    od;
od;

Print(haveDS,"\n");
Print(Length(haveDS),"\n");