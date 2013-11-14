# Read( "C:/Users/Gavin/Desktop/GAP Code/Writer.g" );

n1 := 1;
n2 := 56092;

output := OutputTextFile( "C:/Users/Gavin/Desktop/GAP Code/myOutput.txt",false );
PrintTo( output );

for i in [n1..n2] do
    WriteLine( output, StructureDescription( SmallGroup( 256, i ) ) );
    if i mod 100 = 0 then
        Print( i, " done.\n" );
    fi;
od;

CloseStream( output );