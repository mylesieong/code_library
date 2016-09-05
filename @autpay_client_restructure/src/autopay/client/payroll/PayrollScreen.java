package autopay.client.payroll;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ComponentEvent;
import java.awt.event.ComponentListener;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseEvent;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.Properties;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.imageio.ImageIO;
import javax.swing.ButtonGroup;
import javax.swing.GroupLayout;
import javax.swing.GroupLayout.Alignment;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JRadioButton;
import javax.swing.JScrollPane;
import javax.swing.JSeparator;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.LayoutStyle.ComponentPlacement;
import javax.swing.SwingConstants;
import javax.swing.border.BevelBorder;
import javax.swing.border.EmptyBorder;
import javax.swing.border.TitledBorder;
import javax.swing.event.CellEditorListener;
import javax.swing.event.ChangeEvent;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import javax.swing.filechooser.FileNameExtensionFilter;
import javax.swing.table.TableModel;
import javax.swing.table.TableRowSorter;
import javax.swing.text.AttributeSet;
import javax.swing.text.BadLocationException;
import javax.swing.text.PlainDocument;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;

import autopay.client.Language;
import autopay.client.MainScreen;
import autopay.client.MainScreenController;
import autopay.client.MainScreenModel;
import autopay.client.LoginScreen;
import autopay.client.RunAutopayExe;
import autopay.util.Cryptography;
import autopay.util.DBConnector;
import autopay.util.FileConnector;

import com.itextpdf.text.DocumentException;

import datechooser.beans.DateChooserDialog;
import datechooser.beans.PermanentBean;
import datechooser.model.multiple.Period;
import datechooser.model.multiple.PeriodSet;

/**
 * Main screen to interact with user.
 * 
 * @author Francisco Lo BB14PGM
 * @since 28/10/2010
 * 
 */

@SuppressWarnings("serial")
public class PayrollScreen extends MainScreen implements ActionListener, FocusListener, CellEditorListener, KeyListener, WindowListener, DocumentListener, ComponentListener {
	
	private static final int DATABASE = 0, EXCEL = 1, PDF = 2;
	/*MYLES*/
	private static final int PAYROLL_ACC_MAX_LEN=10;
	/*/Myles*/
	/*MYLES: support font-size changing */
	private static final int PAYROLLSCREEN_MINX = 590, PAYROLLSCREEN_MINY=460;
	private static final int DEFAULT_FONT_SIZE_EN=12, DEFAULT_FONT_SIZE_CN=14;
	/*/Myles*/
	
	private String SEARCH_TEXT;
	private MainScreenModel model;
	private MainScreenController control;
	private LoginScreen dlgLogin;
	private DecimalFormat amount, record;
	private Font fntSearch;
	
	private JPanel contentPane;
	private JMenuBar mbrPayroll;
	private JMenu mnuFile;
	private JMenu mnuRow;
	private JMenu mnuAbout;
	private JMenuItem mitSave;
	private JMenuItem mitGenerateFile;
	private JMenu mnuPrint;
	private JMenuItem mitImport;
	private JMenuItem mitLogout;
	private JMenuItem mitExit;
	private JMenuItem mitAdd;
	private JMenuItem mitDelete;
	private JMenuItem mitClearAll;
	private JMenuItem mitVersion;
	private JMenuItem mitResetPassword;
	private JSeparator sepMnuFileImport;
	private JSeparator sepMnuFilePrint;
	private JPanel panButtons;
	private JButton btnSave;
	private JPanel panMain;
	private JButton btnGenerateFile;
	private JButton btnInsert;
	private JSeparator sepGenAdd;
	private JButton btnDelete;
	private JPanel panRight;
	private JButton btnSearch;
	private JButton btnDatePicker;
	private JPanel panLeft;
	private JTextField txtSearch;
	private JLabel lblPartyCode;
	private JLabel lblPartyName;
	private JTextField txtPartyCode;
	private JTextField txtPartyName;
	private JPanel panParty;
	private JPanel panPayment;
	private JTextField txtPaymentDate;
	private JTextField txtPaymentID;
	private JLabel lblPaymentID;
	private JLabel lblPaymentDate;
	private JPanel panel;
	private JTextField txtTotalTxn;
	private JLabel lblTotalTxn;
	private JLabel lblTotalAmount;
	private JTextField txtAmount;
	private JLabel lblInputtedAmount;
	private JTextField txtInputtedAmount;
	private JTextField txtInputtedRecord;
	private JLabel lblInputtedRecord;
	private JScrollPane scp;
	private JTable tbl;
	private JFileChooser fchGenerate;
	private JFileChooser fchImport;
	private JMenuItem mitInsert;
	private Properties autopayOption;
	private JRadioButton rdoDB;
	private JRadioButton rdoExcel;
	private ButtonGroup gup;
	private JMenuItem mitPrinter;
	private JMenuItem mitPDF;
	private JTextField txtSeq;
	private JLabel lblSeq;
	private FileNameExtensionFilter filterDAT;
	private FileNameExtensionFilter filterXLS;
	private FileNameExtensionFilter filterXLSX;
	private FileNameExtensionFilter filterPDF;

	private boolean keyCtrl = false;
	private Object copiedObject = null;
	
	//for testing only - lets windows builder to work
	public PayrollScreen() throws NumberFormatException, ClassNotFoundException, SQLException {
		this(null);
	}
	
	public PayrollScreen(Properties config) throws NumberFormatException, ClassNotFoundException, SQLException {
		super(config);
		try {
			autopayOption = FileConnector.loadAutopaySetting();
			/*MYLES
			model = new MainScreenModel(new String[]{ln._TableName(), ln._TableAccount(), ln._TableAmount(), ln._TableReference()}, this);
			*/
			/*MYLES: Change ln._tableAccount() to ln._tableAccount4P()*/
			model = new MainScreenModel(new String[]{ln._TableName(), ln._TableAccount4P(), ln._TableAmount(), ln._TableReference()}, this);
			/*/MYLES*/
			control = new MainScreenController(model);

			init();
		} catch (Exception e) {
			handleException(e);
			JOptionPane.showMessageDialog(this, ln._AppForceClose(), 
					ln._Exit(), JOptionPane.WARNING_MESSAGE);
			System.exit(1);
		}
	}
	
