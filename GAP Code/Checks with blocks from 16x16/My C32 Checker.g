# Read("C:/Users/Gavin/Desktop/GAP Code/My C32 Checker.g");
LoadPackage("rds");

thisBetterNotBeEmpty:=[];

haveDS:=[];

haveZ32:=[ 449, 501, 532, 536, 6620, 6642, 6647, 6648, 6716, 6717, 6720 ];

checkAll := [];

for i in haveZ32 do
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

Print("Checking ", Length(check), " groups for a DS with C32. \n");

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
            if (StructureDescription(jjj)="C32") then
                H:=jjj;
            fi;
        fi;
       
        if not H = 0 then
            currentPerm:=[1,  2,  3,  4,  5,  6,  7,  8];
            x:=0;
            for i in Elements(H) do

                if Order(i)=32 then

                    if(GroupWithGenerators([i]) = H) then
                        x:=i;
                    fi;
                fi;
            od;

            if not ( x = 0 ) then
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

                b1:=[x^7,x^11,x^17,x^19,x^21,x^25,x^29,x^31];
                b2:=[x^8,x^9,x^10,x^12,x^14,x^17,x^19,x^21,x^23,x^24,x^26,x^27,x^28,x^29,x^30,x^31];
                b3:=[x^4,x^5,x^6,x^12,x^13,x^14,x^17,x^19,x^20,x^22,x^23,x^25,x^27,x^28,x^30,x^31];
                b4:=[x^4,x^5,x^7,x^8,x^9,x^10,x^11,x^13,x^14,x^17,x^19,x^20,x^24,x^26,x^30,x^31];
                b5:=[x^2,x^3,x^6,x^10,x^14,x^15,x^17,x^18,x^21,x^22,x^23,x^25,x^26,x^27,x^29,x^30];
                b6:=[x^2,x^3,x^6,x^7,x^8,x^9,x^11,x^12,x^15,x^17,x^18,x^21,x^22,x^24,x^28,x^29];
                b7:=[x^2,x^3,x^4,x^5,x^7,x^10,x^11,x^12,x^13,x^15,x^17,x^18,x^20,x^25,x^26,x^28];
                b8:=[x^2,x^3,x^4,x^5,x^6,x^8,x^9,x^13,x^15,x^17,x^18,x^20,x^22,x^23,x^24,x^27];

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