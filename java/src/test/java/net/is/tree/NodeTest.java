package net.is.tree;

import java.util.ArrayList;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

public class NodeTest extends TestCase {

    public Node root;
    public ArrayList<Integer> expected = new ArrayList<Integer>();

    public void testSearch() {
    }


    public void testCollect() {
      /*
        expected.add(7);
        expected.add(11);
        expected.add(13);
        assertEquals(expected.size(), 3);

        Node root = new Node(11);
        Node n7 = new Node(7);
        Node n13 = new Node(13);
        root.insert(n7);
        root.insert(n13);
        */

        ArrayList<Integer> actual = new ArrayList<Integer>();
        // assert_equals(root.collect(actual), expected);
    }

    public void testSize() {
        Node root = new Node(11);
        //assertEquals(1, root.size());

        Node left = new Node(3);
        root.insert(left);
        //assertEquals(2, root.size());

        Node right = new Node(21);
        root.insert(right);
        //assertEquals(3, root.size());

        Node n7 = new Node(7);
        root.insert(n7);
        //assertEquals(3, root.size());

        Node n5 = new Node(5);
        root.insert(n5);
        //assertEquals(3, root.size());

        Node n13 = new Node(13);
        root.insert(n13);
        //assertEquals(3, root.size());

        Node n17 = new Node(17);
        root.insert(n17);
        //assertEquals(3, root.size());
    }

    public void testInsert() {
        Node root = new Node(11);
        assertEquals(11, root.value);

        Node left = new Node(3);
        Node right = new Node(21);
        root.insert(left);
        root.insert(right);
        assertEquals(right, root.right);
        assertEquals(left, root.left);

        Node n7 = new Node(7);
        Node n5 = new Node(5);
        root.insert(n7);
        root.insert(n5);
        assertEquals(root.left.right, n7);
        assertEquals(root.left.right.left, n5);

        Node n13 = new Node(13);
        Node n17 = new Node(17);
        root.insert(n13);
        root.insert(n17);
        assertEquals(root.right.left, n13);
        assertEquals(root.right.left.right, n17);
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
