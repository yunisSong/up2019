import java.util.*;

class Solution {
    public int calPoints(String[] ops) {
        List<String> list = new ArrayList<String>();
        int sum = 0;
        for (int i = 0; i < ops.length; i++) {
            String item = ops[i];
            if (item.equals("+")) {
                String i1 = list.get(list.size() - 1);
                String i2 = list.get(list.size() - 2);

                int i3 = Integer.parseInt(i1) + Integer.parseInt(i2);
                list.add(String.valueOf(i3));
            }else if (item.equals("C")) {
                list.remove(list.size() - 1);
            }else if (item.equals("D")) {
                String i1 = list.get(list.size() - 1);
                int i2 = Integer.parseInt(i1) * 2;
                list.add(String.valueOf(i2));
            }else {
                list.add(item);
            }
        }
        for (String item : list) {
            int i3 = Integer.parseInt(item);
            sum += i3;
        }
        return sum;
    }

    
}
