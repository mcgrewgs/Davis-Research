# Read( "C:/Users/Gavin/Desktop/GAP Code/GenProd.g" );

t0 := Runtime()/1000.0;

DontCheck:=[];

input := InputTextFile( "C:/Users/Gavin/Desktop/GAP Code/TurynBound.txt" );

while not IsEndOfStream(input) do
    s := ReadLine( input );
    if s = fail then
        break;
    fi;
    NormalizeWhitespace(s);
    Add( DontCheck, Int(s) );
od;

CloseStream( input );

input := InputTextFile( "C:/Users/Gavin/Desktop/GAP Code/E16.txt" );

while not IsEndOfStream(input) do
    s := ReadLine( input );
    if s = fail then
        break;
    fi;
    NormalizeWhitespace(s);
    Add( DontCheck, Int(s) );
od;

CloseStream( input );

input := InputTextFile( "C:/Users/Gavin/Desktop/GAP Code/H4H64.txt" );

while not IsEndOfStream(input) do
    s := ReadLine( input );
    if s = fail then
        break;
    fi;
    NormalizeWhitespace(s);
    Add( DontCheck, Int(s) );
od;

CloseStream( input );

input := InputTextFile( "C:/Users/Gavin/Desktop/GAP Code/H16H16.txt" );

while not IsEndOfStream(input) do
    s := ReadLine( input );
    if s = fail then
        break;
    fi;
    NormalizeWhitespace(s);
    Add( DontCheck, Int(s) );
od;

CloseStream( input );

NoDS64 := [1,50,52,53,54,38,47,186];

GenProd:=[];

Check := [];

for i in [2..56092] do
    if not ( i in DontCheck ) then
        Add( Check, i );
    fi;
od;

k := 1;
p := Size(Check);

for i in Check do
    Print("Working on group number ", k, " out of ", p ,".  Time taken: ", (Runtime()/1000.0-t0), " seconds.\n");
    k := k+1;
    G:=SmallGroup(256,i);
    NS:=AllSubgroups(G);
    bk:=false;
    for j in NS do
        if Size(j)=64 then
            if not ( IdSmallGroup(j)[2] in NoDS64 ) then
                F := CosetDecomposition(G,j);
                for ii in [1..64] do
                    for jj in [1..64] do
                        for kk in [1..64] do
                            a := Inverse(F[2][ii]);
                            b := Inverse(F[3][jj]);
                            c := Inverse(F[4][kk]);
                            S:=[a*Inverse(b),b*Inverse(c),c*Inverse(a)];
                            if a in S then
                                if b in S then
                                    if c in S then
                                        if Length(Set([a,b,c])) = Length(Set(S)) then
                                            Add(GenProd,i);
                                            bk:=true;
                                            break;
                                        fi;
                                    fi;
                                    if Inverse(c) in S then
                                        if Length(Set([a,b,Inverse(c)])) = Length(Set(S)) then
                                            Add(GenProd,i);
                                            bk:=true;
                                            break;
                                        fi;
                                    fi;
                                fi;
                                if Inverse(b) in S then
                                    if c in S then
                                        if Length(Set([a,Inverse(b),c])) = Length(Set(S)) then
                                            Add(GenProd,i);
                                            bk:=true;
                                            break;
                                        fi;
                                    fi;
                                    if Inverse(c) in S then
                                        if Length(Set([a,Inverse(b),Inverse(c)])) = Length(Set(S)) then
                                            Add(GenProd,i);
                                            bk:=true;
                                            break;
                                        fi;
                                    fi;
                                fi;
                            fi;
                            if Inverse(a) in S then
                                if b in S then
                                    if c in S then
                                        if Length(Set([Inverse(a),b,c])) = Length(Set(S)) then
                                            Add(GenProd,i);
                                            bk:=true;
                                            break;
                                        fi;
                                    fi;
                                    if Inverse(c) in S then
                                        if Length(Set([Inverse(a),b,Inverse(c)])) = Length(Set(S)) then
                                            Add(GenProd,i);
                                            bk:=true;
                                            break;
                                        fi;
                                    fi;
                                fi;
                                if Inverse(b) in S then
                                    if c in S then
                                        if Length(Set([Inverse(a),Inverse(b),c])) = Length(Set(S)) then
                                            Add(GenProd,i);
                                            bk:=true;
                                            break;
                                        fi;
                                    fi;
                                    if Inverse(c) in S then
                                        if Length(Set([Inverse(a),Inverse(b),Inverse(c)])) = Length(Set(S)) then
                                            Add(GenProd,i);
                                            bk:=true;
                                            break;
                                        fi;
                                    fi;
                                fi;
                            fi;
                        od;
                        if bk = true then
                            break;
                        fi;
                    od;
                    if bk = true then
                        break;
                    fi;
                od;
                if bk = true then
                    break;
                fi;
            fi;
        fi;
    od;
    #if (Size(GenProd) mod 100) = 0 then
    #    Print( Size(GenProd), " found so far.\n");
    #fi;
od;

Print(Size(GenProd), " groups have a DS due to the generalized product construction.  They are at these indices: \n");
# Print(GenProd);
Print("\n");
Print("Time taken: ", (Runtime()/1000.0-t0), " seconds.\n");

output := OutputTextFile( "C:/Users/Gavin/Desktop/GAP Code/GenProd.txt", false );

for i in GenProd do
    AppendTo(output, i, "\n");
od;

CloseStream(output);