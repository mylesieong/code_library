package autopay.client;

import java.awt.Component;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.image.BufferedImage;

import javax.imageio.ImageIO;
import javax.swing.BoxLayout;
import javax.swing.DefaultComboBoxModel;
import javax.swing.GroupLayout;
import javax.swing.GroupLayout.Alignment;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.LayoutStyle.ComponentPlacement;
import javax.swing.border.EtchedBorder;
import java.awt.BorderLayout;
import java.io.File;
import java.io.IOException;



/**
 * @author Francisco Lo BB14PGM
 * @since 01/11/2010
 * 
 * The screen to get user password from the user
 */

@SuppressWarnings("serial")
public class BakLoginScreen extends JDialog implements ActionListener {

	private MainScreen frame;
	private JLabel lblTitle1;
	private JLabel lblTitle2;
	private JPanel panTitle;
	private JPanel panButton;
	private JPanel panMain;
	private JButton btnOK;
	private JButton btnExit;
	private JLabel lblPartyCode;
	private JLabel lblPassword;
	private JComboBox cboPartyCode;
	private JPasswordField pwdPassword;
	private JPanel panTop;
	private JLabel lblCopyRight;
	private JLabel lblLogo;

	public BakLoginScreen(JFrame jframe, String[] partyCodes, Dimension dim) {
		super(jframe, true);
		frame = (MainScreen)jframe;
		setBounds(new Rectangle(dim));
		initialize();
		cboPartyCode.setModel(new DefaultComboBoxModel(partyCodes));
	}
	
	private void initialize() {
		setTitle(frame.ln._Login());
		setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
		/**
		 * Myles' Edit 2016-1-6: alter 2 lines
		 */
		setResizable(true); 
		setUndecorated(false);
		 
		//setResizable(false);
		//setUndecorated(true);
		getContentPane().setLayout(new FlowLayout(FlowLayout.CENTER, 5, 5));
		
		panTop = new JPanel();
		panTop.setBorder(new EtchedBorder(EtchedBorder.LOWERED, null, null));
		getContentPane().add(panTop);
		panTop.setLayout(new BoxLayout(panTop, BoxLayout.Y_AXIS));
		
		panTitle = new JPanel();
		panTop.add(panTitle);
		panTitle.setLayout(new BoxLayout(panTitle, BoxLayout.Y_AXIS));
		
		try {
			BufferedImage logo = ImageIO.read(new File("bcmNlogoC.JPG"));
			lblLogo = new JLabel(new ImageIcon(logo));
			lblLogo.setAlignmentX(Component.CENTER_ALIGNMENT);
			panTitle.add(lblLogo);
		} catch (IOException e) {
			e.printStackTrace();
		} 
		
		lblTitle1 = new JLabel(frame.ln._BankName2());
		lblTitle1.setFont(new Font("Dialog", Font.BOLD, 17));
		lblTitle1.setAlignmentX(Component.CENTER_ALIGNMENT);
		panTitle.add(lblTitle1);
		
		lblTitle2 = new JLabel(frame.ln._ApplicationName());
		lblTitle2.setAlignmentX(Component.CENTER_ALIGNMENT);
		panTitle.add(lblTitle2);
				
		panMain = new JPanel();
		panTop.add(panMain);
		
		lblPartyCode = new JLabel(frame.ln._PartyCode());
		
		lblPassword = new JLabel(frame.ln._PasswordColon());
		
		cboPartyCode = new JComboBox();
		cboPartyCode.setMaximumRowCount(5);
		cboPartyCode.setFont(new Font("Dialog", Font.PLAIN, 12));
		
		pwdPassword = new JPasswordField();
		pwdPassword.setEchoChar('*');
		
		panButton = new JPanel();
		panTop.add(panButton);
		
		btnExit = new JButton(frame.ln._Exit());
		btnExit.addActionListener(this);
		panButton.setLayout(new BorderLayout(0, 0));
		
		lblCopyRight = new JLabel(frame.ln._Copyright());
		lblCopyRight.setFont(new Font("Tahoma", Font.PLAIN, 9));
		panButton.add(lblCopyRight, BorderLayout.WEST);
		panButton.add(btnExit, BorderLayout.EAST);
		
		btnOK = new JButton(frame.ln._OK());
		btnOK.addActionListener(this);
		GroupLayout gl_panMain = new GroupLayout(panMain);
		gl_panMain.setHorizontalGroup(
			gl_panMain.createParallelGroup(Alignment.LEADING)
				.addGroup(gl_panMain.createSequentialGroup()
					.addGap(145)
					.addGroup(gl_panMain.createParallelGroup(Alignment.TRAILING)
						.addComponent(btnOK)
						.addGroup(gl_panMain.createSequentialGroup()
							.addGroup(gl_panMain.createParallelGroup(Alignment.TRAILING, false)
								.addComponent(lblPassword, Alignment.LEADING, GroupLayout.DEFAULT_SIZE, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
								.addComponent(lblPartyCode, Alignment.LEADING, GroupLayout.PREFERRED_SIZE, 73, GroupLayout.PREFERRED_SIZE))
							.addPreferredGap(ComponentPlacement.RELATED)
							.addGroup(gl_panMain.createParallelGroup(Alignment.LEADING, false)
								.addComponent(pwdPassword)
								.addComponent(cboPartyCode, GroupLayout.PREFERRED_SIZE, 82, GroupLayout.PREFERRED_SIZE))))
					.addContainerGap(144, Short.MAX_VALUE))
		);
		gl_panMain.setVerticalGroup(
			gl_panMain.createParallelGroup(Alignment.LEADING)
				.addGroup(gl_panMain.createSequentialGroup()
					.addGap(62)
					.addGroup(gl_panMain.createParallelGroup(Alignment.BASELINE)
						.addComponent(lblPartyCode)
						.addComponent(cboPartyCode, GroupLayout.PREFERRED_SIZE, 21, GroupLayout.PREFERRED_SIZE))
					.addPreferredGap(ComponentPlacement.RELATED)
					.addGroup(gl_panMain.createParallelGroup(Alignment.BASELINE)
						.addComponent(lblPassword)
						.addComponent(pwdPassword, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
					.addPreferredGap(ComponentPlacement.RELATED)
					.addComponent(btnOK)
					.addContainerGap(108, Short.MAX_VALUE))
		);
		gl_panMain.setAutoCreateGaps(true);
		gl_panMain.setAutoCreateContainerGaps(true);
		panMain.setLayout(gl_panMain);
		
	}
	
	public void actionPerformed(ActionEvent a) {
		
		if(a.getSource() == btnOK) {
			/**
			 * Myles' Edit 2016-1-7: Move 1 lines upward [PartB]
			 * */
			dispose();
			frame.passLoginInfo(cboPartyCode.getSelectedItem().toString(), pwdPassword.getPassword());
			/**
			 * Myles' Edit 2016-1-7: Move 1 lines upward [PartA]
			 * */
			//dispose();
			
		}else if(a.getSource() == btnExit) {
			frame.passLoginInfo(null, null);
			dispose();
			frame.dispose();
			System.exit(0);
		}
	}
}
