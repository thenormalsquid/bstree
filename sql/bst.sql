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

-- With UNION ALL
WITH RECURSIVE
  dfs(label, level) AS (
    VALUES('root', 0)
    UNION ALL
    SELECT bst.label, dfs.level+1
      FROM bst JOIN dfs ON bst.parent=dfs.label
      ORDER BY 2 -- DESC
    )
    SELECT substr('..........',1, level*3) || label FROM dfs;

-- Without UNION ALL
WITH RECURSIVE
  dfs(label, level) AS (
    VALUES('root', 0)
    UNION
    SELECT bst.label, dfs.level+1
      FROM bst JOIN dfs ON bst.parent=dfs.label
      ORDER BY 2 DESC
    )
    SELECT substr('..........',1, level*3) || label FROM dfs;


WITH RECURSIVE
  dfs(label, level) AS (
    VALUES('root', 0)
    UNION
    SELECT bst.label, dfs.level+1
      FROM bst JOIN dfs ON bst.parent=dfs.label
      ORDER BY 2 DESC
    )
    SELECT substr('..........',1, level*3) || label,level FROM dfs;


-- find
SELECT value FROM bst WHERE value = 7;

-- present?
SELECT DISTINCT 1 from bst where value = 7;
SELECT DISTINCT 1 from bst where value = 700;

-- maximum
SELECT * FROM bst ORDER BY value DESC LIMIT 1;

-- minimum
SELECT * FROM bst ORDER BY value ASC LIMIT 1;

-- SELECT * FROM bst WHERE value
