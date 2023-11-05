package upravljanjePodacima;

import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.EventQueue;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JPopupMenu;
import javax.swing.border.EmptyBorder;

import connectionpool.ConnectionPool;

import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.JTableHeader;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.ActionEvent;
import javax.swing.JTextField;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JComboBox;
import javax.swing.JScrollPane;

public class AzuriranjeRadarskihKazni extends JFrame {
	private static AzuriranjeRadarskihKazni frame;
	private JPanel contentPane;
	private JTable table;
	private JTextField KljucPretrageField;
	private JTable table_1;
	private Object[][] trenutnaMatrica;
	DefaultTableModel model;
	private JComboBox KategorijePretrazivanja;
	
	ConnectionPool pool = null;
	Connection c= null;
	Statement s = null;
	ResultSet rs = null;
	CallableStatement cs = null;


	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try 
				{
					 frame = new AzuriranjeRadarskihKazni();
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
	public AzuriranjeRadarskihKazni() {
		//setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 769, 535);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JButton btnNewButton = new JButton("Izbrisi");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e)
			{
				
				try 
				{
					pool=ConnectionPool.getInstance();
					c =pool.checkOut();
					int redZaBrisanje=table_1.getSelectedRow();
					Object[] red=trenutnaMatrica[redZaBrisanje];
					
					PreparedStatement ps = c.prepareStatement("delete from radarskakazna where idRadarskaKazna=?");
					ps.setInt(1,(Integer)red[0]);
					int rezultat =ps.executeUpdate();
					if(rezultat==1)
					{
						model.removeRow(redZaBrisanje);
						JOptionPane.showMessageDialog(frame,  "Radarska kazna je usjesno uklonjena!");
					}
					else
					{
						JOptionPane.showMessageDialog(frame,  "Doslo je do greske..");
					}
					//System.out.println(red[0]);
					
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
		btnNewButton.setBounds(33, 22, 89, 23);
		contentPane.add(btnNewButton);
		
		JButton btnNewButton_1 = new JButton("Azuriraj");
		btnNewButton_1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e)
			{
				try 
				{
					pool=ConnectionPool.getInstance();
					c =pool.checkOut();
					int redZaAzuriranje=table_1.getSelectedRow();
					Object[] red=trenutnaMatrica[redZaAzuriranje];
					Object[] noviRed=new Object[8];
					new FormaRadarskeKazne().azuriranje((int)red[0]);
					
					
					//PreparedStatement ps = c.prepareStatement("select idRadarskaKazna,idRadarskaKontrola,Vrijeme,Datum,NovcanaKazna,PrekoracenjeBrzine,RegistracijskeTablice,concat(Ulica,' ',Mjesto) as Adresa" + 
						//	" from radarskakazna natural join radarskakontrola natural join adresa where idRadarskaKazna=?");
					cs=c.prepareCall("{call dobavljanje_radarske_kazne(?)}");
					cs.setInt(1, (int)red[0]);
					rs = cs.executeQuery();


				//	ps.setInt(1,(int)red[0]);
					//rs=ps.executeQuery();
					if(rs.next())
					{
						noviRed[0]=rs.getInt(1);
						noviRed[1]=rs.getInt(2);
						noviRed[2]=rs.getTime(3);
						noviRed[3]=rs.getDate(4);
						noviRed[4]=rs.getDouble(5);
						noviRed[5]=rs.getInt(6);
						noviRed[6]=rs.getString(7);
						noviRed[7]=rs.getString(8);
										
						model.removeRow(redZaAzuriranje);
						model.addRow(noviRed);
					}
					else
					{
						JOptionPane.showMessageDialog(frame,  "Doslo je do greske..");
					}
					//System.out.println(red[0]);
					
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
		btnNewButton_1.setBounds(165, 22, 89, 23);
		contentPane.add(btnNewButton_1);
		
		KljucPretrageField = new JTextField();
		KljucPretrageField.setBounds(32, 128, 222, 37);
		contentPane.add(KljucPretrageField);
		KljucPretrageField.setColumns(10);
		
		JLabel lblNewLabel = new JLabel("Pretraga");
		lblNewLabel.setBounds(30, 108, 206, 14);
		contentPane.add(lblNewLabel);
		
		JButton btnNewButton_2 = new JButton("Pretrazi");
		btnNewButton_2.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) 
			{
				
				String kategorija=(String)KategorijePretrazivanja.getSelectedItem();
				String kljucPretrage=KljucPretrageField.getText();
				
				model=new DefaultTableModel(inicijalizujMatricu(kljucPretrage,kategorija),new String[]{
						"idRadarskeKazne", "idRadarskeKontrole", "Vrijeme","Datum", "NovcanaKazna","PrekoracenjeBrzine","RegistracijskeTablice","Adresa"
					}); 
				Object[] imena={
						"idRadarskeKazne", "idRadarskeKontrole", "Vrijeme","Datum", "NovcanaKazna","PrekoracenjeBrzine","RegistracijskeTablice","Adresa"
					};
				model.setColumnIdentifiers(imena);
				table_1.setModel(model);
				
			}
		});
		btnNewButton_2.setBounds(479, 135, 89, 23);
		contentPane.add(btnNewButton_2);
		
		KategorijePretrazivanja = new JComboBox();
		KategorijePretrazivanja.setBounds(264, 128, 171, 37);
		contentPane.add(KategorijePretrazivanja);
		KategorijePretrazivanja.addItem("idRadarskeKazne");
		KategorijePretrazivanja.addItem("idRadarskeKontrole");
		KategorijePretrazivanja.addItem("RegistracijskeTablice");

		
		JLabel lblNewLabel_1 = new JLabel("Kategorija pretrage");
		lblNewLabel_1.setBounds(264, 108, 143, 14);
		contentPane.add(lblNewLabel_1);
		
		JScrollPane scrollPane = new JScrollPane();
		scrollPane.setBounds(30, 214, 713, 271);
		contentPane.add(scrollPane);
		
		table_1 = new JTable();
		model=new DefaultTableModel(inicijalizujMatricu("*",null),new String[]{
				"idRadarskeKazne", "idRadarskeKontrole", "Vrijeme","Datum", "NovcanaKazna","PrekoracenjeBrzine","RegistracijskeTablice","Adresa"
			}); 
		Object[] imena={
				"idRadarskeKazne", "idRadarskeKontrole", "Vrijeme","Datum", "NovcanaKazna","PrekoracenjeBrzine","RegistracijskeTablice","Adresa"
			};
		model.setColumnIdentifiers(imena);
		table_1.setModel(model);
		scrollPane.setViewportView(table_1);
		//contentPane.add(table);
	}
	private Object [][] inicijalizujMatricu(String kljucPretrage,String kategorija)
	{
		
		
		Object [][] matrica=null;
		try
		{
			PreparedStatement ps=null;
			pool=ConnectionPool.getInstance();
			c =pool.checkOut();
			s = c.createStatement();
			if(kljucPretrage.equals("*"))
			{
				rs=s.executeQuery("select count(*) from radarskakazna");
				rs.next();
				matrica=new Object[rs.getInt(1)][8];
				
				rs=s.executeQuery("select idRadarskaKazna,idRadarskaKontrola,Vrijeme,Datum,NovcanaKazna,PrekoracenjeBrzine,RegistracijskeTablice,concat(Ulica,' ',Mjesto) as Adresa"
						+ " from radarskakazna natural join radarskakontrola natural join adresa");
				int i=0;
				while(rs.next())
				{
					matrica[i][0]=rs.getInt(1);
					matrica[i][1]=rs.getInt(2);
					matrica[i][2]=rs.getTime(3);
					matrica[i][3]=rs.getDate(4);
					matrica[i][4]=rs.getDouble(5);
					matrica[i][5]=rs.getInt(6);
					matrica[i][6]=rs.getString(7);
					matrica[i++][7]=rs.getString(8);
					
					
				}
			}
			else if(kategorija.equals("idRadarskeKazne"))
			{
				ps = c.prepareStatement("select count(*) from radarskakazna where idRadarskaKazna=?");
				ps.setInt(1,Integer.parseInt(kljucPretrage));
				rs=ps.executeQuery();
				if (rs.next())
					matrica=new Object[rs.getInt(1)][8];
				
				//ps = c.prepareStatement("select idRadarskaKazna,idRadarskaKontrola,Vrijeme,Datum,NovcanaKazna,PrekoracenjeBrzine,RegistracijskeTablice,concat(Ulica,' ',Mjesto) as Adresa" + 
				//		" from radarskakazna natural join radarskakontrola natural join adresa where idRadarskaKazna=?");
				//ps.setInt(1,Integer.parseInt(kljucPretrage));
				//rs=ps.executeQuery();
				cs=c.prepareCall("{call dobavljanje_radarske_kazne(?)}");
				cs.setInt(1, Integer.parseInt(kljucPretrage));
				rs = cs.executeQuery();

				int i=0;
				while(rs.next())
				{
					matrica[i][0]=rs.getInt(1);
					matrica[i][1]=rs.getInt(2);
					matrica[i][2]=rs.getTime(3);
					matrica[i][3]=rs.getDate(4);
					matrica[i][4]=rs.getDouble(5);
					matrica[i][5]=rs.getInt(6);
					matrica[i][6]=rs.getString(7);
					matrica[i++][7]=rs.getString(8);
					
				}
				
			}
			else if( kategorija.equals("idRadarskeKontrole"))
			{
				ps = c.prepareStatement("select count(*) from radarskakazna where idRadarskaKontrola=?");
				ps.setInt(1,Integer.parseInt(kljucPretrage));
				rs=ps.executeQuery();
				if (rs.next())
					matrica=new Object[rs.getInt(1)][8];
				
			//	ps = c.prepareStatement("select idRadarskaKazna,idRadarskaKontrola,Vrijeme,Datum,NovcanaKazna,PrekoracenjeBrzine,RegistracijskeTablice,concat(Ulica,' ',Mjesto) as Adresa"+ 
					//	" from radarskakazna natural join radarskakontrola natural join adresa where idRadarskaKontrola=?");
				//ps.setInt(1,Integer.parseInt(kljucPretrage));
				//rs=ps.executeQuery();
				cs=c.prepareCall("{call dobavljanje_kazni_radarske_kontrole(?)}");
				cs.setInt(1, Integer.parseInt(kljucPretrage));
				rs = cs.executeQuery();
				int i=0;
				while(rs.next())
				{
					matrica[i][0]=rs.getInt(1);
					matrica[i][1]=rs.getInt(2);
					matrica[i][2]=rs.getTime(3);
					matrica[i][3]=rs.getDate(4);
					matrica[i][4]=rs.getDouble(5);
					matrica[i][5]=rs.getInt(6);
					matrica[i][6]=rs.getString(7);
					matrica[i++][7]=rs.getString(8);
					
				}
				
			}
			else if( kategorija.equals("RegistracijskeTablice"))
			{
				ps = c.prepareStatement("select count(*) from radarskakazna where registracijskeTablice=?");
				ps.setString(1,kljucPretrage);
				rs=ps.executeQuery();
				if (rs.next())
					matrica=new Object[rs.getInt(1)][8];
				
				//ps = c.prepareStatement("select idRadarskaKazna,idRadarskaKontrola,Vrijeme,Datum,NovcanaKazna,PrekoracenjeBrzine,RegistracijskeTablice,concat(Ulica,' ',Mjesto) as Adresa"+ 
						//" from radarskakazna natural join radarskakontrola natural join adresa where registracijskeTablice=?");
				//ps.setString(1,kljucPretrage);
				//rs=ps.executeQuery();
				cs=c.prepareCall("{call dobavljanje_kazni_na_osnovu_registracije(?)}");
				cs.setString(1, kljucPretrage);
				rs = cs.executeQuery();
				int i=0;
				while(rs.next())
				{
					matrica[i][0]=rs.getInt(1);
					matrica[i][1]=rs.getInt(2);
					matrica[i][2]=rs.getTime(3);
					matrica[i][3]=rs.getDate(4);
					matrica[i][4]=rs.getDouble(5);
					matrica[i][5]=rs.getInt(6);
					matrica[i][6]=rs.getString(7);
					matrica[i++][7]=rs.getString(8);
					
				}
				
			}
			
			
		}
		catch(Exception ex)
		{
			System.out.println("Izuzetak kod kreiranja matrice!");
			ex.printStackTrace();
		}
		finally
		{
			pool.checkIn(c);
			return trenutnaMatrica=matrica;
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
}
