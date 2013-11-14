# Read( "C:/Users/Gavin/Desktop/GAP Code/Z8Z8.g" );

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

input := InputTextFile( "C:/Users/Gavin/Desktop/GAP Code/GenProd.txt" );

while not IsEndOfStream(input) do
    s := ReadLine( input );
    if s = fail then
        break;
    fi;
    NormalizeWhitespace(s);
    Add( DontCheck, Int(s) );
od;

CloseStream( input );

Z8Z8:=[];

Check := [];

for i in [2..56092] do
    if not ( i in DontCheck ) then
        Add( Check, i );
    fi;
od;

k := 1;
p := Size(Check);

output := OutputTextFile( "C:/Users/Gavin/Desktop/GAP Code/RemainingAfterGenProd.txt", false );

for i in Check do
    AppendTo(output, i, "\n");
od;

CloseStream(output);

for i in Check do
    Print("Working on group number ", k, " out of ", p ,".  Time taken: ", (Runtime()/1000.0-t0), " seconds.\n");
    k := k+1;
    G:=SmallGroup(256,i);
    NS:=ConjugacyClassesSubgroups(G);
    for j in NS do
        jj:=Representative(j);
        if Size(jj) = 64 then
            if IsAbelian(jj) then
                if IsNormal(G,jj) then
                    if StructureDescription(jj) = "C8 x C8" then
                        Add(Z8Z8,i);
                        break;
                    fi;
                fi;
            fi;
        fi;
    od;
od;

Print(Size(Z8Z8), " groups have a DS due to a Z8 x Z8 normal subgroup.  They are at these indices: \n");
# Print(Z8Z8);
Print("\n");
Print("Time taken: ", (Runtime()/1000.0-t0), " seconds.\n");

output := OutputTextFile( "C:/Users/Gavin/Desktop/GAP Code/Z8Z8.txt", false );

for i in Z8Z8 do
    AppendTo(output, i, "\n");
od;

CloseStream(output);