	private void init() throws SQLException, ClassNotFoundException {
		setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
		addWindowListener(this);
		setBounds(100, 100, 800, 600);
		setMinimumSize(new Dimension(PAYROLLSCREEN_MINX, PAYROLLSCREEN_MINY));		
		
		SEARCH_TEXT = ln._SearchText();
		setTitle(ln._ApplicationName());
		
		Font fnt14;
		if(ln.getLanguage() == Language.CN) {
			fntSearch = new Font("�s�ө���", Font.ITALIC, 11);
			fnt14 = new Font("�s�ө���", Font.BOLD, DEFAULT_FONT_SIZE_CN);
		} else {	//defaults to English
			fntSearch = new Font("Tahoma", Font.ITALIC, 11); //20//11
			fnt14 = new Font("Tahoma", Font.PLAIN, DEFAULT_FONT_SIZE_EN); //20//14
		}
		Color lightBlue = new Color(70, 50, 250);
		record = new DecimalFormat("#,###");
		amount = new DecimalFormat("#,###.00");
		if(model.getPartyList().length == 0) {
			JOptionPane.showMessageDialog(this, ln._RunSetup(), 
					ln._Exit(), JOptionPane.WARNING_MESSAGE);
			System.exit(1);
			return;
		}
				
		mbrPayroll = new JMenuBar();
		setJMenuBar(mbrPayroll);
		
		mnuFile = new JMenu(ln._File());
		mnuFile.setMnemonic('F');
		mbrPayroll.add(mnuFile);
		
		mitSave = new JMenuItem(ln._SaveAs());
		mitSave.setMnemonic('S');
		mitSave.addActionListener(this);
		mnuFile.add(mitSave);
		
		mitGenerateFile = new JMenuItem(ln._GenerateFile());
		mitGenerateFile.addActionListener(this);
		mitGenerateFile.setMnemonic('G');
		mnuFile.add(mitGenerateFile);
		
		mitImport = new JMenuItem(ln._Import());
		mitImport.addActionListener(this);
		mitImport.setMnemonic('I');
		mnuFile.add(mitImport);
		
		sepMnuFileImport = new JSeparator();
		mnuFile.add(sepMnuFileImport);
		
		mnuPrint = new JMenu(ln._Print());
		mnuPrint.setMnemonic('P');
		mnuFile.add(mnuPrint);
		
		mitPrinter = new JMenuItem(ln._Printer());
		mitPrinter.addActionListener(this);
		mnuPrint.add(mitPrinter);
		
		mitPDF = new JMenuItem(ln._PDF());
		mitPDF.addActionListener(this);
		mnuPrint.add(mitPDF);
		
		sepMnuFilePrint = new JSeparator();
		mnuFile.add(sepMnuFilePrint);
		
		mitLogout = new JMenuItem(ln._LogInOut());
		mitLogout.addActionListener(this);
		mitLogout.setMnemonic('L');
		mnuFile.add(mitLogout);
		
		mitExit = new JMenuItem(ln._Exit());
		mitExit.addActionListener(this);
		mitExit.setMnemonic('X');
		mnuFile.add(mitExit);
		
		mnuRow = new JMenu(ln._Row());
		mnuRow.setMnemonic('R');
		mbrPayroll.add(mnuRow);
		
		mitAdd = new JMenuItem(ln._Add());
		mitAdd.addActionListener(this);
		mitAdd.setMnemonic('A');
		mnuRow.add(mitAdd);
		
		mitInsert = new JMenuItem(ln._Insert());
		mitInsert.addActionListener(this);
		mitInsert.setMnemonic('I');
		mnuRow.add(mitInsert);
		
		mitDelete = new JMenuItem(ln._Delete());
		mitDelete.addActionListener(this);
		mitDelete.setMnemonic('D');
		mnuRow.add(mitDelete);
		
		mitClearAll = new JMenuItem(ln._ClearAll());
		mitClearAll.addActionListener(this);
		mitClearAll.setMnemonic('C');
		mnuRow.add(mitClearAll);
		
		mnuAbout = new JMenu(ln._About());
		mnuAbout.setMnemonic('B');
		mbrPayroll.add(mnuAbout);
		
		mitVersion = new JMenuItem(ln._Version());
		mitVersion.addActionListener(this);
		mitVersion.setMnemonic('V');
		mnuAbout.add(mitVersion);
		
		mitResetPassword = new JMenuItem("Reset Password");
		mitResetPassword.addActionListener(this);
		mnuAbout.add(mitResetPassword);
		
		contentPane = new JPanel();
		contentPane.setSize(contentPane.getPreferredSize());
		
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(new BorderLayout(0, 0));
		
		panButtons = new JPanel();
		contentPane.add(panButtons, BorderLayout.NORTH);
		panButtons.setLayout(new BorderLayout(0, 0));
		
		panLeft = new JPanel();
		panLeft.setSize(panLeft.getPreferredSize()); //tommy
		FlowLayout flowLayout = (FlowLayout) panLeft.getLayout();
		flowLayout.setVgap(0);
		flowLayout.setHgap(0);
		flowLayout.setAlignment(FlowLayout.LEFT);
		panButtons.add(panLeft, BorderLayout.WEST);
		
		btnSave = new JButton(ln._Save());
		panLeft.add(btnSave);
		btnSave.setMnemonic('S');
		btnSave.addActionListener(this);
		
		btnGenerateFile = new JButton(ln._GenerateFile());
		btnGenerateFile.addActionListener(this);
		panLeft.add(btnGenerateFile);
		
		sepGenAdd = new JSeparator();
		panLeft.add(sepGenAdd);
		sepGenAdd.setOrientation(SwingConstants.VERTICAL);
		
		btnInsert = new JButton(ln._InsertRow());
		btnInsert.setMnemonic('I');
		btnInsert.addActionListener(this);
		panLeft.add(btnInsert);
		
		btnDelete = new JButton(ln._DeleteRow());
		btnDelete.setMnemonic('D');
		btnDelete.addActionListener(this);
		panLeft.add(btnDelete);
		
		panRight = new JPanel();
		panRight.setSize(panRight.getPreferredSize());
		FlowLayout fl_panRight = (FlowLayout) panRight.getLayout();
		fl_panRight.setVgap(0);
		fl_panRight.setHgap(0);
		fl_panRight.setAlignment(FlowLayout.RIGHT);
		panButtons.add(panRight, BorderLayout.EAST);
		
		txtSearch = new JTextField();
		txtSearch.addFocusListener(this);
		//txtSearch.setForeground(Color.LIGHT_GRAY); //tommy
		//txtSearch.setFont(fntSearch); //tommy		
		//txtSearch.setText(SEARCH_TEXT); //tommy
		
		txtSearch.setFont(fnt14); //tommy	 
		panRight.add(txtSearch);
		txtSearch.setColumns(15); 
		
		btnSearch = new JButton(ln._Search());
		btnSearch.addActionListener(this);
		panRight.add(btnSearch);
		
		panMain = new JPanel();
		panMain.setSize(panMain.getPreferredSize()); //tommy
		panMain.setBorder(new BevelBorder(BevelBorder.LOWERED, null, null, null, null));
		contentPane.add(panMain, BorderLayout.CENTER);
		
		panParty = new JPanel();
		
		panParty.setBorder(new TitledBorder(null, ln._DebitParty(), TitledBorder.LEADING, TitledBorder.TOP, fnt14, lightBlue));
		
		panPayment = new JPanel();
		panPayment.setSize(panPayment.getPreferredSize()); //tommy
		panPayment.setBorder(new TitledBorder(null, ln._Payment(), TitledBorder.LEADING, TitledBorder.TOP, fnt14, lightBlue));
		panPayment.setLayout(null);
		
		txtPaymentDate = new JTextField();
		txtPaymentDate.setFont(fnt14); //tommy
		
		txtPaymentDate.setToolTipText(ln._ToolTipPaymentDate());
		txtPaymentDate.setColumns(8);
		txtPaymentDate.setBounds(100, 51, 118, 18);
		//txtPaymentDate.setSize(txtPaymentDate.getPreferredSize()); //tommy
		txtPaymentDate.setEditable(false);
		panPayment.add(txtPaymentDate);
		
		txtPaymentID = new JTextField();
        txtPaymentID.setFont(fnt14);	//tommy	        
		txtPaymentID.setToolTipText(ln._ToolTipPaymentID1() + " " + FileConnector.Header.PART6.length() + ln._ToolTipPaymentID2());
		txtPaymentID.setColumns(10);
		txtPaymentID.setBounds(100, 25, 150, 18);
		//txtPaymentID.setSize(txtPaymentID.getPreferredSize()); //tommy
		txtPaymentID.setDocument(new TextFieldFormat(FileConnector.Header.PART6.length(), TextFieldFormat.INTEGERS));
		panPayment.add(txtPaymentID);
		
		lblPaymentID = new JLabel(ln._ID());
		lblPaymentID.setFont(fnt14); //tommy
		lblPaymentID.setBounds(12, 25, 46, 14);
		//lblPaymentID.setSize(lblPaymentID.getPreferredSize()); //tommy
		panPayment.add(lblPaymentID);
		
		lblPaymentDate = new JLabel(ln._PaymentDate());
		lblPaymentDate.setFont(fnt14); //tommy		
		lblPaymentDate.setBounds(12, 49, 46, 14);
		//lblPaymentDate.setSize(lblPaymentDate.getPreferredSize()); //tommy
		panPayment.add(lblPaymentDate);
		
		panel = new JPanel();
		panel.setBorder(new TitledBorder(null, ln._Total(), TitledBorder.LEADING, TitledBorder.TOP, fnt14, lightBlue));
		panel.setLayout(null);
		panel.setSize(panel.getPreferredSize()); //tommy
		
		txtTotalTxn = new JTextField();
		txtTotalTxn.setFont(fnt14); //tommy		
		txtTotalTxn.setToolTipText(ln._ToolTipTotalTxn1() + " " + FileConnector.Header.PART5.length() + ln._ToolTipTotalTxn2());
		txtTotalTxn.setColumns(10);
		txtTotalTxn.setBounds(100, 48, 150, 18);
		//txtTotalTxn.setSize(txtTotalTxn.getPreferredSize()); //tommy
		txtTotalTxn.setDocument(new TextFieldFormat(FileConnector.Header.PART5.length(), TextFieldFormat.INTEGERS));
		panel.add(txtTotalTxn);
		
		lblTotalTxn = new JLabel(ln._TotalDebitTxn());
		lblTotalTxn.setFont(fnt14); //tommy		
		lblTotalTxn.setBounds(12, 30, 117, 14);
		//lblTotalTxn.setSize(lblTotalTxn.getPreferredSize()); //tommy
		panel.add(lblTotalTxn);
		
		lblTotalAmount = new JLabel(ln._TotalDebitAmount());
		lblTotalAmount.setFont(fnt14); //tommy		
		lblTotalAmount.setBounds(12, 67, 117, 14);
		//lblTotalAmount.setSize(lblTotalAmount.getPreferredSize()); //tommy
		panel.add(lblTotalAmount);
		
		txtAmount = new JTextField();
		txtAmount.setFont(fnt14); //tommy		
		txtAmount.setToolTipText(ln._ToolTipTotalAmount1() + " " + (FileConnector.Header.PART4.length() - 3) + ln._ToolTipTotalAmount2());
		txtAmount.setColumns(10);
		txtAmount.setBounds(100, 82, 150, 18);
		//txtAmount.setSize(txtAmount.getPreferredSize()); //tommy
		txtAmount.setDocument(new TextFieldFormat(FileConnector.Header.PART4.length(), TextFieldFormat.REALNUMBERS));
		panel.add(txtAmount);
		
		lblInputtedAmount = new JLabel(ln._InputtedAmount());
		lblInputtedAmount.setFont(fnt14); //tommy
		lblInputtedAmount.setBounds(12, 147, 173, 14);
		//lblInputtedAmount.setSize(lblInputtedAmount.getPreferredSize()); //tommy		
		panel.add(lblInputtedAmount);
		
		txtInputtedAmount = new JTextField();
		txtInputtedAmount.setFont(fnt14); //tommy		
		txtInputtedAmount.setToolTipText(ln._ToolTipInputtedAmount());
		txtInputtedAmount.setEditable(false);
		txtInputtedAmount.setColumns(10);
		txtInputtedAmount.setBounds(100, 161, 150, 18);
		//txtInputtedAmount.setSize(txtInputtedAmount.getPreferredSize()); //tommy
		panel.add(txtInputtedAmount);
		
		txtInputtedRecord = new JTextField();
		txtInputtedRecord.setFont(fnt14); //tommy		
		txtInputtedRecord.setToolTipText(ln._ToolTipInputtedRecord());
		txtInputtedRecord.setEditable(false);
		txtInputtedRecord.setColumns(10);
		txtInputtedRecord.setBounds(100, 127, 150, 18);
		//txtInputtedRecord.setSize(txtInputtedRecord.getPreferredSize()); //tommy
		panel.add(txtInputtedRecord);
		
		lblInputtedRecord = new JLabel(ln._InputtedRecord());
		lblInputtedRecord.setFont(fnt14); //tommy		
		lblInputtedRecord.setBounds(12, 111, 173, 14);
		//lblInputtedRecord.setSize(lblInputtedRecord.getPreferredSize()); //tommy
		panel.add(lblInputtedRecord);
		panParty.setLayout(null);
		
		
		txtPartyName = new JTextField();
		txtPartyName.setFont(fnt14); //tommy	
		txtPartyName.setToolTipText(ln._ToolTipPartyName1() + " " + FileConnector.Header.PART7.length() + ln._ToolTipPartyName2());
		txtPartyName.setBounds(100, 51, 150, 18);		
		txtPartyName.setColumns(10);
		//txtPartyName.setSize(txtPartyName.getPreferredSize()); //tommy
		txtPartyName.setDocument(new TextFieldFormat(FileConnector.Header.PART7.length()));
		panParty.add(txtPartyName);
		
		txtPartyCode = new JTextField();
		txtPartyCode.setFont(fnt14); //tommy		
		txtPartyCode.setToolTipText(ln._ToolTipPartyCode());
		txtPartyCode.setBounds(100, 23, 150, 18);		
		txtPartyCode.setEditable(false);
		txtPartyCode.setColumns(10);
		//txtPartyCode.setSize(txtPartyCode.getPreferredSize()); //tommy
		panParty.add(txtPartyCode);
		
		lblPartyCode = new JLabel(ln._Code());
		lblPartyCode.setMaximumSize(new Dimension(100, 14));
		lblPartyCode.setFont(fnt14); //tommy		
		lblPartyCode.setBounds(12, 25, 78, 14);
		//lblPartyCode.setSize(lblPartyCode.getPreferredSize()); //tommy		
		panParty.add(lblPartyCode);
		
		lblPartyName = new JLabel(ln._Name());
		lblPartyName.setMaximumSize(new Dimension(100, 14));
		lblPartyName.setFont(fnt14); //tommy		
		lblPartyName.setBounds(12, 49, 78, 14);
		//lblPartyName.setSize(lblPartyName.getPreferredSize()); //tommy
		panParty.add(lblPartyName);
		
		panParty.setSize(panParty.getPreferredSize()); //tommy
		
		tbl = new JTable(model.getTableModel()) {
			public String getToolTipText(MouseEvent e) {
                int realColumnIndex = convertColumnIndexToModel(columnAtPoint(e.getPoint()));

                switch(realColumnIndex) {
                	case MainScreenModel.NAME_INDEX: 
                		return ln._ToolTipTableBegin() + FileConnector.Detail.PART6.length() + ln._ToolTipTableString();
                	case MainScreenModel.ACCOUNT_INDEX:
                		return ln._ToolTipTableBegin() + FileConnector.Detail.PART2.length() + ln._ToolTipTableNumber();
                	case MainScreenModel.AMOUNT_INDEX:
                		return ln._ToolTipTableBegin() + (FileConnector.Detail.PART3.length()-2) + ln._ToolTipTableRealNumber();
                	case MainScreenModel.REF_INDEX:
                		return ln._ToolTipTableBegin() + FileConnector.Detail.PART4.length() + ln._ToolTipTableString();
                	default:
                		return super.getToolTipText(e);
                }
            }
		};
		tbl.setFont(fnt14); //tommy
		tbl.getTableHeader().setFont(fnt14);
		tbl.getTableHeader().setReorderingAllowed(false);
		tbl.setRowSorter(new TableRowSorter<TableModel>(model.getTableModel()));
		for(int i=0; i<tbl.getColumnCount(); i++) {
			/*Myles
			tbl.setDefaultEditor(model.getTableModel().getColumnClass(i), new AutoPayCellEditor());
			*/
			/*Myles:inject tableModel*/
			tbl.setDefaultEditor(model.getTableModel().getColumnClass(i), new PayrollCellEditor().setTableModel(model.getTableModel()));			
			/*/Myles*/
		}
		tbl.setDefaultRenderer(Double.class, new NumberRenderer());
		//add different listeners to table
		tbl.getDefaultEditor(tbl.getColumnClass(MainScreenModel.AMOUNT_INDEX)).addCellEditorListener(this);
		tbl.addKeyListener(this);
		
		scp = new JScrollPane();
		scp.setViewportView(tbl);

		txtSearch.setToolTipText(ln._ToolTipSearch1() + 
				tbl.getColumnName(MainScreenModel.NAME_INDEX) + ln._ToolTipSearch2() + 
				tbl.getColumnName(MainScreenModel.ACCOUNT_INDEX) + "\"");
		
		txtSeq = new JTextField();
		txtSeq.setFont(fnt14); //tommy
		//txtSeq.setSize(txtSeq.getPreferredSize()); //tommy
		txtSeq.setEditable(false);
		txtSeq.setColumns(10);
		
		lblSeq = new JLabel(ln._Seq());
		lblSeq.setFont(fnt14); //tommy
		//lblSeq.setSize(lblSeq.getPreferredSize()); //tommy
		
		GroupLayout gl_panMain = new GroupLayout(panMain);
		gl_panMain.setHorizontalGroup(
			gl_panMain.createParallelGroup(Alignment.LEADING)
				.addGroup(gl_panMain.createSequentialGroup()
					.addGap(12)
					.addGroup(gl_panMain.createParallelGroup(Alignment.TRAILING, false)
						.addComponent(panParty, GroupLayout.DEFAULT_SIZE, 260, Short.MAX_VALUE)
						.addComponent(panPayment, GroupLayout.DEFAULT_SIZE, 260, Short.MAX_VALUE)
						.addGroup(gl_panMain.createSequentialGroup()
							.addComponent(lblSeq)
							.addPreferredGap(ComponentPlacement.RELATED)
							.addComponent(txtSeq, GroupLayout.PREFERRED_SIZE, 128, GroupLayout.PREFERRED_SIZE)
							.addGap(10))
						.addComponent(panel, GroupLayout.DEFAULT_SIZE, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
					.addPreferredGap(ComponentPlacement.RELATED)
					.addComponent(scp, GroupLayout.DEFAULT_SIZE, 542, Short.MAX_VALUE)
					.addContainerGap())
		);
		gl_panMain.setVerticalGroup(
			gl_panMain.createParallelGroup(Alignment.LEADING)
				.addGroup(gl_panMain.createSequentialGroup()
					.addGroup(gl_panMain.createParallelGroup(Alignment.LEADING)
						.addGroup(gl_panMain.createSequentialGroup()
							.addComponent(panParty, GroupLayout.PREFERRED_SIZE, 80, GroupLayout.PREFERRED_SIZE)
							.addPreferredGap(ComponentPlacement.RELATED)
							.addComponent(panPayment, GroupLayout.PREFERRED_SIZE, 80, GroupLayout.PREFERRED_SIZE)
							.addPreferredGap(ComponentPlacement.RELATED)
							.addComponent(panel, GroupLayout.PREFERRED_SIZE, 190, GroupLayout.PREFERRED_SIZE)
							.addPreferredGap(ComponentPlacement.RELATED, 109, Short.MAX_VALUE)
							.addGroup(gl_panMain.createParallelGroup(Alignment.BASELINE)
								.addComponent(txtSeq, GroupLayout.PREFERRED_SIZE, 18, GroupLayout.PREFERRED_SIZE)
								.addComponent(lblSeq)))
						.addComponent(scp, GroupLayout.DEFAULT_SIZE, 482, Short.MAX_VALUE))
					.addContainerGap())
		);
		
		btnDatePicker = new JButton("...");
		btnDatePicker.addActionListener(this);
		btnDatePicker.setBounds(228, 51, 22, 18);
		panPayment.add(btnDatePicker);
		gl_panMain.setAutoCreateGaps(true);
		gl_panMain.setAutoCreateContainerGaps(true);
		panMain.setLayout(gl_panMain);

		filterDAT = new FileNameExtensionFilter(ln._BCMFormatDatFile(), "DAT");
		filterXLS = new FileNameExtensionFilter(ln._ExcelFile(), "XLS");
		filterXLSX = new FileNameExtensionFilter(ln._ExcelFile2007(), "XLSX");
		filterPDF = new FileNameExtensionFilter(ln._PDFFile(), "PDF");
		fchGenerate = new JFileChooser();
		fchGenerate.setSelectedFile(new File(autopayOption.getProperty("GeneratedFileName", "DBPBCM")));
		
		fchImport = new JFileChooser();
		fchImport.addChoosableFileFilter(filterDAT);
		fchImport.addChoosableFileFilter(filterXLS);
		fchImport.addChoosableFileFilter(filterXLSX);
		fchImport.setFileFilter(filterDAT);
		
		rdoDB = new JRadioButton(ln._DotLocalDatabase());
		rdoExcel = new JRadioButton(ln._DotExcel());
		gup = new ButtonGroup();
		gup.add(rdoDB);
		gup.add(rdoExcel);
		rdoDB.setSelected(true);
		
		/*Myles: Activate componentListener*/
		this.addComponentListener(this);
		/*/Myles*/
		//this.tbl.setAutoResizeMode(JTable.AUTO_RESIZE_ALL_COLUMNS);

		setControlEnable(false);
		setLocationRelativeTo(null);
		setVisible(true);
		
		displayLoginWin();
	}
	
	@Override
	protected void setInputtedRecord(int totalEmps) {
		txtInputtedRecord.setText(record.format(totalEmps));
	}

	@Override
	protected void setInputtedAmount(double totalAmount) {
		txtInputtedAmount.setText(amount.format(totalAmount));
	}

	@Override
	protected void setModifiedSeq(long seq) {
		txtSeq.setText(String.valueOf(seq));
	}
	
	@Override
	protected void passLoginInfo(String partyCode, char[] password) {
		try {
			if(partyCode != null) {
				if(control.comparePassword(partyCode, password, true) == MainScreenModel.LOGOUT) {
					JOptionPane.showMessageDialog(this, ln._IncorrectPassword(), 
							null, JOptionPane.WARNING_MESSAGE);
					/**
					 * Myles' Edit 2016-1-6: delete 1 line
					 */
					//setControlEnable(false);
					displayLoginWin();
				} else {
					setControlEnable(true);
					/**
					 * Myles' Edit 2016-1-6: Move 2 lines into if-block [PartB]
					 * */
					setMenuEnable(true);
					initValue();
					/**
					 * Myles' Edit 2016-1-6: add 1 line
					 */
					this.setVisible(true);
					
					
					
				}
			}
			/**
			 * Myles' Edit 2016-1-6: Move 2 lines into if-block [PartA]
			 * */
			//setMenuEnable(true);
			//initValue();
		} catch (Exception e) {
			handleException(e);
		}
	}

	/*
	 * Event handlers
	 */
	
	public void actionPerformed(ActionEvent a) {

		if(a.getSource() == btnSave) {
			try {
				save(DATABASE);
			} catch (Exception e) {
				handleException(e);
			}
		}
		
		else if(a.getSource() == btnGenerateFile) {
			try {
				generateFile();
			} catch (Exception e) {
				handleException(e);
			}
		}
		
		else if(a.getSource() == btnInsert) {
			try {
				insertRow();
			} catch (Exception e) {
				handleException(e);
			}
		}
		
		else if(a.getSource() == btnDelete) {
			try {
				if(tbl.getSelectedRow() > -1) {
					int option = JOptionPane.showConfirmDialog(this, ln._DeleteDataConfirm(), 
							ln._SelectOption(), JOptionPane.YES_NO_OPTION);
					if(option == JOptionPane.YES_OPTION) {
						deleteRow();
					}
				}
			}  catch (Exception e) {
				handleException(e);
			}
		}
		
		else if(a.getSource() == btnSearch) {
			try {
				if(!txtSearch.getText().trim().equals(SEARCH_TEXT)) {
					int row = control.searchRow(txtSearch.getText().trim());
					if(row >= 0) {
						row = tbl.convertRowIndexToView(row);
						tbl.getSelectionModel().setSelectionInterval(row, row);
						scp.getVerticalScrollBar().setValue(row * tbl.getRowHeight());
					} else {
						JOptionPane.showMessageDialog(this, ln._TextNotFound(), 
								ln._SearchResult(), JOptionPane.INFORMATION_MESSAGE);
					}
				}
			}  catch (Exception e) {
				handleException(e);
			}
		}
		
		else if(a.getSource() == btnDatePicker) {
			try {
				DateChooserDialog dc = new DateChooserDialog();
				PermanentBean.loadBeanParameters(dc, 
						new File("Config\\DateChooserDialog.dchd"));
				
				Calendar c = Calendar.getInstance();
//				String date = txtPaymentDate.getText();
//				if(!date.equals("")) {
//					c.set(new Integer(date.substring(0, 4)), 
//							new Integer(date.substring(4, 6)) - 1, 
//									new Integer(date.substring(6)));
//				}
				dc.setDefaultPeriods(new PeriodSet(new Period(c)));
				
        		dc.showDialog(this);
        		c = dc.getSelectedDate();
        		DecimalFormat df = new DecimalFormat("00");
        		txtPaymentDate.setText(c.get(Calendar.YEAR) +
        				df.format((c.get(Calendar.MONTH)+1)) +
        				df.format(c.get(Calendar.DAY_OF_MONTH)));
			}  catch (Exception e) {
				handleException(e);
			}
		}
		
		else if(a.getSource() == mitSave) {
			try {
				int option = JOptionPane.showConfirmDialog(this, new Object[]{rdoDB, rdoExcel}, 
						ln._SaveAs(), JOptionPane.OK_CANCEL_OPTION);
				if(option == JOptionPane.OK_OPTION) {
					if(rdoDB.isSelected())
						save(DATABASE);
					else if(rdoExcel.isSelected())
						save(EXCEL);
				}
			} catch (Exception e) {
				handleException(e);
			}
		}
		
		else if(a.getSource() == mitGenerateFile) {
			try {
				generateFile();
			} catch (Exception e) {
				handleException(e);
			}
		}
		
		else if(a.getSource() == mitImport) {
			try {
				int option = JOptionPane.showConfirmDialog(this, 
						ln._SaveBeforeImport(), 
						ln._SelectOption(), JOptionPane.YES_NO_CANCEL_OPTION);
				if(option != JOptionPane.CANCEL_OPTION) {
					if(option == JOptionPane.YES_OPTION) {
						if(!save(DATABASE)) return;
					}
					option = fchImport.showOpenDialog(this);
					if(option == JFileChooser.APPROVE_OPTION) {
						if(control.importFile(fchImport.getSelectedFile().getPath()) == true) {
							JOptionPane.showMessageDialog(this, ln._ImportSuccessful(), 
									null, JOptionPane.INFORMATION_MESSAGE);
							initValue();	
						} else {
							JOptionPane.showMessageDialog(this, ln._FileNotBelongParty(), 
									null, JOptionPane.INFORMATION_MESSAGE);
						}
					}
				}
			} catch (Exception e) {
				handleException(e);
			}
		}
		
		else if(a.getSource() == mitPrinter) {
			try {
				if(saveConfirmed()) {
					control.print();
				}
			} catch (Exception e) {
				handleException(e);
			}
		}
		
		else if(a.getSource() == mitPDF) {
			try {
				save(PDF);
			} catch (Exception e) {
				handleException(e);
			}
		}
		
		else if(a.getSource() == mitLogout) {
			try {
				if(leaveConfirmed(ln._LogoutConfirm())) {
					control.logout();
					initValue();
					setControlEnable(false);
					displayLoginWin();
				}
			} catch (Exception e) {
				handleException(e);
			}
		}
		
		else if(a.getSource() == mitExit) {
			if(leaveConfirmed(ln._ExitConfirm())) {
				dispose();
				System.exit(0);
			}
		}
		
		else if(a.getSource() == mitAdd) {
			try {
				control.addRow();
			} catch (Exception e) {
				handleException(e);
			}
		}
		
		else if(a.getSource() == mitInsert) {
			try {
				insertRow();
			} catch (Exception e) {
				handleException(e);
			}
		}
		
		else if(a.getSource() == mitDelete) {
			try {
				if(tbl.getSelectedRow() > -1) {
					int option = JOptionPane.showConfirmDialog(this, 
							ln._DeleteDataConfirm(), 
							ln._SelectOption(), JOptionPane.YES_NO_OPTION);
					if(option == JOptionPane.YES_OPTION) {
						deleteRow();
					}
				}
			}  catch (Exception e) {
				handleException(e);
			}
		}
		
		else if(a.getSource() == mitClearAll) {
			try {
				int option = JOptionPane.showConfirmDialog(this, 
						ln._ClearDataConfirm(), 
						ln._SelectOption(), JOptionPane.YES_NO_OPTION);
				if(option == JOptionPane.YES_OPTION) {
					tbl.getSelectionModel().setSelectionInterval(0, tbl.getRowCount()-1);
					deleteRow();
				}
			}  catch (Exception e) {
				handleException(e);
			}
		}
		
		else if(a.getSource() == mitVersion) {
			try {
				StringBuffer str = new StringBuffer();
				str.append(ln._BankName1());
				str.append("\n\n" + ln._ApplicationName());
				str.append("\n" + ln._Version() + ": " + RunAutopayExe.VERSION_NUMBER);
				JLabel lblLogo = new JLabel(new ImageIcon(ImageIO.read(new File("bcmNlogoC.JPG"))));
				JOptionPane.showMessageDialog(this, new Object[]{lblLogo, str.toString()}, 
						ln._About(), JOptionPane.INFORMATION_MESSAGE);
			} catch (Exception e) {
				handleException(e);
			}
		}
		
		else if(a.getSource() == mitResetPassword) {
			try {
				control.resetPassword();
			} catch (Exception e) {
				handleException(e);
			}
		}
	}

	public void editingCanceled(ChangeEvent e) {}
	public void editingStopped(ChangeEvent e) { 
		txtInputtedAmount.setText(amount.format(model.getTotalInputtedAmount()));
	}
	
	public void focusGained(FocusEvent e) {
		if(txtSearch.getText().equals(SEARCH_TEXT)) {
			txtSearch.setForeground(Color.BLACK);
			txtSearch.setFont(new Font("Dialog", Font.PLAIN, 11));
			txtSearch.setText("");
		}
	}
	
	public void focusLost(FocusEvent e) {
		if(txtSearch.getText().equals("")) {
			txtSearch.setForeground(Color.LIGHT_GRAY);
			txtSearch.setFont(fntSearch);
			txtSearch.setText(SEARCH_TEXT);
		}
	}
	
	public void keyTyped(KeyEvent k) {}
	public void keyReleased(KeyEvent k) {
		if(k.getKeyCode() == KeyEvent.VK_CONTROL) {
			keyCtrl = false;
		}
	}
	
	public void keyPressed(KeyEvent k) {
		if(k.getKeyCode() == KeyEvent.VK_CONTROL) {
			keyCtrl = true;
		}
		if(k.getKeyCode() == KeyEvent.VK_C && keyCtrl == true) {
			//copy function
			copiedObject = tbl.getValueAt(tbl.getSelectedRow(), tbl.getSelectedColumn());
		}
		if(k.getKeyCode() == KeyEvent.VK_V && keyCtrl == true) {
			//paste function
			int columnIndex = tbl.getSelectedColumn();
			if(copiedObject != null && (tbl.getColumnClass(columnIndex) == copiedObject.getClass() 
					|| tbl.getColumnClass(columnIndex) == String.class)) {
				tbl.setValueAt(copiedObject, tbl.getSelectedRow(), columnIndex);
				if(columnIndex == MainScreenModel.AMOUNT_INDEX) {
					txtInputtedAmount.setText(amount.format(model.getTotalInputtedAmount()));
				}
			}
		}
		
		if(tbl.getSelectedRow()+1 == tbl.getRowCount()) {
			if(k.getKeyCode() == KeyEvent.VK_ENTER || k.getKeyCode() == KeyEvent.VK_DOWN) {
				try {
					control.addRow();
				} catch (Exception e) {
					handleException(e);
				}
			}
		}
	}

	public void windowOpened(WindowEvent e) {}
	public void windowClosed(WindowEvent e) {}
	public void windowIconified(WindowEvent e) {}
	public void windowDeiconified(WindowEvent e) {}
	public void windowActivated(WindowEvent e) {}
	public void windowDeactivated(WindowEvent e) {}
	public void windowClosing(WindowEvent e) {
		if(leaveConfirmed(ln._ExitConfirm())) {
			dispose();
			System.exit(0);
		}
	}

	public void changedUpdate(DocumentEvent e) {
		control.partyInfoUpdate(txtPartyCode.getText(), txtPartyName.getText(), 
				txtPaymentID.getText(), txtPaymentDate.getText());
	}

	public void insertUpdate(DocumentEvent e) {
		control.partyInfoUpdate(txtPartyCode.getText(), txtPartyName.getText(), 
				txtPaymentID.getText(), txtPaymentDate.getText());
	}

	public void removeUpdate(DocumentEvent e) {
		control.partyInfoUpdate(txtPartyCode.getText(), txtPartyName.getText(), 
				txtPaymentID.getText(), txtPaymentDate.getText());
	}
	
	/*
	 * private methods
	 */
	
	private void displayLoginWin() {
		setMenuEnable(false);
		/**
		 * Myles' Edit 2016-1-6: Insert 1 line:
		 */
		this.setVisible(false);
		dlgLogin = new LoginScreen(this, model.getPartyList(), contentPane.getSize());
		dlgLogin.setLocationRelativeTo(contentPane);
		dlgLogin.setVisible(true);

		
	}

	/**
	 * Put value from the model onto the text fields 
	 */
	private void initValue() {
		txtPartyName.getDocument().removeDocumentListener(this);
		txtPaymentID.getDocument().removeDocumentListener(this);
		txtPaymentDate.getDocument().removeDocumentListener(this);

		txtPartyCode.setText(model.getPartyCode());
		txtPartyName.setText(model.getPartyName());
		txtPaymentID.setText(model.getPaymentID());
		txtPaymentDate.setText(model.getPaymentDate()+"");
		txtTotalTxn.setText(0+"");
		txtAmount.setText(0+"");
		txtInputtedAmount.setText(amount.format(model.getTotalInputtedAmount()));
		txtInputtedRecord.setText(record.format(model.getTotalInputtedRecord()));
		txtSeq.setText(String.valueOf(model.getModifySeq()));

		txtPartyName.getDocument().addDocumentListener(this);
		txtPaymentID.getDocument().addDocumentListener(this);
		txtPaymentDate.getDocument().addDocumentListener(this);
	}
	
	/**
	 * Disable/enable the buttons and menu items
	 * @param enable
	 */
	private void setControlEnable(boolean enable) {
		btnInsert.setEnabled(enable);
		btnDelete.setEnabled(enable);
		btnGenerateFile.setEnabled(enable);
		btnSave.setEnabled(enable);
		btnSearch.setEnabled(enable);
		btnDatePicker.setEnabled(enable);
		mitAdd.setEnabled(enable);
		mitInsert.setEnabled(enable);
		mitClearAll.setEnabled(enable);
		mitDelete.setEnabled(enable);
		mitGenerateFile.setEnabled(enable);
		mitImport.setEnabled(enable);
		mnuPrint.setEnabled(enable);
		mitSave.setEnabled(enable);
		txtPartyName.setEnabled(enable);
		txtPaymentID.setEnabled(enable);
		txtSearch.setEnabled(enable);
		txtTotalTxn.setEnabled(enable);
		txtAmount.setEnabled(enable);
	}
	
	private void setMenuEnable(boolean enable) {
		mnuFile.setEnabled(enable);
		mnuRow.setEnabled(enable);
		mnuAbout.setEnabled(enable);
	}
	
	private void insertRow() {
		int row = tbl.getSelectedRow();
		control.insertRow(row);
		tbl.getSelectionModel().setSelectionInterval(row, row);
	}

	private void deleteRow() {
		int[] rows = tbl.getSelectedRows();
		int[] rowsModelIndex = new int[rows.length];
		for(int i=0; i<rows.length; i++)
			rowsModelIndex[i] = tbl.convertRowIndexToModel(rows[i]);
		control.deleteRow(rows, rowsModelIndex);
	}

	/**
	 * Ask user to confirm leaving the current screen (i.e. exit/logout)
	 * @param textShowToUser
	 * @return User decision, true = wish to leave, false otherwise
	 */
	private boolean leaveConfirmed(String textShowToUser) {
		boolean leaveConfirmd = true;
		if(model.getLoginStatus() != MainScreenModel.LOGOUT) {
			int option = JOptionPane.showConfirmDialog(this, 
					textShowToUser, 
					ln._SelectOption(), JOptionPane.YES_NO_OPTION);
			if(option == JOptionPane.NO_OPTION) {
				leaveConfirmd = false;
			}
		}
		return leaveConfirmd;
	}
	
	/**
	 * Ask user to confirm to save before continue any operation
	 * @return true is user saved, false otherwise
	 */
	private boolean saveConfirmed() throws NumberFormatException, InvalidKeyException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException, InvalidFormatException, ClassNotFoundException, SQLException, IOException, DocumentException {
		if(model.isModified()) {
			int option = JOptionPane.showConfirmDialog(this, 
					ln._SaveConfirm1() + "\n" + ln._SaveConfirm2(), 
					ln._SelectOption(), JOptionPane.YES_NO_OPTION);
			if(option != JOptionPane.NO_OPTION) {
				//If successfully saved
				if(save(DATABASE) == true) {
					return true;
				}
			}
			return false;
		} else {
			//return model is saved if no modification made
			return true;
		}
	}
	
	/**
	 * Validate input on screen
	 * @return true if valid, false otherwise
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	private boolean validInput() throws ClassNotFoundException, SQLException {
		char[] englishCheck;
		StringBuffer tempString = new StringBuffer();
		double amountCheck;
		double amountMax = Math.pow(10, FileConnector.Header.PART3.length()-2)-0.01;
		for(int i=0; i<tbl.getRowCount(); i++) {
			//check: amount > 0
			amountCheck = Double.parseDouble((tbl.getValueAt(i, MainScreenModel.AMOUNT_INDEX)).toString());
			if(amountCheck <= 0.00001) {
				return jumpAndDisplayMessage(i, ln._NotAllowZeroPayment1() + "\n" + ln._NotAllowZeroPayment2());
			}
			//check: length of amount
			if(amountCheck > amountMax) {
				return jumpAndDisplayMessage(i, ln._AmountExceedLength1() + "\n" + ln._AmountExceedLength2() + 
						" " + (FileConnector.Header.PART3.length()-2) + ln._AmountExceedLength3() + 
						amount.format(amountMax) + ")");
			}
			
			/*MYLES: Abandon validation, these 2 logic is ensure in CollectionCellEditor.stopCellEditing
			//check: no non-numbers a/c number
			tempString.replace(0, tempString.length(), (tbl.getValueAt(i, MainScreenModel.ACCOUNT_INDEX)).toString());
			try {
				Long.parseLong(tempString.toString());
			} 
			catch(NumberFormatException e){
				return jumpAndDisplayMessage(i, ln._InvalidAccountNumber());
			}
			//check: length of account number
			if(tempString.length() > FileConnector.Detail.PART2.length()) {
				return jumpAndDisplayMessage(i, ln._AccountExceedLength() + FileConnector.Detail.PART2.length() + ").");
			}
			*/
			
//			//check: no non-English characters for name
//			tempString.replace(0, tempString.length(), tbl.getValueAt(i, MainScreenModel.NAME_INDEX).toString());
//			englishCheck = tempString.toString().toCharArray();
//			for(char c : englishCheck) {
//				if(c < 32 || c > 126) {
//						return jumpAndDisplayMessage(i, ln._EmployeeNameNoNonEnglish());
//				}
//			}
			//check: length of name
			if(tempString.length() > FileConnector.Detail.PART6.length()) {
				return jumpAndDisplayMessage(i, ln._EmployeeNameExceedLength() + FileConnector.Detail.PART6.length() + ").");
			}
			
			//check: no non-English characters for reference
			tempString.replace(0, tempString.length(), tbl.getValueAt(i, MainScreenModel.REF_INDEX).toString());
			englishCheck = tempString.toString().toCharArray();
			for(char c : englishCheck) {
				if(c < 32 || c > 126) {
						return jumpAndDisplayMessage(i, ln._ReferenceNoNonEnglish());
				}
			}
			//check: length of reference
			if(tempString.length() > FileConnector.Detail.PART4.length()) {
				return jumpAndDisplayMessage(i, ln._ReferenceExceedLength() + FileConnector.Detail.PART4.length() + ").");
			}
		}
		
		//check: Total Txn and amount
		int totalRecords;
		double totalAmount;
		try {
			totalRecords = Integer.parseInt(txtTotalTxn.getText());
			totalAmount = Double.parseDouble(txtAmount.getText());
		}
		catch(NumberFormatException e) {
			return jumpAndDisplayMessage(-1, ln._InvalidTotalTxnAmount());
		}
		
//		//check: no non-English character for party name
//		englishCheck = txtPartyName.getText().toCharArray();
//		for(char c : englishCheck) {
//			if(c < 32 || c > 126) {
//					return jumpAndDisplayMessage(-1, ln._PartyNameNoNonEnglish());
//			}
//		}
		
		//check: inputed == calculated
		if(totalRecords == model.getTotalInputtedRecord() &&
				totalAmount == model.getTotalInputtedAmount()) {
			return true;
		} else {
			return jumpAndDisplayMessage(-1, ln._TxnAmountNotEqual1() + "\n" + ln._TxnAmountNotEqual2());
		}
	}
	
