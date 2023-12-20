using System;
using System.Collections.Generic;
using System.Drawing;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;
using PremierCare.Classes;

namespace PremierCare.UI
{
    public partial class AppointmentUserControl : UserControl
    {
        AppointmentClass appointment = new AppointmentClass();
        private string myconnstr = GlobalClass.connectionString;

        public AppointmentUserControl()
        {
            InitializeComponent();

            // Format columns in DataGrid view
            dgv_findAppointment.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
            dgv_findAppointment.AutoResizeColumns();
            dgv_findAppointment.ColumnHeadersDefaultCellStyle.Font = new Font(DefaultFont, FontStyle.Bold);

            // De-select all items in DataGrid view
            dgv_findAppointment.ClearSelection();
        }

        public void LoadAppointmentDgvData()
        {
            // Load data onto DataGrid view
            DataTable dt = appointment.Select();
            dgv_findAppointment.DataSource = dt;
        }

        private void btn_updateAppointment_Click(object sender, EventArgs e)
        {
            // Get the data from text boxes
            appointment.AppointmentId = int.Parse(txtbx_aptID.Text);
            appointment.PatientId = Convert.ToInt32(cmb_aptPatient.SelectedValue.ToString());
            appointment.Date = dtp_aptDate.Text;
            appointment.Time = dtp_aptTime.Text;
            appointment.ServiceId = Convert.ToInt32(cmb_aptService.SelectedValue.ToString());
            appointment.DoctorId = Convert.ToInt32(cmb_aptDoctor.SelectedValue.ToString());
            appointment.CsrId = int.Parse(txtbx_csrID.Text);

            // Update data in the database
            bool success = appointment.Update(appointment);
            if (success)
            {
                // Successfully updated
                MessageBox.Show("Appointment updated successfully.");
                
                // Call the method to refresh DataGrid view after update.
                LoadAppointmentDgvData();

                // Call the clear method
                Clear();
            }
            else
            {
                // Failed to update contact
                MessageBox.Show("Failed to update appointment. Try again.");
            }
        }

        private void btn_addAppointment_Click(object sender, EventArgs e)
        {
            // Get the value from the input fields
            appointment.PatientId = Convert.ToInt32(cmb_aptPatient.SelectedValue.ToString());
            appointment.Date = dtp_aptDate.Text;
            appointment.Time = dtp_aptTime.Text;
            appointment.ServiceId = Convert.ToInt32(cmb_aptService.SelectedValue.ToString());
            appointment.DoctorId = Convert.ToInt32(cmb_aptDoctor.SelectedValue.ToString());
            appointment.CsrId = int.Parse(txtbx_csrID.Text);

            // Insert data into database
            bool success = appointment.Insert(appointment);
            if (success)
            {
                // Successfully inserted
                MessageBox.Show("Appointment added successfully.");

                // Call the clear method
                Clear();
            }
            else
            {
                // Failed to add patient
                MessageBox.Show("Failed to add new appointment. Try again.");
            }
            
            // Call the method to refresh DataGrid view after insert.
            LoadAppointmentDgvData();
        }

        private void btn_deleteAppointment_Click(object sender, EventArgs e)
        {
            // Get the appointment ID from the application
            appointment.AppointmentId = Convert.ToInt32(txtbx_aptID.Text);

            // Delete data from database
            bool success = appointment.Delete(appointment);
            if(success)
            {
                // Successfully deleted
                MessageBox.Show("Appointment deleted successfully.");
                
                // Call the method to refresh DataGrid view after deletion.
                LoadAppointmentDgvData();

                // Call the clear method
                Clear();
            }
            else
            {
                // Delete failed
                MessageBox.Show("Failed to delete appointment. Try again.");
            }
        }

        private void btn_clearAppointment_Click(object sender, EventArgs e)
        {
            // Call the clear method.
            Clear();
        }

        public void Clear()
        {
            txtbx_aptID.Clear();
            cmb_aptPatient.SelectedIndex = -1;
            dtp_aptDate.Value = DateTime.Today;
            dtp_aptTime.Value = DateTime.Now;
            cmb_aptService.SelectedIndex = -1;
            cmb_aptDoctor.SelectedIndex = -1;
            //txtbx_csrID.Clear();
            txtbx_csrID.Text = "2";
            txtbx_findAppointment.Clear();
            dgv_findAppointment.ClearSelection();
        }

