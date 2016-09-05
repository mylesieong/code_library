package autopay.utility;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import javax.swing.DefaultComboBoxModel;
import javax.swing.GroupLayout;
import javax.swing.GroupLayout.Alignment;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.LayoutStyle.ComponentPlacement;
import javax.swing.border.BevelBorder;
import javax.swing.border.EmptyBorder;
import javax.swing.border.SoftBevelBorder;
import javax.swing.border.TitledBorder;

import autopay.util.Cryptography;
import autopay.util.DBConnector;
import autopay.utility.SetupExe.Password;

/**
 * @author Francisco Lo BB14PGM
 * @since 09/11/2010
 * 
 * Dialog to reset password(s)
 */

@SuppressWarnings("serial")
public class ResetPasswordDialog extends JDialog implements ActionListener {

	public static int CREATE_PASSWORD = 0;
	public static int RESET_PASSWORD = 1;
	public static int FORCE_RESET_PASSWORD = 2;
	
	private SetupExe frame;
	private int purpose;
	private Password[] passwords;
	private JPanel contentPane;
	private JPanel panMain;
	private JButton btnCancel;
	private JComboBox cboParty;
	private JLabel lblPartyCode;
	private JPasswordField pwdSupervisorNew;
	private JLabel lblSupervisorNew;
	private JLabel lblSupervisorAgain;
	private JPasswordField pwdSupervisorAgain;
	private JPanel panSupervisor;
	private JButton btnSetSupervisor;
	private DBConnector db;
	private JPanel panOperator;
	private JLabel lblOperatorAgain;
	private JLabel lblOperatorNew;
	private JPasswordField pwdOperatorNew;
	private JButton btnSetOperator;
	private JPasswordField pwdOperatorAgain;
	private JButton btnOK;
	private JPasswordField pwdSupervisorOld;
	private JLabel lblSupervisorOld;
	private JPasswordField pwdOperatorOld;
	private JLabel lblOperatorOld;
	
	public ResetPasswordDialog(JFrame frame, String title, String[] partyList, int initPassword) throws ClassNotFoundException, SQLException {
		this(frame, title, partyList, initPassword, (DBConnector)null);
	}
	
	public ResetPasswordDialog(JFrame frame, String title, String[] partyList, int initPassword, String appPath) throws ClassNotFoundException, SQLException {
		this(frame, title, partyList, initPassword, (appPath != null? new DBConnector(appPath): null));
	}
	
