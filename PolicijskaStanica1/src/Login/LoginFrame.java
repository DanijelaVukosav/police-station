package Login;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.PropertyResourceBundle;
import java.util.ResourceBundle;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;

import connectionpool.ConnectionPool;
import upravljanjePodacima.PocetnaForma;

import javax.swing.JLabel;
import javax.swing.JOptionPane;

import java.awt.Font;
import javax.swing.SwingConstants;
import javax.swing.JTextField;
import javax.swing.JButton;
import javax.swing.JPasswordField;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class LoginFrame extends JFrame {

	private JPanel contentPane;
	private static LoginFrame frame;
	private JTextField UsernameTextField;
	private JPasswordField PasswordField;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					 frame = new LoginFrame();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public LoginFrame() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 305, 422);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JLabel lblNewLabel = new JLabel("Prijava na sistem");
		lblNewLabel.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel.setFont(new Font("Tahoma", Font.BOLD, 16));
		lblNewLabel.setBounds(32, 5, 218, 43);
		contentPane.add(lblNewLabel);
		
		JLabel lblNewLabel_1 = new JLabel("Username:");
		lblNewLabel_1.setFont(new Font("Tahoma", Font.PLAIN, 13));
		lblNewLabel_1.setBounds(10, 70, 75, 14);
		contentPane.add(lblNewLabel_1);
		
		UsernameTextField = new JTextField();
		UsernameTextField.setBounds(10, 95, 240, 43);
		contentPane.add(UsernameTextField);
		UsernameTextField.setColumns(10);
		
		JLabel lblNewLabel_2 = new JLabel("Password:");
		lblNewLabel_2.setFont(new Font("Tahoma", Font.PLAIN, 13));
		lblNewLabel_2.setBounds(10, 173, 75, 23);
		contentPane.add(lblNewLabel_2);
		
		JButton btnNewButton = new JButton("OK");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) 
			{
				String user=UsernameTextField.getText();
				String pass=PasswordField.getText();
				
				ConnectionPool pool = null;
				Connection c=null;
				PreparedStatement ps = null;
				ResultSet rs = null;
				try 
				{
					pool=ConnectionPool.getInstance();
					c =pool.checkOut();
					ps = c.prepareStatement("select password,JMB,idUprava,RadniOdnos from policajac where username=?");
					ps.setString(1,user);
					rs=ps.executeQuery();
					if (rs.next())
					{
						
						if(rs.getString(1).equals(pass) && rs.getString(3).equals("SP") &&  rs.getBoolean(4))
						{
							new PocetnaForma().main(null);
							Main.jmb_prijavljenog_policajca=Long.toString(rs.getLong(2));
							frame.dispose();
							System.out.println(rs.getString(1));
						}
						else if(! rs.getBoolean(4))
						{
						    JOptionPane.showMessageDialog(frame, "Ovaj nalog pripada policajcu sa prekinutim radnim odnosom!", "Warning",
						        JOptionPane.WARNING_MESSAGE);
						}
						else if(!rs.getString(3).equals("SP"))
						{
						    JOptionPane.showMessageDialog(frame, "Ovaj nalog ne pripada saobracajnom policajcu!", "Warning",
						        JOptionPane.WARNING_MESSAGE);
						}
						else
						{
							JOptionPane.showMessageDialog(frame, "Pogresna lozinka!", "Warning",
							        JOptionPane.WARNING_MESSAGE);
						}
					}
					else
					{
						JOptionPane.showMessageDialog(frame, "Ne postoji policajac datim username-om!", "Warning",
						        JOptionPane.WARNING_MESSAGE);
					}
				} catch (SQLException ex) {
					ex.printStackTrace();
				} 
				finally
				{
					pool.checkIn(c);
				}
				
			}
		});
		btnNewButton.setBounds(161, 306, 89, 23);
		contentPane.add(btnNewButton);
		
		JButton btnNewButton_1 = new JButton("Cancel");
		btnNewButton_1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				System.exit(0);
			}
		});
		btnNewButton_1.setBounds(32, 306, 89, 23);
		contentPane.add(btnNewButton_1);
		
		PasswordField = new JPasswordField();
		PasswordField.setBounds(10, 207, 240, 43);
		contentPane.add(PasswordField);
	}
}
