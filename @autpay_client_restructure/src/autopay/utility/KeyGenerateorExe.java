package autopay.utility;

import static autopay.util.Cryptography.ALGORITHM;

import java.security.NoSuchAlgorithmException;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import sun.misc.BASE64Encoder;
import javax.swing.*;

/**
 * 
 * @author Francisco Lo BB14PGM
 * @since 27/10/2010
 * 
 * Class to Generate a Key with the algorithm provided in AutoPay.util.Cryptography class,
 * and which the key should then hard coded in AutoPay.util.Cryptography class.
 */

public class KeyGenerateorExe {
	
	public static void main(String[] args) {
		try {
			KeyGenerator kg = KeyGenerator.getInstance(ALGORITHM);
			kg.init(128);	//128bits key size
			SecretKey key = kg.generateKey();
			byte[] genKey = key.getEncoded();
			
			JLabel lbl = new JLabel("Generated Key :");
			JTextField txt = new JTextField(new BASE64Encoder().encode(genKey));
		    JOptionPane.showMessageDialog(null, new Object[]{lbl, txt}, "Generate Key exe", 
		    		JOptionPane.INFORMATION_MESSAGE);
		    
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		System.exit(0);
	}
}
