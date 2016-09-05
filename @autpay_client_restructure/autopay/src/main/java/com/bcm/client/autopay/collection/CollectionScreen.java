package com.bcm.client.autopay.collection;

import java.awt.FlowLayout;

import javax.swing.*;

public class CollectionScreen extends JFrame {
	public void init(){
		JPanel panel = new JPanel();
		panel.setLayout(new FlowLayout());
		JLabel label = new JLabel("This is a label!");
		JButton button = new JButton();
		button.setText("Press me");
		panel.add(label);
		panel.add(button);
		this.add(panel);
		this.setSize(300, 300);
		this.setLocationRelativeTo(null);
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}
	public void setVisible(boolean b){
		this.setVisible(b);
	}
}