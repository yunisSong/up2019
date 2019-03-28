import java.util.Arrays;


public class Solution {

    public static void main(String[] args) {
     
        Solution s = new Solution();
        int []t = {-5,1,2,4,7,10};
        int []b = s.sortedSquares(t);
        System.out.println(Arrays.toString(b));

    }

    public int[] sortedSquares(int[] A) {

        int [] b = new int[A.length];
        int begin = 0;
        int end = A.length - 1;
        int index = A.length - 1;

        for (int i = 0;i <A.length;i++)
        {
            if (Solution.sy_abs(A[begin]) < Solution.sy_abs(A[end])) {
                b[index] = A[end] * A[end]; 
                end-=1;
            }else
            {
                b[index] = A[begin] * A[begin];
                begin+=1;
            }
            index-=1;
        }
 
        return b;
    }

    static  int sy_abs(int a) {
        return a>0?a:-a;
    }
}