	/**
	 * private method used by the method - validInput(). It jumps to a specify row and display the 
	 * message in JOptionPane. It always return false.
	 * @param row
	 * @param message
	 * @return Always false
	 */
	private boolean jumpAndDisplayMessage(int row, String message) {
		if(row >= 0) {
			tbl.getSelectionModel().setSelectionInterval(row, row);
			scp.getVerticalScrollBar().setValue(row * tbl.getRowHeight());
		}
		JOptionPane.showMessageDialog(this, 
				message + "\n\n" + ln._RecordsNotSave(), 
				ln._WrongInfo(), JOptionPane.WARNING_MESSAGE);
		return false;
	}
	
	private void generateFile() throws ClassNotFoundException, SQLException, 
					NoSuchAlgorithmException, InvalidKeyException, NoSuchPaddingException, 
					InvalidAlgorithmParameterException, IllegalBlockSizeException, 
					BadPaddingException, IOException, DocumentException, InvalidFormatException {
		//If successfully saved or no modification made
		if(saveConfirmed()) {
			int option;
			int loginStatus = model.getLoginStatus();
			//ask for override if currently at operator level
			if(loginStatus == MainScreenModel.OPERATOR) {
				JOptionPane.showMessageDialog(this, ln._OverrideConfirm());
			    
				//create a password prompt dialog
				JPasswordField jpf = new JPasswordField();
			    jpf.setEchoChar('*');
			    option = JOptionPane.showConfirmDialog(this, 
			    		new Object[]{new JLabel(ln._EnterPassword()), jpf}, 
			    		ln._Password(), JOptionPane.OK_CANCEL_OPTION);
			    
			    if(option == JOptionPane.OK_OPTION) {
			    	loginStatus = 
			    		control.comparePassword(model.getPartyCode(), jpf.getPassword(), false);
			    	if(loginStatus != MainScreenModel.SUPERVISOR) {
			    		JOptionPane.showMessageDialog(this, ln._IncorrectPassword(), 
			    				null, JOptionPane.WARNING_MESSAGE);
			    	}
			    }
			}
			
			//if currently login as supervisor or override with a supervisor password
			if(loginStatus == MainScreenModel.SUPERVISOR) {
				fchGenerate.resetChoosableFileFilters();
				fchGenerate.addChoosableFileFilter(filterDAT);
				option = fchGenerate.showSaveDialog(this);
				if(option == JFileChooser.APPROVE_OPTION) {
					control.exportFile(fchGenerate.getSelectedFile().getPath(), "DAT");
					JOptionPane.showMessageDialog(this, ln._FileGenerated() + "\n" + 
							fchGenerate.getSelectedFile().getPath(), 
							null, JOptionPane.INFORMATION_MESSAGE);
				}
			}
		}
	}
	
