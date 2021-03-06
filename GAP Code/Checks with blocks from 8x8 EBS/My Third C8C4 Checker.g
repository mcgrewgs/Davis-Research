# Read("C:/Users/Gavin/Documents/GitHub/Davis-Research/GAP Code/Checks with blocks from 8x8 EBS/My Third C8C4 Checker.g");
# C16 x C16 is group 39
LoadPackage("rds");

thisBetterNotBeEmpty:=[];

haveDS := [];

haveZ8Z4 := [ 367, 368, 380, 381, 6642, 6647, 6648, 6711 ];

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
            if (StructureDescription(jjj)="C8 x C4") then
                H:=jjj;
            fi;
        fi;
       
        if not H = 0 then
            currentPerm:=[1,  2,  3,  4,  5,  6,  7,  8];
            x:=0;
            y:=0;
            for i in Elements(H) do

                if Order(i)=8 then

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
                r5:=cosets[5][1];
                r6:=cosets[6][1];
                r7:=cosets[7][1];
                r8:=cosets[8][1];

                cosetReps:=[r1,  r2,  r3,  r4,  r5,  r6,  r7,  r8];

                Append(b1,Elements(RightCoset(Subgroup(H,[x^2,y^2]),x)));

                Append(b2,Elements(RightCoset(Subgroup(H,[x]),x^0)));
                Append(b2,Elements(RightCoset(Subgroup(H,[x]),y^4)));
                Append(b2,Elements(RightCoset(Subgroup(H,[x^2,y^4]),y)));
                Append(b2,Elements(RightCoset(Subgroup(H,[x^2,y^4]),x*y^3)));

                Append(b3,Elements(RightCoset(Subgroup(H,[y]),x^0)));
                Append(b3,Elements(RightCoset(Subgroup(H,[x^2*y]),x)));

                Append(b4,Elements(RightCoset(Subgroup(H,[x*y]),x^0)));
                Append(b4,Elements(RightCoset(Subgroup(H,[x^3*y]),x)));

                Append(b5,Elements(RightCoset(Subgroup(H,[x]),x^0)));
                Append(b5,Elements(RightCoset(Subgroup(H,[x]),y^2)));
                Append(b5,Elements(RightCoset(Subgroup(H,[x*y^4]),y)));
                Append(b5,Elements(RightCoset(Subgroup(H,[x*y^4]),y^3)));

                Append(b6,Elements(RightCoset(Subgroup(H,[x]),x^0)));
                Append(b6,Elements(RightCoset(Subgroup(H,[x]),y^6)));
                Append(b6,Elements(RightCoset(Subgroup(H,[x*y^4]),y)));
                Append(b6,Elements(RightCoset(Subgroup(H,[x*y^4]),y^3)));

                Append(b7,Elements(RightCoset(Subgroup(H,[x*y^2]),x^0)));
                Append(b7,Elements(RightCoset(Subgroup(H,[x*y^2]),y^2)));
                Append(b7,Elements(RightCoset(Subgroup(H,[x*y^6]),y)));
                Append(b7,Elements(RightCoset(Subgroup(H,[x*y^6]),y^3)));

                Append(b8,Elements(RightCoset(Subgroup(H,[x*y^2]),y)));
                Append(b8,Elements(RightCoset(Subgroup(H,[x*y^2]),x*y)));
                Append(b8,Elements(RightCoset(Subgroup(H,[x*y^6]),y^2)));
                Append(b8,Elements(RightCoset(Subgroup(H,[x*y^6]),y^4)));

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