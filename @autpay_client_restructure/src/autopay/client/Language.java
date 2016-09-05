package autopay.client;

import java.sql.SQLException;
import autopay.util.DBConnector;

/**
 * Class to hold all the screen text and message for the application
 * 
 * @author Francisco Lo
 * @since 16/12/2010
 */
public class Language {
	
	//the total available languages, this must change in order to add more language
	public final static int AVAILABLE_LANGUAGE = 2;	
	public final static int EN = 0;		//English
	public final static int CN = 1;		//Chinese
	
	private static String[][] text;
	
	private int language;
	
	public Language(String programName) throws ClassNotFoundException, SQLException {
		this(EN, programName);
	}
	
	public Language(int lang, String programName) throws ClassNotFoundException, SQLException {
		language = lang;
		DBConnector db = new DBConnector();
		text = db.readScreenText(programName);
		db.close();
	}

	//Screen Component text
	public String _BankName1() {return text[0][language];}
	public String _BankName2() {return text[1][language];}
	public String _ApplicationName() {return text[2][language];}
	public String _SearchText() {return text[3][language];}
	public String _File() {return text[4][language];}
	public String _Save() {return text[5][language];}
	public String _GenerateFile() {return text[6][language];}
	public String _Import() {return text[7][language];}
	public String _Print() {return text[8][language];}
	public String _LogInOut() {return text[9][language];}
	public String _Exit() {return text[10][language];}
	public String _Row() {return text[11][language];}
	public String _Add() {return text[12][language];}
	public String _Insert() {return text[13][language];}
	public String _Delete() {return text[14][language];}
	public String _ClearAll() {return text[15][language];}
	public String _About() {return text[16][language];}
	public String _Version() {return text[17][language];}
	public String _Search() {return text[18][language];}
	public String _InsertRow() {return text[19][language];}
	public String _DeleteRow() {return text[20][language];}
	public String _DebitParty() {return text[21][language];}
	public String _Payment() {return text[22][language];}
	public String _ID() {return text[23][language];}
	public String _PaymentDate() {return text[24][language];}
	public String _Total() {return text[25][language];}
	public String _TotalDebitTxn() {return text[26][language];}
	public String _TotalDebitAmount() {return text[27][language];}
	public String _InputtedAmount() {return text[28][language];}
	public String _InputtedRecord() {return text[29][language];}
	public String _Code() {return text[30][language];}
	public String _Name() {return text[31][language];}
	public String _BCMFormatDatFile() {return text[32][language];}
	public String _ExcelFile() {return text[33][language];}
	public String _ExcelFile2007() {return text[34][language];}
	public String _PDFFile() {return text[35][language];}
	public String _SelectOption() {return text[36][language];}
	public String _WrongInfo() {return text[37][language];}
	public String _Password() {return text[38][language];}
	public String _Error() {return text[39][language];}
	public String _SearchResult() {return text[40][language];}
	public String _Login() {return text[41][language];}
	public String _OK() {return text[42][language];}
	public String _Cancel() {return text[43][language];}
	public String _PartyCode() {return text[44][language];}
	public String _PasswordColon() {return text[45][language];}
	public String _SaveAs() {return text[46][language];}
	public String _Printer() {return text[47][language];}
	public String _PDF() {return text[48][language];}
	public String _DotLocalDatabase() {return text[49][language];}
	public String _DotExcel() {return text[50][language];}
	public String _TableName() {return text[51][language];}
	/*MYLES
	public String _TableAccount() {return text[52][language];}
	*/
	/*Myles: expand _TableAccount() to 2 method*/
	public String _TableAccount4P() {return text[52][language];}
	public String _TableAccount4C() {return text[221][language];}
	/*/Myles*/
	public String _TableAmount() {return text[53][language];}
	public String _TableReference() {return text[54][language];}
	public String _Copyright() {return text[55][language];}
	public String _Collection() {return text[56][language];}
	public String _Other() {return text[57][language];}
	public String _BCMCollectionDatFile() {return text[58][language];}
	public String _Seq() {return text[59][language];}

