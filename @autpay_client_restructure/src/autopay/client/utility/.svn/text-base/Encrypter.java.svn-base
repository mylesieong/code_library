package autopay.client.utility;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JOptionPane;

import autopay.util.Cryptography;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

public class Encrypter {
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		try {			
			final JFileChooser fch = new JFileChooser();
			JButton btn = new JButton("Choose File...");
			btn.addActionListener(new ActionListener() {
				
				public void actionPerformed(ActionEvent a) {
					int option = fch.showOpenDialog(null);
					if(option == JFileChooser.APPROVE_OPTION) {
						File file = new File(fch.getSelectedFile().getPath());
						if(file.exists()) {
							try {
								encrypt(file);
							} catch (IOException e) {
								JOptionPane.showMessageDialog(null, "File not found.", null, JOptionPane.ERROR_MESSAGE);
								e.printStackTrace();
							} catch (Exception e) {
								JOptionPane.showMessageDialog(null, "File encrypt unsuccessfully!!\n"+e.getMessage(), null, JOptionPane.ERROR_MESSAGE);
								e.printStackTrace();
							} 
						}
					}
				}

				private void encrypt(File fileFr) throws IOException, InvalidKeyException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
					String path = fileFr.getPath();
					File fileFr2 = new File(fileFr.getParent() + "\\" + fileFr.getName() + "#bk");
					if(fileFr.renameTo(fileFr2)) {
						File fileTo = new File(path);
						BufferedReader reader = new BufferedReader(new FileReader(fileFr2));
						BufferedWriter writer = new BufferedWriter(new FileWriter(fileTo));
						
						Cryptography c = new Cryptography();	
						String key = reader.readLine();
						key = key.substring(1, 5).concat(key.substring(5, 13));
						writer.write(c.encrypt(key));
			
						c = new Cryptography(key);
						key = null;
						
						String line;
						while((line = reader.readLine()) != null) {
							writer.write(c.encrypt(line));
						}
						writer.close();
						reader.close();
						
						fileFr2.delete();
						JOptionPane.showMessageDialog(null, "File encrypted successfully.");
					} else {
						throw new IOException();
					}
				}
			});
			
		    JOptionPane.showMessageDialog(null, new Object[]{btn}, "Encrypter - BCM encryption", 
		    		JOptionPane.PLAIN_MESSAGE);
		} catch (Exception e) {
			JOptionPane.showMessageDialog(null, "File encrypt unsuccessfully!!\n"+e.getMessage(), null, JOptionPane.ERROR_MESSAGE);
			e.printStackTrace();
		}

		System.exit(0);
	}

}
