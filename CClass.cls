public class CClass {
    public static Map<String, Integer> countLetter(String s) {
        Map<String, Integer> count = new Map<String, Integer>();
        String[] substr = s.split('');
        for(String letter: substr) {
            if(!count.containsKey(letter)) {
                count.put(letter, 1);
            } else {
                Integer buf = count.get(letter) + 1;
                count.put(letter, buf);
            }
        }
        return count;
    }
}