package autopay.utility;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.border.*;
import javax.swing.GroupLayout.Alignment;
import javax.swing.LayoutStyle.ComponentPlacement;


import autopay.*;
import autopay.util.Cryptography;
import autopay.util.DBConnector;
import autopay.util.FileConnector;

import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.Properties;
import java.util.Vector;
import java.io.*;

/**
 * @author Francisco Lo BB14PGM
 * @since 10/11/2010
 * 
 * Setup Auto Payroll Application
 */

@SuppressWarnings("serial")
public class SetupExe extends JFrame implements ActionListener {

	private final static String AUTOPAY_FOLDER = "\\BCM_Autopay";
	private final static String AUTOCOLLECTION_FOLDER = "\\BCM_AutoCollection";
	private final static String SEPERATOR = "\\";
	private final static String CONFIG_DIRECTORY = "Config";
//	private final static String LIB_DIRECTORY = "RunAutopayExe_lib";
	
	//Directories need to copy
	private final static String[] DIRECTORY_NAMES = new String[] {
		CONFIG_DIRECTORY,
//		LIB_DIRECTORY
	};
		
	//Files need to copy
	private final static String[] FILE_NAMES = new String[] {
		"RunAutopayExe.jar", 
		DBConnector.DATABASE_NAME, 
		"bcmNlogoC.JPG", 
		CONFIG_DIRECTORY + "\\DateChooserDialog.dchd", 
		CONFIG_DIRECTORY + "\\config.ini",  
		CONFIG_DIRECTORY + "\\autopay_option.ini",  
		CONFIG_DIRECTORY + "\\autocollection_option.ini", 
//		LIB_DIRECTORY + "\\commons-logging-1.1.jar",
//		LIB_DIRECTORY + "\\DateChooser.jar",
//		LIB_DIRECTORY + "\\dom4j-1.6.1.jar",
//		LIB_DIRECTORY + "\\geronimo-stax-api_1.0_spec-1.0.jar",
//		LIB_DIRECTORY + "\\iText-5.0.5.jar",
//		LIB_DIRECTORY + "\\junit-3.8.1.jar",
//		LIB_DIRECTORY + "\\log4j-1.2.13.jar",
//		LIB_DIRECTORY + "\\poi-3.6-20091214.jar",
//		LIB_DIRECTORY + "\\poi-contrib-3.6-20091214.jar",
//		LIB_DIRECTORY + "\\poi-examples-3.6-20091214.jar",
//		LIB_DIRECTORY + "\\poi-ooxml-3.6-20091214.jar",
//		LIB_DIRECTORY + "\\poi-ooxml-schemas-3.6-20091214.jar",
//		LIB_DIRECTORY + "\\poi-scratchpad-3.6-20091214.jar",
//		LIB_DIRECTORY + "\\xmlbeans-2.3.0.jar"
	};
	
	private String[] partyCodes = null;
	private Password[] passwords = null;
	
