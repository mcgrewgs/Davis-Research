import java.io.*;
import java.util.*;

/**
*   Given a string, for example, like "1 + x + x^2 + y + y^3 + xy", this program would output:
*   Even x: [ x^0, x, y, y^3 ];
*   Odd x: [ x^0, y ];
*   Even y: [ x^0, x, x^2 ];
*   Odd y: [ x^0, y^0, x ];
*/
public class C
{
    public static void main( String[] args )
    {
        System.out.print( "" );
        Scanner sc = new Scanner( System.in );
        String st = "";
        while( true )
        {
            st = sc.nextLine();
            if( st.contains( "quit" ) )
            {
                break;
            }
            System.out.println( parseSum( st, "x" ) );
            System.out.println( parseSum( st, "y" ) );
        }
        sc.close();
    }
    
    public static String parseSum( String s, String var )
    {
        String[] st = s.split( "\\+" );
        String ss = "";
        String str = "Even " + var + ": [ ";
        for( int i = 0; i < st.length; ++i )
        {
            ss = parseEven( st[i], var );
            if( !ss.equals( "" ) )
            {
                str += ( ss + ", " );
            }
        }
        str = str.substring( 0, str.length() - 2 );
        str += " ];\nOdd " + var + ": [ ";
        for( int i = 0; i < st.length; ++i )
        {
            ss = parseOdd( st[i], var );
            if( !ss.equals( "" ) )
            {
                str += ( ss + ", " );
            }
        }
        str = str.substring( 0, str.length() - 2 );
        str += " ];";
        return str;
    }
    
    public static String parseEven( String s, String var )
    {
        int x = 0;
        int y = 0;
        int k = 0;
        if( s.contains( "x" ) )
        {
            if( s.contains( "x^" ) )
            {
                k = s.indexOf( "x" );
                x = Integer.parseInt( s.substring( k+2, k+3 ) );
            }
            else
            {
                x = 1;
            }
        }
        else
        {
            x = 0;
        }
        if( s.contains( "y" ) )
        {
            if( s.contains( "y^" ) )
            {
                k = s.indexOf( "y" );
                y = Integer.parseInt( s.substring( k+2, k+3 ) );
            }
            else
            {
                y = 1;
            }
        }
        else
        {
            y = 0;
        }
        String str = "";
        if( var.equals( "x" ) )
        {
            if( x % 2 == 0 )
            {
                if( x == 0 )
                {
                    if( y == 0 )
                    {
                        str = "x^0";
                    }
                    else
                    {
                        str = "y^" + y;
                    }
                }
                else
                {
                    str += ("x^" + x/2);
                    if( y != 0 )
                    {
                        str += ("*y^" + y);
                    }
                }
            }
        }
        if( var.equals( "y" ) )
        {
            if( y % 2 == 0 )
            {
                if( x == 0 )
                {
                    if( y == 0 )
                    {
                        str = "x^0";
                    }
                    else
                    {
                        str = "y^" + y/2;
                    }
                }
                else
                {
                    str += ("x^" + x);
                    if( y != 0 )
                    {
                        str += ("*y^" + y/2);
                    }
                }
            }
        }
        str = str.replace( "x^1", "x" );
        str = str.replace( "y^1", "y" );
        return str;
    }
    
    public static String parseOdd( String s, String var )
    {
        int x = 0;
        int y = 0;
        int k = 0;
        if( s.contains( "x" ) )
        {
            if( s.contains( "x^" ) )
            {
                k = s.indexOf( "x" );
                x = Integer.parseInt( s.substring( k+2, k+3 ) );
            }
            else
            {
                x = 1;
            }
        }
        else
        {
            x = 0;
        }
        if( s.contains( "y" ) )
        {
            if( s.contains( "y^" ) )
            {
                k = s.indexOf( "y" );
                y = Integer.parseInt( s.substring( k+2, k+3 ) );
            }
            else
            {
                y = 1;
            }
        }
        else
        {
            y = 0;
        }
        String str = "";
        if( var.equals( "x" ) )
        {
            if( (x-1) % 2 == 0 )
            {
                if( (x-1) == 0 )
                {
                    if( y == 0 )
                    {
                        str = "x^0";
                    }
                    else
                    {
                        str = "y^" + y;
                    }
                }
                else
                {
                    str += ("x^" + (x-1)/2);
                    if( y != 0 )
                    {
                        str += ("*y^" + y);
                    }
                }
            }
        }
        if( var.equals( "y" ) )
        {
            if( (y-1) % 2 == 0 )
            {
                if( x == 0 )
                {
                    if( (y-1) == 0 )
                    {
                        str = "x^0";
                    }
                    else
                    {
                        str = "y^" + (y-1)/2;
                    }
                }
                else
                {
                    str += ("x^" + x);
                    if( (y-1) != 0 )
                    {
                        str += ("*y^" + (y-1)/2);
                    }
                }
            }
        }
        str = str.replace( "x^1", "x" );
        str = str.replace( "y^1", "y" );
        return str;
    }
}