	private boolean save(int fileType) throws NumberFormatException, ClassNotFoundException, SQLException, InvalidKeyException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException, InvalidFormatException, IOException, DocumentException {
		int option;
		switch(fileType) {
			case DATABASE: 
				if(validInput()) {
					//get the rows on screen order
					int[] order = new int[tbl.getRowCount()];
					for(int i=0; i<order.length; i++) {
						order[i] = tbl.convertRowIndexToModel(i);
					}
			
					control.saveToDatabase(order);
					JOptionPane.showMessageDialog(this, ln._RecordsSave(), 
							null, JOptionPane.INFORMATION_MESSAGE);
					return true;
				} break;
			case EXCEL:
				if(validInput()) {
					fchGenerate.resetChoosableFileFilters();
					fchGenerate.addChoosableFileFilter(filterXLS);
					option = fchGenerate.showSaveDialog(this);
					if(option == JFileChooser.APPROVE_OPTION) {
						control.exportFile(fchGenerate.getSelectedFile().getPath(),"XLS");
						JOptionPane.showMessageDialog(this, ln._SaveAsExcel() + "\n" + 
								fchGenerate.getSelectedFile().getPath(), 
								null, JOptionPane.INFORMATION_MESSAGE);
						return true;
					}
				} break;
			case PDF:
				if(saveConfirmed()) {
					fchGenerate.resetChoosableFileFilters();
					fchGenerate.addChoosableFileFilter(filterPDF);
					option = fchGenerate.showSaveDialog(this);
					if(option == JFileChooser.APPROVE_OPTION) {
						control.exportFile(fchGenerate.getSelectedFile().getPath(),"PDF");
						JOptionPane.showMessageDialog(this, ln._PrintAsPDF() + "\n" + 
								fchGenerate.getSelectedFile().getPath(), 
								null, JOptionPane.INFORMATION_MESSAGE);
						return true;
					}
				}
		}
		return false;
	}
	
