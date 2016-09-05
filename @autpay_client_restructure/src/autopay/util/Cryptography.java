package autopay.util;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.*;
import java.security.spec.AlgorithmParameterSpec;
import javax.crypto.*;
import javax.crypto.spec.*;
import sun.misc.BASE64Encoder;
import sun.misc.BASE64Decoder;

/**
 * Encrypt and Decrypt any pass in value.
 * The iv factor must not exceed the length of 18 characters without the symbol '='.
 * 
 * @author Francisco Lo BB14PGM
 * @since 27/10/2010
 * 
 */

public class Cryptography {

	public static final String ALGORITHM = "AES";
	public static final String CHARSET = "UTF-8";
	private static final String HASH_METHOD = "MD5";
	private static final String PADDING = "AES/CBC/PKCS5Padding";
	
	/*
	 * Key for encrypt and decrypt, please change this key by using KeyGenerateorExe.jar only
	 * It may lead to problem if not doing so.
	 */
	private static final String KEY = "7EHlXl9Un2ILyuoC7HP/sw==";
	
	/*
	 * This is part of the IV for encrypt and decrypt, it must concat with part 1 to 
	 * form a full IV. This part must not exceed 10 characters long without symbol '='.
	 */
	private static final String IV_PART2 = "@BCM";
	
	private BASE64Decoder decoder64;
	private Cipher encrypt;
	private Cipher decrypt;
	
	public Cryptography() 
			throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException,
					InvalidAlgorithmParameterException, IOException { 
		this("");
	}
	
	//iv must not exceed 18 characters long and without the symbol '='
	public Cryptography(String iv_part1) 
			throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException,
					InvalidAlgorithmParameterException, IOException { 
		
		//Total of 22 characters for one whole IV factor
		String iv = iv_part1 + IV_PART2;
		//pad zero to the right of iv if its length is not equal to 22
		if(iv.length() < 22) {
			StringBuffer sb = new StringBuffer(iv);
			int padLength = 22 - iv.length();
			for(int i=0; i<padLength; i++) {
				sb.append("0");
			}
			iv = sb.toString();
		}
		
		decoder64 = new BASE64Decoder();
		AlgorithmParameterSpec paramSpec = 
			new IvParameterSpec(decoder64.decodeBuffer(iv + "=="));
		SecretKeySpec keySpec = new SecretKeySpec(decoder64.decodeBuffer(KEY), ALGORITHM);
		
		encrypt = Cipher.getInstance(PADDING);
		encrypt.init(Cipher.ENCRYPT_MODE, keySpec, paramSpec);
		decrypt = Cipher.getInstance(PADDING);
		decrypt.init(Cipher.DECRYPT_MODE, keySpec, paramSpec);
	}
	
	public String encrypt(int plain) throws IllegalBlockSizeException, 
					BadPaddingException, IOException{
		return encrypt(String.valueOf(plain));
	}
	
	public String encrypt(double plain) throws IllegalBlockSizeException, 
					BadPaddingException, IOException{
		return encrypt(String.valueOf(plain));
	}
	
	public String encrypt(float plain) throws IllegalBlockSizeException, 
					BadPaddingException, IOException{
		return encrypt(String.valueOf(plain));
	}
	
	public String encrypt(String plainText) throws IllegalBlockSizeException, 
					BadPaddingException, IOException {
        byte[] b = encrypt.doFinal(plainText.getBytes(CHARSET));
        String enc = new BASE64Encoder().encodeBuffer(b);
        
        //remove any "new-line" character
        StringBuffer sb = new StringBuffer(enc);
        int index;
        while ((index = sb.indexOf("\n")) != -1) {
        	if(index < sb.length()-1) {
        		sb.delete(index-1, index+1);
        	} else break;	//if it is appear at the end
        }
        return sb.toString();
	}
	
	public String decrypt(String cipherText) throws IllegalBlockSizeException, 
					BadPaddingException, IOException {
		byte[] dec = decrypt.doFinal(decoder64.decodeBuffer(cipherText));
        return new String(dec, CHARSET);
	}
	
	
	/*
	 * Static class
	 */
	
	public static String hash(char[] password) throws NoSuchAlgorithmException, 
					UnsupportedEncodingException {
		StringBuffer pw = new StringBuffer();
		pw.append(password);
		password = null;
		
		//Hash the password
		MessageDigest md = MessageDigest.getInstance(HASH_METHOD) ;
		md.update(pw.toString().getBytes(CHARSET)) ;
		byte[] digest = md.digest();
		
		//re-format the byte array to string
		pw.delete(0, pw.length());
		for(int i=0 ; i<digest.length; i++)
			pw.append(digest[i]);
		
		return pw.toString();
	}
}
