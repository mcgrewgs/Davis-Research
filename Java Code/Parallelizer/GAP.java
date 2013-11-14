import java.io.*;
import java.util.*;

/**
 * This program is designed to read in one GAP Program, 0.txt, which is intended for parallelization and uses numThreads and threadId, and write out
 * a number of programs equal to the int numThreads delcared in this program's main method, designed to be run in parallel.
 * @author Gavin McGrew
 * @version October 13, 2013
 */
public class GAP
{
    public static void main( String[] args )
    {
        try
        {
            Scanner s = null;
            BufferedWriter b = null;
            String st = "";
            int numThreads = 8;
            for( int i = 1; i <= numThreads; i++ )
            {
                s = new Scanner( new File( "0.txt" ) );
                b = new BufferedWriter( new FileWriter( "" + i + ".g") );
                while( s.hasNextLine() )
                {
                    st = s.nextLine();
                    if( st.equals( "numThreads := 1;" ) )
                    {
                        b.write("numThreads := " + numThreads + ";" );
                        b.newLine();
                    }
                    else if( st.equals( "threadId := 1;" ) )
                    {
                        b.write("threadId := " + i + ";" );
                        b.newLine();
                    }
                    else
                    {
                        b.write(st);
                        b.newLine();
                    }
                }
                s.close();
                b.close();
            }
        }
        catch( Exception e )
        {
            e.printStackTrace();
        }
    }
}