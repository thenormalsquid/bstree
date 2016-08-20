#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <collector.h>

int
collector_equals(Collector * c1, Collector * c2) {
  if (c1->size != c2->size) { return 0; }
  if (c1->current_position != c2->current_position) { return 0; }

  for (int i = 0; i<c1->current_position; i++) {
    if (c1->values[i] != c2->values[i]) {
      return 0;
    }
  }
  return 1;
}

void
collector_add(Collector * c, int value) {
  c->values[c->current_position] = value;
  c->current_position++;
}

Collector *
collector_new(size_t size) {
  Collector * c = (Collector *) malloc(sizeof(Collector));
  memset(c, 0xDA, sizeof(Collector));
  c->values = (int *) calloc(size, sizeof(int));
  c->size = size;
  c->current_position = 0;
  return c;
}

void
collector_destroy(Collector * c) {
  memset(c->values, 0xDD, sizeof(c->size));
  free(c->values);
  memset(c, 0xDD, sizeof(Collector));
  free(c);
}

void
collector_reset(Collector * c) {
  memset(c->values, 0, sizeof(int));
  c->current_position = 0;
}

void
collector_printf(Collector * c) {
  for (int i = 0; i<c->current_position; i++) {
    printf("%d ", c->values[i]);
  }
  printf("\n");
}


