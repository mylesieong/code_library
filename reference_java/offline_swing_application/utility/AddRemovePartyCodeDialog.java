package autopay.utility;

import javax.swing.*;
import javax.swing.GroupLayout.Alignment;
import javax.swing.LayoutStyle.ComponentPlacement;



import java.awt.event.*;

/**
 * @author Francisco Lo BB14PGM
 * @since 10/11/2010
 * 
 */

@SuppressWarnings("serial")
public class AddRemovePartyCodeDialog extends JDialog implements ActionListener{
	
	private SetupExe frame;
	private JLabel lblParty;
	private JTextField txtParty;
	private JButton btnAdd;
	private JTextArea txta;
	private JButton btnRemove;
	private JScrollPane scl;
	private JList list;
	private DefaultListModel model;
	private JButton btnOK;
	private JButton btnCancel;
	
	public AddRemovePartyCodeDialog(JFrame frame, String title, String[] partylist) {
		this(frame, title);
		for(int i=0; i<partylist.length; i++) 
			model.add(model.size(), partylist[i]);
	}

	public AddRemovePartyCodeDialog(JFrame frame, String title) {
		super(frame, title, true);
		this.frame = (SetupExe)frame;
		setBounds(100, 100, 284, 253);
		
		lblParty = new JLabel("Party Code:");
		
		txtParty = new JTextField();
		txtParty.setColumns(4);
		
		btnAdd = new JButton(">>");
		btnAdd.addActionListener(this);
		
		txta = new JTextArea();
		txta.setText("Party Code must have\nexactly 4 units long \nand must be unique.");
		txta.setEditable(false);
		
		btnRemove = new JButton("<<");
		btnRemove.addActionListener(this);
		
		scl = new JScrollPane();
		
		btnOK = new JButton("OK");
		btnOK.addActionListener(this);
		
		btnCancel = new JButton("Cancel");
		btnCancel.addActionListener(this);
		
		GroupLayout groupLayout = new GroupLayout(getContentPane());
		groupLayout.setHorizontalGroup(
			groupLayout.createParallelGroup(Alignment.LEADING)
				.addGroup(groupLayout.createSequentialGroup()
					.addGroup(groupLayout.createParallelGroup(Alignment.LEADING)
						.addGroup(groupLayout.createSequentialGroup()
							.addContainerGap()
							.addGroup(groupLayout.createParallelGroup(Alignment.LEADING)
								.addGroup(groupLayout.createSequentialGroup()
									.addComponent(lblParty, GroupLayout.PREFERRED_SIZE, 75, GroupLayout.PREFERRED_SIZE)
									.addGap(12)
									.addComponent(txtParty, GroupLayout.PREFERRED_SIZE, 48, GroupLayout.PREFERRED_SIZE))
								.addGroup(groupLayout.createSequentialGroup()
									.addGap(87)
									.addComponent(btnAdd, GroupLayout.PREFERRED_SIZE, 48, GroupLayout.PREFERRED_SIZE))
								.addGroup(groupLayout.createSequentialGroup()
									.addGap(8)
									.addComponent(txta, GroupLayout.PREFERRED_SIZE, 127, GroupLayout.PREFERRED_SIZE))
								.addGroup(groupLayout.createSequentialGroup()
									.addGap(87)
									.addComponent(btnRemove, GroupLayout.PREFERRED_SIZE, 48, GroupLayout.PREFERRED_SIZE)))
							.addPreferredGap(ComponentPlacement.RELATED)
							.addComponent(scl, GroupLayout.PREFERRED_SIZE, 108, GroupLayout.PREFERRED_SIZE))
						.addGroup(groupLayout.createSequentialGroup()
							.addGap(70)
							.addComponent(btnOK)
							.addPreferredGap(ComponentPlacement.RELATED)
							.addComponent(btnCancel)))
					.addContainerGap(15, Short.MAX_VALUE))
		);
		groupLayout.setVerticalGroup(
			groupLayout.createParallelGroup(Alignment.LEADING)
				.addGroup(groupLayout.createSequentialGroup()
					.addContainerGap()
					.addGroup(groupLayout.createParallelGroup(Alignment.LEADING, false)
						.addGroup(groupLayout.createSequentialGroup()
							.addGroup(groupLayout.createParallelGroup(Alignment.LEADING)
								.addComponent(lblParty)
								.addComponent(txtParty, GroupLayout.PREFERRED_SIZE, GroupLayout.DEFAULT_SIZE, GroupLayout.PREFERRED_SIZE))
							.addGap(6)
							.addComponent(btnAdd)
							.addGap(6)
							.addComponent(txta, GroupLayout.PREFERRED_SIZE, 48, GroupLayout.PREFERRED_SIZE)
							.addGap(13)
							.addComponent(btnRemove))
						.addComponent(scl))
					.addPreferredGap(ComponentPlacement.RELATED, 24, Short.MAX_VALUE)
					.addGroup(groupLayout.createParallelGroup(Alignment.BASELINE)
						.addComponent(btnOK)
						.addComponent(btnCancel))
					.addContainerGap())
		);
		
		list = new JList();
		model = new DefaultListModel();
		list.setModel(model);
		list.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		scl.setViewportView(list);
		groupLayout.setAutoCreateContainerGaps(true);
		groupLayout.setAutoCreateGaps(true);
		getContentPane().setLayout(groupLayout);
	}
	
	public void actionPerformed(ActionEvent a) {
		
		if(a.getSource() == btnAdd) {
			String partyCode = txtParty.getText();
			if(partyCode.length() == 4) {
				for(int i=0; i<model.size(); i++) {
					if(partyCode.equals(model.get(i).toString())) {
						JOptionPane.showMessageDialog(this, "Party Code must be unique");
						return;
					}
				}
				model.add(model.size(), partyCode);
				txtParty.setText("");
			} else {
				JOptionPane.showMessageDialog(this, "Party Code must have length of 4");
			}
		}
		
		else if(a.getSource() == btnRemove) {
			if(list.getSelectedIndex() >= 0) {
				model.remove(list.getSelectedIndex());
			}
		}
		
		else if(a.getSource() == btnOK) {
			String[] codes = new String[model.size()];
			for(int i=0; i<codes.length; i++)
				codes[i] = model.get(i).toString();
			frame.setPartyCodes(codes);
			dispose();
		}
		
		else if(a.getSource() == btnCancel) {
			frame.setPartyCodes(null);
			dispose();
		}
	}
}
