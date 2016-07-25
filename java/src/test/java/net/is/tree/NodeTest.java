package net.is.tree;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

public class NodeTest extends TestCase {
    public NodeTest( String testName ) {
        super( testName );
    }

    public static Test suite() {
        return new TestSuite( NodeTest.class );
    }

    public void testApp() {
        assertTrue( true );
    }
}
