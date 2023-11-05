package prikazpodataka;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
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

public class PregledRadarskihKazni extends JFrame {

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
					PregledRadarskihKazni frame = new PregledRadarskihKazni();
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
	public PregledRadarskihKazni() {
		//setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 777, 401);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JLabel lblNewLabel = new JLabel("Radarske kazne");
		lblNewLabel.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel.setFont(new Font("Sitka Subheading", Font.ITALIC, 26));
		lblNewLabel.setBounds(154, 21, 450, 37);
		contentPane.add(lblNewLabel);
		
		scrollPane = new JScrollPane();
		scrollPane.setBounds(25, 96, 713, 255);
		contentPane.add(scrollPane);
		
		table = new JTable();
		DefaultTableModel model=new DefaultTableModel(
				inicijalizujMatricu(),
				new String[] {
					"Registracijske tablice", "Prekoracenje brzine", "Vrijeme", "Datum", "Adresa", "Grad"
				}
			);
		Object[] imena={
				"Registracijske tablice", "Prekoracenje brzine", "Vrijeme", "Datum", "Adresa", "Grad"
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
			rs=s.executeQuery("select count(*) from radarske_kazne");
			rs.next();
			matrica=new Object[rs.getInt(1)][6];
			
			rs=s.executeQuery("select * from radarske_kazne");
			int i=0;
			while(rs.next())
			{
				matrica[i][0]=rs.getString(1);
				matrica[i][1]=rs.getInt(2);
				matrica[i][2]=rs.getTime(3);
				matrica[i][3]=rs.getDate(4);
				matrica[i][4]=rs.getString(5);
				matrica[i++][5]=rs.getString(6);
				
				
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
