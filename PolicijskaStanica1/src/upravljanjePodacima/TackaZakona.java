package upravljanjePodacima;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;

import connectionpool.ConnectionPool;

import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextField;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.awt.event.ActionEvent;

public class TackaZakona extends JFrame {

	private JPanel contentPane;
	private JTextField Indeks;
	private JTextField Opis;
	private JTextField Naziv;
	private static TackaZakona frame;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					 frame = new TackaZakona();
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
	public TackaZakona() {
		//setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 565, 341);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JLabel lblNewLabel = new JLabel("Indeks:");
		lblNewLabel.setBounds(10, 11, 48, 14);
		contentPane.add(lblNewLabel);
		
		Indeks = new JTextField();
		Indeks.setBounds(10, 36, 96, 20);
		contentPane.add(Indeks);
		Indeks.setColumns(10);
		
		JLabel lblNewLabel_1 = new JLabel("Naziv:");
		lblNewLabel_1.setBounds(10, 67, 48, 14);
		contentPane.add(lblNewLabel_1);
		
		Opis = new JTextField();
		Opis.setBounds(10, 157, 494, 103);
		contentPane.add(Opis);
		Opis.setColumns(10);
		
		JLabel lblNewLabel_2 = new JLabel("Opis:");
		lblNewLabel_2.setBounds(10, 132, 48, 14);
		contentPane.add(lblNewLabel_2);
		
		JButton btnNewButton = new JButton("Save");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				int poslednjaTackaZakona=0;
				
				ConnectionPool pool = null;
				Connection c= null;
				PreparedStatement ps = null;
				ResultSet rs = null;
				try
				{
					pool=ConnectionPool.getInstance();
					c =pool.checkOut();
					
					ps = c.prepareStatement("insert into zakon values (?,?,?)");
					ps.setInt(1,Integer.parseInt(Indeks.getText()));
					ps.setString(2,Naziv.getText());
					ps.setString(3,Opis.getText());
					ps.executeUpdate();
					KazneniNalog.TackaZakona.addItem(Naziv.getText());
					frame.dispose();
					
				}
				catch(Exception ex)
				{
					JOptionPane.showMessageDialog(frame, ex.getMessage(), "Warning",
					        JOptionPane.WARNING_MESSAGE);
				}
				finally
				{
					pool.checkIn(c);
				}
				
				
			}
		});
		btnNewButton.setBounds(419, 268, 89, 23);
		contentPane.add(btnNewButton);
		
		Naziv = new JTextField();
		Naziv.setBounds(10, 92, 494, 29);
		contentPane.add(Naziv);
		Naziv.setColumns(10);
	}
}
