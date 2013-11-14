# Read("C:/Users/Gavin/Desktop/GAP Code/Checks with blocks from 16x16/My C16C4 Checker.g");
LoadPackage("rds");

thisBetterNotBeEmpty:=[];

haveDS:=[];

haveZ16Z4:=[ 367, 368, 373, 374, 380, 381, 434, 436, 440, 449, 532, 5421, 5427, 5430, 6629, 6642, 6647, 6648, 6674, 6693, 6709, 6711, 6716, 6717, 6720 ];

checkAll := [];

for i in haveZ16Z4 do
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

Print("Checking ", Length(check), " groups for a DS with C16 x C4. \n");

maxPerms := 4; #no more than 4
for di in check do
    Print("Checking group ",di, "\n");
    dsfound:=false;

    G:=SmallGroup(256,di);
    NS:=NormalSubgroups(G);
    H:=0;
    for jjj in NS do
        H:=0;
        if (Size(jjj)=64) then
            if (StructureDescription(jjj)="C16 x C4") then
                H:=jjj;
            fi;
        fi;
       
        if not H = 0 then
            currentPerm:=[1,  2,  3,  4];
            x:=0;
            y:=0;
            for i in Elements(H) do

                if Order(i)=16 then

                    for j in Elements(H) do 

                        if Order(j)=4 then

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

                b1:=[x*y^2,x*y^3,x^2*y,x^2*y^3,x^3*y,x^3*y^2,x^5*y^2,x^5*y^3,x^6*y,x^6*y^3,x^7*y,x^7*y^2,x^9*y^2,x^9*y^3,x^10*y,x^10*y^3,x^11*y,x^11*y^2,x^13*y^2,x^13*y^3,x^14*y,x^14*y^3,x^15*y,x^15*y^2];
                b2:=[x*y^2,x*y^3,x^2*y,x^2*y^3,x^3,x^3*y^3,x^5,x^5*y^3,x^6*y,x^6*y^3,x^7*y^2,x^7*y^3,x^8,x^8*y,x^8*y^2,x^8*y^3,x^9,x^9*y,x^10,x^10*y^2,x^11*y,x^11*y^2,x^12,x^12*y,x^12*y^2,x^12*y^3,x^13*y,x^13*y^2,x^14,x^14*y^2,x^15,x^15*y];
                b3:=[x*y^2,x*y^3,x^2*y,x^2*y^3,x^3*y^2,x^3*y^3,x^4,x^4*y,x^4*y^2,x^4*y^3,x^5,x^5*y,x^6,x^6*y^2,x^7,x^7*y,x^9*y^2,x^9*y^3,x^10*y,x^10*y^3,x^11*y^2,x^11*y^3,x^12,x^12*y,x^12*y^2,x^12*y^3,x^13,x^13*y,x^14,x^14*y^2,x^15,x^15*y];
                b4:=[x*y^2,x*y^3,x^2*y,x^2*y^3,x^3*y,x^3*y^2,x^4,x^4*y,x^4*y^2,x^4*y^3,x^5*y,x^5*y^2,x^6*y,x^6*y^3,x^7*y^2,x^7*y^3,x^8,x^8*y,x^8*y^2,x^8*y^3,x^9,x^9*y,x^10,x^10*y^2,x^11,x^11*y^3,x^13,x^13*y^3,x^14,x^14*y^2,x^15,x^15*y];

                legos:=[b1,b2,b3,b4];

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