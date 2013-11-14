# Read("C:/Users/Gavin/Desktop/GAP Code/GroupId.g");
# Group 336
# f:= FreeGroup("x","y","z","w"); 
# x:=f.1;
# y:=f.2;
# z:=f.3;
# w:=f.4;
# rels:= [x^4,y^4,z^2,w^8,w*x*w^-1*(x*y)^-1,w*y*w^-1*(x^2*y*z)^-1,w*z*w^-1*(x^2*z)^-1,x*y*(y*x)^-1,x*z*(z*x)^-1,y*z*(z*y)^-1]; 
# g1:= f/rels;

# Print(StructureDescription(g1),"\n");
# Print(IdSmallGroup(g1),"\n");

# Read("C:/Users/Gavin/Desktop/GAP Code/My C8C2C2 Checker.g");
LoadPackage("rds");

crr:=[];

thisBetterNotBeEmpty:=[];

haveDS:=[];

haveZ8Z2Z2 := [ 336 ];

checkAll:=haveZ8Z2Z2;

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

Print("Checking ", Length(check), " groups for a DS with C4 x C4 x C2. \n");

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
            if (StructureDescription(jjj)="C4 x C4 x C2") then
                H:=jjj;
            fi;
        fi;
       
        if not H = 0 then
            currentPerm:=[1,  2,  3,  4,  5,  6,  7,  8];
            x:=0;
            y:=0;
            z:=0;
            for i in Elements(H) do

                if Order(i)=4 then

                    for j in Elements(H) do 

                        if Order(j)=4 then

                            for k in Elements(H) do

                                if Order(k) = 2 then
                                    if(GroupWithGenerators([i,j,k]) = H) then
                                        x:=i;
                                        y:=j;
                                        z:=k;
                                        xx:=x;
                                        yy:=y;
                                        zz:=z;
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

						                d1:=[];
										Append(d1, Elements(Subgroup(H, [x^2, y])));
										Append(d1, Elements(RightCoset(Subgroup(H, [x^2*z, y]),x)));

										d2:= [];
										Append(d2, Elements(Subgroup(H, [x^2, y*z])));
										Append(d2, Elements(RightCoset(Subgroup(H, [x^2*z, y*z]),x)));

										d3:=[];
										Append(d3, Elements(Subgroup(H, [x, y^2*z])));
										Append(d3, Elements(RightCoset(Subgroup(H, [x*y^2, y^2*z]),y)));

										d4:=[];
										Append(d4, Elements(Subgroup(H, [x*y, y^2*z])));
										Append(d4, Elements(RightCoset(Subgroup(H, [x*y^3, y^2*z]),y)));

										d5:= [];
										Append(d5, Elements(Subgroup(H, [x, z])));
										Append(d5, Elements(RightCoset(Subgroup(H, [x*y^2, z]),y)));

										d6:=[];
										Append(d6, Elements(Subgroup(H, [x^2, y^2,z])));


										d7:=[];
										Append(d7, Elements(Subgroup(H, [y, z])));
										Append(d7, Elements(RightCoset(Subgroup(H, [x^2*y, z]),x)));

										d8:=[];
										Append(d8, Elements(Subgroup(H, [x*y,z])));
										Append(d8, Elements(RightCoset(Subgroup(H, [x^3*y, z]),x)));

						                legos:=[d1,d2,d3,d4,d5,d6,d7,d8];

						                count := 0;
						                while dsfound=false do
						                	if count >= 1470 then
						                		Print(count,"\n");
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
							                            Print(diffset,"\n");
							                            Print("Found one! \n");
							                            Print(count,"\n");
							                            Add(crr,cosetReps[currentPerm[1]]);
							                            Add(crr,cosetReps[currentPerm[2]]);
							                            Add(crr,cosetReps[currentPerm[3]]);
							                            Add(crr,cosetReps[currentPerm[4]]);
							                            Add(crr,cosetReps[currentPerm[5]]);
							                            Add(crr,cosetReps[currentPerm[6]]);
							                            Add(crr,cosetReps[currentPerm[7]]);
							                            Add(crr,cosetReps[currentPerm[8]]);
							                            Add(thisBetterNotBeEmpty,[di,diffset]);
							                            Add(haveDS,di);
							                        fi;
							                    fi;

							                    if count>maxPerms then
							                        dsfound:=true;
							                        Print("No difference sets found.\n");
							                    fi;
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
                        fi;
                        if di in haveDS then
			                break;
			            fi;
                    od;
                fi;
                if di in haveDS then
	                break;
	            fi;
            od;
        fi;
        if di in haveDS then
            break;
        fi;
    od;
od;

Print(haveDS,"\n");
Print(Length(haveDS),"\n");

