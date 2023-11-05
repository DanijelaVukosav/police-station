package upravljanjePodacima;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.DefaultListModel;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;


import connectionpool.ConnectionPool;

import javax.swing.JLabel;
import javax.swing.JTextField;
import javax.swing.JList;
import javax.swing.JPopupMenu;
import java.awt.Component;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Statement;
import java.sql.Time;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import javax.swing.JButton;
import javax.swing.ListSelectionModel;
import javax.swing.AbstractListModel;
import javax.swing.JMenu;
import javax.swing.JOptionPane;
import javax.swing.JComboBox;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.SwingConstants;
import java.awt.SystemColor;

public class FormaRadarskeKazne extends JFrame 
{
	private static FormaRadarskeKazne frame;
	private JPanel contentPane;
	private JTextField idKamereText;
	private JTextField GradKontrole;
	JComboBox TipoviKamerecomboBox = new JComboBox();
	private JTextField DatumKontrole;
	private JTextField TipKamereText;
	JLabel TipKamereLabel = new JLabel("Tip kamere:");
	JLabel idKamereLabel = new JLabel("idKamere:");
	private JTextField TabliceText;
	private JTextField VrijemeText;
	private JTextField PrekoracenjeBrzine;
	private JTextField AdresaKontrole;
	private JLabel UspjesnoUnosenje;
	private JPanel panelKontrole ;
	private JPanel panelKazne ;
	
