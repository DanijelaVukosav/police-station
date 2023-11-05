package upravljanjePodacima;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;

import connectionpool.ConnectionPool;

import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.SwingConstants;
import java.awt.Font;
import javax.swing.JTextField;
import javax.swing.JTextArea;
import javax.swing.JButton;
import javax.swing.JComboBox;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.awt.event.ActionEvent;

public class SaobracajnaNesrecaForma extends JFrame {

	private JPanel contentPane;
	private JTextField VrijemeText;
	private JTextField DatumText;
	private JTextField AdresaText;
	private JTextField GradText;
	private JTextField UcesniciText;
	private static SaobracajnaNesrecaForma frame;
	
	ConnectionPool pool = null;
	Connection c= null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					frame = new SaobracajnaNesrecaForma();
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
	public SaobracajnaNesrecaForma() {
		//setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 811, 476);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JLabel lblNewLabel = new JLabel("Izvjestaj saobracajne nesrece");
		lblNewLabel.setFont(new Font("Tahoma", Font.PLAIN, 18));
		lblNewLabel.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel.setBounds(246, 11, 260, 33);
		contentPane.add(lblNewLabel);
		
		JLabel lblNewLabel_1 = new JLabel("Vrijeme(hh:mm)");
		lblNewLabel_1.setBounds(505, 78, 80, 14);
		contentPane.add(lblNewLabel_1);
		
		VrijemeText = new JTextField();
		VrijemeText.setBounds(607, 75, 154, 20);
		contentPane.add(VrijemeText);
		VrijemeText.setColumns(10);
		
		JLabel lblNewLabel_2 = new JLabel("Datum(yyyy-mm-dd)");
		lblNewLabel_2.setBounds(505, 109, 98, 14);
		contentPane.add(lblNewLabel_2);
		
		DatumText = new JTextField();
		DatumText.setBounds(607, 106, 154, 20);
		contentPane.add(DatumText);
		DatumText.setColumns(10);
		
		JTextArea IzvjestajText = new JTextArea();
		IzvjestajText.setBounds(43, 196, 731, 121);
		contentPane.add(IzvjestajText);
		
		JLabel lblNewLabel_3 = new JLabel("Izvjestaj o saobracajnoj nesreci:");
		lblNewLabel_3.setBounds(43, 177, 163, 14);
		contentPane.add(lblNewLabel_3);
		
		JLabel lblNewLabel_4 = new JLabel("Adresa:");
		lblNewLabel_4.setBounds(46, 58, 48, 14);
		contentPane.add(lblNewLabel_4);
		
		AdresaText = new JTextField();
		AdresaText.setBounds(43, 75, 209, 33);
		contentPane.add(AdresaText);
		AdresaText.setColumns(10);
		
		JLabel lblNewLabel_5 = new JLabel("Grad:");
		lblNewLabel_5.setBounds(46, 109, 48, 14);
		contentPane.add(lblNewLabel_5);
		
		GradText = new JTextField();
		GradText.setBounds(45, 134, 207, 32);
		contentPane.add(GradText);
		GradText.setColumns(10);
		
		JLabel lblNewLabel_6 = new JLabel("JMB ucesnika:");
		lblNewLabel_6.setBounds(43, 339, 68, 39);
		contentPane.add(lblNewLabel_6);
		
		UcesniciText = new JTextField();
		UcesniciText.setBounds(121, 346, 653, 25);
		contentPane.add(UcesniciText);
		UcesniciText.setColumns(10);
		
		JButton Save = new JButton("Save");
		Save.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) 
			{
				try
				{
					if(VrijemeText.getText()==null || DatumText.getText()==null ||  AdresaText.getText()==null || GradText.getText()==null 
							|| IzvjestajText.getText()==null || UcesniciText.getText()==null)
						throw new Exception("Niste unijeli podatke - sva polja su obavezna!");
					int idAdrese=0;
					SimpleDateFormat formater = new SimpleDateFormat("HH:mm");
					Time vrijeme =new Time( formater.parse(VrijemeText.getText()).getTime());
					java.sql.Date datum=Date.valueOf(DatumText.getText());
					pool=ConnectionPool.getInstance();
					c =pool.checkOut();
					
					
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
					
					ps = c.prepareStatement("insert into saobracajnanesreca(Vrijeme,Datum,Izvjestaj,idAdrese) values (?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
					ps.setTime(1,vrijeme);
					ps.setDate(2,datum);
					ps.setString(3,IzvjestajText.getText());
					ps.setInt(4,idAdrese);
					int rezultat=ps.executeUpdate();
					int idSaobracajneNesrece=-1;
					rs=ps.getGeneratedKeys();
					if (rezultat>0 && rs.next())
					{
						idSaobracajneNesrece=rs.getInt(1);
					}
					else
					{
						throw new Exception("Doslo je do greske prilikom upisa izvjestaja u bazu...");
					}
					
					String[] ucesnici=UcesniciText.getText().split(",");
					ps = c.prepareStatement("insert into ucesniciusaobracajnojnesreci values (?,?)");
					for(int i=0;i<ucesnici.length;i++)
					{
						ps.setInt(1,idSaobracajneNesrece);
						ps.setLong(2,Long.parseLong(ucesnici[i]));
						ps.executeUpdate();
					}
					frame.dispose();
					
				}
				catch(Exception ex)
				{

					JOptionPane.showMessageDialog(frame, ex.getMessage(), "Warning",
					        JOptionPane.WARNING_MESSAGE);
					ex.printStackTrace();
				}
				finally
				{
					pool.checkIn(c);
				}
			}
		});
		Save.setBounds(620, 392, 89, 23);
		contentPane.add(Save);
		
		JLabel lblNewLabel_7 = new JLabel("*Zapeta, kao separator");
		lblNewLabel_7.setBounds(43, 380, 127, 14);
		contentPane.add(lblNewLabel_7);
	}

}