	//Responsible to display error message to user and print/log any information for debug
	private void handleException(Exception e) {
		e.printStackTrace();
		
		if(e instanceof NumberFormatException) {
			JOptionPane.showMessageDialog(this, ln._NFE() + "\n" + ln._ERRORColon() + e.getMessage(), 
					ln._Error(), JOptionPane.WARNING_MESSAGE);
		}
		
		else if(e instanceof ClassNotFoundException) {
			JOptionPane.showMessageDialog(this, ln._CNFE() + "\n" + ln._ERRORColon() + e.getMessage(), 
					ln._Error(), JOptionPane.ERROR_MESSAGE);
		} else if(e instanceof SQLException) {
			int errorCode = ((SQLException)e).getErrorCode();
			if(errorCode == -3702) {
				JOptionPane.showMessageDialog(this, ln._SQLE_NoBlankAccount(), 
						ln._WrongInfo(), JOptionPane.WARNING_MESSAGE);
			} else if(errorCode == -1811) {
				JOptionPane.showMessageDialog(this, ln._SQLE_DBNotFound1() + DBConnector.DATABASE_NAME + ln._SQLE_DBNotFound2() + "\n" + ln._ERRORColon() + e.getMessage(), 
						ln._Error(), JOptionPane.ERROR_MESSAGE);
			} else if(errorCode == -1905) {
				JOptionPane.showMessageDialog(this, ln._SQLE_PasswordNotValid1() + "\n" + ln._SQLE_PasswordNotValid2(), 
						ln._Error(), JOptionPane.ERROR_MESSAGE);
			} else {
				JOptionPane.showMessageDialog(this, ln._SQLE() + "\n" + ln._ERRORColon() + e.getMessage(), 
						ln._Error(), JOptionPane.ERROR_MESSAGE);
			}
		}  
		
		else if(e instanceof DocumentException) {
			JOptionPane.showMessageDialog(this, ln._DE() + "\n" + ln._ERRORColon() + e.getMessage(), 
					ln._Error(), JOptionPane.ERROR_MESSAGE);
		} else if(e instanceof InvalidFormatException) {
			JOptionPane.showMessageDialog(this, ln._IFE() + "\n" + ln._ERRORColon() + e.getMessage(), 
					ln._Error(), JOptionPane.ERROR_MESSAGE);
		} else if(e instanceof IllegalStateException) {
			JOptionPane.showMessageDialog(this, ln._ISE() + "\n" + ln._ERRORColon() + e.getMessage(), 
					ln._Error(), JOptionPane.ERROR_MESSAGE);
		}
		
		else if(e instanceof FileNotFoundException) {
			JOptionPane.showMessageDialog(this, ln._FNFE() + "\n" + ln._ERRORColon() + e.getMessage(), 
					ln._Error(), JOptionPane.ERROR_MESSAGE);
		}else if(e instanceof IOException) {
			JOptionPane.showMessageDialog(this, ln._IOE() + "\n" + ln._ERRORColon() + e.getMessage(), 
					ln._Error(), JOptionPane.ERROR_MESSAGE);
		} 
		
		else if(e instanceof NoSuchAlgorithmException) {
			JOptionPane.showMessageDialog(this, ln._NSAE() + "\n" + ln._ERRORColon() + e.getMessage(), 
					ln._Error(), JOptionPane.ERROR_MESSAGE);
		} else if(e instanceof UnsupportedEncodingException) {
			JOptionPane.showMessageDialog(this, ln._UEE1() + Cryptography.CHARSET + ln._UEE2() + "\n" + ln._ERRORColon() + e.getMessage(), 
					ln._Error(), JOptionPane.ERROR_MESSAGE);
		} else if(e instanceof InvalidKeyException) {
			JOptionPane.showMessageDialog(this, ln._PartyNotAuthorise(), 
					null, JOptionPane.WARNING_MESSAGE);
		} else if(e instanceof NoSuchPaddingException) {
			JOptionPane.showMessageDialog(this, ln._PartyNotAuthorise(), 
					null, JOptionPane.WARNING_MESSAGE);
		} else if(e instanceof InvalidAlgorithmParameterException) {
			JOptionPane.showMessageDialog(this, ln._PartyNotAuthorise(), 
					null, JOptionPane.WARNING_MESSAGE);
		} else if(e instanceof BadPaddingException) {
			JOptionPane.showMessageDialog(this, ln._PartyNotAuthorise(), 
					null, JOptionPane.WARNING_MESSAGE);
		} else if(e instanceof IllegalBlockSizeException) {
			JOptionPane.showMessageDialog(this, ln._IBSE(), 
					null, JOptionPane.WARNING_MESSAGE);
		} 
		
		else {
			JOptionPane.showMessageDialog(this, ln._UnknownException() + "\n" + ln._ERRORColon() + e.getMessage(), 
					ln._Error(), JOptionPane.ERROR_MESSAGE);
		}
	}
	
	
	/*
	 * Private Class
	 */
	
