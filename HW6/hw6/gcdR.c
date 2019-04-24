#include <stdio.h>


/* Download and compile gcdR.c to assembly code on your machine: 
 * 1 -- Use the command gcc -S gcdR.c
 * 2 -- Use the command gcc -O2 -S gcdR.c
 */

/*
Definition of gcd:

   gcd of A B
         is A if B = 0
         is gcd B (mod A B)
*/

int gcdR (int i, int j){
   if (j==0){
      return i;
   } else {
      return gcdR( j, i%j);
   }
}

    
        
