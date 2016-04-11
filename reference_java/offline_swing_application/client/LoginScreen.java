package autopay.client;

import java.awt.*;
import java.awt.event.*;
import java.awt.image.BufferedImage;

import javax.swing.*;
import javax.swing.GroupLayout.Alignment;
import javax.swing.LayoutStyle.ComponentPlacement;
import javax.swing.border.EtchedBorder;
import javax.swing.SwingConstants;

import java.io.*;

import javax.imageio.ImageIO;

import java.util.TimerTask;

/**
 * @author Francisco Lo BB14PGM
 * @since 01/11/2010
 * 
 * The screen to get user password from the user
 */

@SuppressWarnings("serial")
public class LoginScreen extends JDialog implements ActionListener, ComponentListener {

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
	private Timer resizeTimer;
	
	private int widthLast;
	private int heightLast;
	
	final int WIDTH_ORIGIN=520;
	final int HEIGHT_ORIGIN=450;

	public LoginScreen(JFrame jframe, String[] partyCodes, Dimension dim) {
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
		lblPartyCode.setHorizontalAlignment(SwingConstants.RIGHT);
		
		lblPassword = new JLabel(frame.ln._PasswordColon());
		lblPassword.setHorizontalAlignment(SwingConstants.RIGHT);
		
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
				.addGroup(Alignment.TRAILING, gl_panMain.createSequentialGroup()
					.addGap(98)
					.addGroup(gl_panMain.createParallelGroup(Alignment.TRAILING)
						.addComponent(lblPartyCode, GroupLayout.PREFERRED_SIZE, 120, GroupLayout.PREFERRED_SIZE)
						.addComponent(lblPassword, GroupLayout.DEFAULT_SIZE, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
					.addPreferredGap(ComponentPlacement.RELATED)
					.addGroup(gl_panMain.createParallelGroup(Alignment.LEADING)
						.addComponent(btnOK, Alignment.TRAILING, GroupLayout.DEFAULT_SIZE, 142, Short.MAX_VALUE)
						.addComponent(cboPartyCode, Alignment.TRAILING, 0, 142, Short.MAX_VALUE)
						.addComponent(pwdPassword))
					.addGap(144))
		);
		gl_panMain.setVerticalGroup(
			gl_panMain.createParallelGroup(Alignment.LEADING)
				.addGroup(gl_panMain.createSequentialGroup()
					.addGap(62)
					.addGroup(gl_panMain.createParallelGroup(Alignment.LEADING)
						.addGroup(gl_panMain.createSequentialGroup()
							.addGap(7)
							.addComponent(lblPartyCode, GroupLayout.DEFAULT_SIZE, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
						.addComponent(cboPartyCode, GroupLayout.PREFERRED_SIZE, 21, Short.MAX_VALUE))
					.addPreferredGap(ComponentPlacement.RELATED)
					.addGroup(gl_panMain.createParallelGroup(Alignment.BASELINE)
						.addGroup(gl_panMain.createSequentialGroup()
							.addGap(6)
							.addComponent(lblPassword, GroupLayout.DEFAULT_SIZE, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
						.addComponent(pwdPassword))
					.addPreferredGap(ComponentPlacement.RELATED)
					.addComponent(btnOK, GroupLayout.DEFAULT_SIZE, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
					.addGap(108))
		);
		gl_panMain.setAutoCreateGaps(true);
		gl_panMain.setAutoCreateContainerGaps(true);
		panMain.setLayout(gl_panMain);
		
		this.addComponentListener(this);
		this.setSize(WIDTH_ORIGIN,HEIGHT_ORIGIN);
		this.widthLast=WIDTH_ORIGIN;
		this.heightLast=HEIGHT_ORIGIN;
		
		/**
		 * Define resizeTimer: When user resize finished, this timer will kick off a manual size adjustment
		 */
		this.resizeTimer = new Timer(200,this); 
		
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
			
		}
		
		if(a.getSource() == btnExit) {
			frame.passLoginInfo(null, null);
			dispose();
			frame.dispose();
			System.exit(0);
		}
		
		if(a.getSource()==this.resizeTimer){    //Perform a manual resize 
			int width=this.getWidth();
			int height=this.getHeight();
			double sizingFactor=new Double(width+height)/new Double(this.widthLast+this.heightLast);
			int widthNew= (int)Math.round(this.widthLast*sizingFactor<WIDTH_ORIGIN?WIDTH_ORIGIN:this.widthLast*sizingFactor);
			int heightNew=(int)Math.round(this.heightLast*sizingFactor<HEIGHT_ORIGIN?HEIGHT_ORIGIN:this.heightLast*sizingFactor); 
			this.setSize(widthNew,heightNew);
			sizingFactor=new Double(widthNew+heightNew)/new Double(this.widthLast+this.heightLast);
			this.widthLast=widthNew;
			this.heightLast=heightNew;
			
			this.modifyFont(this.lblTitle1, sizingFactor);
			this.modifyFont(this.lblTitle2, sizingFactor);
			this.modifyFont(this.btnOK, sizingFactor);
			this.modifyFont(this.btnExit, sizingFactor);
			this.modifyFont(this.lblPartyCode, sizingFactor);
			this.modifyFont(this.lblPassword, sizingFactor);
			this.modifyFont(this.cboPartyCode, sizingFactor);
			this.modifyFont(this.pwdPassword, sizingFactor);
			this.modifyFont(this.lblCopyRight, sizingFactor);
			this.modifyFont(this.lblLogo, sizingFactor);

			//this.modifyComponentSize(this.panTop, sizingFactor);
			//this.modifyComponentSize(this.panMain, sizingFactor);
			//this.modifyComponentSize(this.panButton, sizingFactor);
			
			/**
			 * This timer is set to stop the javax.swing.Timer from restarting by an 
			 * up-coming ComponentEvent invoke by this.setSize() above. 
			 */
			java.util.Timer timer=new java.util.Timer();
			TimerTask task= new ResizeHelper(this.resizeTimer);
			timer.schedule(task, 150);
			
		}
	}
	
	private void modifyFont(Component comp, double factor) {
		Font font=comp.getFont();
		String fontFamily=font.getFamily();
		int fontStyle=font.getStyle();
		int fontSize=font.getSize();
		int newFontSize= (int)Math.round(fontSize*factor);
		if (newFontSize>30){
			newFontSize=30;
		}
		if (newFontSize<5){
			newFontSize=5;
		}
		comp.setFont(new Font(fontFamily, fontStyle, newFontSize));
	}
	
	@Override
	public void componentResized(ComponentEvent arg0) {
		System.out.println("Invoke resize listener");
		if (!(this.getWidth()==500 & this.getHeight()==500)){
			this.resizeTimer.restart();	
		}
	}
	
	/** 
	 * This Class is created to support the window resizing operation. It is invoked by
	 * method actionPerformed(ActionEvent) in UserInterface 0.2 seconds after whenever 
	 * application user drag to resize the window.  
	 * @Date	2016-01-04
	 * @author	Myles I.
	 */
	private class ResizeHelper extends TimerTask {
		private Timer t;
		public ResizeHelper(Timer t){
			this.t=t;
		}

		public void run() {
			t.stop();
		}
	}
	
	/**
	 * Below are deactivated method inherited from interface
	 * 
	 */
	@Override
	public void componentHidden(ComponentEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void componentMoved(ComponentEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void componentShown(ComponentEvent arg0) {
		// TODO Auto-generated method stub
		
	}
}