	/**
	 * Limiting the text format of user input.
	 */
	private static class TextFieldFormat extends PlainDocument {
		
		protected final static int TEXT = 0;
		protected final static int INTEGERS = 1;
		protected final static int REALNUMBERS = 2;
		
	    private int limit;
	    private int format;
	    
	    TextFieldFormat(int limit) {
	        this(limit, TEXT);
	    }
	    
	    TextFieldFormat(int limit, int format) {
	        super();
	        this.format = format;
	        this.limit = limit;
	    }
	    
	    public void insertString(int offset, String  str, AttributeSet attr)
	            throws BadLocationException {

	        if (str == null) return;

	        int input;
	        switch(format) {
	        case INTEGERS:
	        	input = str.charAt(0);
	        	if(input < '0' || input > '9') {
	        		return;
	        	}
	        	break;
	        case REALNUMBERS:
	        	input = str.charAt(0);
	        	if((input < '0' && input != '.') || input > '9' ) {
	        		return;
	        	}
	        }
	        
	        if ((getLength() + str.length()) <= limit) {
	            super.insertString(offset, str, attr);
	        }
	    }
	}
	
	
	/*
	 * Myles'code:
	 * 1. ComponentListener capturing window resize action and activating fonts modification
	 * 2. Method modifyFont
	 */
	
