DROP TABLE IF EXISTS bst;

CREATE TABLE bst(
  label TEXT PRIMARY KEY,
  value INT,
  parent TEXT REFERENCES bst,
  left TEXT REFERENCES bst,
  right TEXT REFERENCES bst
) WITHOUT ROWID;

INSERT INTO bst VALUES('root', 11, NULL, 'node5', 'node17');
INSERT INTO bst VALUES('node5', 5, 'root', 'node3', 'node7');
INSERT INTO bst VALUES('node3', 3, 'node5', NULL, NULL);
INSERT INTO bst VALUES('node7', 7, 'node5', NULL, NULL);
INSERT INTO bst VALUES('node17', 17, 'root', 'node13', 'node19');
INSERT INTO bst VALUES('node13', 13, 'node17', NULL, NULL);
INSERT INTO bst VALUES('node19', 19, 'node17', NULL, NULL);


SELECT 'With UNION ALL';
WITH RECURSIVE
  dfs(label, level) AS (
    VALUES('root', 0)
    UNION ALL
    SELECT bst.label, dfs.level+1
      FROM bst JOIN dfs ON bst.parent=dfs.label
      ORDER BY 2 -- DESC
    )
    SELECT substr('..........',1, level*3) || label FROM dfs;


select 'Without UNION ALL';
WITH RECURSIVE
  dfs(label, level) AS (
    VALUES('root', 0)
    UNION
    SELECT bst.label, dfs.level+1
      FROM bst JOIN dfs ON bst.parent=dfs.label
      ORDER BY 2 DESC
    )
    SELECT substr('..........',1, level*3) || label FROM dfs;


SELECT 'Attempt to find common parent';
-- This is actually not trivial.
WITH RECURSIVE
  dfs(label1, label2, level) AS (
    -- VALUES('root', 'node19', 0)
    VALUES('node3', 'node19', 0)
    UNION
    SELECT bst.label, bst.label, dfs.level+1
      FROM bst JOIN dfs ON bst.parent=dfs.label1 AND bst.parent=dfs.label2
      ORDER BY 2 DESC
    )
    SELECT substr('..........',1, level*3) || label2,level FROM dfs;


-- These are all relatively trivial
-- find
-- SELECT value FROM bst WHERE value = 7;

-- present?
-- SELECT DISTINCT 1 from bst where value = 7;
-- SELECT DISTINCT 1 from bst where value = 700;

-- maximum
-- SELECT * FROM bst ORDER BY value DESC LIMIT 1;

-- minimum
-- SELECT * FROM bst ORDER BY value ASC LIMIT 1;

-- size
-- SELECT 'size of tree'
-- SELECT count(*) from bst;

-- SELECT 'collect ascending';
-- SELECT value FROM bst ORDER BY value ASC;
