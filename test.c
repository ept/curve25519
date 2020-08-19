#include <stdio.h>
#define FOR(i,n) for (i = 0;i < n;++i)
#define sv static void

typedef long long i64;
typedef i64 gf[16];

sv car25519(gf o)
{
  int i;
  i64 c;
  FOR(i,16) {
    o[i]+=(1LL<<16);
    c=o[i]>>16;
    o[(i+1)*(i<15)]+=c-1+37*(c-1)*(i==15);
    o[i]-=c<<16;
  }
}

sv simplified(gf o)
{
  int i;
  i64 c;
  FOR(i,16) {
    c=o[i]>>16;
    o[(i+1)*(i<15)]+=c+37*c*(i==15);
    o[i]-=c<<16;
  }
}


int main(int argc, char **argv) {
    gf val = {0x10, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff, 0xfffffffff};
    gf val2;
    for (int i = 0; i < 16; i++) val2[i] = val[i];
    car25519(val);
    car25519(val);
    simplified(val2);
    simplified(val2);
    for (int i = 0; i < 16; i++) printf("%lld ", val[i]);
    printf("\n");
    for (int i = 0; i < 16; i++) printf("%lld ", val2[i]);
    printf("\n");
    //i64 x = -0x1000000LL;
    //printf("%llx\n", x - ((x >> 16) << 16));
    return 0;
}
