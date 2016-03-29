package autopay.client;

import java.util.Properties;

import javax.swing.JOptionPane;
import javax.swing.SwingUtilities;
import autopay.client.collection.CollectionScreen;
import autopay.client.payroll.PayrollScreen;
import autopay.util.FileConnector;

/**
 * Class to run AutoPay. In order to make AutoPay.Utility.SetupExe work, this class must be 
 * export as "AutoPayroll.jar" when creating runnable jar file. 
 * @author Francisco Lo BB14PGM
 * @since 27/10/2010
 * 
 */

public class RunAutopayExe {
	public static final String VERSION_NUMBER = "v1.1";
	
	public static void main(String[] args) {
		SwingUtilities.invokeLater(new Runnable() {
            public void run() {
            	Properties config = FileConnector.loadConfig();
            	String startingProgram = config.getProperty("Program");
            	try {
                	if(startingProgram.equalsIgnoreCase("autopay")) {
                		new PayrollScreen(config);
                	} else if(startingProgram.equalsIgnoreCase("autocollection")) {
                		new CollectionScreen(config);
                	} else {
                		JOptionPane.showMessageDialog(null, "Incorrect config file", "Error", JOptionPane.ERROR_MESSAGE);
                	}
            	}
            	catch (Exception e) {
        			JOptionPane.showMessageDialog(null, "Error when start up the application. Probably cause by un-config database or corrupt config file.", 
        					"Exit", JOptionPane.ERROR_MESSAGE);
        			System.exit(1);
            	}
            }
        });
	}
}
