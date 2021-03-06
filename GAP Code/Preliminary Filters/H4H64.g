# Read( "C:/Users/Gavin/Desktop/GAP Code/H4H64.g" );

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

NoDS64 := [1,50,52,53,54,38,47,186];

H4H64:=[];

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
    b := false;
    for j in NS do
        if Size(j)=64 then
            if not ((IdSmallGroup(j)[2]) in NoDS64) then
                for m in NS do
                    if Size(m)=4 then
                        if Size(Intersection(j,m)) = 1 then # Note at bottom
                            b := true;
                            Add(H4H64,i);
                            break;
                        fi;
                    fi;
                od;
                if b = true then
                    break;
                fi;
            fi;
        fi;
    od;
    if (Size(H4H64) mod 100) = 0 then
        Print( Size(H4H64), " found so far.\n");
    fi;
od;

Print(Size(H4H64), " groups have a DS due to the H4 x H64 construction.  They are at these indices: \n");
# Print(H4H64);
Print("\n");
Print("Time taken: ", (Runtime()/1000.0-t0), " seconds.\n");

output := OutputTextFile( "C:/Users/Gavin/Desktop/GAP Code/H4H64.txt", false );

for i in H4H64 do
    AppendTo(output, i, "\n");
od;

CloseStream(output);

# Note: the condition on line 59 is necessary and sufficient.  Gallian says (on pg. 139) that for a,b in m, aj = bj if and only if a^{-1}b is in j.  However, since m is a subgroup, a^{-1}b is in m, so then unless a = b, m and j have nontrivial intersection.  He also says aj and bj must be equal or disjoint.  So, if m and j have nontrivial intersection, their direct product must be G.