# Find a difference set in groups with subgroups isomorphic to z4 x z4 x z2
# Read ("C:/Users/Gavin/Desktop/a.g");

LoadPackage("rds");

currentPerm:=[1, 2, 3, 4, 5, 6, 7, 8];
dsfound:=false;
G:=SmallGroup(256, 98);
NS:=NormalSubgroups(G);
madesubgroup := false;
numsubgroupstried := 0;
numgeneratorcombostried := 0;

for l in NS do
    if (madesubgroup = true) then break; fi;

    if StructureDescription(l)="C4 x C4 x C2" then
        N:=l;
        numsubgroupstried := numsubgroupstried + 1;
        numgeneratorcombostried := 0;

        EN := Elements(N);

        for i in EN do
            if (madesubgroup = true) then break; fi;

            if Order(i)=4 then


                for j in EN do
                    if (madesubgroup = true) then break; fi;

                    if j > i then continue; fi;


                    if Order(j)=4 then

                        for k in EN do
                            if (madesubgroup = true) then break; fi;

                            if k > j then continue; fi;

                            if Order(k) = 2 then
                                if (madesubgroup = true) then break; fi;

                                c1c2c3:=Subgroup(N, [i, j, k]);
                                if c1c2c3 = N then
                                    numgeneratorcombostried := numgeneratorcombostried + 1;
                                    x := i;
                                    y := j;
                                    z := k;

                                    cosets:=CosetDecomposition(G,N);

                                    r1:=cosets[1][1];
                                    r2:=cosets[2][1];
                                    r3:=cosets[3][1];
                                    r4:=cosets[4][1];
                                    r5:=cosets[5][1];
                                    r6:=cosets[6][1];
                                    r7:=cosets[7][1];
                                    r8:=cosets[8][1];

                                    cosetReps:=[r1,r2,r3,r4,r5,r6,r7,r8];

                                    d1:=[];
                                    Append(d1, Elements(Subgroup(G, [x^2, y])));
                                    Append(d1, Elements(RightCoset(Subgroup(G, [x^2*z, y]),x)));

                                    d2:= [];
                                    Append(d2, Elements(Subgroup(G, [x^2, y*z])));
                                    Append(d2, Elements(RightCoset(Subgroup(G, [x^2*z, y*z]),x)));

                                    d3:=[];
                                    Append(d3, Elements(Subgroup(G, [x, y^2*z])));
                                    Append(d3, Elements(RightCoset(Subgroup(G, [x*y^2, y^2*z]),y)));

                                    d4:=[];
                                    Append(d4, Elements(Subgroup(G, [x*y, y^2*z])));
                                    Append(d4, Elements(RightCoset(Subgroup(G, [x*y^3, y^2*z]),y)));

                                    d5:= [];
                                    Append(d5, Elements(Subgroup(G, [x, z])));
                                    Append(d5, Elements(RightCoset(Subgroup(G, [x*y^2, z]),y)));

                                    d6:=[];
                                    Append(d6, Elements(Subgroup(G, [x^2, y^2,z])));

                                    d7:=[];
                                    Append(d7, Elements(Subgroup(G, [y, z])));
                                    Append(d7, Elements(RightCoset(Subgroup(G, [x^2*y, z]),x)));

                                    d8:=[];
                                    Append(d8, Elements(Subgroup(G, [x*y,z])));
                                    Append(d8, Elements(RightCoset(Subgroup(G, [x^3*y, z]),x)));

                                    clumps := [d1, d2, d3, d4, d5, d6, d7, d8];

                                    count := 0;
                                    while (dsfound = false) do
                                        diffset := [];

                                        for jj in [1..Length(clumps)] do
                                            for kk in clumps[jj] do
                                                Add(diffset, cosetReps[currentPerm[jj]] * kk);
                                            od;
                                        od;

                                        ds:=[];
                                        for ii in [2..Length(diffset)] do
                                            x:=diffset[ii]*(diffset[1]^(-1));
                                            if not(x = Elements(G)[1]) then
                                                Add(ds, x);
                                            fi;
                                        od;

                                        if Length(ds) = 119 then
                                            if IsDiffset( ds, G, 56 ) then
                                                dsfound := true;
                                                madesubgroup := true;
                                                Print("Found one! \n");
                                                Print( diffset, "\n" );
                                                if (count=0) then
                                                    Print("1 permutation of coset reps tried.\n");
                                                else
                                                    Print(count+1, " permutations of coset reps tried.\n");
                                                fi;
                                            fi;
                                        fi;

                                        if ( count > 40318 ) then
                                            dsfound:=true;
                                            Print("No difference sets found.");
                                        fi;

                                        if ( dsfound = false ) then
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
                                            if (count=1) then
                                                Print("1 permutation of coset reps tried.\n");
                                            else
                                                Print(count, " permutations of coset reps tried.\n");
                                            fi;
                                        fi;
                                    od;
                                    if (numgeneratorcombostried = 1) then
                                        Print( "1 combination of generators tried.\n");
                                    else
                                        Print( numgeneratorcombostried, " combinations of generators tried.\n" );
                                    fi;
                                fi;
                            fi;
                        od; 
                    fi;
                od;
            fi;
        od;
        if (numsubgroupstried = 1) then
            Print( "1 subgroup tried.\n");
        else
            Print( numsubgroupstried, " subgroups tried.\n" );
        fi;
    fi;
od;