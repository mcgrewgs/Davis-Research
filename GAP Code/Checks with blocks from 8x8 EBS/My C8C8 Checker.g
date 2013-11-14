# Read("C:/Users/Gavin/Desktop/GAP Code/My C8C8 Checker.g");
# C16 x C16 is group 39
LoadPackage("rds");

thisBetterNotBeEmpty:=[];

haveDS := [];

haveZ8Z4 := [ 367, 368, 373, 374, 380, 381, 434, 440, 449, 532, 5421, 5427, 5430, 6629, 6642, 6647, 6648, 6674, 6693, 6709, 6711, 6716, 6717, 6720 ];

haveZ8Z4 := [ 39 ];

checkAll:=[];

for i in haveZ8Z4 do
    if not ( i in haveDS ) then
        Add(checkAll,i);
    fi;
od;

Print(checkAll,"\n\n");

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

Print("Checking ", Length(check), " groups for a DS with C8 x C4. \n");

maxPerms := 6; #no more than 6
for di in check do
    Print("Checking group ",di, "\n");
    dsfound:=false;

    G:=SmallGroup(256,di);
    NS:=NormalSubgroups(G);
    H:=0;
    for jjj in NS do
        H:=0;
        if (Size(jjj)=64) then
            if (StructureDescription(jjj)="C8 x C8") then
                H:=jjj;
            fi;
        fi;
       
        if not H = 0 then
            currentPerm:=[1,  2,  3,  4];
            x:=0;
            y:=0;
            for i in Elements(H) do

                if Order(i)=8 then

                    for j in Elements(H) do 

                        if Order(j)=8 then

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

                cosetReps:=[r1,  r2,  r3,  r4];

                D1 := [x , x^2 , x^3 , x^5 , x^6 , x^7 , x *y , x^5 *y , x^2 *y^2 , x^6 *y^2 , x^3 *y^3 , x^7 *y^3 , x *y^4 , x^2 *y^4 , x^3 *y^4 , x^5 *y^4 , x^6 *y^4 , x^7 *y^4 , x *y^5 , x^5 *y^5 , x^2 *y^6 , x^6 *y^6 , x^3 *y^7 , x^7 *y^7];
                D2 := [x^0 , x , x^2 , x^3 , y , x *y , x^3 *y , x^6 *y , y^2 , x^2 *y^2 , x^5 *y^2 , x^7 *y^2 , y^3 , x^5 *y^3 , x^6 *y^3 , x^7 *y^3 , y^4 , x *y^4 , x^2 *y^4 , x^3 *y^4 , y^5 , x *y^5 , x^3 *y^5 , x^6 *y^5 , y^6 , x^2 *y^6 , x^5 *y^6 , x^7 *y^6 , y^7 , x^5 *y^7 , x^6 *y^7 , x^7 *y^7];
                D3 := [x^0 , x , x^2 , x^3 , x^4 , x^5 , x^6 , x^7 , y , x *y , x^4 *y , x^5 *y , y^2 , x^2 *y^2 , x^4 *y^2 , x^6 *y^2 , y^3 , x *y^3 , x^4 *y^3 , x^5 *y^3 , x^2 *y^5 , x^3 *y^5 , x^6 *y^5 , x^7 *y^5 , x *y^6 , x^3 *y^6 , x^5 *y^6 , x^7 *y^6 , x^2 *y^7 ,x^3 *y^7 , x^6 *y^7 , x^7 *y^7];
                D4 := [x^0 , y , x *y , y^2 , x *y^2 , x^2 *y^2 , y^3 , x^3 *y^3 , x *y^4 , x^2 *y^4 , x^4 *y^4 , x^4 *y^5 , x^5 *y^5 , x^4 *y^6 , x^5 *y^6 , x^6 *y^6 , x *y^7 , x^2 *y^7 ,x^4 *y^7 , x^7 *y^7 , x^3 *y^8 , x^5 *y^8 , x^6 *y^8 , x^2 *y^9 , x^3 *y^9 , x^3 *y^10 , x^5 *y^11 , x^6 *y^11 , x^7 *y^12 , x^6 *y^13 , x^7 *y^13 , x^7 *y^14 ];

                legos:=[D1,D2,D3,D4];

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

                        a:= 5;
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