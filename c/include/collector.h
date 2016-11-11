#ifndef IS_BST_COLLECTOR_H
#define IS_BST_COLLECTOR_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stddef.h>

#include "node.h"

typedef struct _collector Collector;

/* probably need to move this to it's own file.
 * what it needs to do:
 * 1. test that it instantiates, easy.
 * 2. test the callback hook up for executing.
 * 3. need an array testing method, this can go into testutils.
 *
 * We want to collect all the values into an array, but this is
 * really hard to do recursively.
 *
 * Another way to do this might be to create a pseudo-closure similar
 * to how `size` was implemented.
 */
typedef struct _collector Collector;

typedef void (*Executor)(Collector collector);

/* Replace State with this in node_collect. */
struct _collector {
  int size;
  int current_position;
  int * values;
  int height;
  Node * n;
  Executor execute;
};

int collector_equals         (Collector * c1,
                              Collector * c2);

void collector_add           (Collector * c,
                              int value);

void collector_add_int_array (Collector * c,
                              int values[]);

Collector * collector_new    (size_t size);

void collector_destroy       (Collector * c);

void collector_printf        (Collector * c);

void collector_reset         (Collector * c);

#ifdef __cplusplus
}
#endif

#endif /* IS_BST_COLLECTOR_H */
