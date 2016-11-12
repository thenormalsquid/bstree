package net.is.tree;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import static java.util.Arrays.asList;


import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

public class BSTreeTest extends TestCase {

    public void testIsBst() {
      BSTree tree = new BSTree();
      Node root = new Node(17);
      tree.insert(root);
      assertEquals(true, tree.is_bst());
    }

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

    public void testTransplant() {
        Node root = new Node(17);
        BSTree tree = new BSTree(root);
        tree.transplant(root, null);
        assertEquals(tree.root, null);


       /* transplant left child into root */
        root = new Node(17);
        tree = new BSTree(root);
        Node n5 = new Node(5);
        tree.insert(n5);
        tree.transplant(root, n5);
        assertEquals(n5.parent, null);
        assertEquals(tree.root, n5);

       /* transplant right child into root */
        root = new Node(17);
        tree = new BSTree(root);
        Node n23 = new Node(23);
        tree.insert(n23);
        tree.transplant(root, n23);
        assertEquals(n23.parent, null);
        assertEquals(tree.root, n23);

       /* transplant from left subtree */
        root = new Node(17);
        tree = new BSTree(root);
        n5 = new Node(5);
        Node n7 = new Node(7);
        tree.insert(n5);
        tree.insert(n7);
        tree.transplant(n5, n7);
        assertEquals(n7.parent, tree.root);
        assertEquals(tree.root.left, n7);

       /* transplant from right subtree */
        root = new Node(17);
        tree = new BSTree(root);
        n23 = new Node(23);
        Node n29 = new Node(29);
        tree.insert(n23);
        tree.insert(n29);
        tree.transplant(n23, n29);
        assertEquals(n29.parent, tree.root);
        assertEquals(tree.root.right, n29);
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

        Node root = new Node(17);
        BSTree tree = new BSTree(root);
        Node n2 = new Node(2);
        Node n3 = new Node(3);
        Node n5 = new Node(5);
        Node n7 = new Node(7);
        Node n11 = new Node(11);
        Node n13 = new Node(13);
        Node n19 = new Node(19);
        Node n23 = new Node(23);
        Node n29 = new Node(29);
        tree.insert(n5);
        tree.insert(n3);
        tree.insert(n2);
        tree.insert(n7);
        tree.insert(n11);
        tree.insert(n13);
        tree.insert(n23);
        tree.insert(n19);
        tree.insert(n29);

        tree.delete_node(11);
        assertEquals(n11.is_unlinked(), true);
        assertEquals(tree.size(), 9);
        assertEquals(n7.right, n13);
        assertEquals(n13.parent, n7);

        tree.delete_node(3);
        assertEquals(n3.is_unlinked(), true);
        assertEquals(tree.size(), 8);
        assertEquals(n5.left, n2);
        assertEquals(n2.parent, n5);

        tree.delete_node(5);
        assertEquals(tree.size(), 7);
        assertEquals(tree.root.left, n7);
        assertEquals(n7.parent, tree.root);
        assertEquals(n7.left, n2);
        assertEquals(n2.parent, n7);

        tree.delete_node(17);
        assertEquals(tree.size(), 6);
        assertEquals(tree.root, n19);
        assertEquals(tree.root.left, n7);
        assertEquals(n7.parent, tree.root);
        assertEquals(tree.root.right, n23);
        assertEquals(n23.parent, tree.root);

        tree.delete_node(7);
        assertEquals(tree.size(), 5);
        assertEquals(tree.root.left, n13);
        assertEquals(n13.parent, tree.root);
        assertEquals(n13.left, n2);
        assertEquals(n2.parent, n13);

        tree.delete_node(2);
        tree.delete_node(23);
        tree.delete_node(13);
        Node deleted = tree.delete_node(19);
        assertEquals(deleted, n19);
        assertEquals(tree.size(), 1);
        assertEquals(tree.root, n29);
        assertEquals(n29.is_unlinked(), true);

        tree.delete_node(29);
        assertEquals(tree.root, null);
        assertEquals(tree.size(), 0);
    }

    public void testlistKeys() {
        // empty list for empty tree
        BSTree tree = new BSTree();
        ArrayList<Integer> expected = new ArrayList<Integer>();
        ArrayList<Integer> actual = tree.list_keys();
        assertEquals(expected, actual);

        // returns result from root node list keys
        expected.clear();
        expected.add(17);
        Node root = new Node(17);
        tree.insert(root);
        actual = tree.list_keys();
        assertEquals(expected, actual);
    }

    public void testCollectEmptyTree() {
        ArrayList<Integer> expected = new ArrayList<Integer>();
        BSTree tree = new BSTree();
        ArrayList<Integer> actual = new ArrayList<Integer>();
        tree.collect(actual);
        assertEquals(expected, expected);
    }

    public void testCollectSingleNode() {
        ArrayList<Integer> expected = new ArrayList<Integer>();
        expected.add(11);
        Node root = new Node(11);
        BSTree tree = new BSTree(root);
        ArrayList<Integer> actual = new ArrayList<Integer>();
        tree.collect(actual);
        assertEquals(expected, actual);
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
        ArrayList<Integer> actual = new ArrayList<Integer>();
        tree.collect(actual);

        assertEquals(expected, actual);
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

        ArrayList<Integer> actual = new ArrayList<Integer>();
        tree.collect(actual);
        assertEquals(expected, actual);
    }

    public void testInsert() {
        Node root = new Node(11);
        BSTree tree = new BSTree(root);
        assertEquals(11, tree.root.key);

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
      assertEquals(11, tree.root.key);
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