	ConnectionPool pool = null;
	Connection c= null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	public int idUneseneKontrole=-1;
	private JTextField idKontrole;
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					frame= new FormaRadarskeKazne();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}
	public void azuriranje(int idRadarskeKazne)
	{
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					frame= new FormaRadarskeKazne(idRadarskeKazne);
					//inicijalizujPolja(idRadarskeKazne);
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
	public  FormaRadarskeKazne(int idRadarskeKazne) 
	{
		//setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 820, 556);
		contentPane = new JPanel();
		contentPane.setBackground(SystemColor.inactiveCaption);
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		panelKazne = new JPanel();
		panelKazne.setBounds(307, 44, 487, 431);
		contentPane.add(panelKazne);
		panelKazne.setBackground(SystemColor.activeCaption);
		panelKazne.setLayout(null);
		panelKazne.setVisible(true);
		JLabel lblNewLabel_6 = new JLabel("Radarske kazne unesene kontrole");
		lblNewLabel_6.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel_6.setBounds(72, 11, 184, 36);
		panelKazne.add(lblNewLabel_6);
		
		TabliceText = new JTextField();
		TabliceText.setBounds(42, 179, 151, 29);
		panelKazne.add(TabliceText);
		TabliceText.setColumns(10);
		
		JLabel lblNewLabel_8 = new JLabel("Registracijske tablice:");
		lblNewLabel_8.setBounds(42, 154, 109, 14);
		panelKazne.add(lblNewLabel_8);
		
		JLabel lblNewLabel_9 = new JLabel("Vrijeme(hh:mm)");
		lblNewLabel_9.setBounds(42, 219, 109, 20);
		panelKazne.add(lblNewLabel_9);
		
		VrijemeText = new JTextField();
		VrijemeText.setBounds(42, 250, 151, 29);
		panelKazne.add(VrijemeText);
		VrijemeText.setColumns(10);
		
		JLabel lblNewLabel_11 = new JLabel("Prekoracenje brzine:");
		lblNewLabel_11.setBounds(331, 154, 105, 14);
		panelKazne.add(lblNewLabel_11);
		
		PrekoracenjeBrzine = new JTextField();
		PrekoracenjeBrzine.setBounds(331, 183, 96, 20);
		panelKazne.add(PrekoracenjeBrzine);
		PrekoracenjeBrzine.setColumns(10);
		
		JButton Save = new JButton("Save");
		Save.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) 
			{
				try
				{
					SimpleDateFormat formater = new SimpleDateFormat("HH:mm");
					Time vrijeme =new Time( formater.parse(VrijemeText.getText()).getTime());
					int prekoracenje=Integer.parseInt(PrekoracenjeBrzine.getText());
					pool=ConnectionPool.getInstance();
					c =pool.checkOut();
					ps = c.prepareStatement("update radarskakazna set Vrijeme=?,PrekoracenjeBrzine=?,registracijskeTablice=?,idRadarskaKontrola=? where idRadarskaKazna= ?");
					ps.setTime(1,vrijeme);
					ps.setInt(2,prekoracenje);
					ps.setString(3,TabliceText.getText());
					ps.setString(4,idKontrole.getText());
					ps.setInt(5,idRadarskeKazne);
					int rezultat=ps.executeUpdate();
					if(rezultat==1)
						UspjesnoUnosenje.setVisible(true);
					else
					{
						UspjesnoUnosenje.setVisible(true);
						UspjesnoUnosenje.setText("Doslo je do greske...");
					}
					VrijemeText.setText("");
					PrekoracenjeBrzine.setText("");
					TabliceText.setText("");
					frame.dispose();
					
				}
				catch(Exception ex)
				{
					System.out.println("Izuzetak kod cuvanja radarske kazne!");
					ex.printStackTrace();
				}
				finally
				{
					pool.checkIn(c);
				}
			}
		});
		Save.setBounds(347, 349, 89, 45);
		panelKazne.add(Save);
		
		UspjesnoUnosenje = new JLabel("Uspjesno!");
		UspjesnoUnosenje.setBounds(42, 380, 109, 14);
		panelKazne.add(UspjesnoUnosenje);
		UspjesnoUnosenje.setVisible(false);
		
		JLabel lblNewLabel_1 = new JLabel("IdRadarskaKontrola:");
		lblNewLabel_1.setBounds(263, 71, 109, 14);
		panelKazne.add(lblNewLabel_1);
		
		idKontrole = new JTextField();
		idKontrole.setBounds(381, 68, 80, 20);
		panelKazne.add(idKontrole);
		idKontrole.setColumns(10);
		inicijalizujPolja(idRadarskeKazne);
		
	}
	public FormaRadarskeKazne() {
		//setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 820, 556);
		contentPane = new JPanel();
		contentPane.setBackground(SystemColor.inactiveCaption);
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		panelKontrole = new JPanel();
		panelKontrole.setBounds(29, 44, 268, 431);
		contentPane.add(panelKontrole);
		panelKontrole.setLayout(null);
		
		JLabel lblNewLabel = new JLabel("Unesite podatke o radarskoj kontroli:");
		lblNewLabel.setBounds(49, 8, 180, 14);
		panelKontrole.add(lblNewLabel);
		
		JLabel AdresaLabel = new JLabel("Adresa:");
		AdresaLabel.setBounds(22, 46, 38, 14);
		panelKontrole.add(AdresaLabel);
		
		JLabel GradLabel = new JLabel("Grad:");
		GradLabel.setBounds(22, 107, 58, 14);
		panelKontrole.add(GradLabel);
		
		GradKontrole = new JTextField();
		GradKontrole.setBounds(22, 121, 180, 31);
		panelKontrole.add(GradKontrole);
		GradKontrole.setColumns(10);
		
		JLabel DatumLabel = new JLabel("Datum(yyyy-mm-dd)");
		DatumLabel.setBounds(22, 163, 180, 14);
		panelKontrole.add(DatumLabel);
		
		AdresaKontrole = new JTextField();
		AdresaKontrole.setBounds(22, 60, 181, 31);
		panelKontrole.add(AdresaKontrole);
		AdresaKontrole.setColumns(10);
		
		JButton DodajKameruButton = new JButton("Dodaj kameru");
		DodajKameruButton.setBounds(77, 227, 99, 23);
		panelKontrole.add(DodajKameruButton);
		DodajKameruButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				TipoviKamerecomboBox.setVisible(false);
				idKamereLabel.setVisible(true);
				idKamereText.setVisible(true);
				TipKamereLabel.setVisible(true);
				TipKamereText.setVisible(true);
			}
		});
		
		JLabel KameraLabel = new JLabel("Kamera:");
		KameraLabel.setBounds(26, 231, 41, 14);
		panelKontrole.add(KameraLabel);
		idKamereLabel.setBounds(26, 324, 50, 14);
		panelKontrole.add(idKamereLabel);
		
		idKamereLabel.setVisible(false);
		TipoviKamerecomboBox.setBounds(25, 281, 177, 37);
		panelKontrole.add(TipoviKamerecomboBox);
		
		inicijalizujComboBox();
		
		
		DatumKontrole = new JTextField();
		DatumKontrole.setBounds(22, 178, 177, 38);
		panelKontrole.add(DatumKontrole);
		DatumKontrole.setColumns(10);
		
		TipKamereLabel.setBounds(22, 256, 58, 14);
		panelKontrole.add(TipKamereLabel);
		TipKamereLabel.setVisible(false);
		
		TipKamereText = new JTextField();
		TipKamereText.setBounds(26, 282, 177, 31);
		panelKontrole.add(TipKamereText);
		TipKamereText.setColumns(10);
		TipKamereText.setVisible(false);
		
		idKamereText = new JTextField();
		idKamereText.setBounds(26, 349, 177, 31);
		panelKontrole.add(idKamereText);
		idKamereText.setColumns(10);
		idKamereText.setVisible(false);
		
		JButton SacuvajRadarskuKontrolu = new JButton("Sacuvaj radarsku kontrolu");
		SacuvajRadarskuKontrolu.setBounds(99, 391, 157, 23);
		panelKontrole.add(SacuvajRadarskuKontrolu);
		
		panelKazne = new JPanel();
		panelKazne.setBounds(307, 44, 487, 431);
		contentPane.add(panelKazne);
		panelKazne.setBackground(SystemColor.activeCaption);
		panelKazne.setLayout(null);
		panelKazne.setVisible(false);
		JLabel lblNewLabel_6 = new JLabel("Radarske kazne unesene kontrole");
		lblNewLabel_6.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel_6.setBounds(72, 11, 184, 36);
		panelKazne.add(lblNewLabel_6);
		
		TabliceText = new JTextField();
		TabliceText.setBounds(42, 179, 151, 29);
		panelKazne.add(TabliceText);
		TabliceText.setColumns(10);
		
		JLabel lblNewLabel_8 = new JLabel("Registracijske tablice:");
		lblNewLabel_8.setBounds(42, 154, 109, 14);
		panelKazne.add(lblNewLabel_8);
		
		JLabel lblNewLabel_9 = new JLabel("Vrijeme(hh:mm)");
		lblNewLabel_9.setBounds(42, 219, 109, 20);
		panelKazne.add(lblNewLabel_9);
		
		VrijemeText = new JTextField();
		VrijemeText.setBounds(42, 250, 151, 29);
		panelKazne.add(VrijemeText);
		VrijemeText.setColumns(10);
		
		JLabel lblNewLabel_11 = new JLabel("Prekoracenje brzine:");
		lblNewLabel_11.setBounds(331, 154, 105, 14);
		panelKazne.add(lblNewLabel_11);
		
		PrekoracenjeBrzine = new JTextField();
		PrekoracenjeBrzine.setBounds(331, 183, 96, 20);
		panelKazne.add(PrekoracenjeBrzine);
		PrekoracenjeBrzine.setColumns(10);
		
		JButton Save = new JButton("Save");
		Save.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) 
			{
				try
				{
					SimpleDateFormat formater = new SimpleDateFormat("HH:mm");
					Time vrijeme =new Time( formater.parse(VrijemeText.getText()).getTime());
					int prekoracenje=Integer.parseInt(PrekoracenjeBrzine.getText());
					pool=ConnectionPool.getInstance();
					c =pool.checkOut();
					ps = c.prepareStatement("insert into radarskakazna(Vrijeme,PrekoracenjeBrzine,registracijskeTablice,idRadarskaKontrola) values (?,?,?,?)");
					ps.setTime(1,vrijeme);
					ps.setInt(2,prekoracenje);
					ps.setString(3,TabliceText.getText());
					ps.setString(4,idKontrole.getText());
					int rezultat=ps.executeUpdate();
					if(rezultat==1)
						UspjesnoUnosenje.setVisible(true);
					else
					{
						UspjesnoUnosenje.setVisible(true);
						UspjesnoUnosenje.setText("Doslo je do greske...");
					}
					VrijemeText.setText("");
					PrekoracenjeBrzine.setText("");
					TabliceText.setText("");
					
				}
				catch(Exception ex)
				{
					System.out.println("Izuzetak kod cuvanja radarske kazne!");
				}
				finally
				{
					pool.checkIn(c);
				}
			}
		});
		Save.setBounds(347, 349, 89, 45);
		panelKazne.add(Save);
		
		UspjesnoUnosenje = new JLabel("Uspjesno unosenje!");
		UspjesnoUnosenje.setBounds(42, 380, 109, 14);
		panelKazne.add(UspjesnoUnosenje);
		UspjesnoUnosenje.setVisible(false);
		
		JLabel lblNewLabel_1 = new JLabel("IdRadarskaKontrola:");
		lblNewLabel_1.setBounds(263, 71, 109, 14);
		panelKazne.add(lblNewLabel_1);
		
		idKontrole = new JTextField();
		idKontrole.setBounds(381, 68, 80, 20);
		panelKazne.add(idKontrole);
		idKontrole.setColumns(10);
		SacuvajRadarskuKontrolu.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				int idKamere=-1;
				int idAdrese=-1;
				
				int rezultat=0;
				try 
				{
					if(AdresaKontrole.getText()==null || DatumKontrole.getText()==null || GradKontrole.getText()==null)
						throw new Exception("Potrebno je popuniti sva polja!");
					SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-mm-dd");
				    java.util.Date datum = sdformat.parse(DatumKontrole.getText());
				    java.util.Date danasnjiDatum = sdformat.parse(sdformat.format(new java.util.Date()));
				    if(datum.compareTo(danasnjiDatum)>0)
				    	throw new Exception("Datum mora biti danasnji, ili mladji!");
					pool=ConnectionPool.getInstance();
					c =pool.checkOut();
					if(TipoviKamerecomboBox.isVisible())
					{
						String[] parsirano=TipoviKamerecomboBox.getSelectedItem().toString().split("-");
						idKamere = Integer.parseInt(parsirano[0].trim());
						System.out.println(idKamere);
						rezultat=1;
					}
					else if(Integer.parseInt(idKamereText.getText())>0)
					{
						ps = c.prepareStatement("insert into kamera values (?,?)");
						ps.setInt(1,idKamere=Integer.parseInt(idKamereText.getText()));
						ps.setString(2,TipKamereText.getText());
						rezultat=ps.executeUpdate();
					}
					else
						throw new Exception("ID kamere nije valida!");
					if(rezultat==0)
						throw new Exception("Kamera vec postoji u bazi!");
					
					ps = c.prepareStatement("select idAdrese from adresa where Ulica=? and Mjesto=?");
					ps.setString(1,AdresaKontrole.getText());
					ps.setString(2,GradKontrole.getText());
					rs=ps.executeQuery();
					if (rs.next())
					{
						idAdrese=rs.getInt(1);
					}
					else
					{
						ps = c.prepareStatement("insert into adresa(Ulica,Mjesto) values (?,?)", Statement.RETURN_GENERATED_KEYS);
						ps.setString(1,AdresaKontrole.getText());
						ps.setString(2,GradKontrole.getText());
						ps.executeUpdate();
						rs=ps.getGeneratedKeys();
						if(rs.next())
							idAdrese=rs.getInt(1);
					}
					java.sql.Date datumkontrole=Date.valueOf(DatumKontrole.getText());  
					ps = c.prepareStatement("insert into radarskakontrola(idKamere,idAdrese,Datum) values (?,?,?)", Statement.RETURN_GENERATED_KEYS);
					ps.setInt(1,idKamere);
					ps.setInt(2,idAdrese);
					ps.setDate(3,datumkontrole);
					rezultat=ps.executeUpdate();
					rs=ps.getGeneratedKeys();
					if (rezultat>0 && rs.next())
					{
						idUneseneKontrole=rs.getInt(1);
						idKontrole.setText(Integer.toString(idUneseneKontrole));
					}
					else
					{
						JOptionPane.showMessageDialog(frame, "Greska kod unosa kontrole!", "Warning",
						        JOptionPane.WARNING_MESSAGE);
					}
					panelKontrole.setVisible(true);
					panelKazne.setVisible(true);
					SacuvajRadarskuKontrolu.setVisible(false);;
					DodajKameruButton.setVisible(false);
					
					
				} 
				catch (SQLException ex)
				{
					ex.printStackTrace();
				} 
				catch (Exception ex)
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
		
	}
	private  void inicijalizujComboBox()
	{
		try
		{
			pool=ConnectionPool.getInstance();
			c =pool.checkOut();
			Statement s=c.createStatement();
			rs=s.executeQuery("select * from kamera");
			while(rs.next())
			{
				TipoviKamerecomboBox.addItem(rs.getInt(1)+"-"+rs.getString(2));
				
			}
		}
		catch (SQLException ex)
		{
			ex.printStackTrace();
		} 
		finally
		{
			pool.checkIn(c);
		}
		
	}
	private static void addPopup(Component component, final JPopupMenu popup) {
		component.addMouseListener(new MouseAdapter() {
			public void mousePressed(MouseEvent e) {
				if (e.isPopupTrigger()) {
					showMenu(e);
				}
			}
			public void mouseReleased(MouseEvent e) {
				if (e.isPopupTrigger()) {
					showMenu(e);
				}
			}
			private void showMenu(MouseEvent e) {
				popup.show(e.getComponent(), e.getX(), e.getY());
			}
		});
	}
	
	private void inicijalizujPolja(int idRadarskeKazne)
	{
		try
		{
			pool=ConnectionPool.getInstance();
			c =pool.checkOut();
			ps = c.prepareStatement("select idRadarskaKazna,idRadarskaKontrola,Vrijeme,PrekoracenjeBrzine,RegistracijskeTablice" + 
					" from radarskakazna  where idRadarskaKazna=?");
			ps.setInt(1,idRadarskeKazne);
			rs=ps.executeQuery();
			if(rs.next())
			{
				
				panelKazne.setVisible(true);
				idKontrole.setText(Integer.toString(rs.getInt(2)));
				TabliceText.setText(rs.getString(5));
				VrijemeText.setText(rs.getTime(3).toString());
				PrekoracenjeBrzine.setText(Integer.toString(rs.getInt(4)));
				
			}
		
		} catch (SQLException ex) {
			ex.printStackTrace();
		} 
		finally
		{
			pool.checkIn(c);
		}
	}
}
