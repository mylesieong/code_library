package autopay.client;

import java.awt.Color;
import java.awt.Component;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.util.Properties;

import javax.swing.BorderFactory;
import javax.swing.DefaultCellEditor;
import javax.swing.JFrame;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.SwingConstants;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.TableModel;

@SuppressWarnings("serial")
public abstract class MainScreen extends JFrame {

	/**
	 * All the text on screen should be get from this variable.
	 */
	protected final Language ln;
	
	public MainScreen(Properties config) throws NumberFormatException,
			ClassNotFoundException, SQLException {

		ln = new Language(Integer.parseInt(config.getProperty("Language",	Language.EN + "")), config.getProperty("Program"));
		
		/*Myles: for WindowBuilder activation */
		//ln = null; 	//for testing only - lets windows builder to work
		/*/Myles*/
	}

	/**
	 * Display the total number of employees (records).
	 * Use with caution - This method will alter the value on screen regardless what the value in the model.
	 * 
	 * @param totalEmployees
	 *            The total number of employees
	 */
	abstract protected void setInputtedRecord(int totalEmployees);

	/**
	 * Display the total amount input to the screen. 
	 * Use with caution - This method will alter the value on screen regardless what the value in the model.
	 * 
	 * @param totalAmount
	 *            The total amount
	 */
	abstract protected void setInputtedAmount(double totalAmount);

	/**
	 * Display the modified sequence. 
	 * 
	 * @param seq
	 *            The modified sequence
	 */
	abstract protected void setModifiedSeq(long seq);

	/**
	 * Pass login information from login screen to main screen
	 * 
	 * @param partyCode
	 *            Party Code. Null if user wants to cancel the login.
	 * @param password
	 */
	abstract protected void passLoginInfo(String partyCode, char[] password);

	/**
	 * Custom cell editor to allow highlighting the whole text in the cell once in edit mode.
	 */
	protected class AutoPayCellEditor extends DefaultCellEditor {
		
		/*Myles
		private JTextField jtf;
		private Class<?> columnClass;
		*/
		/* Myles */
		protected JTextField jtf;
		protected Class<?> columnClass;
		protected int columnIndex;
		protected TableModel tm;
		/*/Myles*/
		
		public AutoPayCellEditor() {
			super(new JTextField());
		}

		/*Myles*/
		public AutoPayCellEditor setTableModel(TableModel tableModel){
			this.tm=tableModel;
			return this;
		}
		/*/Myles*/
		
		public Component getTableCellEditorComponent(JTable table,
				Object value, boolean isSelected, int row, int column) {
			Component c = super.getTableCellEditorComponent(table, value,
					isSelected, row, column);
			if (c instanceof JTextField) {
				jtf = ((JTextField) c);
				jtf.selectAll();
				jtf.setBorder(BorderFactory.createLineBorder(Color.BLACK, 1));
				jtf.setBackground(Color.WHITE);
			}
			/*Myles
			columnClass = value.getClass();
			*/
			/*Myles*/
			columnClass = tm.getColumnClass(column);
			columnIndex = column;
			/*/Myles*/
			return c;
		}

		public boolean stopCellEditing() {
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
			}

			return super.stopCellEditing();
		}
		
		/*Myles
		private boolean badEdit() 
		*/
		/*Myles*/
		protected boolean badEdit()
		/*/Myles*/
		{
			jtf.setBorder(BorderFactory.createLineBorder(Color.RED, 1));
			jtf.setBackground(Color.RED);
			return false;
		}
	}

	/**
	 * Custom cell renderer to display numbers with 2 decimal places
	 */
	protected class NumberRenderer extends DefaultTableCellRenderer {
		private NumberFormat formatter;

		public NumberRenderer() {
			super();
			formatter = NumberFormat.getInstance();
			formatter.setMinimumFractionDigits(2);
			setHorizontalAlignment(SwingConstants.RIGHT);
		}

		public void setValue(Object value) {
			//  Format the Object before setting its value in the renderer
			if (value != null)
				value = formatter.format(value);
			super.setValue(value);
		}
	}

}