	private JPanel contentPane;
	private JButton btnSetup;
	private JLabel lblSetup;
	private JButton btnParty;
	private JLabel lblAddOrRemove;
	private JButton btnPassword;
	private JLabel lblResetPassword;
	private JButton btnExit;
	private ResetPasswordDialog pwDialog;
	private AddRemovePartyCodeDialog partyDialog;
	private String setupString;

	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					SetupExe frame = new SetupExe();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	public SetupExe() {
		setTitle("Auto Payroll Setup Utilities");
		setDefaultCloseOperation(DISPOSE_ON_CLOSE);
		setBounds(100, 100, 510, 272);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		
		btnSetup = new JButton("Setup");
		btnSetup.addActionListener(this);
		
		lblSetup = new JLabel("First time setup.");
		lblSetup.setFont(new Font("Dialog", Font.BOLD, 14));
		
		btnParty = new JButton("Add/Remove Party");
		btnParty.addActionListener(this);
		
		lblAddOrRemove = new JLabel("Add / Remove Party from the application");
		lblAddOrRemove.setFont(new Font("Dialog", Font.BOLD, 14));
		
		btnPassword = new JButton("Reset Password");
		btnPassword.addActionListener(this);
		
		lblResetPassword = new JLabel("Reset password");
		lblResetPassword.setFont(new Font("Dialog", Font.BOLD, 14));
		
		btnExit = new JButton("Exit");
		btnExit.addActionListener(this);
		GroupLayout gl_contentPane = new GroupLayout(contentPane);
		gl_contentPane.setHorizontalGroup(
			gl_contentPane.createParallelGroup(Alignment.LEADING)
				.addGroup(gl_contentPane.createSequentialGroup()
					.addGap(26)
					.addGroup(gl_contentPane.createParallelGroup(Alignment.LEADING)
						.addGroup(gl_contentPane.createSequentialGroup()
							.addComponent(btnSetup, GroupLayout.PREFERRED_SIZE, 166, GroupLayout.PREFERRED_SIZE)
							.addPreferredGap(ComponentPlacement.UNRELATED)
							.addComponent(lblSetup, GroupLayout.PREFERRED_SIZE, 222, GroupLayout.PREFERRED_SIZE))
						.addGroup(Alignment.TRAILING, gl_contentPane.createParallelGroup(Alignment.LEADING)
							.addGroup(gl_contentPane.createSequentialGroup()
								.addComponent(btnParty)
								.addPreferredGap(ComponentPlacement.RELATED)
								.addComponent(lblAddOrRemove, GroupLayout.DEFAULT_SIZE, 304, Short.MAX_VALUE))
							.addGroup(Alignment.TRAILING, gl_contentPane.createSequentialGroup()
								.addComponent(btnPassword, GroupLayout.PREFERRED_SIZE, 138, GroupLayout.PREFERRED_SIZE)
								.addGap(12)
								.addGroup(gl_contentPane.createParallelGroup(Alignment.TRAILING)
									.addComponent(lblResetPassword, GroupLayout.PREFERRED_SIZE, 304, GroupLayout.PREFERRED_SIZE)
									.addComponent(btnExit)))))
					.addContainerGap())
		);
		gl_contentPane.setVerticalGroup(
			gl_contentPane.createParallelGroup(Alignment.LEADING)
				.addGroup(gl_contentPane.createSequentialGroup()
					.addGap(30)
					.addGroup(gl_contentPane.createParallelGroup(Alignment.BASELINE)
						.addComponent(btnSetup, GroupLayout.PREFERRED_SIZE, 57, GroupLayout.PREFERRED_SIZE)
						.addComponent(lblSetup, GroupLayout.PREFERRED_SIZE, 55, GroupLayout.PREFERRED_SIZE))
					.addGap(34)
					.addGroup(gl_contentPane.createParallelGroup(Alignment.BASELINE)
						.addComponent(btnParty)
						.addComponent(lblAddOrRemove, GroupLayout.PREFERRED_SIZE, 23, GroupLayout.PREFERRED_SIZE))
					.addGap(18)
					.addGroup(gl_contentPane.createParallelGroup(Alignment.LEADING)
						.addComponent(btnPassword)
						.addGroup(gl_contentPane.createSequentialGroup()
							.addGap(1)
							.addComponent(lblResetPassword, GroupLayout.PREFERRED_SIZE, 23, GroupLayout.PREFERRED_SIZE)))
					.addContainerGap(32, Short.MAX_VALUE))
				.addGroup(Alignment.TRAILING, gl_contentPane.createSequentialGroup()
					.addContainerGap(190, Short.MAX_VALUE)
					.addComponent(btnExit)
					.addContainerGap())
		);
		gl_contentPane.setAutoCreateGaps(true);
		gl_contentPane.setAutoCreateContainerGaps(true);
		contentPane.setLayout(gl_contentPane);
	}
	
