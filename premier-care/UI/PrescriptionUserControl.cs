using System;
using System.Data;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Drawing;
using PremierCare.Classes;

namespace PremierCare.UI
{
    public partial class PrescriptionUserControl : UserControl
    {
        PrescriptionClass prescription = new PrescriptionClass();

        private string myconnstr = GlobalClass.connectionString;

        public PrescriptionUserControl()
        {
            InitializeComponent();

            // Format columns in DataGrid view
            dgv_findPrescription.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
            dgv_findPrescription.AutoResizeColumns();
            dgv_findPrescription.ColumnHeadersDefaultCellStyle.Font = new Font(DefaultFont, FontStyle.Bold);

            // De-select all items in DataGrid view
            dgv_findPrescription.ClearSelection();
        }

        public void LoadPrescriptionDgvData()
        {
            // Load data onto DataGrid view
            DataTable dt = prescription.Select();
            dgv_findPrescription.DataSource = dt;
        }

        private void btn_addPrescription_Click_1(object sender, EventArgs e)
        {
            // Get the data from input/selection fields.
            prescription.DrugId = Convert.ToInt32(cmb_prescDrug.SelectedValue.ToString());
            prescription.DoctorId = Convert.ToInt32(cmb_prescDoctor.SelectedValue.ToString());
            prescription.PatientId = Convert.ToInt32(cmb_prescPatient.SelectedValue.ToString());
            prescription.Period = txtbx_prescPeriod.Text;
            prescription.Dosage = txtbx_dosage.Text;
            prescription.Description = txtbx_prescDesc.Text;
            prescription.Date = DateTime.Today.ToString("MM/dd/yyyy");

            // Insert data into database
            bool success = prescription.Insert(prescription);
            if (success)
            {
                // Successfully inserted
                MessageBox.Show("Prescription added successfully.");

                // Call the clear method
                Clear();
            }
            else
            {
                // Failed to add patient
                MessageBox.Show("Failed to add new prescription. Try again.");
            }

            // Call the method to refresh DataGrid view after insert.
            LoadPrescriptionDgvData();
        }

        private void btn_updatePrescription_Click(object sender, EventArgs e)
        {
            // Get the data from text boxes
            prescription.PrescriptionId = int.Parse(txtbx_prescID.Text);
            prescription.DrugId = Convert.ToInt32(cmb_prescDrug.SelectedValue.ToString());
            prescription.DoctorId = Convert.ToInt32(cmb_prescDoctor.SelectedValue.ToString());
            prescription.PatientId = Convert.ToInt32(cmb_prescPatient.SelectedValue.ToString());
            prescription.Period = txtbx_prescPeriod.Text;
            prescription.Dosage = txtbx_dosage.Text;
            prescription.Description = txtbx_prescDesc.Text;
            prescription.Date = DateTime.Today.ToString("MM/dd/yyyy");

            // Update data in the database
            bool success = prescription.Update(prescription);
            if (success)
            {
                // Successfully updated
                MessageBox.Show("Prescription updated successfully.");
                
                // Call the method to refresh DataGrid view after update.
                LoadPrescriptionDgvData();

                // Call the clear method
                Clear();
            }
            else
            {
                // Failed to update contact
                MessageBox.Show("Failed to update prescription. Try again.");
            }
        }

        private void btn_deletePrescription_Click(object sender, EventArgs e)
        {
            // Get the prescription ID from the application
            prescription.PrescriptionId = Convert.ToInt32(txtbx_prescID.Text);

            // Delete data in the database
            bool success = prescription.Delete(prescription);
            if(success)
            {
                // Successfully deleted
                MessageBox.Show("Prescription deleted successfully.");
                
                // Call the method to refresh DataGrid view after deletion.
                LoadPrescriptionDgvData();

                // Call the clear method
                Clear();
            }
            else
            {
                // Delete failed
                MessageBox.Show("Failed to delete prescription. Try again.");
            }
        }

        private void btn_clearPrescription_Click(object sender, EventArgs e)
        {
            // Call the clear method
            Clear();
        }

        public void Clear()
        {
            txtbx_prescID.Clear();
            cmb_prescDrug.SelectedIndex = -1;
            cmb_prescDoctor.SelectedIndex = -1;
            txtbx_dosage.Clear();
            txtbx_findPrescription.Clear();
            cmb_prescPatient.SelectedIndex = -1;
            txtbx_prescDesc.Clear();
            txtbx_prescPeriod.Clear();
            dgv_findPrescription.ClearSelection();
        }