br:=false;
El := Elements(G);
e:=El[1];
for a in El do
	for b in El do
		for c in El do
			for d in El do
				if Order(a) = 4 then
					if Order(b) = 4 then
						if Order(c) = 2 then
							if Order(d) = 8 then
								if (GroupWithGenerators([a,b,c,d]) = G) then
									x:=a;
									y:=b;
									z:=c;
									w:=d;
									rels:= [x^4,y^4,z^2,w^8,w*x*w^-1*(x*y)^-1,w*y*w^-1*(x^2*y*z)^-1,w*z*w^-1*(x^2*z)^-1,x*y*(y*x)^-1,x*z*(z*x)^-1,y*z*(z*y)^-1];
									if rels = [e,e,e,e,e,e,e,e,e,e] then
										br:=true;
										bb1:=[];
										bb2:=[];
										bbb:=[[],[],[],[],[],[],[],[]];
										creps:=[];
										newBlocks:=[[],[],[],[],[],[],[],[]];
										for i in [xx,yy,zz] do
											for aa in [0..3] do
												for bb in [0..3] do
													for cc in [0..1] do
														for dd in [0..7] do
															if i=x^aa*y^bb*z^cc*w^dd then
																str:=JoinStringsWithSeparator(["x^",String(aa),"*y^",String(bb),"*z^",String(cc),"*w^",String(dd)],"");
																str:=ReplacedString(str,"*y^0","");
																str:=ReplacedString(str,"*z^0","");
																str:=ReplacedString(str,"*w^0","");
																str:=ReplacedString(str,"x^0*","");
																str:=ReplacedString(str,"x^0","1");
																str:=ReplacedString(str,"x^1","x");
																str:=ReplacedString(str,"y^1","y");
																str:=ReplacedString(str,"z^1","z");
																str:=ReplacedString(str,"w^1","w");
																Add(bb1,str);
															fi;
														od;
													od;
												od;
											od;
										od;
										for i in crr do
											for aa in [0..3] do
												for bb in [0..3] do
													for cc in [0..1] do
														for dd in [0..7] do
															if i=x^aa*y^bb*z^cc*w^dd then
																str:=JoinStringsWithSeparator(["x^",String(aa),"*y^",String(bb),"*z^",String(cc),"*w^",String(dd)],"");
																str:=ReplacedString(str,"*y^0","");
																str:=ReplacedString(str,"*z^0","");
																str:=ReplacedString(str,"*w^0","");
																str:=ReplacedString(str,"x^0*","");
																str:=ReplacedString(str,"x^0","1");
																str:=ReplacedString(str,"x^1","x");
																str:=ReplacedString(str,"y^1","y");
																str:=ReplacedString(str,"z^1","z");
																str:=ReplacedString(str,"w^1","w");
																Add(bb2,str);
																Add(creps,x^aa*y^bb*z^cc*w^dd);
															fi;
														od;
													od;
												od;
											od;
										od;
										for j in [1..8] do
											for i in legos[j] do
												for aa in [0..3] do
													for bb in [0..3] do
														for cc in [0..1] do
															for dd in [0..7] do
																if i=x^aa*y^bb*z^cc*w^dd then
																	str:=JoinStringsWithSeparator(["x^",String(aa),"*y^",String(bb),"*z^",String(cc),"*w^",String(dd)],"");
																	str:=ReplacedString(str,"*y^0","");
																	str:=ReplacedString(str,"*z^0","");
																	str:=ReplacedString(str,"*w^0","");
																	str:=ReplacedString(str,"x^0*","");
																	str:=ReplacedString(str,"x^0","1");
																	str:=ReplacedString(str,"x^1","x");
																	str:=ReplacedString(str,"y^1","y");
																	str:=ReplacedString(str,"z^1","z");
																	str:=ReplacedString(str,"w^1","w");
																	Add(bbb[j],str);
																	Add(newBlocks[j],x^aa*y^bb*z^cc*w^dd);
																fi;
															od;
														od;
													od;
												od;
											od;
										od;
									fi;
								fi;
							fi;
						fi;
					fi;
				fi;
				if br=true then
					break;
				fi;
			od;
			if br=true then
				break;
			fi;
		od;
		if br=true then
			break;
		fi;
	od;
	if br=true then
		break;
	fi;
od;
Print(bb1,"\n");
Print([xx,yy,zz],"\n\n\n");
Print(bb2,"\n");
Print(crr,"\n");
Print([w^0,w^1,w^2,w^3,w^4,w^5,w^6,w^7],"\n\n\n");
Print(bbb[1],"\n");
Print(bbb[2],"\n");
Print(bbb[3],"\n");
Print(bbb[4],"\n");
Print(bbb[5],"\n");
Print(bbb[6],"\n");
Print(bbb[7],"\n");
Print(bbb[8],"\n");




diffset := [];

for jj in [1..Length(newBlocks)] do
    for kk in newBlocks[jj] do
        Add(diffset,creps[jj]*kk);
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
        Print(diffset,"\n");
        Print("Found one! \n");
        Print(count,"\n");
        Add(thisBetterNotBeEmpty,[di,diffset]);
        Add(haveDS,di);
    fi;
fi;








