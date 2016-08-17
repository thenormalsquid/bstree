package net.is.tree;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import static java.util.Arrays.asList;


import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

public class BSTreeTest extends TestCase {

    /*
     * find a null when empty
     * find the root node when only single tree
     * find a left child
     * find a right child
     */
    public void testSearch() {
        // Move this to instantiation test below
        BSTree tree = new BSTree();
        assertEquals(tree.root, null);

        Node root = new Node(11);
        tree.insert(root);
        assertEquals(tree.root, root);
        // assertEquals(tree.search(11), root);

        Node n3 = new Node(3);
        Node n21 = new Node(21);
        tree.insert(n3);
        tree.insert(n21);
        //assertEquals(tree.search(3), n3);
        //assertEquals(tree.search(21), n21);

        // find a leaf node left-right-left
        Node n7 = new Node(7);
        Node n5 = new Node(5);
        tree.insert(n7);
        tree.insert(n5);
        //assertEquals(tree.search(3), n3);

        // find a leaf node right-left-right
        Node n13 = new Node(13);
        Node n17 = new Node(17);
        tree.insert(n13);
        tree.insert(n17);
        //assertEquals(tree.search(17), n17);
    }

    public void testHeight() {
        BSTree tree = new BSTree();
        Node root = new Node(11);
        tree.insert(root);
        //assertEquals(9, tree.height());

        Node left = new Node(3);
        tree.insert(left);
        //assertEquals(9, tree.height());

        Node right = new Node(21);
        tree.insert(right);
        //assertEquals(9, tree.height());

        Node n7 = new Node(7);
        tree.insert(n7);
        //assertEquals(9, tree.height());

        Node n5 = new Node(5);
        tree.insert(n5);
        //assertEquals(9, tree.height());

        Node n13 = new Node(13);
        tree.insert(n13);
        //assertEquals(9, tree.height());

        Node n17 = new Node(17);
        tree.insert(n17);
        //assertEquals(9, tree.height());
    }


    public void testSize() {
        BSTree tree = new BSTree();
        assertEquals(0, tree.size());

        Node root = new Node(11);
        tree.insert(root);
        //assertEquals(1, tree.size());

        Node left = new Node(3);
        tree.insert(left);
        //assertEquals(2, tree.size());

        Node right = new Node(21);
        tree.insert(right);
        //assertEquals(3, tree.size());

        Node n7 = new Node(7);
        tree.insert(n7);
        //assertEquals(3, tree.size());

        Node n5 = new Node(5);
        tree.insert(n5);
        //assertEquals(3, tree.size());

        Node n13 = new Node(13);
        tree.insert(n13);
        //assertEquals(3, tree.size());

        Node n17 = new Node(17);
        tree.insert(n17);
        //assertEquals(3, tree.size());
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


    // TODO:
    // * test for empty tree
    // * test for single node
    // * test for duplicates
    public void testCollect() {
        // List<Integer> expected = Arrays.asList(2, 3, 5, 7, 11, 13, 19);
        ArrayList<Integer> expected = new ArrayList<Integer>();

        expected.add(7);
        expected.add(11);
        expected.add(13);
        assertEquals(expected.size(), 3);

        Node root = new Node(11);
        BSTree tree = new BSTree(root);
        Node n7 = new Node(7);
        Node n13 = new Node(13);
        tree.insert(n7);
        tree.insert(n13);

        // List<Integer> actual = Arrays.asList();
        // ArrayList<Integer> actual = new ArrayList<Integer>();
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
