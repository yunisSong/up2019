import com.sun.org.apache.bcel.internal.generic.NOP;

class Solution {
    public boolean judgeCircle(String moves) {
        int leftRight = 0;
        int upDown = 0;
        for (int i = 0; i < moves.length(); i++) {
            char item = moves.charAt(i);
            if (item == 'R') {
               leftRight += 1; 
            }else if (item == 'L') {
               leftRight -= 1; 
            } else if (item == 'U') {
                upDown += 1;
            } else if (item == 'D') {
                upDown -= 1;
            }
        }
        if (upDown == 0 && leftRight == 0) {
            return true;
        }

        return false;
        
    }
}