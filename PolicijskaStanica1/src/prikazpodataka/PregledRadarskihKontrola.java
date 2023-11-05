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
import javax.swing.JScrollPane;

public class PregledRadarskihKontrola extends JFrame {

	private JPanel contentPane;
	private JTable table;
	private JScrollPane scrollPane;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					PregledRadarskihKontrola frame = new PregledRadarskihKontrola();
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
	public PregledRadarskihKontrola() {
		//setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 777, 401);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JLabel lblNewLabel = new JLabel("Radarske kontrole saobracajne policije");
		lblNewLabel.setFont(new Font("Sitka Subheading", Font.ITALIC, 26));
		lblNewLabel.setBounds(154, 21, 450, 37);
		contentPane.add(lblNewLabel);
		
		scrollPane = new JScrollPane();
		scrollPane.setBounds(24, 76, 727, 275);
		contentPane.add(scrollPane);
		
		table = new JTable();
		DefaultTableModel model=new DefaultTableModel(
				inicijalizujMatricu(),
				new String[] {
					"Adresa", "Grad", "Datum", "TipKamere"
				}
			);
		Object[] imena={
				"Adresa", "Grad", "Datum", "TipKamere"
			};
		model.setColumnIdentifiers(imena);
		table.setModel(model);
		scrollPane.setViewportView(table);
		

		//String[] columnNames = new String[] {"Column Header1", "Column Header2", "Column Header3"};
		//model.setColumnIdentifiers(columnNames);
		
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
			rs=s.executeQuery("select count(*) from radarske_kontrole");
			rs.next();
			matrica=new Object[rs.getInt(1)][4];
			
			rs=s.executeQuery("select * from radarske_kontrole");
			int i=0;
			while(rs.next())
			{
				matrica[i][0]=rs.getString(1);
				matrica[i][1]=rs.getString(2);
				matrica[i][2]=rs.getDate(3);
				matrica[i++][3]=rs.getString(4);
				
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
