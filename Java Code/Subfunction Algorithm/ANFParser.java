import java.io.*;
import java.math.*;
import java.util.*;

/**
 * A class containing methods for converting a boolean function in an arbitrary number of variables to its corresponding Algebraic Normal Form, or ANF.
 * 
 * @author Gavin "gm8in" McGrew
 * @version 6/26/2013
 */
public class ANFParser
{
    public static void main( String[] args )
    {
        ArrayList<Integer> a = new ArrayList<Integer>(6);
        a.add(3);
        a.add(7);
        a.add(11);
        a.add(12);
        a.add(13);
        a.add(15);
        System.out.println( ANFParser.toANF( a, 4 ) );
    }

    public static String toANF( ArrayList<Integer> a, int n )
    {
        int x = ( n <= 5 ) ? 1 : (int)Math.pow( 2, n - 5 );
        int y = ( n < 5 ) ? (int)Math.pow(2,n) : 32;
        int[] ii = new int[x];
        String s = "";
        int c = 0;
        for( int i = 0; i < x; i++ )
        {
            s = "";
            for( int j = 0; j < y; j++ )
            {
                if( a.contains( (c++) ) )
                {
                    s += "1";
                }
                else
                {
                    s += "0";
                }
            }
            ii[i] = Integer.parseInt( s, 2 );
        }
        return ANFParser.parse( ii, n );
    }

    public static String parse( int[] f, int n )
    {
        String s = "";
        String s2 = "";
        int a = 32;
        if( n < 5 )
        {
            a = (int)Math.pow( 2, n );
        }
        for( int i = 0; i < f.length; i++ )
        {
            s2 = Integer.toBinaryString( f[i] );
            while( s2.length() < a )
            {
                s2 = "0" + s2;
            }
            s += s2;
        }
        String s3 = "";
        for( int i = 0; i < s.length(); i++ )
        {
            s3 += s.charAt( s.length() - 1 - i );
        }
        BigInteger b = new BigInteger( s3, 2 );
        return ANFParser.parse( b, n );
    }

    private static String parse( BigInteger f, int n )
    {
        String toReturn = "";
        String s = "";
        String[] vars = new String[n];
        for( int i = 1; i <= n; i++ )
        {
            vars[i-1] = "x" + Integer.toString( i );
        }
        BigInteger[] nums = ANFParser.buildListThing( n );
        for( int i = nums.length - 1; i >= 0; i-- )
        {
            s = ANFParser.buildMult( vars, i );
            if( ( nums[i].and( f ) ).bitCount() % 2 == 1 )
            {
                toReturn += ( " + " + s );
            }
        }
        return ANFParser.form( ( (toReturn.length() >= 3 ) ? toReturn.substring( 3, toReturn.length() ) : "0" ) );
    }

    private static String buildMult( String[] s, int n )
    {
        if( n == 0 )
        {
            return "1";
        }
        String toReturn = "";
        for( int i = s.length - 1; i >= 0; i-- )
        {
            if( n % (int)Math.pow( 2, i+1 ) >= (int)Math.pow( 2, i ) )
            {
                toReturn += s[s.length - i - 1];
            }
        }
        return toReturn;
    }

    private static BigInteger[] buildListThing( int n )
    {
        BigInteger[] toReturn = new BigInteger[(int)Math.pow( 2, n ) ];
        toReturn[0] = BigInteger.ONE;
        toReturn[1] = new BigInteger( "3" );
        BigInteger w = null;
        int count = 2;
        for( int i = 1; i < n; i++ )
        {
            w = toReturn[count - 1].add( new BigInteger( "2" ) );
            for( int j = 0; j < (int)Math.pow( 2, i ); j++ )
            {
                toReturn[count++] = w.multiply( toReturn[j] );
            }
        }
        return toReturn;
    }

    private static String form( String f )
    {
        String s = "";
        if( ! f.contains( "+" ) )
        {
            return f;
        }
        String[] st = f.split( " \\+ " );
        int[] a = new int[st.length];
        int m = 0;
        for( int i = 0; i < st.length; i++ )
        {
            a[i] = ANFParser.count( st[i], 'x' );
            if( a[i] > m )
            {
                m = a[i];
            }
        }
        for( int i = m; i >= 0; i-- )
        {
            for( int j = 0; j < st.length; j++ )
            {
                if( a[j] == i )
                {
                    s += ( st[j] + " + " );
                }
            }
        }
        return s.substring( 0, s.length() - 3 );
    }

    private static int count( String s, char c )
    {
        int a = 0;
        for( int i = 0; i < s.length(); i++ )
        {
            if( s.charAt( i ) == c )
            {
                a++;
            }
        }
        return a;
    }

    public static int degree( String f )
    {
        if( ! f.contains( "+" ) )
        {
            return ANFParser.count( f, 'x' );
        }
        String[] st = f.split( " \\+ " );
        int x = 0;
        int y = 0;
        for( String s : st )
        {
            y = ANFParser.count( s, 'x' );
            if( y > x )
            {
                x = y;
            }
        }
        return x;
    }
}