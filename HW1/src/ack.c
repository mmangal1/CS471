#include <stdio.h>

int ack(int m, int n){
	if(m == 0){
		return(n+1);
	}else if(n == 0 && m > 0){
		return ack(m-1, 1);
	}else if(n > 0 && m > 0){
		return ack(m-1, ack(m, n-1));
	}else{
		//shouldnt reach here
		return -1;
	}
}

int main(int argc, char **argv) {
  
  if (argc < 3) {
    printf("%s usage: [NUMBER] [NUMBER]\n", argv[0]);
    return 1;
  }
  int m = atoi(argv[1]);
  int n = atoi(argv[2]);
  int r = ack(m,n);
  printf("ACK(%d, %d) = %d\n", m, n, r);
  return 0;
}
