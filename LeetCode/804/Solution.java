import com.sun.java.util.jar.pack.ConstantPool.Index;

class Solution {
    public int uniqueMorseRepresentations(String[] words) {

        String[] m = { ".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "..", ".---", "-.-", ".-..", "--",
                "-.", "---", ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", "-.--", "--.." };

        Map<String, String> resultmap = new HashMap<>();

        for (int i = 0; i < words.length; i++) {
            String word = words[i];
            String result = "";
            for (int j = 0; j < word.length(); j++) {
                char c = word.charAt(j);
                int index = c - 'a';
                String asc = m[index];
                result += asc;
            }

            resultmap.put(result, "1");

        }
        return resultmap.size();



        HashSet<String> set = new HashSet<String>();
        for (String s : words) {
            StringBuilder sb = new StringBuilder();
            for (char c : s.toCharArray()) {
                sb.append(m[c - 'a']);
            }
            set.add(sb.toString());
        }
        return set.size();

    }
}