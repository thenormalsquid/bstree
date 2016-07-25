package net.is.tree;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

public class NodeTest extends TestCase {

    public Node root;

    public void testInsert() {
        Node root = new Node(11);
        assertEquals(11, root.value);

        Node left = new Node(7);
        Node right = new Node(13);
        root.insert(left);
        root.insert(right);

        assertEquals(left, root.left);
        assertEquals(right, root.right);
    }

    public void testInstantiation() {
        Node node = new Node(11);
        assertEquals(11, node.value);
        assertEquals(null, node.left);
        assertEquals(null, node.right);
    }

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
