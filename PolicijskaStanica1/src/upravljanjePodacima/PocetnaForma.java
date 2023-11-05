package upravljanjePodacima;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.border.EmptyBorder;
import javax.swing.table.DefaultTableModel;

import prikazpodataka.IzvjestajiSaobracajnihNesreca;
import prikazpodataka.PregledRadarskihKazni;
import prikazpodataka.PregledRadarskihKontrola;

//import com.sun.tools.javac.util.List;

import java.awt.FlowLayout;
import java.awt.Image;

import javax.swing.JLabel;
import javax.swing.ImageIcon;
import javax.swing.JTextField;
import javax.swing.JMenuItem;
import javax.swing.KeyStroke;
import java.awt.event.KeyEvent;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.awt.CardLayout;
import javax.swing.JButton;
import javax.swing.GroupLayout;
import javax.swing.GroupLayout.Alignment;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.LayoutStyle.ComponentPlacement;
import java.awt.Color;
import java.awt.SystemColor;
import java.awt.Font;
import javax.swing.SwingConstants;
import javax.swing.JTable;
import java.awt.Scrollbar;
import javax.swing.border.LineBorder;
import javax.swing.UIManager;

public class PocetnaForma extends JFrame {

	private JPanel contentPane;
	private JTable table;
	private JTable table_1;
	private JTable table_2;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					PocetnaForma frame = new PocetnaForma();
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
	public PocetnaForma() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 1035, 639);
		contentPane = new JPanel();
		contentPane.setBackground(SystemColor.inactiveCaption);
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JPanel panel = new JPanel();
		panel.setBackground(SystemColor.activeCaption);
		panel.setBounds(78, 96, 380, 166);
		contentPane.add(panel);
		
		JButton DodajRadarskuKontrolu = new JButton("Radarska kontrola");
		DodajRadarskuKontrolu.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				new FormaRadarskeKazne().main(null);
			}
		});
		DodajRadarskuKontrolu.setBackground(UIManager.getColor("Button.light"));
		
		JLabel lblNewLabel = new JLabel("Dodaj:");
		
		JButton btnNewButton_1 = new JButton("Kazneni nalog");
		btnNewButton_1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				new KazneniNalog().main(null);
			}
		});
		
		JButton btnNewButton_2 = new JButton("Izvjestaj saobracajne nesrece");
		btnNewButton_2.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				new SaobracajnaNesrecaForma().main(null);
			}
		});
		GroupLayout gl_panel = new GroupLayout(panel);
		gl_panel.setHorizontalGroup(
			gl_panel.createParallelGroup(Alignment.LEADING)
				.addGroup(gl_panel.createSequentialGroup()
					.addGap(46)
					.addGroup(gl_panel.createParallelGroup(Alignment.LEADING, false)
						.addComponent(btnNewButton_2, Alignment.TRAILING, GroupLayout.DEFAULT_SIZE, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
						.addComponent(btnNewButton_1, GroupLayout.DEFAULT_SIZE, GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
						.addComponent(DodajRadarskuKontrolu, GroupLayout.DEFAULT_SIZE, 282, Short.MAX_VALUE)
						.addComponent(lblNewLabel))
					.addContainerGap(52, Short.MAX_VALUE))
		);
		gl_panel.setVerticalGroup(
			gl_panel.createParallelGroup(Alignment.LEADING)
				.addGroup(gl_panel.createSequentialGroup()
					.addContainerGap()
					.addComponent(lblNewLabel)
					.addPreferredGap(ComponentPlacement.RELATED)
					.addComponent(DodajRadarskuKontrolu, GroupLayout.PREFERRED_SIZE, 32, GroupLayout.PREFERRED_SIZE)
					.addPreferredGap(ComponentPlacement.UNRELATED)
					.addComponent(btnNewButton_1, GroupLayout.PREFERRED_SIZE, 31, GroupLayout.PREFERRED_SIZE)
					.addPreferredGap(ComponentPlacement.UNRELATED)
					.addComponent(btnNewButton_2, GroupLayout.PREFERRED_SIZE, 31, GroupLayout.PREFERRED_SIZE)
					.addContainerGap(19, Short.MAX_VALUE))
		);
		panel.setLayout(gl_panel);
		
		JPanel panel_1 = new JPanel();
		panel_1.setBackground(SystemColor.activeCaption);
		panel_1.setBounds(78, 273, 380, 159);
		contentPane.add(panel_1);
		
		JLabel lblNewLabel_1 = new JLabel("Procitaj dosadasnje izvjestaje:");
		
		JButton btnNewButton_3 = new JButton("Radarske kontrola");
		btnNewButton_3.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				new PregledRadarskihKontrola().main(null);
			}
			
		});
		JButton btnNewButton_5 = new JButton("Izvjestaji saobracajnih nesreca");
		btnNewButton_5.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				new IzvjestajiSaobracajnihNesreca().main(null);
			}
		});
		JButton btnNewButton_4 = new JButton("Radarske kazne");
		btnNewButton_4.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				new PregledRadarskihKazni().main(null);
			}
		});
		
		GroupLayout gl_panel_1 = new GroupLayout(panel_1);
		gl_panel_1.setHorizontalGroup(
			gl_panel_1.createParallelGroup(Alignment.TRAILING)
				.addGroup(Alignment.LEADING, gl_panel_1.createSequentialGroup()
					.addGap(42)
					.addGroup(gl_panel_1.createParallelGroup(Alignment.LEADING)
						.addGroup(gl_panel_1.createSequentialGroup()
							.addComponent(lblNewLabel_1)
							.addContainerGap())
						.addGroup(Alignment.TRAILING, gl_panel_1.createSequentialGroup()
							.addGroup(gl_panel_1.createParallelGroup(Alignment.TRAILING)
								.addComponent(btnNewButton_5, Alignment.LEADING, GroupLayout.DEFAULT_SIZE, 289, Short.MAX_VALUE)
								.addComponent(btnNewButton_4, Alignment.LEADING, GroupLayout.DEFAULT_SIZE, 289, Short.MAX_VALUE)
								.addComponent(btnNewButton_3, Alignment.LEADING, GroupLayout.DEFAULT_SIZE, 289, Short.MAX_VALUE))
							.addGap(49))))
		);
		gl_panel_1.setVerticalGroup(
			gl_panel_1.createParallelGroup(Alignment.LEADING)
				.addGroup(gl_panel_1.createSequentialGroup()
					.addContainerGap()
					.addComponent(lblNewLabel_1)
					.addPreferredGap(ComponentPlacement.RELATED)
					.addComponent(btnNewButton_3, GroupLayout.PREFERRED_SIZE, 34, GroupLayout.PREFERRED_SIZE)
					.addPreferredGap(ComponentPlacement.UNRELATED)
					.addComponent(btnNewButton_4, GroupLayout.PREFERRED_SIZE, 32, GroupLayout.PREFERRED_SIZE)
					.addPreferredGap(ComponentPlacement.RELATED)
					.addComponent(btnNewButton_5, GroupLayout.PREFERRED_SIZE, 34, GroupLayout.PREFERRED_SIZE)
					.addContainerGap(50, Short.MAX_VALUE))
		);
		panel_1.setLayout(gl_panel_1);
		
		JLabel lblNewLabel_2 = new JLabel("Policija Republike Srpske");
		lblNewLabel_2.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel_2.setFont(new Font("Script MT Bold", Font.BOLD | Font.ITALIC, 32));
		lblNewLabel_2.setBounds(46, 11, 550, 74);
		contentPane.add(lblNewLabel_2);
		
		JLabel lblNewLabel_3 = new JLabel("New label");
		lblNewLabel_3.setIcon(new ImageIcon("slika1.jpg"));
		lblNewLabel_3.setBounds(533, 70, 462, 492);
		contentPane.add(lblNewLabel_3);
		
		JPanel panel_2 = new JPanel();
		panel_2.setBackground(SystemColor.activeCaption);
		panel_2.setBounds(76, 446, 382, 95);
		contentPane.add(panel_2);
		panel_2.setLayout(null);
		
		JLabel lblNewLabel_4 = new JLabel("Izmjena podataka:");
		lblNewLabel_4.setBounds(47, 11, 188, 14);
		panel_2.add(lblNewLabel_4);
		
		JButton btnNewButton = new JButton("Radarske kazne");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				new AzuriranjeRadarskihKazni().main(null);;
			}
		});
		btnNewButton.setBounds(47, 36, 285, 36);
		panel_2.add(btnNewButton);
		
	}
	
	private Object[][] ucitajUprave() {
		Object[][] pom=new Object[1][2];
		Connection c = null;
		Statement s = null;
		ResultSet rs = null;
		try {
			c = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/policijaa", "root", "Vukosav99");
			s = c.createStatement();
			String query = "select count(*) from uprava";
			rs = s.executeQuery(query);
		    rs.next();
		    int count = rs.getInt(1);
		    System.out.println(count);
			rs = s.executeQuery("select * from uprava");
			pom=new Object[count][2]; int i=0;
			while (rs.next())
			{
				System.out.println(rs.getString(1) + " " + rs.getString(2));
				pom[i][0]= rs.getString(1);
				pom[i++][1]= rs.getString(2);
			}
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
		
		//Object[][] tabela=new Object[4][2];
		return pom;
	}
}
