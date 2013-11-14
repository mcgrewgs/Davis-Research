import java.util.*;

public class A2
{
    public static void algorithm()
    {
        ArrayList<Long> bentFunctions = new ArrayList<Long>(42386176);
        double d1 = System.nanoTime()/1000000000.0;
        int[] r = { -1, Integer.parseInt( "01010101010101010101010101010101", 2 ), Integer.parseInt( "00110011001100110011001100110011", 2 ), Integer.parseInt( "00001111000011110000111100001111", 2 ), Integer.parseInt( "00000000111111110000000011111111", 2 ), 65535 };
        int[] fo = new int[32];
        for( int i = 0; i < 32; i++ )
        {
            for( int j = 1; j < 6; j++ )
            {
                fo[i] ^= ( ( i >> (j-1) ) % 2 ) * r[j];
            }
        }
        int[] r2 = new int[20];
        int c = 0;
        for( int i = 0; i < 4; i++ )
        {
            for( int j = i + 1; j < 5; j++ )
            {
                for( int k = j + 1; k < 6; k++ )
                {
                    r2[c++] = r[i] & r[j] & r[k];
                }
            }
        }
        int n = (int)Math.pow( 2, 20 );
        int tm = 0;
        int[] g = new int[1024];
        int[][] b = new int[1024][1024];
        byte[][][] whtb = new byte[1024][1024][32];
        c = 0;
        for( int i = 0; i < n; ++i )
        {
            c = i >> 10;
            tm = 0;
            for( int j = 0; j < 20; ++j )
            {
                tm ^= ( ( i >> j ) % 2 ) * r2[j];
            }
            if( A2.t32( tm ) )
            {
                whtb[c][g[c]] = A2.wht( tm );
                b[c][g[c]++] = tm;
            }
        }
        int gn = 0;
        for( int gg : g )
        {
            gn += gg;
        }
        System.out.println( gn + " semi-bent functions found in 5 variables.  Time taken: " + ( System.nanoTime()/1000000000.0 - d1 ) );
        byte[] b1 = null;
        byte[] b2 = null;
        boolean next = false;
        //int[][] nb = new int[1024][1024];
        int numBent = 0;
        /*
        int n4888 = 0;
        int n66610 = 0;
        int n88812 = 0;
        int n6101010 = 0;
        int a4 = 0;
        int a6 = 0;
        int a8 = 0;
        int a10 = 0;
        int a12 = 0;
        int[] aaa = null;
         */
        long ll = 0l;
        for( int i = 0; i < b.length; ++i )
        {
            for( int j = 0; j < g[i]; ++j )
            {
                b1 = whtb[i][j];
                for( int k = 0; k < g[i]; ++k )
                {
                    b2 = whtb[i][k];
                    //nb[j][k] = 0;
                    for( int l = 0; l < 32; ++l )
                    {
                        next = false;
                        for( int ii = 0; ii < 32; ++ii )
                        {
                            if( ( ( b1[ii] + b2[ii^l] ) % 16 ) == 0 )
                            {
                                next = true;
                                break;
                            }
                        } 
                        if( next )
                        {
                            continue;
                        }
                        //ll = ( ( ( (long)b[i][j] ) << 32 ) ^ ( ( (long)b[i][k] ) ^ ( (long)fo[l] ) ) );
                        //nb[j][k]++;
                        /*
                        bentFunctions.add( ll );
                        a4 = 0;
                        a6 = 0;
                        a8 = 0;
                        a10 = 0;
                        a12 = 0;
                        aaa = new int[4];
                        for( int iiii = 0; iiii < 64; iiii += 16 )
                        {
                        aaa[iiii/16] = Long.bitCount( ll & ( 65535l << iiii ) );
                        if( aaa[iiii/16] == 4 )
                        {
                        a4++;
                        }
                        else if( aaa[iiii/16] == 6 )
                        {
                        a6++;
                        }
                        else if( aaa[iiii/16] == 8 )
                        {
                        a8++;
                        }
                        else if( aaa[iiii/16] == 10 )
                        {
                        a10++;
                        }
                        else if( aaa[iiii/16] == 12 )
                        {
                        a12++;
                        }
                        }
                        if( a4 == 1 && a8 == 3 )
                        {
                        n4888++;
                        }
                        else if( a6 == 3 && a10 == 1 )
                        {
                        n66610++;
                        }
                        else if( a8 == 3 && a12 == 1 )
                        {
                        n88812++;
                        }
                        else if( a6 == 1 && a10 == 3 )
                        {
                        n6101010++;
                        }
                        else
                        {
                        System.err.println( "[ " + aaa[0] + " " + aaa[1] + " " + aaa[2] + " " + aaa[3] + " ]" );
                        }
                         */
                        if( ( ( ++numBent ) % 1000000 ) == 0 )
                        {
                            System.err.println( numBent + " found so far.  Time: " + ( System.nanoTime()/1000000000.0 - d1 ) );
                        }
                    }
                    /*
                    if( nb[j][k] != 4 && nb[j][k] != 0 )
                    {
                    System.err.println( nb[j][k] );
                    }
                     */
                }
            }
        }
        System.out.println( numBent + " 6-variable bent functions found.  Total time: " + ( System.nanoTime()/1000000000.0 - d1 ) );
        /*
        System.out.println( n4888 + " meet the 4|8|8|8 requirement." );
        System.out.println( n66610 + " meet the 6|6|6|10 requirement." );
        System.out.println( n6101010 + " meet the 6|10|10|10 requirement." );
        System.out.println( n88812 + " meet the 8|8|8|12 requirement." );
         */
        /*
        for( int[] i : nb )
        {
        System.out.print( "[ " );
        for( int j = 0; j < i.length - 1; j++ )
        {
        System.out.print( i[j] + ", " );
        }
        System.out.println( i[i.length - 1] + " ]" );
        }
         */
    }

    public static byte[] wht( int word )
    {
        byte[] b = new byte[32];
        byte sum = 0;
        for( int i = 0; i < 32; ++i )
        {
            sum = 0;
            for( int j = 0; j < 32; ++j )
            {
                sum += ( 1 - 2 * ( ( Integer.bitCount( i & j ) ^ ( ( word >> ( 31 - j ) ) & 1 ) ) % 2 ) );
            }
            b[i] = sum;
        }
        return b;
    }

    public static String whtToString( byte[] t )
    {
        String s = "";
        s += "[ ";
        for( byte bb : t )
        {
            if( bb < 0 )
            {
                s += ( bb + "  " );
            }
            else
            {
                s += ( "/+" + bb + " " );
            }
        }
        s += "]";
        return s;
    }
    
    public static String toANF( int p, int n )
    {
        int[] ii = { p };
        return ANFParser.parse( ii, n );
    }

    public static String toANF( long p, int n )
    {
        int[] ii = { (int)(p >> 32), (int)p };
        return ANFParser.parse( ii, n );
    }

    public static boolean t32( int word )
    {
        int sum = 0;
        for(int y = 0; y < 32; ++y)
        {
            sum = 0;
            for(int x = 0; x < 32; ++x)
            {
                sum += ( 1 - 2 * ( ( Integer.bitCount( x & y ) ^ (1 & (word >> (31 - x ) ) ) ) % 2 ) );
            }
            if( sum != 0 )
            {
                if( sum != 8 )
                {
                    if( sum != -8 )
                    {
                        return false;
                    }
                }
            }
        }
        return true;
    }

    public static void main( String[] args )
    {
        A2.algorithm();
    }
}
