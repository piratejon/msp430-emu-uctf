#include "emu.h"

void
loadromfile(char * romfname) {
  size_t rd, idx;
  FILE *romfile;

  romfile = fopen(romfname, "rb");
  ASSERT(romfile, "fopen");

  idx = 0;
  while (true) {
    rd = fread(&memory[idx], 1, sizeof(memory) - idx, romfile);
    if (rd == 0)
      break;
    idx += rd;
  }
  // printf("Loaded %zu words from image.\n", idx/2);

  fclose(romfile);
}


