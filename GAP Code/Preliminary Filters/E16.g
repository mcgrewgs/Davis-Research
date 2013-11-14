# Read( "C:/Users/Gavin/Desktop/GAP Code/E16.g" );

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

HasE16:=[];

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
    k := k + 1;
    G:=SmallGroup(256,i);
    Sub:=NormalSubgroups(G);
    for j in Sub do
        if Size(j)=16 then
            if IsElementaryAbelian(j) then
                Add(HasE16,i);
                break;
            fi;
        fi;
    od;
od;

Print(Size(HasE16), " groups have a DS due to an elementary Abelian subgroup of size 16.  They are at these indices: \n");
# Print(HasE16);
Print("\n");
Print("Time taken: ", (Runtime()/1000.0-t0), " seconds.\n");

output := OutputTextFile( "C:/Users/Gavin/Desktop/GAP Code/E16.txt", false );

for i in HasE16 do
    AppendTo(output, i, "\n");
od;

CloseStream( output );