	/**
	 * Myles: ComponentListener interface implementing
	 */

	@Override
	public void componentResized(ComponentEvent arg0) {
		System.out.println("Component Resize in Payroll Screen");
		int screenWidth= this.getWidth();
		double factor=(double)screenWidth/(double)PAYROLLSCREEN_MINX; 
		factor= flattenFactor(factor);
		this.modifyFont(this.txtSearch, factor);
		this.modifyFont(this.lblPartyCode, factor);
		this.modifyFont(this.lblPartyName, factor);
		this.modifyFont(this.txtPartyCode, factor);
		this.modifyFont(this.txtPartyName, factor);
		this.modifyFont(this.panParty, factor);
		this.modifyFont(this.panPayment, factor);
		this.modifyFont(this.txtPaymentDate, factor);
		this.modifyFont(this.txtPaymentID, factor);
		this.modifyFont(this.lblPaymentID, factor);
		this.modifyFont(this.lblPaymentDate, factor);
		this.modifyFont(this.txtTotalTxn, factor);
		this.modifyFont(this.lblTotalTxn, factor);
		this.modifyFont(this.lblTotalAmount, factor);
		this.modifyFont(this.txtAmount, factor);
		this.modifyFont(this.lblInputtedAmount, factor);
		this.modifyFont(this.txtInputtedAmount, factor);
		this.modifyFont(this.txtInputtedRecord, factor);
		this.modifyFont(this.lblInputtedRecord, factor);
		this.modifyFont(this.txtSeq, factor);
		this.modifyFont(this.lblSeq, factor);
		this.modifyFont(this.mbrPayroll, factor);
		this.modifyFont(this.mnuFile, factor);
		this.modifyFont(this.mnuRow, factor);
		this.modifyFont(this.mnuAbout, factor);
		this.modifyFont(this.mitSave, factor);
		this.modifyFont(this.mitGenerateFile, factor);
		this.modifyFont(this.mnuPrint, factor);
		this.modifyFont(this.mitImport, factor);
		this.modifyFont(this.mitLogout, factor);
		this.modifyFont(this.mitExit, factor);
		this.modifyFont(this.mitAdd, factor);
		this.modifyFont(this.mitDelete, factor);
		this.modifyFont(this.mitClearAll, factor);
		this.modifyFont(this.mitVersion, factor);
		this.modifyFont(this.mitResetPassword, factor);
		this.modifyFont(this.sepMnuFileImport, factor);
		this.modifyFont(this.sepMnuFilePrint, factor);
		this.modifyFont(this.btnSave, factor);
		this.modifyFont(this.btnGenerateFile, factor);
		this.modifyFont(this.btnInsert, factor);
		this.modifyFont(this.sepGenAdd, factor);
		this.modifyFont(this.btnDelete, factor);
		this.modifyFont(this.btnSearch, factor);
		this.modifyFont(this.btnDatePicker, factor);
		int originalRowHeight=25;
		tbl.setRowHeight((int) (originalRowHeight*factor));
		this.modifyFont(this.tbl, factor);
		this.modifyFont(this.tbl.getTableHeader(), factor);
		//this.modifyFont(this.fchGenerate, factor);
		//this.modifyFont(this.fchImport, factor);
		this.modifyFont(this.mitInsert, factor);
		this.modifyFont(this.rdoDB, factor);
		this.modifyFont(this.rdoExcel, factor);
		this.modifyFont(this.mitPrinter, factor);
		this.modifyFont(this.mitPDF, factor);
		
	}
	
