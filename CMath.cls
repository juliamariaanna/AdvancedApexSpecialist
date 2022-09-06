public class CMath {
    public static integer factorial(integer n) {
        integer res = 1;
        for(integer i = n; i > 0; --i) {
            res *= i;
        }
        return res;
    }
}