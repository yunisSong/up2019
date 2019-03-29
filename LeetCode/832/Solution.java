class Solution {
    public int[][] flipAndInvertImage(int[][] A) {
        for (int i = 0; i < A.length; i++) {
            int [] B = A[i];
            int length = B.length;
            int [] temp = new int[length];
            for (int j = 0; j < length; j++) {
                // int element = (B[j] - 1) * -1;
                int element = 1 - B[j] ;
                temp[length-j-1] = element;

            }
            A[i] = temp;

        }

        return A;
    }
}