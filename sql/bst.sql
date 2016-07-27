DROP TABLE IF EXISTS bst;

CREATE TABLE bst(
  label TEXT PRIMARY KEY,
  value INT,
  parent TEXT REFERENCES bst,
  left TEXT REFERENCES bst,
  right TEXT REFERENCES bst
) WITHOUT ROWID;

INSERT INTO bst VALUES('root', 11, NULL, 'node5', 'node17');
INSERT INTO bst VALUES('node5', 5, 'root', NULL, 'node7');
INSERT INTO bst VALUES('node7', 7, 'node5', NULL, NULL);
INSERT INTO bst VALUES('node17', 17, 'root', NULL, NULL);

WITH RECURSIVE
  dfs(label, level) AS (
    VALUES('root', 0)
    UNION ALL
    SELECT bst.label, dfs.level+1
      FROM bst JOIN dfs ON bst.parent=dfs.label
      ORDER BY 2 DESC
    )
    SELECT substr('..........',1, level*3) || label FROM dfs;


-- find
SELECT value FROM bst WHERE value = 7;

-- present?
SELECT DISTINCT 1 from bst where value = 7;
SELECT DISTINCT 1 from bst where value = 700;
