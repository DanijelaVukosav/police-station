package prikazpodataka;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JLabel;
import java.awt.Font;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.JTableHeader;

import connectionpool.ConnectionPool;
import javax.swing.SwingConstants;
import javax.swing.JScrollPane;


public class IzvjestajiSaobracajnihNesreca extends JFrame {

	private JPanel contentPane;
	private JTable table;
	private JScrollPane scrollPane;
	private JTable table_1;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					IzvjestajiSaobracajnihNesreca frame = new IzvjestajiSaobracajnihNesreca();
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
	public IzvjestajiSaobracajnihNesreca() {
		//setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 777, 401);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JLabel lblNewLabel = new JLabel("Izvjestaji saobracajnih nesreca sa ucesnicima");
		lblNewLabel.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel.setFont(new Font("Sitka Subheading", Font.ITALIC, 26));
		lblNewLabel.setBounds(31, 21, 696, 37);
		contentPane.add(lblNewLabel);
		
		JScrollPane scrollPane_1 = new JScrollPane();
		scrollPane_1.setBounds(31, 103, 705, 231);
		contentPane.add(scrollPane_1);
		
		table_1 = new JTable();
		
		
		DefaultTableModel model=new DefaultTableModel(inicijalizujMatricu(),new String[]{
				"Ucesnik", "Adresa", "Grad", "Vrijeme","Datum"
			}); 
		Object[] imena={
				"Ucesnik", "Adresa", "Grad", "Vrijeme","Datum"
			};
		model.setColumnIdentifiers(imena);
		table_1.setModel(model);
		scrollPane_1.setViewportView(table_1);
		
	}
	private ResultSet inicijalizujMatricuRS()
	{
		
		ConnectionPool pool = null;
		Connection c= null;
		Statement s = null;
		ResultSet rs = null;
		Object [][] matrica=null;
		try
		{
			
			pool=ConnectionPool.getInstance();
			c =pool.checkOut();
			s = c.createStatement();
			rs=s.executeQuery("select count(*) from saobracajne_nesrece");
			rs.next();
			matrica=new Object[rs.getInt(1)][5];
			
			rs=s.executeQuery("select * from saobracajne_nesrece");
			int i=0;
			while(rs.next())
			{
				matrica[i][0]=rs.getString(1);
				matrica[i][1]=rs.getString(2);
				matrica[i][2]=rs.getString(3);
				matrica[i][3]=rs.getTime(4);
				matrica[i++][4]=rs.getDate(5);
				
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
			return rs;
		}
	}
	
	private Object [][] inicijalizujMatricu()
	{
		
		ConnectionPool pool = null;
		Connection c= null;
		Statement s = null;
		ResultSet rs = null;
		Object [][] matrica=null;
		try
		{
			
			pool=ConnectionPool.getInstance();
			c =pool.checkOut();
			s = c.createStatement();
			rs=s.executeQuery("select count(*) from saobracajne_nesrece");
			rs.next();
			matrica=new Object[rs.getInt(1)][5];
			
			rs=s.executeQuery("select * from saobracajne_nesrece");
			int i=0;
			while(rs.next())
			{
				matrica[i][0]=rs.getString(1);
				matrica[i][1]=rs.getString(2);
				matrica[i][2]=rs.getString(3);
				matrica[i][3]=rs.getTime(4);
				matrica[i++][4]=rs.getDate(5);
				
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
			return matrica;
		}
	}
}
