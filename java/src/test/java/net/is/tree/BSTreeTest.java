package net.is.tree;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import static java.util.Arrays.asList;


import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

public class BSTreeTest extends TestCase {

    public void testPredecessor() {
      BSTree tree = new BSTree();
      Node root = new Node(17);
      tree.insert(root);
      assertEquals(root, tree.predecessor(root));
    }

    public void testSuccessor() {
        BSTree tree = new BSTree();
        Node root = new Node(11);
        tree.insert(root);
        assertEquals(root, tree.successor(root));
    }

    /*
     * Also tests `is_present()`
     */
    public void testSearch() {
        BSTree tree = new BSTree();

        Node root = new Node(11);
        tree.insert(root);
        assertEquals(root, tree.search(11));
        assertEquals(true, tree.is_present(11));

        Node n3 = new Node(3);
        Node n21 = new Node(21);
        tree.insert(n3);
        tree.insert(n21);
        assertEquals(n3, tree.search(3));
        assertEquals(true, tree.is_present(3));
        assertEquals(n21, tree.search(21));
        assertEquals(true, tree.is_present(21));

        // find a leaf node left-right-left
        Node n7 = new Node(7);
        Node n5 = new Node(5);
        tree.insert(n7);
        tree.insert(n5);
        assertEquals(n5, tree.search(5));
        assertEquals(true, tree.is_present(5));
        assertEquals(n7, tree.search(7));
        assertEquals(true, tree.is_present(7));

        // find a leaf node right-left-right
        Node n13 = new Node(13);
        Node n17 = new Node(17);
        tree.insert(n13);
        tree.insert(n17);
        assertEquals(n13, tree.search(13));
        assertEquals(true, tree.is_present(13));
        assertEquals(n17, tree.search(17));
        assertEquals(true, tree.is_present(17));

        assertEquals(false, tree.is_present(-1));
        assertEquals(false, tree.is_present(0));
        assertEquals(false, tree.is_present(42));
    }

    public void testHeight() {
        BSTree tree = new BSTree();
        Node root = new Node(11);
        tree.insert(root);
        assertEquals(0, tree.height());

        Node left = new Node(3);
        tree.insert(left);
        assertEquals(1, tree.height());

        Node right = new Node(21);
        tree.insert(right);
        assertEquals(1, tree.height());

        Node n7 = new Node(7);
        tree.insert(n7);
        assertEquals(2, tree.height());
    }


    public void testMaxAndMin() {
        BSTree tree = new BSTree();
        assertEquals(null, tree.maximum());
        assertEquals(null, tree.minimum());

        Node root = new Node(11);
        tree.insert(root);
        assertEquals(root, tree.maximum());
        assertEquals(root, tree.minimum());
    }

    public void testSize() {
        BSTree tree = new BSTree();
        assertEquals(0, tree.size());

        Node root = new Node(11);
        tree.insert(root);
        assertEquals(1, tree.size());

        Node left = new Node(3);
        tree.insert(left);
        assertEquals(2, tree.size());

        Node right = new Node(21);
        tree.insert(right);
        assertEquals(3, tree.size());

        Node n7 = new Node(7);
        tree.insert(n7);
        assertEquals(4, tree.size());
    }

    public void testIsBst() {
      // handy check to ensure that delete works correctly.
    }

    /*
     * do not delete anything when empty
     * delete the root node when only single tree
     * delete a left child
     * delete a right child
     * delete a leaf node left-right-left
     * delete a leaf node right-left-right
     * delete an interior node left-right
     * delete an interior node right left
     */
    public void testDelete() {
      // after each delete, search to ensure node cannot be found
      // and check that the size of the tree is reduced, and check
      // that it's still a binary search tree with `is_bst()`.
      // Also check that the left and right child links are pointing
      // to the correct children.
    }

    public void testCollectEmptyTree() {
        ArrayList<Integer> expected = new ArrayList<Integer>();
        BSTree tree = new BSTree();
        assertEquals(tree.collect(), expected);
    }

    public void testCollectSingleNode() {
        ArrayList<Integer> expected = new ArrayList<Integer>();
        expected.add(11);
        Node root = new Node(11);
        BSTree tree = new BSTree(root);
        assertEquals(tree.collect(), expected);
    }

    public void testCollect3() {
        ArrayList<Integer> expected = new ArrayList<Integer>();
        expected.add(7);
        expected.add(11);
        expected.add(13);

        Node root = new Node(11);
        BSTree tree = new BSTree(root);
        Node n7 = new Node(7);
        Node n13 = new Node(13);
        tree.insert(n7);
        tree.insert(n13);

        assertEquals(tree.collect(), expected);
    }

    // TODO:
    // * test for duplicates
    public void testCollect10() {
        ArrayList<Integer> expected = new ArrayList<Integer>();
        expected.add(2);
        expected.add(3);
        expected.add(5);
        expected.add(7);
        expected.add(11);
        expected.add(13);
        expected.add(17);
        expected.add(19);
        expected.add(23);
        expected.add(29);

        Node root = new Node(11);
        BSTree tree = new BSTree(root);
        Node n2 = new Node(2);
        Node n3 = new Node(3);
        Node n5 = new Node(5);
        Node n7 = new Node(7);
        Node n13 = new Node(13);
        Node n17 = new Node(17);
        Node n19 = new Node(19);
        Node n23 = new Node(23);
        Node n29 = new Node(29);
        tree.insert(n7);
        tree.insert(n23);
        tree.insert(n3);
        tree.insert(n5);
        tree.insert(n2);
        tree.insert(n29);
        tree.insert(n19);
        tree.insert(n17);
        tree.insert(n13);

        assertEquals(tree.collect(), expected);
    }

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
