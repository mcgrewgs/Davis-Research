# Read("C:/Users/Gavin/Desktop/GAP Code/copy.g");

DontCheck:=[];

input := InputTextFile( "C:/Users/Gavin/Desktop/GAP Code/GenProd1.txt" );

while not IsEndOfStream(input) do
    s := ReadLine( input );
    if s = fail then
        break;
    fi;
    NormalizeWhitespace(s);
    Add( DontCheck, Int(s) );
od;

CloseStream( input );

input := InputTextFile( "C:/Users/Gavin/Desktop/GAP Code/GenProd2.txt" );

while not IsEndOfStream(input) do
    s := ReadLine( input );
    if s = fail then
        break;
    fi;
    NormalizeWhitespace(s);
    Add( DontCheck, Int(s) );
od;

CloseStream( input );

input := InputTextFile( "C:/Users/Gavin/Desktop/GAP Code/GenProd3.txt" );

while not IsEndOfStream(input) do
    s := ReadLine( input );
    if s = fail then
        break;
    fi;
    NormalizeWhitespace(s);
    Add( DontCheck, Int(s) );
od;

CloseStream( input );

input := InputTextFile( "C:/Users/Gavin/Desktop/GAP Code/GenProd4.txt" );

while not IsEndOfStream(input) do
    s := ReadLine( input );
    if s = fail then
        break;
    fi;
    NormalizeWhitespace(s);
    Add( DontCheck, Int(s) );
od;

CloseStream( input );

input := InputTextFile( "C:/Users/Gavin/Desktop/GAP Code/GenProd5.txt" );

while not IsEndOfStream(input) do
    s := ReadLine( input );
    if s = fail then
        break;
    fi;
    NormalizeWhitespace(s);
    Add( DontCheck, Int(s) );
od;

CloseStream( input );

input := InputTextFile( "C:/Users/Gavin/Desktop/GAP Code/GenProd6.txt" );

while not IsEndOfStream(input) do
    s := ReadLine( input );
    if s = fail then
        break;
    fi;
    NormalizeWhitespace(s);
    Add( DontCheck, Int(s) );
od;

CloseStream( input );

input := InputTextFile( "C:/Users/Gavin/Desktop/GAP Code/GenProd7.txt" );

while not IsEndOfStream(input) do
    s := ReadLine( input );
    if s = fail then
        break;
    fi;
    NormalizeWhitespace(s);
    Add( DontCheck, Int(s) );
od;

CloseStream( input );

input := InputTextFile( "C:/Users/Gavin/Desktop/GAP Code/GenProd8.txt" );

while not IsEndOfStream(input) do
    s := ReadLine( input );
    if s = fail then
        break;
    fi;
    NormalizeWhitespace(s);
    Add( DontCheck, Int(s) );
od;

CloseStream( input );

output := OutputTextFile( "C:/Users/Gavin/Desktop/GAP Code/GenProd.txt", false );

Print(Length(DontCheck),"\n");

for i in DontCheck do
    AppendTo(output, i, "\n");
od;

CloseStream( output );