	public ResetPasswordDialog(JFrame frame, String title, String[] partyList, int initPassword, DBConnector db) {
		super(frame, title, true);
		this.frame = (SetupExe)frame;
		purpose = initPassword;
		this.db = db;
		
		setResizable(false);
		setDefaultCloseOperation(DISPOSE_ON_CLOSE);
		setBounds(100, 100, 526, 305);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		
		panMain = new JPanel();
		panMain.setBorder(new SoftBevelBorder(BevelBorder.LOWERED, null, null, null, null));
		
		btnCancel = new JButton("Cancel");
		btnCancel.addActionListener(this);
		
		btnOK = new JButton("OK");
		btnOK.addActionListener(this);
		GroupLayout gl_contentPane = new GroupLayout(contentPane);
		gl_contentPane.setHorizontalGroup(
			gl_contentPane.createParallelGroup(Alignment.LEADING)
				.addGroup(gl_contentPane.createSequentialGroup()
					.addContainerGap()
					.addGroup(gl_contentPane.createParallelGroup(Alignment.LEADING)
						.addGroup(gl_contentPane.createSequentialGroup()
							.addComponent(panMain, GroupLayout.DEFAULT_SIZE, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
							.addGap(10))
						.addGroup(Alignment.TRAILING, gl_contentPane.createSequentialGroup()
							.addComponent(btnOK)
							.addPreferredGap(ComponentPlacement.RELATED)
							.addComponent(btnCancel)
							.addGap(177))))
		);
		gl_contentPane.setVerticalGroup(
			gl_contentPane.createParallelGroup(Alignment.LEADING)
				.addGroup(gl_contentPane.createSequentialGroup()
					.addContainerGap()
					.addComponent(panMain, GroupLayout.PREFERRED_SIZE, 193, Short.MAX_VALUE)
					.addPreferredGap(ComponentPlacement.RELATED)
					.addGroup(gl_contentPane.createParallelGroup(Alignment.BASELINE)
						.addComponent(btnOK)
						.addComponent(btnCancel))
					.addGap(4))
		);
		
		cboParty = new JComboBox();
		cboParty.setMaximumRowCount(3);
		
		lblPartyCode = new JLabel("Party Code:");
		
		panSupervisor = new JPanel();
		panSupervisor.setBorder(new TitledBorder(null, "Supervisor Password", TitledBorder.LEADING, TitledBorder.TOP, null, null));
		
		panOperator = new JPanel();
		panOperator.setBorder(new TitledBorder(null, "Operator Password", TitledBorder.LEADING, TitledBorder.TOP, null, null));
		
		lblOperatorAgain = new JLabel("Re-Type:");
		
		lblOperatorNew = new JLabel("New: ");
		
		pwdOperatorNew = new JPasswordField();
		pwdOperatorNew.setEchoChar('*');
		
		btnSetOperator = new JButton("Set");
		btnSetOperator.addActionListener(this);
		
		pwdOperatorAgain = new JPasswordField();
		pwdOperatorAgain.setEchoChar('*');
		
		pwdOperatorOld = new JPasswordField();
		pwdOperatorOld.setEchoChar('*');
		
		lblOperatorOld = new JLabel("Old:");
		GroupLayout gl_panOperator = new GroupLayout(panOperator);
		gl_panOperator.setHorizontalGroup(
			gl_panOperator.createParallelGroup(Alignment.LEADING)
				.addGroup(gl_panOperator.createSequentialGroup()
					.addContainerGap()
					.addGroup(gl_panOperator.createParallelGroup(Alignment.LEADING)
						.addGroup(gl_panOperator.createSequentialGroup()
							.addComponent(lblOperatorOld, GroupLayout.PREFERRED_SIZE, 34, GroupLayout.PREFERRED_SIZE)
							.addPreferredGap(ComponentPlacement.RELATED, 25, Short.MAX_VALUE)
							.addComponent(pwdOperatorOld, GroupLayout.PREFERRED_SIZE, 131, GroupLayout.PREFERRED_SIZE))
						.addGroup(gl_panOperator.createSequentialGroup()
							.addGroup(gl_panOperator.createParallelGroup(Alignment.LEADING)
								.addComponent(lblOperatorAgain)
								.addComponent(lblOperatorNew))
							.addGap(12)
							.addGroup(gl_panOperator.createParallelGroup(Alignment.LEADING)
								.addComponent(pwdOperatorNew, GroupLayout.PREFERRED_SIZE, 131, GroupLayout.PREFERRED_SIZE)
								.addComponent(pwdOperatorAgain, GroupLayout.PREFERRED_SIZE, 131, GroupLayout.PREFERRED_SIZE)
								.addGroup(gl_panOperator.createSequentialGroup()
									.addGap(10)
									.addComponent(btnSetOperator)))))
					.addContainerGap(GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
		);
		gl_panOperator.setVerticalGroup(
			gl_panOperator.createParallelGroup(Alignment.LEADING)
				.addGroup(gl_panOperator.createSequentialGroup()
					.addContainerGap()
					.addGroup(gl_panOperator.createParallelGroup(Alignment.BASELINE)
						.addComponent(lblOperatorOld)
						.addComponent(pwdOperatorOld, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
					.addPreferredGap(ComponentPlacement.RELATED)
					.addGroup(gl_panOperator.createParallelGroup(Alignment.BASELINE)
						.addComponent(lblOperatorNew)
						.addComponent(pwdOperatorNew, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
					.addGap(8)
					.addGroup(gl_panOperator.createParallelGroup(Alignment.LEADING)
						.addGroup(gl_panOperator.createSequentialGroup()
							.addGap(2)
							.addComponent(lblOperatorAgain))
						.addComponent(pwdOperatorAgain, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
					.addPreferredGap(ComponentPlacement.RELATED)
					.addComponent(btnSetOperator)
					.addContainerGap(36, Short.MAX_VALUE))
		);
		gl_panOperator.setAutoCreateGaps(true);
		gl_panOperator.setAutoCreateContainerGaps(true);
		panOperator.setLayout(gl_panOperator);
		GroupLayout gl_panMain = new GroupLayout(panMain);
		gl_panMain.setHorizontalGroup(
			gl_panMain.createParallelGroup(Alignment.LEADING)
				.addGroup(gl_panMain.createSequentialGroup()
					.addContainerGap()
					.addGroup(gl_panMain.createParallelGroup(Alignment.TRAILING)
						.addGroup(Alignment.LEADING, gl_panMain.createSequentialGroup()
							.addComponent(panSupervisor, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
							.addPreferredGap(ComponentPlacement.RELATED, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
							.addComponent(panOperator, GroupLayout.PREFERRED_SIZE, 226, GroupLayout.PREFERRED_SIZE))
						.addGroup(gl_panMain.createSequentialGroup()
							.addComponent(lblPartyCode, GroupLayout.PREFERRED_SIZE, 74, GroupLayout.PREFERRED_SIZE)
							.addGap(4)
							.addComponent(cboParty, GroupLayout.PREFERRED_SIZE, 123, GroupLayout.PREFERRED_SIZE)
							.addContainerGap(276, Short.MAX_VALUE))))
		);
		gl_panMain.setVerticalGroup(
			gl_panMain.createParallelGroup(Alignment.LEADING)
				.addGroup(gl_panMain.createSequentialGroup()
					.addContainerGap()
					.addGroup(gl_panMain.createParallelGroup(Alignment.BASELINE)
						.addComponent(lblPartyCode, GroupLayout.PREFERRED_SIZE, 23, GroupLayout.PREFERRED_SIZE)
						.addComponent(cboParty, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
					.addPreferredGap(ComponentPlacement.RELATED)
					.addGroup(gl_panMain.createParallelGroup(Alignment.TRAILING, false)
						.addComponent(panOperator, Alignment.LEADING, 0, 0, Short.MAX_VALUE)
						.addComponent(panSupervisor, Alignment.LEADING, GroupLayout.PREFERRED_SIZE, 159, Short.MAX_VALUE))
					.addContainerGap(83, Short.MAX_VALUE))
		);
		
		pwdSupervisorNew = new JPasswordField();
		pwdSupervisorNew.setEchoChar('*');
		lblSupervisorNew = new JLabel("New: ");
		lblSupervisorAgain = new JLabel("Re-Type:");
		pwdSupervisorAgain = new JPasswordField();
		pwdSupervisorAgain.setEchoChar('*');
		btnSetSupervisor = new JButton("Set");
		btnSetSupervisor.addActionListener(this);
		
		pwdSupervisorOld = new JPasswordField();
		pwdSupervisorOld.setEchoChar('*');
		
		lblSupervisorOld = new JLabel("Old:");
		
		GroupLayout gl_panSupervisor = new GroupLayout(panSupervisor);
		gl_panSupervisor.setHorizontalGroup(
			gl_panSupervisor.createParallelGroup(Alignment.LEADING)
				.addGroup(gl_panSupervisor.createSequentialGroup()
					.addContainerGap()
					.addGroup(gl_panSupervisor.createParallelGroup(Alignment.LEADING)
						.addGroup(Alignment.TRAILING, gl_panSupervisor.createSequentialGroup()
							.addComponent(lblSupervisorOld, GroupLayout.PREFERRED_SIZE, 34, GroupLayout.PREFERRED_SIZE)
							.addPreferredGap(ComponentPlacement.RELATED, 31, Short.MAX_VALUE)
							.addComponent(pwdSupervisorOld, GroupLayout.PREFERRED_SIZE, 131, GroupLayout.PREFERRED_SIZE))
						.addGroup(Alignment.TRAILING, gl_panSupervisor.createSequentialGroup()
							.addGroup(gl_panSupervisor.createParallelGroup(Alignment.LEADING)
								.addComponent(lblSupervisorAgain)
								.addComponent(lblSupervisorNew))
							.addGap(12)
							.addGroup(gl_panSupervisor.createParallelGroup(Alignment.LEADING)
								.addComponent(pwdSupervisorNew, GroupLayout.PREFERRED_SIZE, 131, GroupLayout.PREFERRED_SIZE)
								.addComponent(pwdSupervisorAgain, GroupLayout.PREFERRED_SIZE, 131, GroupLayout.PREFERRED_SIZE)
								.addGroup(gl_panSupervisor.createSequentialGroup()
									.addGap(10)
									.addComponent(btnSetSupervisor)))))
					.addContainerGap())
		);
		gl_panSupervisor.setVerticalGroup(
			gl_panSupervisor.createParallelGroup(Alignment.TRAILING)
				.addGroup(Alignment.LEADING, gl_panSupervisor.createSequentialGroup()
					.addGroup(gl_panSupervisor.createParallelGroup(Alignment.BASELINE)
						.addComponent(pwdSupervisorOld, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE)
						.addComponent(lblSupervisorOld))
					.addPreferredGap(ComponentPlacement.RELATED)
					.addGroup(gl_panSupervisor.createParallelGroup(Alignment.BASELINE)
						.addComponent(lblSupervisorNew)
						.addComponent(pwdSupervisorNew, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
					.addGap(8)
					.addGroup(gl_panSupervisor.createParallelGroup(Alignment.LEADING)
						.addGroup(gl_panSupervisor.createSequentialGroup()
							.addGap(2)
							.addComponent(lblSupervisorAgain))
						.addComponent(pwdSupervisorAgain, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
					.addPreferredGap(ComponentPlacement.RELATED)
					.addComponent(btnSetSupervisor)
					.addContainerGap(36, Short.MAX_VALUE))
		);
		gl_panSupervisor.setAutoCreateGaps(true);
		gl_panSupervisor.setAutoCreateContainerGaps(true);
		panSupervisor.setLayout(gl_panSupervisor);
		gl_panMain.setAutoCreateGaps(true);
		gl_panMain.setAutoCreateContainerGaps(true);
		panMain.setLayout(gl_panMain);
		gl_contentPane.setAutoCreateContainerGaps(true);
		gl_contentPane.setAutoCreateGaps(true);
		contentPane.setLayout(gl_contentPane);
		
		cboParty.setModel(new DefaultComboBoxModel(partyList));
		
		if(purpose == CREATE_PASSWORD) {
			pwdSupervisorOld.setEnabled(false);
			pwdOperatorOld.setEnabled(false);
			btnOK.setEnabled(false);
			passwords = new Password[partyList.length];
			for(int i=0; i<passwords.length; i++) 
				passwords[i] = this.frame.new Password();
			cboParty.setEnabled(false);
			cboParty.setSelectedIndex(0);
			JOptionPane.showMessageDialog(this, 
					"Please set password for party code:" + 
					cboParty.getItemAt(cboParty.getSelectedIndex()).toString());
		} else if(purpose == FORCE_RESET_PASSWORD){
			pwdSupervisorOld.setEnabled(false);
			pwdOperatorOld.setEnabled(false);
		}
	}
	
	public void actionPerformed(ActionEvent a) {
		
		if(a.getSource() == btnSetSupervisor) {
			String newPW = new String(pwdSupervisorNew.getPassword());
			String againPW = new String(pwdSupervisorAgain.getPassword());
			if(newPW.length() >= 8) {
				if(newPW.equals(againPW)) {
					try {
						int option = JOptionPane.YES_OPTION;
						if(purpose == RESET_PASSWORD) {
							String oldPW = Cryptography.hash(pwdSupervisorOld.getPassword());
							if(db.readSupervisorPassword(cboParty.getItemAt(cboParty.getSelectedIndex()).toString()).equals(oldPW)) {
								option = JOptionPane.showConfirmDialog(this, "You are about to reset the supervisor's password for\n" +
										"party code: " + cboParty.getSelectedItem().toString() + "\n\nContinue?", "", JOptionPane.YES_NO_OPTION);
							} else {
								JOptionPane.showMessageDialog(this, "Incorrect old password.");
								option = JOptionPane.NO_OPTION;
							}
						}
						if(option == JOptionPane.YES_OPTION) {
							if(purpose == CREATE_PASSWORD) {
								int index = cboParty.getSelectedIndex();
								passwords[index].setPartyCode(cboParty.getSelectedItem().toString());
								passwords[index].setSupervisorPW(pwdSupervisorNew.getPassword());
								btnSetSupervisor.setEnabled(false);
								JOptionPane.showMessageDialog(this, "Supervisor password setted.", 
										"", JOptionPane.INFORMATION_MESSAGE);
								if(passwords[index].getOperatorPW() != null) {
									setNextParty(index);
								}
							} else {
								db.writeSupervisorPassword(cboParty.getSelectedItem().toString(), 
										Cryptography.hash(pwdSupervisorNew.getPassword()));
								pwdSupervisorNew.setText("");
								pwdSupervisorAgain.setText("");
								pwdSupervisorOld.setText("");
								JOptionPane.showMessageDialog(this, "Password successfully reset.", 
										"", JOptionPane.INFORMATION_MESSAGE);
							}
						}
					} catch (NoSuchAlgorithmException e) {
						JOptionPane.showMessageDialog(this, "The requested algorthm is not available.\nError: " + e.getMessage(), 
								"Error", JOptionPane.ERROR_MESSAGE);
						e.printStackTrace();
					} catch (UnsupportedEncodingException e) {
						JOptionPane.showMessageDialog(this, "Operating System not support the encoding - " + Cryptography.CHARSET + " which is needed by AutoPay .\nError: " + e.getMessage(), 
								"Error", JOptionPane.ERROR_MESSAGE);
						e.printStackTrace();
					} catch (SQLException e) {
						JOptionPane.showMessageDialog(this, "Unpredictable error while trying to connecting to database.\nError: " + e.getMessage(), 
								"Error", JOptionPane.ERROR_MESSAGE);
						e.printStackTrace();
					}
				} else {
					JOptionPane.showMessageDialog(this, "The two passwords is not the same.");
				}
			} else {
				JOptionPane.showMessageDialog(this, "Password must have at least 8 characters long.");
			}
		}
		
		else if(a.getSource() == btnSetOperator) {
			String newPW = new String(pwdOperatorNew.getPassword());
			String againPW = new String(pwdOperatorAgain.getPassword());
			if(newPW.length() >= 8) {
				if(newPW.equals(againPW)) {
					try {
						int option = JOptionPane.YES_OPTION;
						if(purpose == RESET_PASSWORD) {
							String oldPW = Cryptography.hash(pwdOperatorOld.getPassword());
							if(db.readOperatorPassword(cboParty.getItemAt(cboParty.getSelectedIndex()).toString()).equals(oldPW)) {
								option = JOptionPane.showConfirmDialog(this, "You are about to reset the operator's password for\n" +
										"party code: " + cboParty.getSelectedItem().toString() + "\n\nContinue?", "", JOptionPane.YES_NO_OPTION);
							} else {
								JOptionPane.showMessageDialog(this, "Incorrect old password.");
								option = JOptionPane.NO_OPTION;
							}
						}
						if(option == JOptionPane.YES_OPTION) {
							if(purpose == CREATE_PASSWORD) {
								int index = cboParty.getSelectedIndex();
								passwords[index].setPartyCode(cboParty.getSelectedItem().toString());
								passwords[index].setOperatorPW(pwdOperatorNew.getPassword());
								btnSetOperator.setEnabled(false);
								JOptionPane.showMessageDialog(this, "Operator password setted.", 
										"", JOptionPane.INFORMATION_MESSAGE);
								if(passwords[index].getSupervisorPW() != null) {
									setNextParty(index);
								}
							} else {
								db.writeOperatorPassword(cboParty.getSelectedItem().toString(), 
										Cryptography.hash(pwdOperatorNew.getPassword()));
								pwdOperatorNew.setText("");
								pwdOperatorAgain.setText("");
								pwdOperatorOld.setText("");
								JOptionPane.showMessageDialog(this, "Password successfully reset.", 
										"", JOptionPane.INFORMATION_MESSAGE);
							}
						}
					} catch (NoSuchAlgorithmException e) {
						JOptionPane.showMessageDialog(this, "The requested algorthm is not available.\nError: " + e.getMessage(), 
								"Error", JOptionPane.ERROR_MESSAGE);
						e.printStackTrace();
					} catch (UnsupportedEncodingException e) {
						JOptionPane.showMessageDialog(this, "Operating System not support the encoding - " + Cryptography.CHARSET + " which is needed by AutoPay .\nError: " + e.getMessage(), 
								"Error", JOptionPane.ERROR_MESSAGE);
						e.printStackTrace();
					} catch (SQLException e) {
						JOptionPane.showMessageDialog(this, "Unpredictable error while trying to connecting to database.\nError: " + e.getMessage(), 
								"Error", JOptionPane.ERROR_MESSAGE);
						e.printStackTrace();
					}
				} else {
					JOptionPane.showMessageDialog(this, "The two passwords is not the same.");
				}
			} else {
				JOptionPane.showMessageDialog(this, "Password must have at least 8 characters long.");
			}
		}
		
		else if(a.getSource() == btnOK) {
			if(purpose == CREATE_PASSWORD)
				frame.setPasswords(passwords);
			try {
				if(db != null)
					db.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				dispose();
			}
		}
		
		else if(a.getSource() == btnCancel) {
			try {
				if(db != null)
					db.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				dispose();
			}
		}
	}
	
	
	/*
	 * Private method
	 */
	
	private void setNextParty(int index) {
		if(index < cboParty.getItemCount()-1) {
			index++;
			cboParty.setSelectedIndex(index);
			pwdSupervisorNew.setText("");
			pwdSupervisorAgain.setText("");
			pwdOperatorNew.setText("");
			pwdOperatorAgain.setText("");
			btnSetOperator.setEnabled(true);
			btnSetSupervisor.setEnabled(true);
			JOptionPane.showMessageDialog(this, 
					"Please set password for party code:" + 
					cboParty.getItemAt(index).toString());
		} else {
			btnOK.setEnabled(true);
			JOptionPane.showMessageDialog(this, "All passwords setted\nPlease press \"OK\".");
		}
	}
}