        public void FillServiceComboBox()
        {
            // Create a List of KeyValue pairs to populate the Service combobox
            var serviceList = new List<KeyValuePair<string, int>>();

            // Add the services
            serviceList.Add(new KeyValuePair<string, int>("Pediatrics", 1));
            serviceList.Add(new KeyValuePair<string, int>("General Practice", 2));
            serviceList.Add(new KeyValuePair<string, int>("Specialist", 3));
            serviceList.Add(new KeyValuePair<string, int>("Laboratory", 4));
            serviceList.Add(new KeyValuePair<string, int>("Therapy", 5));
            serviceList.Add(new KeyValuePair<string, int>("X-Ray", 6));
            
            // Assign List to Service combo box
            cmb_aptService.DataSource = serviceList;

            // Assign KeyValue pair to Service combo box
            cmb_aptService.DisplayMember = "Key";
            cmb_aptService.ValueMember = "Value";

            // De-select all items in combo box
            cmb_aptService.SelectedIndex = -1;
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
                cmb_aptDoctor.DataSource = dt;

                // Assign KeyValue pair to Doctor combo box
                cmb_aptDoctor.ValueMember = "Doctor_ID";
                cmb_aptDoctor.DisplayMember = "Name";

                // Blank combo box on initialization
                cmb_aptDoctor.SelectedIndex = -1;
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

                // Assign Table to Doctor combo box
                cmb_aptPatient.DataSource = dt;

                // Assign KeyValue pair to Doctor combo box
                cmb_aptPatient.ValueMember = "Patient_ID";
                cmb_aptPatient.DisplayMember = "Name";

                // Blank combo box on initialization
                cmb_aptPatient.SelectedIndex = -1;
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

        private void dgv_findAppointment_CellClick(object sender, DataGridViewCellEventArgs e)
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

                txtbx_aptID.Text = dgv_findAppointment.Rows[rowIndex].Cells[0].Value.ToString();
                cmb_aptPatient.Text = dgv_findAppointment.Rows[rowIndex].Cells[1].Value.ToString();
                cmb_aptDoctor.Text = dgv_findAppointment.Rows[rowIndex].Cells[2].Value.ToString();
                cmb_aptService.Text = dgv_findAppointment.Rows[rowIndex].Cells[3].Value.ToString();
                dtp_aptDate.Text = dgv_findAppointment.Rows[rowIndex].Cells[4].Value.ToString();
                dtp_aptTime.Text = dgv_findAppointment.Rows[rowIndex].Cells[5].Value.ToString();
                txtbx_csrID.Text = dgv_findAppointment.Rows[rowIndex].Cells[6].Value.ToString();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btn_findAppointment_Click(object sender, EventArgs e)
        {
            // Get the value from text box
            string keyword = txtbx_findAppointment.Text;

            SqlConnection conn = new SqlConnection(myconnstr);
            SqlDataAdapter sda = new SqlDataAdapter("SELECT Appointment.Appointment_ID, " +
                                                        "CONCAT(Patient.First_Name, ' ', Patient.Last_Name) AS Patient_Name, " +
                                                        "CONCAT(Staff.First_Name, ' ', Staff.Last_Name) AS Doctor_Name, " +
                                                        "Service.Name AS Service_Name, Appointment.Date, Appointment.Time, Appointment.CSR_ID " +
                                                    "FROM Appointment INNER JOIN " +
                                                        "Patient ON Appointment.Patient_ID = Patient.Patient_ID INNER JOIN " +
                                                        "Doctor ON Appointment.Doctor_ID = Doctor.Doctor_ID INNER JOIN " +
                                                        "Staff ON Doctor.Staff_ID = Staff.Staff_ID INNER JOIN " +
                                                        "Service ON Appointment.Service_ID = Service.Service_ID " +
                                                    "WHERE " +
                                                        "Patient.First_Name LIKE '%" + keyword + "%' OR " +
                                                        "Patient.Last_Name LIKE '%" + keyword + "%' OR " +
                                                        "Service.Name LIKE '%" + keyword + "%' OR " +
                                                        "Staff.First_Name LIKE '%" + keyword + "%' OR " +
                                                        "Staff.Last_Name LIKE '%" + keyword + "%'", conn);

            DataTable dt = new DataTable();
            sda.Fill(dt);
            dgv_findAppointment.DataSource = dt;
            dgv_findAppointment.ClearSelection();
        }

        private void txtbx_findAppointment_KeyDown(object sender, KeyEventArgs e)
        {
            // Pressing the Enter key while the Search text box is highlighted
            // will perform a search (instead of clicking the Search button).
            if (e.KeyCode == Keys.Enter)
            {
                btn_findAppointment.PerformClick();
            }
        }
    }
}
