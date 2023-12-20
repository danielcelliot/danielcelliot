using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Windows.Forms;
using PremierCare.Classes;

namespace PremierCare.UI
{
    public partial class AllergiesWF : Form
    {
        // Add a drop shadow to form
        protected override CreateParams CreateParams {
            get {
                const int CS_DROPSHADOW = 0x00020000;
                CreateParams cp = base.CreateParams;
                cp.ClassStyle |= CS_DROPSHADOW;
                return cp;
            }
        }

        private string myconnstr = GlobalClass.connectionString;

        public AllergiesWF(string s)
        {
            InitializeComponent();

            // Set Patient ID TextBox value to the selected patient.
            txtbx_patientID.Text = s;

            // Call the method to fill list box with data from Database
            FillListBox();

            // Call the method to select items in list box that correspond to records stored in Database
            SelectItemsInListBox();
        }

        public void FillListBox()
        {
            // Database Connection
            SqlConnection conn = new SqlConnection(myconnstr);

            // Create DataTable
            DataTable dt = new DataTable();

            try
            {
                // Create SQL Statement to select record(s) from Database
                string sql = "SELECT Allergy_ID, Name FROM Allergy";

                // Create cmd using sql and conn
                SqlCommand cmd = new SqlCommand(sql, conn);

                // Open Connection
                conn.Open();

                // Execute query and load records into DataTable
                dt.Load(cmd.ExecuteReader());
                
                // Assign DataTable to Allergy combo box
                lstbox_allergies.DataSource = dt;

                // Assign KeyValue pair to Allergy combo box
                lstbox_allergies.ValueMember = "Allergy_ID";
                lstbox_allergies.DisplayMember = "Name";

                // De-select all items in combo box
                lstbox_allergies.SelectedIndex = -1;
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                conn.Close();
            }
        }

        public void SelectItemsInListBox()
        {
            // Database Connection
            SqlConnection conn = new SqlConnection(myconnstr);

            // Iterate through items in ListBox
            for (int i = 0; i < lstbox_allergies.Items.Count; i++)
            {
                DataRowView objDataRowView = (DataRowView) lstbox_allergies.Items[i];

                // Create SQL Statement to select record from Database
                string sql = "SELECT * FROM Patient_Allergies " +
                             "WHERE Patient_ID='" + Convert.ToInt32(txtbx_patientID.Text) + "' AND " +
                             "Allergy_ID='" + Convert.ToInt32(objDataRowView["Allergy_ID"].ToString()) + "'";

                // Create cmd using sql and conn
                SqlCommand cmd = new SqlCommand(sql, conn);

                // Open connection
                conn.Open();

                // Execute query and assign its return value to variable
                var recordExists = cmd.ExecuteScalar();

                // Check if record exists in Database
                if (recordExists != DBNull.Value && recordExists != null)
                {
                    // Select items in ListBox
                    lstbox_allergies.SelectedIndex = i;
                }

                // Close connection
                conn.Close();
            }
        }
        
        private void btn_addAllergy_Click(object sender, EventArgs e)
        {
            ComboBox cmbAllergy = new ComboBox();
            cmbAllergy.Show();
            cmbAllergy.Size = new Size(162, 25);
            cmbAllergy.Location = new Point(276, 151);
        }

        private void btn_Close_Click(object sender, EventArgs e)
        {
            Close();
        }
        
        private void button1_Click_1(object sender, EventArgs e)
        {
            // Create new Database connection
            SqlConnection conn = new SqlConnection(myconnstr);
            
            // Iterate through items in ListBox
            for (int i = 0; i < lstbox_allergies.Items.Count; i++)
            {
                DataRowView objDataRowView = (DataRowView) lstbox_allergies.Items[i];
                
                // Create SQL Statement to select record(s)
                string sqlSelect = "SELECT * FROM Patient_Allergies " +
                                   "WHERE Patient_ID='" + Convert.ToInt32(txtbx_patientID.Text) + "' AND " +
                                   "Allergy_ID='" + Convert.ToInt32(objDataRowView["Allergy_ID"].ToString()) + "'";

                // Check if item at index 'i' is selected.
                if (lstbox_allergies.GetSelected(i))    // Returns TRUE or FALSE.
                {
                    // Create SQL Command
                    SqlCommand cmd = new SqlCommand(sqlSelect, conn);

                    // Open connection
                    conn.Open();

                    // Execute query and assign its return value to variable
                    var recordExists = cmd.ExecuteScalar();
                    
                    // Check if record exists in Database
                    if (recordExists == null)
                    {
                        // Create a SQL Statement to insert record
                        string sqlInsert = "INSERT INTO Patient_Allergies (Patient_ID, Allergy_ID) " +
                                             "VALUES ('" +
                                             Convert.ToInt32(txtbx_patientID.Text) + "', '" +
                                             Convert.ToInt32(objDataRowView["Allergy_ID"].ToString()) + "')";

                        // Create SQL command
                        SqlCommand command = new SqlCommand(sqlInsert, conn);

                        // Execute query
                        command.ExecuteNonQuery();
                    }
                }
                else
                {
                    // Create SQL Command
                    SqlCommand cmd = new SqlCommand(sqlSelect, conn);

                    // Open connection
                    conn.Open();

                    // Execute query and assign return value to variable
                    var recordExists = cmd.ExecuteScalar();
                    
                    // Check if record exists in Database
                    if (recordExists != DBNull.Value && recordExists != null)
                    {
                        // Create a SQL Statement to delete record
                        string sqlDelete = "DELETE FROM Patient_Allergies " +
                                             "WHERE Patient_ID='" + Convert.ToInt32(txtbx_patientID.Text) + "' " +
                                             "AND Allergy_ID='" + Convert.ToInt32(objDataRowView["Allergy_ID"].ToString()) + "'";

                        // Create SQL command
                        SqlCommand command = new SqlCommand(sqlDelete, conn);

                        // Execute query
                        int rows = command.ExecuteNonQuery();
                    }
                }

                // Close connection
                conn.Close();
            }

            // Close dialog
            Close();
        }
    }
}
