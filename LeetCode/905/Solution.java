class Solution {
    public int[] sortArrayByParity(int[] A) {
        int i = 0;
        int j = A.length - 1;

        while (i<j) {
            int left = A[i];
            int right = A[j];
            if (left %2 == 0) {
                i += 1;   
            }else
            {
                if (right % 2 != 0) {
                    j -= 1;
                } else {
                    int temp = A[i];
                    A[i] = A[j];
                    A[j] = temp;
                }
            }
        }
        return A;
    }
}