	public void actionPerformed(ActionEvent a) {
		
		if(a.getSource() == btnSetup) {
			int option = JOptionPane.showConfirmDialog(null, "Start the setup process?", "", JOptionPane.YES_NO_OPTION);
			if(option == JOptionPane.YES_OPTION) {
				try {
					//choose Autopay or AutoCollection
					option = JOptionPane.showOptionDialog(this, "Setup whicih application?", "", JOptionPane.DEFAULT_OPTION, 
							JOptionPane.QUESTION_MESSAGE, null, new String[]{"Autopay","AutoCollection"}, "Autopay");
					if(option == 0) {
						setupString = AUTOPAY_FOLDER;
					} else {
						setupString = AUTOCOLLECTION_FOLDER;
					}
					//Set Path
					JOptionPane.showMessageDialog(this, "Set the directory where the application going to install.");
					JFileChooser fchOpen = new JFileChooser();
					fchOpen.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
					option = fchOpen.showOpenDialog(this);
					if(option == JFileChooser.APPROVE_OPTION) {
						//Create Party Codes
						partyDialog = new AddRemovePartyCodeDialog(this, "Create Party Code");
						partyDialog.setVisible(true);
						if(partyCodes != null && partyCodes.length > 0) {
							//Set passwords
							pwDialog = new ResetPasswordDialog(this, "Set password for each party.", partyCodes, ResetPasswordDialog.CREATE_PASSWORD);
							pwDialog.setVisible(true);
							if(passwords != null) {
								File dir = new File(fchOpen.getSelectedFile().getPath() + setupString);
								if(!dir.exists())
									dir.mkdir();
								//start copy and create files/directory
								SetupProgressDialog dialog = new SetupProgressDialog(this, dir.getPath() + SEPERATOR);
								dialog.setVisible(true);
								
								//finish
								JOptionPane.showMessageDialog(this, "Setup finish.");
								dispose();
							}
						} else {
							JOptionPane.showMessageDialog(this, "No party code provided\nExit setup...");
						}
					} else {
						JOptionPane.showMessageDialog(this, "Setup canceled...");
					}
				}
				catch (Exception e) {
					JOptionPane.showMessageDialog(this, "Unknown Error:\n" + e.getMessage(), 
							"", JOptionPane.ERROR_MESSAGE);
					e.printStackTrace();
				}
			}	
		}
		
		else if(a.getSource() == btnParty) {
			String path;
			if((path = getApplicationPath()) != null) {
				try {
					SetupDBConnector db = new SetupDBConnector(path + SEPERATOR);
					String[] orgPartyList = db.readPartyList();
					if(orgPartyList.length == 0) {
						JOptionPane.showMessageDialog(this, "No party information, please run \"SetupExe.jar\" before using the application.", 
								"", JOptionPane.WARNING_MESSAGE);
					} else {
						partyDialog = new AddRemovePartyCodeDialog(this, "Add/Remove Party Code", 
								orgPartyList);
						partyDialog.setVisible(true);
						Vector<String> newParties = new Vector<String>();
						Vector<String> removeParties = new Vector<String>();
						
						//insert and remove partyCodes from database
						if(partyCodes != null) {
							if(partyCodes.length > 0) {
								boolean found;
								for(int i=0; i<orgPartyList.length; i++) {
									found = false;
									for(int j=0; j<partyCodes.length; j++) {
										if(orgPartyList[i].equals(partyCodes[j]))
											found = true;
									}
									if(!found)
										removeParties.add(orgPartyList[i]);
								}
								for(int i=0; i<partyCodes.length; i++) {
									found = false;
									for(int j=0; j<orgPartyList.length; j++) {
										if(partyCodes[i].equals(orgPartyList[j]))
											found = true;
									}
									if(!found)
										newParties.add(partyCodes[i]);
								}
								//set password for new party codes
								if(newParties.size() > 0) {
									pwDialog = new ResetPasswordDialog(this, 
											"Set password for each party.", 
											newParties.toArray(new String[]{}), 
											ResetPasswordDialog.CREATE_PASSWORD);
									pwDialog.setVisible(true);
								}
								
								if(newParties.size() > 0) {
									if(passwords != null) {
										Party party;
										for(String partyCode : newParties) {
											party = new Party();
											party.setCode(partyCode);
											db.writeParty(party);
										}
										for(Password p : passwords) {
											db.writeOperatorPassword(p.getPartyCode(), p.getOperatorPW());
											db.writeSupervisorPassword(p.getPartyCode(), p.getSupervisorPW());
										}
										
										for(String code : removeParties) {
											db.removeParty(code);
										}
										passwords = null;
										JOptionPane.showMessageDialog(this, "Successfully create/remove party");
									}
								} else {
									for(String code : removeParties) {
										db.removeParty(code);
									}
									JOptionPane.showMessageDialog(this, "Successfully remove party");
								}
							} else {
								JOptionPane.showMessageDialog(this, "There must have at least one Party code\nOperation cancelled...");
							}
						}
					}
					db.close();
				} catch (Exception e) {
					JOptionPane.showMessageDialog(this, "Unknown error:\n" + e.getMessage(), "", JOptionPane.ERROR_MESSAGE);
					e.printStackTrace();
				} finally {
					partyCodes = null;
				}
			}
		}
		
		else if(a.getSource() == btnPassword) {
			try {
				String path = getApplicationPath();
				if(path != null) {
					DBConnector db = new DBConnector(path + SEPERATOR);
					String[] partyList = db.readPartyList();
					db.close();
					if(partyList.length == 0) {
						JOptionPane.showMessageDialog(this, "No party information, please run \"SetupExe.jar\" before using the application.", 
								"", JOptionPane.WARNING_MESSAGE);
					} else {
						pwDialog = new ResetPasswordDialog(this, "Reset password(s).", 
								partyList, 
								ResetPasswordDialog.FORCE_RESET_PASSWORD, 
								path + SEPERATOR);
						pwDialog.setVisible(true);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		else if(a.getSource() == btnExit) {
			dispose();
		}
	}
	
	public void setPartyCodes(String[] codes) {
		partyCodes = codes;
	}
	
	public void setPasswords(Password[] passwords) {
		this.passwords = passwords;
	}
	
	
	/*
	 * Private Methods
	 */
	
	//Get the application path for auto payroll system from the user.
	private String getApplicationPath() {
		final JTextField txt = new JTextField();
		txt.setEditable(false);
		JButton btn = new JButton("Open");
		btn.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e) {
				JFileChooser fchOpen = new JFileChooser();
				fchOpen.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
				int option = fchOpen.showOpenDialog(null);
				if(option == JFileChooser.APPROVE_OPTION) {
					try {
						new SetupDBConnector(fchOpen.getSelectedFile().getPath() + SEPERATOR).close();
						txt.setText(fchOpen.getSelectedFile().getPath());
					}
					catch(SQLException ee) {
						JOptionPane.showMessageDialog(null, "This is not a \"Auto Payroll Application\" folder.", 
								"", JOptionPane.INFORMATION_MESSAGE);
					} 
					catch (Exception ee) {
						JOptionPane.showMessageDialog(null, "Unknown error.\nError: " + ee.getMessage(), 
								"Error", JOptionPane.ERROR_MESSAGE);
						ee.printStackTrace();
					}
				}
			}
		});
		int option = JOptionPane.showConfirmDialog(this, 
				new Object[] {btn, txt}, "Select the application path", JOptionPane.PLAIN_MESSAGE);
		if(option == JOptionPane.OK_OPTION) {
			if(!txt.getText().equals("")) {
				return txt.getText();
			} else {
				JOptionPane.showMessageDialog(this, "No Auto Payroll Application path found");
			}
		}
		return null;
	}
	
	
	/*
	 * Public Classes
	 */
	
	public class Password {
		String partyCode, supervisorPW, operatorPW;
		
		public Password() {
			partyCode = null;
			supervisorPW = null;
			operatorPW = null;
		}
		
		public Password(String partyCode, char[] supervisorPW, char[] operatorPW) 
						throws NoSuchAlgorithmException, UnsupportedEncodingException {
			this.partyCode = partyCode;
			this.supervisorPW = Cryptography.hash(supervisorPW);
			this.operatorPW = Cryptography.hash(operatorPW);
		}

		public String getPartyCode() {
			return partyCode;
		}

		public void setPartyCode(String partyCode) {
			this.partyCode = partyCode;
		}

		public String getSupervisorPW() {
			return supervisorPW;
		}

		public void setSupervisorPW(char[] supervisorPW) throws NoSuchAlgorithmException, UnsupportedEncodingException {
			this.supervisorPW = Cryptography.hash(supervisorPW);
		}

		public String getOperatorPW() {
			return operatorPW;
		}

		public void setOperatorPW(char[] operatorPW) throws NoSuchAlgorithmException, UnsupportedEncodingException {
			this.operatorPW = Cryptography.hash(operatorPW);
		}
	}
	
	
	/*
	 * Private Classes
	 */
	
	//class to initialize the access database
	private class SetupDBConnector extends DBConnector {

		public SetupDBConnector(String path) throws ClassNotFoundException, SQLException {
			super(path);
		}
		
		public void writeParty(Party party) throws SQLException {
			super.statement.executeUpdate("INSERT INTO party VALUES('" + 
					party.getCode() + "','" + party.getName() + "','" + 
					party.getPaymentID() + "'," + party.getPaymentDate() + "," + 
					party.getWholeModifySeq() +")");
			super.statement.executeUpdate("INSERT INTO password VALUES('" + 
					party.getCode() + "','0','0')");
		}
		
		public void removeParty(String code) throws SQLException {
			super.statement.executeUpdate("DELETE FROM party WHERE party_code = '" + code + "'");
			super.statement.executeUpdate("DELETE FROM employee WHERE party_code = '" + code + "'");
			super.statement.executeUpdate("DELETE FROM password WHERE party_code = '" + code + "'");
		}
	}
	
	//dialog to display the progress bar
	private class SetupProgressDialog extends JDialog implements ActionListener{
		
		private boolean go = true;
		private int value;
		private String appPath;
		private JProgressBar bar;
		private JLabel lblSetup;
		private JButton btnCancel;
		private InputStream in;
		private OutputStream out;
		
		public SetupProgressDialog(JFrame frame, String path){
			super(frame, "", true);
			setBounds(100, 100, 296, 127);
			
			appPath = path;
			bar = new JProgressBar();
			
			lblSetup = new JLabel("Setup in progress...");
			
			btnCancel = new JButton("Cancel");
			btnCancel.addActionListener(this);
			GroupLayout groupLayout = new GroupLayout(getContentPane());
			groupLayout.setHorizontalGroup(
				groupLayout.createParallelGroup(Alignment.LEADING)
					.addGroup(groupLayout.createSequentialGroup()
						.addGroup(groupLayout.createParallelGroup(Alignment.LEADING)
							.addGroup(groupLayout.createSequentialGroup()
								.addContainerGap()
								.addGroup(groupLayout.createParallelGroup(Alignment.TRAILING)
									.addComponent(lblSetup, Alignment.LEADING, GroupLayout.DEFAULT_SIZE, 264, Short.MAX_VALUE)
									.addComponent(bar, Alignment.LEADING, GroupLayout.DEFAULT_SIZE, 264, Short.MAX_VALUE)))
							.addGroup(groupLayout.createSequentialGroup()
								.addGap(107)
								.addComponent(btnCancel)))
						.addContainerGap())
			);
			groupLayout.setVerticalGroup(
				groupLayout.createParallelGroup(Alignment.LEADING)
					.addGroup(groupLayout.createSequentialGroup()
						.addGap(11)
						.addComponent(lblSetup)
						.addPreferredGap(ComponentPlacement.RELATED)
						.addComponent(bar, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
						.addPreferredGap(ComponentPlacement.UNRELATED)
						.addComponent(btnCancel)
						.addContainerGap(52, Short.MAX_VALUE))
			);
			groupLayout.setAutoCreateGaps(true);
			groupLayout.setAutoCreateContainerGaps(true);
			getContentPane().setLayout(groupLayout);

			
			//calculate progress
			final int MAX = DIRECTORY_NAMES.length + FILE_NAMES.length*2 + partyCodes.length + passwords.length + 1; //+1 initialize config
			value = 0;
			bar.setMaximum(MAX);
			new Thread() {
				public void run() {
					while(value < MAX && go) {
						bar.setValue(value);
						bar.repaint();
						try {
							Thread.sleep(100);
						} catch (InterruptedException e) {
							e.printStackTrace();
						}
					}
				}
			}.start();
			
			new Thread() {
				public void run() {
					try {
						//create directories
						int byteRead;
						File dir;
						for(int i=0; i<DIRECTORY_NAMES.length; i++) {
							dir = new File(appPath+DIRECTORY_NAMES[i]);
							dir.mkdir();
							value++;
							if(!go) return;
						}
						//copy files
						for(int i=0; i<FILE_NAMES.length; i++) {
							in = new FileInputStream(new File(FILE_NAMES[i]));
							out = new FileOutputStream(appPath + FILE_NAMES[i]);
							while((byteRead = in.read()) != -1 && go == true)
								out.write(byteRead);
							in.close();
							out.close();
							value += 2;
							if(!go) return;
						}
						
						//insert Data to Database(partyCodes, passwords);
						DBConnector db = new SetupDBConnector(appPath);
						Party party;
						for(String partyCode : partyCodes) {
							party = new Party();
							party.setCode(partyCode);
							db.writeParty(party);
							value++;
							if(!go) return;
						}
						for(Password p : passwords) {
							db.writeOperatorPassword(p.getPartyCode(), p.getOperatorPW());
							db.writeSupervisorPassword(p.getPartyCode(), p.getSupervisorPW());
							value++;
							if(!go) return;
						}
						db.close();
						
						//update config in config.ini
						if(setupString.equals(AUTOPAY_FOLDER)) {
							setupString = "autopay";
						} else {
							setupString = "autocollection";
						}
						Properties config = FileConnector.loadConfig(appPath + CONFIG_DIRECTORY + "\\config.ini");
						config.setProperty("Program", setupString);
						out = new FileOutputStream(appPath + CONFIG_DIRECTORY + "\\config.ini");
						config.store(out, "Initialized_by_First_Time_Setup");
						out.close();
						value++;
					}
					catch(Exception e) {
						JOptionPane.showMessageDialog(null, e.getMessage(), "", JOptionPane.ERROR_MESSAGE);
						e.printStackTrace();
					}
					finally {
						go = false;
						dispose();
					}
				}
			}.start();
		}
		
		public void actionPerformed(ActionEvent a) {
			go = false;
			dispose();
		}
	}
}
