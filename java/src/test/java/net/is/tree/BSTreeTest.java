package net.is.tree;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

public class BSTreeTest extends TestCase {

    public void testInsert() {
        Node root = new Node(11);
        BSTree tree = new BSTree(root);
        assertEquals(11, tree.root.value);

        Node left = new Node(7);
        Node right = new Node(13);
        tree.insert(left);
        tree.insert(right);
        assertEquals(left, tree.root.left);
        assertEquals(right, tree.root.right);

        Node node5 = new Node(5);
        Node node19 = new Node(19);
        tree.insert(node5);
        tree.insert(node19);
        assertEquals(node5, tree.root.left.left);
        assertEquals(node19, tree.root.right.right);
    }

    public void testInstantiation() {
      Node root = new Node(11);
      BSTree tree = new BSTree(root);
      assertEquals(11, tree.root.value);
    }

    public BSTreeTest( String testName ) {
        super( testName );
    }

    public static Test suite() {
        return new TestSuite( BSTreeTest.class );
    }

    public void testBSTree() {
        assertTrue( true );
    }
}