        public void FillDrugComboBox()
        {
            // Step 1: Database Connection
            SqlConnection conn = new SqlConnection(myconnstr);
            DataTable dt = new DataTable();
            
            try
            {
                // Step 2: Write SQL query
                string sql = "SELECT Drug_ID, Name FROM Drug";

                // Create cmd using sql and conn
                SqlCommand cmd = new SqlCommand(sql, conn);

                conn.Open();
                dt.Load(cmd.ExecuteReader());

                // Assign DataTable to Drug combo box
                cmb_prescDrug.DataSource = dt;

                // Assign KeyValue pair to Drug combo box
                cmb_prescDrug.ValueMember = "Drug_ID";
                cmb_prescDrug.DisplayMember = "Name";

                // De-select all items in combo box
                cmb_prescDrug.SelectedIndex = -1;
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

        public void FillPatientComboBox()
        {
            // Step 1: Database Connection
            SqlConnection conn = new SqlConnection(myconnstr);
            DataTable dt = new DataTable();
            
            try
            {
                // Step 2: Write SQL query
                string sql = "SELECT Patient_ID, " +
                             "CONCAT(First_Name, ' ', Last_Name) AS Name " +
                             "FROM Patient " +
                             "ORDER BY Last_Name";

                // Create cmd using sql and conn
                SqlCommand cmd = new SqlCommand(sql, conn);

                conn.Open();
                dt.Load(cmd.ExecuteReader());

                // Assign Table to combo box
                cmb_prescPatient.DataSource = dt;

                // Assign KeyValue pair to combo box
                cmb_prescPatient.ValueMember = "Patient_ID";
                cmb_prescPatient.DisplayMember = "Name";

                // De-select all items in combo box
                cmb_prescPatient.SelectedIndex = -1;
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

        public void FillDoctorComboBox()
        {
            // Step 1: Database Connection
            SqlConnection conn = new SqlConnection(myconnstr);
            DataTable dt = new DataTable();
            
            try
            {
                // Step 2: Write SQL query
                string sql = "SELECT Doctor_ID, " +
                             "(select CONCAT(First_Name, ' ', Last_Name) from Staff as A where A.Staff_ID = B.Staff_ID) as Name " +
                             "FROM Doctor as B";

                // Create cmd using sql and conn
                SqlCommand cmd = new SqlCommand(sql, conn);

                conn.Open();
                dt.Load(cmd.ExecuteReader());

                // Assign Table to Doctor combo box
                cmb_prescDoctor.DataSource = dt;

                // Assign KeyValue pair to Doctor combo box
                cmb_prescDoctor.ValueMember = "Doctor_ID";
                cmb_prescDoctor.DisplayMember = "Name";

                // De-select all items in combo box
                cmb_prescDoctor.SelectedIndex = -1;
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

        private void PrescriptionUserControl_Load(object sender, EventArgs e)
        {
            // Call the method to load DataGrid view
            LoadPrescriptionDgvData();
        }

        private void dgv_findPrescription_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            try
            {
                // Prevent OutOfBounds exception.
                if (e.RowIndex == -1)
                {
                    return;
                }
                
                // Get the data from the DataGrid view and load it into the respective text boxes.
                // Identify the row on which the mouse is clicked.
                int rowIndex = e.RowIndex;

                txtbx_prescID.Text = dgv_findPrescription.Rows[rowIndex].Cells[0].Value.ToString();
                cmb_prescPatient.Text = dgv_findPrescription.Rows[rowIndex].Cells[1].Value.ToString();
                cmb_prescDrug.Text = dgv_findPrescription.Rows[rowIndex].Cells[2].Value.ToString();
                txtbx_prescPeriod.Text = dgv_findPrescription.Rows[rowIndex].Cells[4].Value.ToString();
                txtbx_dosage.Text = dgv_findPrescription.Rows[rowIndex].Cells[5].Value.ToString();
                cmb_prescDoctor.Text = dgv_findPrescription.Rows[rowIndex].Cells[6].Value.ToString();
                txtbx_prescDesc.Text = dgv_findPrescription.Rows[rowIndex].Cells[7].Value.ToString();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btn_findPrescription_Click(object sender, EventArgs e)
        {
            // Get the value from text box
            string keyword = txtbx_findPrescription.Text;

            SqlConnection conn = new SqlConnection(myconnstr);
            SqlDataAdapter sda = new SqlDataAdapter("SELECT Prescription.Prescription_ID, " +
                                                    "CONCAT(Patient.First_Name, ' ', Patient.Last_Name) AS Patient_Name, " +
                                                    "Drug.Name AS Drug_Name, Prescription.Date, Prescription.Period, " +
                                                    "Prescription.Dosage, CONCAT(Staff.First_Name, ' ', Staff.Last_Name) AS Doctor_Name, " +
                                                    "Prescription.Description FROM Prescription INNER JOIN " +
                                                    "Patient ON Prescription.Patient_ID = Patient.Patient_ID INNER JOIN " +
                                                    "Doctor ON Prescription.Doctor_ID = Doctor.Doctor_ID INNER JOIN " +
                                                    "Drug ON Prescription.Drug_ID = Drug.Drug_ID INNER JOIN " +
                                                    "Staff ON Doctor.Staff_ID = Staff.Staff_ID " +
                                                    "WHERE " +
                                                    "Patient.First_Name LIKE '%" + keyword + "%' OR " +
                                                    "Patient.Last_Name LIKE '%" + keyword + "%' OR " +
                                                    "Drug.Name LIKE '%" + keyword + "%' OR " +
                                                    "Staff.First_Name LIKE '%" + keyword + "%' OR " +
                                                    "Staff.Last_Name LIKE '%" + keyword + "%'", conn);

            DataTable dt = new DataTable();
            sda.Fill(dt);
            dgv_findPrescription.DataSource = dt;
            dgv_findPrescription.ClearSelection();
        }

        private void txtbx_findPrescription_KeyDown(object sender, KeyEventArgs e)
        {
            // Pressing the Enter key while the Search text box is highlighted
            // will perform a search (instead of clicking the Search button).
            if (e.KeyCode == Keys.Enter)
            {
                btn_findPrescription.PerformClick();
            }
        }
    }
}
