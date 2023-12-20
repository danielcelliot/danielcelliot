using System;
using System.Drawing;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;
using PremierCare.Classes;

namespace PremierCare.UI
{
    public partial class PatientUserControl : UserControl
    {
        PatientClass patient = new PatientClass();

        private string myconnstr = GlobalClass.connectionString;

        public PatientUserControl()
        {
            InitializeComponent();
            
            // Format columns in DataGrid view
            dgv_findPatient.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
            dgv_findPatient.AutoResizeColumns();
            dgv_findPatient.ColumnHeadersDefaultCellStyle.Font = new Font(DefaultFont, FontStyle.Bold);

            // De-select all items in DataGrid view
            dgv_findPatient.ClearSelection();
        }

        public void LoadPatientDgvData()
        {
            // Load data onto DataGrid view
            DataTable dt = patient.Select();
            dgv_findPatient.DataSource = dt;
        }
        
        private void patientContact_Click(object sender, EventArgs e)
        {
            // Call the clear method.
            txtbx_patientContact.Clear();
        }

        private void llbl_allergy_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            // Check if patient is selected.
            if (string.IsNullOrEmpty(txtbx_patientID.Text))
            {
                MessageBox.Show("Please select a patient.");
            }
            else
            {
                // Open the Allergies DialogBox.
                AllergiesWF allergiesWF = new AllergiesWF(txtbx_patientID.Text);
                allergiesWF.ShowDialog();
            }
        }

        private void btn_findPatient_Click(object sender, EventArgs e)
        {
            try
            {
                // Get the value from text box
                string keyword = txtbx_search.Text;

                SqlConnection conn = new SqlConnection(myconnstr);
                SqlDataAdapter sda = new SqlDataAdapter("SELECT * FROM Patient WHERE " +
                                                        "First_Name LIKE '%" + keyword + "%' OR " +
                                                        "Last_Name LIKE '%" + keyword + "%' OR " +
                                                        "Address LIKE '%" + keyword + "%'", conn);

                DataTable dt = new DataTable();
                sda.Fill(dt);
                dgv_findPatient.DataSource = dt;
                dgv_findPatient.ClearSelection();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btn_addPatient_Click(object sender, EventArgs e)
        {
            // Get the values from the input/selection fields
            patient.FirstName = txtbx_patientFName.Text;
            patient.LastName = txtbx_patientLName.Text;
            patient.ContactNo = txtbx_patientContact.Text;
            patient.Dob = dtp_patientDOB.Text;
            patient.Sex = cmb_patientSex.Text;
            patient.BloodType = cmb_patientBloodType.Text;
            patient.Address = txtbx_patientAddress.Text;

            // Insert data into database
            bool success = patient.Insert(patient);
            if(success)
            {
                // Successfully inserted
                MessageBox.Show("Patient added successfully.");

                // Call the clear method
                Clear();
            }
            else
            {
                // Failed to add patient
                MessageBox.Show("Failed to add new patient. Try again.");
            }

            // Call the method to load DataGrid view
            LoadPatientDgvData();
        }

        private void btn_updatePatient_Click(object sender, EventArgs e)
        {
            try
            {
                // Get the values from input/selection fields.
                patient.PatientId = int.Parse(txtbx_patientID.Text);
                patient.FirstName = txtbx_patientFName.Text;
                patient.LastName = txtbx_patientLName.Text;
                patient.ContactNo = txtbx_patientContact.Text;
                patient.Dob = dtp_patientDOB.Text;
                patient.Sex = cmb_patientSex.Text;
                patient.BloodType = cmb_patientBloodType.Text;
                patient.Address = txtbx_patientAddress.Text;

                // Update data in the database
                bool success = patient.Update(patient);
                if (success)
                {
                    // Successfully updated
                    MessageBox.Show("Patient updated successfully.");
                
                    // Call the method to load DataGrid view
                    LoadPatientDgvData();

                    // Call the clear method
                    Clear();
                }
                else
                {
                    // Failed to update contact
                    MessageBox.Show("Failed to update patient. Try again.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btn_deletePatient_Click(object sender, EventArgs e)
        {
            try
            {
                // Get the patient ID from the application
                patient.PatientId = Convert.ToInt32(txtbx_patientID.Text);
                bool success = patient.Delete(patient);
                if(success)
                {
                    // Successfully deleted
                    MessageBox.Show("Patient deleted successfully.");
                
                    // Call the method to refresh DataGrid view after deletion.
                    LoadPatientDgvData();

                    // Call the method to clear all input/selection fields.
                    Clear();
                }
                else
                {
                    // Delete failed
                    MessageBox.Show("Failed to delete patient. Try again.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btn_clearPatient_Click(object sender, EventArgs e)
        {
            // Call the Clear() method
            Clear();
        }

        public void Clear()
        {
            txtbx_patientAddress.Clear();
            txtbx_patientContact.Text = "xxx-xxxx";
            txtbx_patientFName.Clear();
            txtbx_patientID.Clear();
            txtbx_patientLName.Clear();
            cmb_patientBloodType.SelectedIndex = -1;
            cmb_patientSex.SelectedIndex = -1;
            txtbx_patientFName.Focus();
            dtp_patientDOB.Value = DateTime.Today;
            txtbx_search.Clear();
            dgv_findPatient.ClearSelection();
        }

        private void dgv_findPatient_CellClick(object sender, DataGridViewCellEventArgs e)
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

                txtbx_patientID.Text = dgv_findPatient.Rows[rowIndex].Cells[0].Value.ToString();
                txtbx_patientFName.Text = dgv_findPatient.Rows[rowIndex].Cells[1].Value.ToString();
                txtbx_patientLName.Text = dgv_findPatient.Rows[rowIndex].Cells[2].Value.ToString();
                txtbx_patientAddress.Text = dgv_findPatient.Rows[rowIndex].Cells[3].Value.ToString();
                txtbx_patientContact.Text = dgv_findPatient.Rows[rowIndex].Cells[4].Value.ToString();
                cmb_patientSex.Text = dgv_findPatient.Rows[rowIndex].Cells[5].Value.ToString();
                dtp_patientDOB.Text = dgv_findPatient.Rows[rowIndex].Cells[6].Value.ToString();
                cmb_patientBloodType.Text = dgv_findPatient.Rows[rowIndex].Cells[7].Value.ToString();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void txtbx_search_KeyDown(object sender, KeyEventArgs e)
        {
            // Pressing the Enter key while the Search text box is highlighted
            // will perform a search (instead of clicking the Search button).
            if (e.KeyCode == Keys.Enter){
                btn_findPatient.PerformClick();
            }
        }
    }
}