	@Deprecated
	public void componentHidden(ComponentEvent arg0) {}
	
	@Deprecated
	public void componentMoved(ComponentEvent arg0) {}
	
	@Deprecated
	public void componentShown(ComponentEvent arg0) {}
	
	/**
	 * Myles: Factor Flatten Function
	 */
	private double flattenFactor(double factor){
		/**
		 * Flatten operation of font resize factor:
		 *   let y=1.5exp(x-1) when factor is (0,5]
		 *   let y=x when factor is {5,++)
		 */
		double factorFlatten;
		
		if (factor<=10){
			factorFlatten=Math.pow(1.2, factor-1);
		}else {
			factorFlatten=factor;
		}	
		return factorFlatten;
	}
	
	/**
	 * Myles: Font Modification Methodb5
	 */
	private void modifyFont(Component comp, double factor) {
		Font font=comp.getFont();		
		String fontFamily=font.getFamily();
		int fontStyle=font.getStyle();
		int fontSize=DEFAULT_FONT_SIZE_EN;
		int newFontSize= (int)Math.round(fontSize*factor);
		if (newFontSize>30){
			newFontSize=30;
		}
		if (newFontSize<5){
			newFontSize=5;
		}
		comp.setFont(new Font(fontFamily, fontStyle, newFontSize));
	}
	
	
	/*Myles: inherit an custom CellEditor */
	/**
	 * inherit an custom CellEditor enabling numeric characteristic and limited length
	 */
	protected class PayrollCellEditor extends MainScreen.AutoPayCellEditor{
		@Override
		public boolean stopCellEditing(){
			Object obj = super.getCellEditorValue();
			if (columnClass == Double.class) {
				try {
					Double.parseDouble(obj.toString());
				} catch (NumberFormatException e) {
					return badEdit();
				}
			}
			else if (columnClass == Long.class) {
				try {					
					Long.parseLong(obj.toString());
				} catch (NumberFormatException e) {
					return badEdit();
				}
			}else if (columnClass == String.class && columnIndex == MainScreenModel.ACCOUNT_INDEX){
				String s=obj.toString();
				boolean b=s.matches("[1-9]+[0-9]*")&&s.length()<=PayrollScreen.PAYROLL_ACC_MAX_LEN;
				if (!b){
					return  badEdit();
				}
			}

			return super.stopCellEditing();
		}
	}
	
	/*/Myles*/
	
}