	//User message
	public String _AppForceClose() {return text[101][language];}
	public String _RunSetup() {return text[102][language];}
	public String _ToolTipPaymentDate() {return text[103][language];}
	public String _ToolTipPaymentID1() {return text[104][language];}
	public String _ToolTipPaymentID2() {return text[105][language];}
	public String _ToolTipTotalTxn1() {return text[106][language];}
	public String _ToolTipTotalTxn2() {return text[107][language];}
	public String _ToolTipTotalAmount1() {return text[108][language];}
	public String _ToolTipTotalAmount2() {return text[109][language];}
	public String _ToolTipInputtedAmount() {return text[110][language];}
	public String _ToolTipInputtedRecord() {return text[111][language];}
	public String _ToolTipPartyName1() {return text[112][language];}
	public String _ToolTipPartyName2() {return text[113][language];}
	public String _ToolTipPartyCode() {return text[114][language];}
	public String _ToolTipTableBegin() {return text[115][language];}
	public String _ToolTipTableString() {return text[116][language];}
	public String _ToolTipTableNumber() {return text[117][language];}
	public String _ToolTipTableRealNumber() {return text[118][language];}
	public String _ToolTipSearch1() {return text[119][language];}
	public String _ToolTipSearch2() {return text[120][language];}
	public String _TextNotFound() {return text[121][language];}
	public String _SaveBeforeImport() {return text[122][language];}
	public String _ImportSuccessful() {return text[123][language];}
	public String _FileNotBelongParty() {return text[124][language];}
	public String _ClearDataConfirm() {return text[125][language];}
	public String _IncorrectPassword() {return text[126][language];}
	public String _NotAllowZeroPayment1() {return text[127][language];}
	public String _NotAllowZeroPayment2() {return text[128][language];}
	public String _AmountExceedLength1() {return text[129][language];}
	public String _AmountExceedLength2() {return text[130][language];}
	public String _AmountExceedLength3() {return text[131][language];}
	public String _InvalidAccountNumber() {return text[132][language];}
	public String _AccountExceedLength() {return text[133][language];}
	public String _EmployeeNameNoNonEnglish() {return text[134][language];}
	public String _EmployeeNameExceedLength() {return text[135][language];}
	public String _ReferenceNoNonEnglish() {return text[136][language];}
	public String _ReferenceExceedLength() {return text[137][language];}
	public String _InvalidTotalTxnAmount() {return text[138][language];}
	public String _PartyNameNoNonEnglish() {return text[139][language];}
	public String _RecordsSave() {return text[140][language];}
	public String _TxnAmountNotEqual1() {return text[141][language];}
	public String _TxnAmountNotEqual2() {return text[142][language];}
	public String _RecordsNotSave() {return text[143][language];}
	public String _SaveConfirm1() {return text[144][language];}
	public String _SaveConfirm2() {return text[145][language];}
	public String _OverrideConfirm() {return text[146][language];}
	public String _EnterPassword() {return text[147][language];}
	public String _FileGenerated() {return text[148][language];}
	public String _SaveAsExcel() {return text[149][language];}
	public String _PrintAsPDF() {return text[150][language];}
	public String _DeleteDataConfirm() {return text[151][language];}
	public String _ExitConfirm() {return text[152][language];}
	public String _LogoutConfirm() {return text[153][language];}

	//Exception(error) message
	public String _ERRORColon() {return text[201][language];}
	public String _NFE() {return text[202][language];}
	public String _CNFE() {return text[203][language];}
	public String _SQLE_NoBlankAccount() {return text[204][language];}
	public String _SQLE_DBNotFound1() {return text[205][language];}
	public String _SQLE_DBNotFound2() {return text[206][language];}
	public String _SQLE_PasswordNotValid1() {return text[207][language];}
	public String _SQLE_PasswordNotValid2() {return text[208][language];}
	public String _SQLE() {return text[209][language];}
	public String _DE() {return text[210][language];}
	public String _IFE() {return text[211][language];}
	public String _ISE() {return text[212][language];}
	public String _FNFE() {return text[213][language];}
	public String _IOE() {return text[214][language];}
	public String _NSAE() {return text[215][language];}
	public String _UEE1() {return text[216][language];}
	public String _UEE2() {return text[217][language];}
	public String _PartyNotAuthorise() {return text[218][language];}
	public String _IBSE() {return text[219][language];}
	public String _UnknownException() {return text[220][language];}
	
	public int getLanguage() {
		return language;
	}
	
	public void setLanguage(int language) {
		this.language = language;
	}
}
