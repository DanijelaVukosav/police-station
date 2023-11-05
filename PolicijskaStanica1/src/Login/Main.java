package Login;

import java.awt.BorderLayout;
import java.awt.EventQueue;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.concurrent.TimeUnit;

import javax.swing.JFrame;
import javax.swing.JTextField;
import javax.swing.WindowConstants;

import connectionpool.ConnectionPool;

public class Main
{
	public static Connection c = null;
	public static Statement s = null;
	public static ResultSet rs = null;
	public static String jmb_prijavljenog_policajca=null;
	
	public static void main(String[] args) {
		Main primer = new Main();
		primer.prikaziPredmete();
		
		try
		{
			
			SimpleDateFormat formater = new SimpleDateFormat("HH:mm");
			Time vrijeme =new Time( formater.parse("14:24").getTime());
			SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-mm-dd");
		    java.util.Date dattum = sdformat.parse("2021-07-30");
		    java.sql.Date datum=Date.valueOf("2021-07-30");
			System.out.println(vrijeme);
			System.out.println(datum);
		}
		catch(Exception ex)
		{
			System.out.println("Izuzetak");
		}
		
	}

	private void prikaziPredmete() {
		ConnectionPool pool = null;
		Statement s = null;
		ResultSet rs = null;
		try 
		{
			pool=ConnectionPool.getInstance();
			Connection c =pool.checkOut();
			s = c.createStatement();
			rs = s.executeQuery("select * from ucesniciusaobracajnojnesreci");

			while (rs.next())
				System.out.println(rs.getString(1) + " " + rs.getString(2) );
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (s != null)
				try {
					s.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (c != null)
				try {
					c.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
	}

}
