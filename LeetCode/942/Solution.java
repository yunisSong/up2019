import sun.security.util.Length;

class Solution {
    public int[] diStringMatch(String S) {
        int length = S.length();
        int max = length;
        int min = 0;
        int[] result = new int[length + 1];
        for (int i = 0; i < length; i++) {
            char b = S.charAt(i);
            if (b == 'D') {
                result[i] = max;
                max--;
            } else {
                result[i] = min;
                min++;
            }
        }
        result[length] = min;
        return result;
    }
}