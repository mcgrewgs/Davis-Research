import java.util.*;

public class Algorithm extends Thread
{
    int numThreads = 1;
    long waitTime = 10000l;

    public Algorithm( int i, int j )
    {
        numThreads = i;
        waitTime = (long)j*1000l;
    }

    class HelperThread extends Thread
    {
        int[][] b;
        int[] g;
        int[] fo;
        byte[][][] whtb;
        ArrayList<Long> a;
        int idNum;

        public HelperThread( int[][] bb, byte[][][] whtbb, int[] gg, int[] fofo, ArrayList<Long> aa, int id )
        {
            b = bb;
            g = gg;
            fo = fofo;
            a = aa;
            idNum = id;
            whtb = whtbb;
        }

        public void run()
        {
            byte[] b1 = null;
            byte[] b2 = null;
            boolean next = false;
            for( int i = 0; i < b.length; i++ )
            {
                for( int j = 0; j < g[i]; j++ )
                {
                    b1 = whtb[i][j];
                    for( int k = 0; k < g[i]; k++ )
                    {
                        b2 = whtb[i][k];
                        for( int l = 0; l < 32; l++ )
                        {
                            next = false;
                            for( int ii = 0; ii < 32; ii++ )
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
                            a.add( ( ( ( (long)b[i][j] ) << 32 ) ^ ( ( (long)b[i][k] ) ^ ( (long)fo[l] ) ) ) );
                        }
                    }
                }
            }
            System.out.println( "Thread " + idNum + " done." );
        }
    }

    public void run()
    {
        try
        {
            setPriority( Thread.MAX_PRIORITY );
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
            for( int i = 0; i < n; i++ )
            {
                c = i >> 10;
                tm = 0;
                for( int j = 0; j < 20; j++ )
                {
                    tm ^= ( ( i >> j ) % 2 ) * r2[j];
                }
                if( Algorithm.t32( tm ) )
                {
                    whtb[c][g[c]] = Algorithm.wht( tm );
                    b[c][g[c]++] = tm;
                }
            }
            int gn = 0;
            for( int gg : g )
            {
                gn += gg;
            }
            System.out.println( gn + " semi-bent functions found in 5 variables.  Time taken: " + ( System.nanoTime()/1000000000.0 - d1 ) );
            d1 = System.nanoTime()/1000000000.0;
            ArrayList<ArrayList<Long>> aaa = new ArrayList<ArrayList<Long>>();
            for( int i = 0; i < numThreads+1; i++ )
            {
                aaa.add( new ArrayList<Long>() );
            }
            HelperThread[] h = new HelperThread[aaa.size()];
            int numOffset = 25;
            for( int i = 0; i < h.length; i++ )
            {
                if( i == 0 )
                {
                    h[i] = ( new HelperThread( Arrays.copyOfRange( b, (1024/numThreads)*(i) + numOffset, (1024/numThreads)*(i+1) ), Arrays.copyOfRange( whtb, (1024/numThreads)*(i) + numOffset, (1024/numThreads)*(i+1) ), Arrays.copyOfRange( g, (1024/numThreads)*(i) + numOffset, (1024/numThreads)*(i+1) ), Arrays.copyOf( fo, fo.length ), aaa.get( i ), i+1 ) );
                    h[i].setPriority( Thread.MAX_PRIORITY - 1 );
                    h[i].start();
                }
                else if( i == numThreads )
                {
                    h[i] = ( new HelperThread( Arrays.copyOfRange( b, 0, numOffset ), Arrays.copyOfRange( whtb, 0, numOffset ), Arrays.copyOfRange( g, 0, numOffset ), Arrays.copyOf( fo, fo.length ), aaa.get( i ), i+1 ) );
                    h[i].setPriority( Thread.NORM_PRIORITY );
                    h[i].start();
                }
                else
                {
                    h[i] = ( new HelperThread( Arrays.copyOfRange( b, (1024/numThreads)*(i), (1024/numThreads)*(i+1) ), Arrays.copyOfRange( whtb, (1024/numThreads)*(i), (1024/numThreads)*(i+1) ), Arrays.copyOfRange( g, (1024/numThreads)*(i), (1024/numThreads)*(i+1) ), Arrays.copyOf( fo, fo.length ), aaa.get( i ), i+1 ) );
                    h[i].setPriority( Thread.MAX_PRIORITY - 1 );
                    h[i].start();
                }
            }
            boolean bool = true;
            int numBent = 0;
            int nbp = 0;
            while( bool )
            {
                bool = false;
                numBent = 0;
                for( int i = 0; i < h.length; i++ )
                {
                    bool = bool || ( h[i].isAlive() );
                    numBent += (aaa.get(i)).size();
                }
                System.out.println( numBent + " found so far.  Time: " + ( System.nanoTime()/1000000000.0 - d1 ) );
                if( bool )
                {
                    sleep( waitTime );
                }
            }
            numBent = 0;
            for( int i = 0; i < aaa.size(); i++ )
            {
                numBent += ( aaa.get(i) ).size();
            }
            System.out.println( numBent + " 6-variable bent functions found.  Total time: " + ( System.nanoTime()/1000000000.0 - d1 ) );
        }
        catch( Exception e )
        {
            e.printStackTrace();
        }
    }

    public static byte[] wht( int word )
    {
        byte[] b = new byte[32];
        byte sum = 0;
        for( int i = 0; i < 32; i++ )
        {
            sum = 0;
            for( int j = 0; j < 32; j++ )
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
            s += ( bb + "  " );
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
        for(int y = 0; y < 32; y++)
        {
            sum = 0;
            for(int x = 0; x < 32; x++)
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
        Algorithm a = new Algorithm( 2, 15 );
        a.run();
    }
}