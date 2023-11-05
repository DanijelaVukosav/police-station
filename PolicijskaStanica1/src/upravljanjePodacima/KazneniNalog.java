package upravljanjePodacima;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;

import Login.Main;
import connectionpool.ConnectionPool;

import javax.swing.JLabel;
import javax.swing.JOptionPane;

import java.awt.Font;
import javax.swing.JTextField;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JTextArea;
import java.awt.event.ActionListener;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.awt.event.ActionEvent;

public class KazneniNalog extends JFrame {

	private JPanel contentPane;
	private JTextField BrojNaloga;
	private JTextField AdresaText;
	private JTextField GradText;
	private JTextField VrijemeText;
	private JTextField DatumText;
	private static KazneniNalog frame;
	public static JComboBox TackaZakona;

	ConnectionPool pool = null;
	Connection c= null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	private JTextField JMBText;
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					frame = new KazneniNalog();
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
	public KazneniNalog() {
		//setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 800, 446);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JLabel lblNewLabel = new JLabel("Kazneni nalog");
		lblNewLabel.setFont(new Font("Tahoma", Font.PLAIN, 17));
		lblNewLabel.setBounds(312, 11, 133, 28);
		contentPane.add(lblNewLabel);
		
		BrojNaloga = new JTextField();
		BrojNaloga.setBounds(666, 18, 96, 20);
		contentPane.add(BrojNaloga);
		BrojNaloga.setColumns(10);
		
		JLabel lblNewLabel_1 = new JLabel("Broj naloga:");
		lblNewLabel_1.setBounds(597, 21, 59, 14);
		contentPane.add(lblNewLabel_1);
		
		JLabel lblNewLabel_2 = new JLabel("Adresa:");
		lblNewLabel_2.setBounds(10, 66, 48, 14);
		contentPane.add(lblNewLabel_2);
		
		AdresaText = new JTextField();
		AdresaText.setBounds(10, 83, 229, 33);
		contentPane.add(AdresaText);
		AdresaText.setColumns(10);
		
		JLabel lblNewLabel_3 = new JLabel("Grad:");
		lblNewLabel_3.setBounds(10, 127, 48, 14);
		contentPane.add(lblNewLabel_3);
		
		GradText = new JTextField();
		GradText.setBounds(10, 152, 229, 38);
		contentPane.add(GradText);
		GradText.setColumns(10);
		
		JLabel lblNewLabel_5 = new JLabel("Vrijeme(hh:mm):");
		lblNewLabel_5.setBounds(597, 49, 104, 14);
		contentPane.add(lblNewLabel_5);
		
		VrijemeText = new JTextField();
		VrijemeText.setBounds(597, 63, 121, 20);
		contentPane.add(VrijemeText);
		VrijemeText.setColumns(10);
		
		JLabel lblNewLabel_6 = new JLabel("Datum(yyyy-mm-dd):");
		lblNewLabel_6.setBounds(597, 92, 104, 14);
		contentPane.add(lblNewLabel_6);
		
		DatumText = new JTextField();
		DatumText.setBounds(597, 104, 164, 28);
		contentPane.add(DatumText);
		DatumText.setColumns(10);
		
		JTextArea OpisText = new JTextArea();
		OpisText.setBounds(292, 161, 470, 183);
		contentPane.add(OpisText);
		
		JLabel lblNewLabel_7 = new JLabel("Opis prekrsaja:");
		lblNewLabel_7.setBounds(292, 140, 85, 14);
		contentPane.add(lblNewLabel_7);
		
		JLabel lblNewLabel_8 = new JLabel("Naziv tacke zakona:");
		lblNewLabel_8.setBounds(187, 358, 104, 14);
		contentPane.add(lblNewLabel_8);
		
		JButton Save = new JButton("Save");
		Save.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) 
			{
				try
				{
					int tackaZakona=0; int idAdrese=0;
					SimpleDateFormat formater = new SimpleDateFormat("HH:mm");
					Time vrijeme =new Time( formater.parse(VrijemeText.getText()).getTime());
					java.sql.Date datum=Date.valueOf(DatumText.getText());
					pool=ConnectionPool.getInstance();
					c =pool.checkOut();
					
					ps = c.prepareStatement("select tackaZakona from zakon where nazivTackeZakona= ?");
					ps.setString(1,(String)TackaZakona.getSelectedItem());
					rs=ps.executeQuery();
					if(rs.next())
						tackaZakona=rs.getInt(1);
					else
					{
						throw new Exception("Neuspjesno odredjivanje tacke zakona!");
					}
					ps = c.prepareStatement("select idAdrese from adresa where Ulica=? and Mjesto=?");
					ps.setString(1,AdresaText.getText());
					ps.setString(2,GradText.getText());
					rs=ps.executeQuery();
					if (rs.next())
					{
						idAdrese=rs.getInt(1);
					}
					else
					{
						ps = c.prepareStatement("insert into adresa(Ulica,Mjesto) values (?,?)", Statement.RETURN_GENERATED_KEYS);
						ps.setString(1,AdresaText.getText());
						ps.setString(2,GradText.getText());
						ps.executeUpdate();
						rs=ps.getGeneratedKeys();
						if(rs.next())
							idAdrese=rs.getInt(1);
						else
							throw new Exception("Neuspjesno odredjivanje adrese u bazi!");
					}
				
					ps = c.prepareStatement("insert into kazneninalog values (?,?,?,?,?,?,?,?)");
					ps.setInt(1,Integer.parseInt(BrojNaloga.getText()));
					ps.setTime(2,vrijeme);
					ps.setDate(3,datum);
					ps.setString(4,OpisText.getText());
					ps.setInt(5,tackaZakona); //tacka zakona
					ps.setLong(6,Long.parseLong(Main.jmb_prijavljenog_policajca)); //policajac
					ps.setInt(7,idAdrese); //adresa
					ps.setLong(8,Long.parseLong(JMBText.getText())); //kaznjeni
					int rezultat=ps.executeUpdate();
					if(rezultat==0)
						throw new Exception("Doslo je do greske prilikom umetanja u bazu...");
					else
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
		Save.setBounds(10, 321, 133, 23);
		contentPane.add(Save);
		
		JLabel lblNewLabel_4 = new JLabel("JMB kaznjenog:");
		lblNewLabel_4.setBounds(10, 223, 104, 14);
		contentPane.add(lblNewLabel_4);
		
		JMBText = new JTextField();
		JMBText.setBounds(10, 248, 229, 38);
		contentPane.add(JMBText);
		JMBText.setColumns(10);
		
		JButton btnNewButton = new JButton("Dodaj tacku");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				
				new TackaZakona().main(null);
			}
		});
		btnNewButton.setBounds(677, 355, 97, 23);
		contentPane.add(btnNewButton);
		
		TackaZakona = new JComboBox();
		TackaZakona.setBounds(292, 354, 375, 22);
		contentPane.add(TackaZakona);
		inicijalizujTackeZakona();
	}
	void inicijalizujTackeZakona()
	{
		try
		{
			pool=ConnectionPool.getInstance();
			c =pool.checkOut();
			
			ps = c.prepareStatement("select nazivTackeZakona from zakon");
			rs=ps.executeQuery();
			while(rs.next())
			{
				TackaZakona.addItem(rs.getString(1));
			}
				
			
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
}
