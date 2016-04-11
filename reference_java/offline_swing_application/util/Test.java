package autopay.util;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;

public class Test {
 public static void main(String[] args){
	 
	 String s1 = "12345";
      char[] pas = s1.toCharArray();
	 
	 try {
		String inputtedPW = Cryptography.hash(pas);
		System.out.println(inputtedPW);
	} catch (NoSuchAlgorithmException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (UnsupportedEncodingException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	 
	 
 }
}
