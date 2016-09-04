package net.is.tree;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import static java.util.Arrays.asList;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

public class NodeTest extends TestCase {

    public Node root;
    public ArrayList<Integer> expected = new ArrayList<Integer>();

    public void testSuccessor() {
        Node root = new Node(17);
        assertEquals(root, root.successor(root));

        Node n23 = new Node(23);
        root.insert(n23);
        assertEquals(n23, root.successor(root));
        assertEquals(n23, root.successor(n23));

        Node n29 = new Node(29);
        root.insert(n29);
        assertEquals(n29, root.successor(n23));
        assertEquals(n29, n23.successor(n23));
        assertEquals(n29, n29.successor(n29));

        Node n19 = new Node(19);
        root.insert(n19);
        assertEquals(n23, root.successor(n19));

        Node n2 = new Node(2);
        Node n3 = new Node(3);
        Node n5 = new Node(5);
        Node n7 = new Node(7);
        Node n11 = new Node(11);
        Node n13 = new Node(13);
        root.insert(n5);
        root.insert(n3);
        root.insert(n2);
        assertEquals(n3, root.successor(n2));
        assertEquals(n5, root.successor(n3));

        root.insert(n7);
        root.insert(n11);
        root.insert(n13);
        assertEquals(n7, root.successor(n5));
        assertEquals(n11, root.successor(n7));
        assertEquals(n13, root.successor(n11));
        assertEquals(root, root.successor(n13));
    }

    public void testSearch() {
        Node root = new Node(11);
        assertEquals(root, root.search(11));
        assertEquals(true, root.is_present(11));

        Node n3 = new Node(3);
        Node n21 = new Node(21);
        root.insert(n3);
        root.insert(n21);
        assertEquals(n3, root.search(3));
        assertEquals(true, root.is_present(3));
        assertEquals(n21, root.search(21));
        assertEquals(true, root.is_present(21));

        Node n7 = new Node(7);
        Node n5 = new Node(5);
        root.insert(n7);
        root.insert(n5);
        assertEquals(n7, root.search(7));
        assertEquals(true, root.is_present(7));
        assertEquals(n5, root.search(5));
        assertEquals(true, root.is_present(5));

        Node n13 = new Node(13);
        Node n17 = new Node(17);
        root.insert(n17);
        root.insert(n13);
        assertEquals(n13, root.search(13));
        assertEquals(true, root.is_present(13));
        assertEquals(n17, root.search(17));
        assertEquals(true, root.is_present(17));

        assertEquals(false, root.is_present(-1));
        assertEquals(false, root.is_present(0));
        assertEquals(false, root.is_present(42));
    }

    public void testMaxAndMin() {
        Node root = new Node(11);
        assertEquals(root, root.maximum());
        assertEquals(root, root.minimum());

        Node n3 = new Node(3);
        root.insert(n3);
        assertEquals(root, root.maximum());
        assertEquals(n3, root.minimum());

        Node n21 = new Node(21);
        root.insert(n21);
        assertEquals(n21, root.maximum());
        assertEquals(n3, root.minimum());

        Node n7 = new Node(7);
        root.insert(n7);
        assertEquals(n21, root.maximum());
        assertEquals(n3, root.minimum());
        assertEquals(n7, n7.maximum());
        assertEquals(n7, n7.minimum());


        Node n5 = new Node(5);
        root.insert(n5);
        assertEquals(n7, n7.maximum());
        assertEquals(n5, n7.minimum());

        Node n17 = new Node(17);
        root.insert(n17);
        assertEquals(n21, n21.maximum());
        assertEquals(n17, n21.minimum());

        Node n13 = new Node(13);
        Node n19 = new Node(19);
        root.insert(n13);
        root.insert(n19);
        assertEquals(n19, n17.maximum());
        assertEquals(n13, n17.minimum());
    }

    public void testHeight() {
        Node root = new Node(11);
        assertEquals(0, root.height());

        Node n3 = new Node(3);
        root.insert(n3);
        assertEquals(1, root.height());
        assertEquals(0, n3.height());

        Node n21 = new Node(21);
        root.insert(n21);
        assertEquals(1, root.height());
        assertEquals(0, n21.height());

        Node n7 = new Node(7);
        root.insert(n7);
        assertEquals(2, root.height());

        Node n5 = new Node(5);
        root.insert(n5);
        assertEquals(3, root.height());

        Node n13 = new Node(13);
        root.insert(n13);
        assertEquals(3, root.height());

        Node n17 = new Node(17);
        root.insert(n17);
        assertEquals(3, root.height());
    }

    public void testCollectSingleNode() {
        ArrayList<Integer> expected = new ArrayList<Integer>();
        expected.add(11);
        Node root = new Node(11);
        ArrayList<Integer> actual = new ArrayList<Integer>();
        root.collect(actual);
        assertEquals(actual, expected);
    }

    public void testCollect() {
        ArrayList<Integer> expected = new ArrayList<Integer>();
        expected.add(7);
        expected.add(11);
        expected.add(13);
        assertEquals(expected.size(), 3);

        Node root = new Node(11);
        Node n7 = new Node(7);
        Node n13 = new Node(13);
        root.insert(n7);
        root.insert(n13);

        ArrayList<Integer> actual = new ArrayList<Integer>();
        root.collect(actual);
        assertEquals(actual, expected);
    }

    public void testSize() {
        Node root = new Node(11);
        assertEquals(1, root.size());

        Node left = new Node(3);
        root.insert(left);
        assertEquals(2, root.size());
        assertEquals(1, left.size());

        Node n21 = new Node(21);
        root.insert(n21);
        assertEquals(3, root.size());
        assertEquals(1, n21.size());

        Node n7 = new Node(7);
        root.insert(n7);
        assertEquals(4, root.size());
        assertEquals(2, left.size());

        Node n5 = new Node(5);
        root.insert(n5);
        assertEquals(5, root.size());

        Node n13 = new Node(13);
        root.insert(n13);
        assertEquals(6, root.size());

        Node n17 = new Node(17);
        root.insert(n17);
        assertEquals(7, root.size());
        assertEquals(3, n21.size());
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

    //public void testApp() {
    //    assertTrue( true );
    //}
}
