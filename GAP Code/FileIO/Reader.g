# Read( "C:/Users/Gavin/Desktop/GAP Code/Reader.g" );

str := "C16 x C8 x C2\n";
input := InputTextFile( "C:/Users/Gavin/Desktop/GAP Code/myOutput.txt" );

i := 1;

while not IsEndOfStream(input) do
    s := ReadLine( input );
    if s = str then
        Print( i, "\n" );
        break;
    fi;
    i := i + 1;
od;

CloseStream( input );