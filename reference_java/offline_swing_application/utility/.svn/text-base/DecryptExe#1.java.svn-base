//package autopay.utility;
//
//import java.io.*;
//import java.awt.EventQueue;
//import java.awt.event.*;
//import javax.swing.*;
//import javax.swing.border.EmptyBorder;
//import javax.swing.filechooser.FileNameExtensionFilter;
//import javax.swing.GroupLayout;
//import javax.swing.GroupLayout.Alignment;
//import javax.swing.LayoutStyle.ComponentPlacement;
//import javax.crypto.BadPaddingException;
//import javax.crypto.IllegalBlockSizeException;
//import javax.crypto.NoSuchPaddingException;
//
//import autopay.Cryptography;
//
//import java.security.InvalidAlgorithmParameterException;
//import java.security.InvalidKeyException;
//import java.security.NoSuchAlgorithmException;
//
///**
// * With interactive User interface
// */
//
///**
// * 
// * @author Francisco Lo BB14PGM
// * @since 08/11/2010
// * 
// * Class to decrypt a text file which encrypted by Auto Payroll Application.
// */
//
//@SuppressWarnings("serial")
//public class DecryptExe extends JFrame implements ActionListener {
//
//	private JPanel contentPane;
//	private JButton btnSource;
//	private JTextField txtSource;
//	private JButton btnDestination;
//	private JTextField txtDestination;
//	private JButton btnDecrypt;
//	private JButton btnExit;
//	private JFileChooser fchSource;
//	private JFileChooser fchDestination;
//
//	public static void main(String[] args) {
//		EventQueue.invokeLater(new Runnable() {
//			public void run() {
//				try {
//					DecryptExe frame = new DecryptExe();
//					frame.setVisible(true);
//				} catch (Exception e) {
//					e.printStackTrace();
//				}
//			}
//		});
//	}
//
//	public DecryptExe() {
//		setResizable(false);
//		setTitle("Auto Payroll Application - Decryption exe");
//		setDefaultCloseOperation(DISPOSE_ON_CLOSE);
//		setBounds(100, 100, 450, 229);
//		contentPane = new JPanel();
//		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
//		setContentPane(contentPane);
//		
//		btnSource = new JButton("Source");
//		btnSource.addActionListener(this);
//		
//		txtSource = new JTextField();
//		txtSource.setColumns(10);
//		
//		btnDestination = new JButton("Destination");
//		btnDestination.addActionListener(this);
//		
//		txtDestination = new JTextField();
//		txtDestination.setColumns(10);
//		
//		btnDecrypt = new JButton("Decrypt");
//		btnDecrypt.addActionListener(this);
//		
//		btnExit = new JButton("Exit");
//		btnExit.addActionListener(this);
//		GroupLayout gl_contentPane = new GroupLayout(contentPane);
//		gl_contentPane.setHorizontalGroup(
//			gl_contentPane.createParallelGroup(Alignment.LEADING)
//				.addGroup(gl_contentPane.createSequentialGroup()
//					.addContainerGap()
//					.addGroup(gl_contentPane.createParallelGroup(Alignment.LEADING)
//						.addComponent(btnDecrypt, GroupLayout.PREFERRED_SIZE, 159, GroupLayout.PREFERRED_SIZE)
//						.addGroup(gl_contentPane.createSequentialGroup()
//							.addGroup(gl_contentPane.createParallelGroup(Alignment.TRAILING, false)
//								.addComponent(btnSource, Alignment.LEADING, GroupLayout.DEFAULT_SIZE, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
//								.addComponent(btnDestination, Alignment.LEADING, GroupLayout.DEFAULT_SIZE, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
//							.addPreferredGap(ComponentPlacement.RELATED)
//							.addGroup(gl_contentPane.createParallelGroup(Alignment.LEADING)
//								.addComponent(txtSource, GroupLayout.DEFAULT_SIZE, 304, Short.MAX_VALUE)
//								.addComponent(txtDestination, GroupLayout.DEFAULT_SIZE, 304, Short.MAX_VALUE)))
//						.addComponent(btnExit, Alignment.TRAILING))
//					.addContainerGap())
//		);
//		gl_contentPane.setVerticalGroup(
//			gl_contentPane.createParallelGroup(Alignment.LEADING)
//				.addGroup(gl_contentPane.createSequentialGroup()
//					.addContainerGap()
//					.addGroup(gl_contentPane.createParallelGroup(Alignment.BASELINE)
//						.addComponent(btnSource)
//						.addComponent(txtSource, GroupLayout.PREFERRED_SIZE, 27, GroupLayout.PREFERRED_SIZE))
//					.addGap(18)
//					.addGroup(gl_contentPane.createParallelGroup(Alignment.LEADING)
//						.addComponent(btnDestination)
//						.addGroup(gl_contentPane.createSequentialGroup()
//							.addGap(1)
//							.addComponent(txtDestination, GroupLayout.PREFERRED_SIZE, 27, GroupLayout.PREFERRED_SIZE)))
//					.addGap(18)
//					.addComponent(btnDecrypt, GroupLayout.PREFERRED_SIZE, 37, GroupLayout.PREFERRED_SIZE)
//					.addGap(9)
//					.addComponent(btnExit)
//					.addContainerGap(GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
//		);
//		gl_contentPane.setAutoCreateGaps(true);
//		gl_contentPane.setAutoCreateContainerGaps(true);
//		contentPane.setLayout(gl_contentPane);
//		
//		fchSource = new JFileChooser();
//		fchSource.addChoosableFileFilter(new FileNameExtensionFilter("BCM format text file", "txt"));
//		fchDestination = new JFileChooser();
//		fchDestination.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
//	}
//	
//	public void actionPerformed(ActionEvent a) {
//		
//		if(a.getSource() == btnSource) {
//			int option = fchSource.showOpenDialog(this);
//			if(option == JFileChooser.APPROVE_OPTION) {
//				txtSource.setText(fchSource.getSelectedFile().getPath());
//			}
//		}
//		
//		else if(a.getSource() == btnDestination) {
//			int option = fchDestination.showOpenDialog(this);
//			if(option == JFileChooser.APPROVE_OPTION) {
//				txtDestination.setText(fchDestination.getSelectedFile().getPath());
//			}
//		}
//		
//		else if(a.getSource() == btnDecrypt) {
//			if(!txtSource.getText().equals("") && !txtDestination.getText().equals("")) {
//				try {
//					File inFile = new File(txtSource.getText());
//					FileReader reader = new FileReader(inFile);
//			        BufferedReader in = new BufferedReader(reader);
//			        
//			        Cryptography decryptor = new Cryptography();
//			        String key = decryptor.decrypt(in.readLine());
//			        if(key.length() == 12) {
//			        	int option = JOptionPane.showConfirmDialog(this, 
//			        			"Party Code: " + key.subSequence(0, 4) +
//			        			"\nPayment Date: " + key.substring(4), 
//			        			"", JOptionPane.YES_NO_OPTION);
//			        	if(option == JOptionPane.YES_OPTION) {
//			        		FileWriter writer = new FileWriter(
//			        				new File(txtDestination.getText(), "de_" + inFile.getName()));
//			        		BufferedWriter out = new BufferedWriter(writer);
//			        		String line;
//			        		decryptor = new Cryptography(key);
//			        		
//			        		while((line = in.readLine()) != null) {
//			        			out.write(decryptor.decrypt(line));
//			        			out.newLine();
//			        		}
//			        		out.close();
//			        		writer.close();
//			        		in.close();
//			        		reader.close();
//			        		key = null;
//			        		decryptor = null;
//			        		JOptionPane.showMessageDialog(this, "File successfully decrypted");
//			        	} else {
//			        		in.close();
//			        		reader.close();
//			        		key = null;
//			        		decryptor = null;
//			        	}
//			        } else {
//			        	JOptionPane.showMessageDialog(this, 
//								"This is not a correct formatted file.\nPlease sepcify another file.",
//								"", JOptionPane.WARNING_MESSAGE);
//			        }
//				} catch (FileNotFoundException e) {
//					JOptionPane.showMessageDialog(this, 
//							"Specified file or folder not found.",
//							"", JOptionPane.ERROR_MESSAGE);
//					e.printStackTrace();
//				} catch (IOException e) {
//					JOptionPane.showMessageDialog(this, 
//							"Error occurs while trying to read and write the specified file",
//							"", JOptionPane.ERROR_MESSAGE);
//					e.printStackTrace();
//				} catch (InvalidKeyException e) {
//					JOptionPane.showMessageDialog(this, 
//							"The format of the text file is wrong.",
//							"", JOptionPane.ERROR_MESSAGE);
//					e.printStackTrace();
//				} catch (NoSuchAlgorithmException e) {
//					JOptionPane.showMessageDialog(this, 
//							"The format of the text file is wrong.",
//							"", JOptionPane.ERROR_MESSAGE);
//					e.printStackTrace();
//				} catch (NoSuchPaddingException e) {
//					JOptionPane.showMessageDialog(this, 
//							"The format of the text file is wrong.",
//							"", JOptionPane.ERROR_MESSAGE);
//					e.printStackTrace();
//				} catch (InvalidAlgorithmParameterException e) {
//					JOptionPane.showMessageDialog(this, 
//							"The format of the text file is wrong.",
//							"", JOptionPane.ERROR_MESSAGE);
//					e.printStackTrace();
//				} catch (IllegalBlockSizeException e) {
//					JOptionPane.showMessageDialog(this, 
//							"The format of the text file is wrong.",
//							"", JOptionPane.ERROR_MESSAGE);
//					e.printStackTrace();
//				} catch (BadPaddingException e) {
//					JOptionPane.showMessageDialog(this, 
//							"The format of the text file is wrong.",
//							"", JOptionPane.ERROR_MESSAGE);
//					e.printStackTrace();
//				} catch (Exception e) {
//					JOptionPane.showMessageDialog(this, 
//							"Unknown error.",
//							"", JOptionPane.ERROR_MESSAGE);
//					e.printStackTrace();
//				}
//			} else {
//				JOptionPane.showMessageDialog(this, 
//						"Please provide the source file and the destination folder.",
//						"", JOptionPane.WARNING_MESSAGE);
//			}
//		}
//		
//		else if(a.getSource() == btnExit) {
//			dispose();
//		}
//	}
//}
