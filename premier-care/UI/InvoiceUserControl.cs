using System;
using System.Drawing;
using System.Data;
using System.Data.SqlClient;
using System.Drawing.Printing;
using System.IO;
using System.Windows.Forms;
using PremierCare.Classes;

namespace PremierCare.UI
{
    public partial class InvoiceUserControl : UserControl
    {
        // Create new instance of InvoiceClass.
        InvoiceClass invoice = new InvoiceClass();

        // Assign Database connection string to variable.
        private string myconnstr = GlobalClass.connectionString;
        
        // Initialization variables for InvoiceUserControl.
        private bool populating = false;
        private double total = 0.00;
        private string description = "";

        public InvoiceUserControl()
        {
            InitializeComponent();

            // Format columns in DataGrid view.
            dgv_findInvoice.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
            dgv_findInvoice.AutoResizeColumns();
            dgv_findInvoice.ColumnHeadersDefaultCellStyle.Font = new Font(DefaultFont, FontStyle.Bold);

            // De-select all items in DataGrid view.
            dgv_findInvoice.ClearSelection();
        }

        public void LoadInvoiceDgvData()
        {
            // Load data onto DataGrid view.
            DataTable dt = invoice.Select();
            dgv_findInvoice.DataSource = dt;
        }

        private void btn_addInvoice_Click_1(object sender, EventArgs e)
        {
            try
            {
                // Get the values from the input fields.
                invoice.CsrId = int.Parse(txtbx_csrID.Text);
                invoice.PatientId = Convert.ToInt32(cmb_invoicePatient.SelectedValue.ToString());
                invoice.Date = dtp_invoiceDate.Text;
                invoice.Description = description;
                invoice.Total = total;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

            // Insert data into database and assign the return value to variable.
            int success = invoice.Insert(invoice);

            // If the operation is successful, the method will return the Invoice_ID of the recently inserted record.
            // The ID is always greater than zero.
            if (success > 0)
            {
                // Add records for all selected services to Invoice_Services table in Database.
                AddServicesToDb(success);
                // Add records for all selected prescriptions to Invoice_Prescriptions table in Database.
                AddPrescriptionsToDb(success);

                // Successfully inserted.
                MessageBox.Show("Invoice added successfully.");

                // Call the method to refresh DataGrid view after insert.
                LoadInvoiceDgvData();

                // Call the method to clear all input/selection fields.
                Clear();
            }
            else
            {
                // Failed to add invoice.
                MessageBox.Show("Failed to add new invoice. Try again.");
            }
        }

        private void btn_deleteInvoice_Click(object sender, EventArgs e)
        {
            try
            {
                // Get the invoice ID from the application.
                invoice.InvoiceId = Convert.ToInt32(txtbx_invoiceID.Text);

                // Delete records in Database for all services selected in the combo box.
                DeleteServicesFromDb();

                // Delete records in Database for all prescriptions selected in the combo box.
                DeletePrescriptionsFromDb();
            }
            catch (Exception exception)
            {
                MessageBox.Show(exception.Message);
            }

            // Delete record from database and assign the return value to variable.
            bool success = invoice.Delete(invoice);

            // If the operation is successful, the method will return TRUE.
            if(success)
            {
                // Successfully deleted.
                MessageBox.Show("Invoice succesfully deleted.");
                
                // Call the method to refresh DataGrid view after deletion.
                LoadInvoiceDgvData();

                // Call the method to clear all input/selection fields
                Clear();
            }
            else
            {
                // Delete failed.
                MessageBox.Show("Failed to delete invoice. Try again.");
            }
        }

        private void AddServicesToDb(int id)
        {
            // Create new Database connection.
            SqlConnection conn = new SqlConnection(myconnstr);
            
            // Iterate through items in ListBox.
            for (int i = 0; i < lbx_services.Items.Count; i++)
            {
                // Create new instance of DataRowView class.
                DataRowView objDataRowView = (DataRowView) lbx_services.Items[i];

                // Check if item at index 'i' is selected.
                if (lbx_services.GetSelected(i)) // Returns TRUE or FALSE.
                {
                    // Create a SQL Statement to insert record.
                    string sqlInsert = "INSERT INTO Invoice_Services (Invoice_ID, Service_ID) " +
                                       "VALUES ('" +
                                       id + "', '" +
                                       Convert.ToInt32(objDataRowView["Service_ID"].ToString()) + "')";

                    try
                    {
                        // Create SQL command.
                        SqlCommand command = new SqlCommand(sqlInsert, conn);

                        // Open connection.
                        conn.Open();

                        // Execute query.
                        command.ExecuteNonQuery();

                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(ex.Message);
                    }
                    finally
                    {
                        // Close connection.
                        conn.Close();
                    }
                }
            }
            
        }

        private void AddPrescriptionsToDb(int id)
        {
            // Create new Database connection
            SqlConnection conn = new SqlConnection(myconnstr);

            // Iterate through items in ListBox
            for (int i = 0; i < lbx_prescription.Items.Count; i++)
            {
                // Create new instance of DataRowView class.
                DataRowView objDataRowView = (DataRowView) lbx_prescription.Items[i];

                // Check if item at index 'i' is selected.
                if (lbx_prescription.GetSelected(i)) // Returns TRUE or FALSE.
                {
                    try
                    {
                        // Create a SQL Statement to insert record.
                        string sqlInsert = "INSERT INTO Invoice_Prescriptions (Invoice_ID, Prescription_ID) " +
                                           "VALUES ('" +
                                           id + "', '" +
                                           Convert.ToInt32(objDataRowView["Prescription_ID"].ToString()) + "')";

                        // Create SQL command.
                        SqlCommand command = new SqlCommand(sqlInsert, conn);

                        // Open connection.
                        conn.Open();

                        // Execute query.
                        command.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(ex.Message);
                    }
                    finally
                    {
                        // Close connection.
                        conn.Close();
                    }
                }
            }
        }

        private void DeleteServicesFromDb()
        {
            // Create new Database connection.
            SqlConnection conn = new SqlConnection(myconnstr);
            
            // Iterate through items in ListBox.
            for (int i = 0; i < lbx_services.Items.Count; i++)
            {
                // Create new instance of DataRowView class.
                DataRowView objDataRowView = (DataRowView) lbx_services.Items[i];

                // Check if item at index 'i' is selected.
                if (lbx_services.GetSelected(i)) // Returns TRUE or FALSE.
                {
                    try
                    {
                        // Create a SQL Statement to delete record.
                        string sqlDelete = "DELETE FROM Invoice_Services " +
                                           "WHERE Invoice_ID='" + Convert.ToInt32(txtbx_invoiceID.Text) + "' " +
                                           "AND Service_ID='" + Convert.ToInt32(objDataRowView["Service_ID"].ToString()) + "'";

                        // Create SQL command.
                        SqlCommand command = new SqlCommand(sqlDelete, conn);

                        // Open connection.
                        conn.Open();

                        // Execute query.
                        command.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(ex.Message);
                    }
                    finally
                    {
                        // Close connection.
                        conn.Close();
                    }
                }
            }
        }

        private void DeletePrescriptionsFromDb()
        {
            // Create new Database connection.
            SqlConnection conn = new SqlConnection(myconnstr);
            
            // Iterate through items in ListBox.
            for (int i = 0; i < lbx_prescription.Items.Count; i++)
            {
                // Create new instance of DataRowView class.
                DataRowView objDataRowView = (DataRowView) lbx_prescription.Items[i];

                // Check if item at index 'i' is selected.
                if (lbx_prescription.GetSelected(i)) // Returns TRUE or FALSE.
                {
                    try
                    {
                        // Create a SQL Statement to delete record
                        string sqlDelete = "DELETE FROM Invoice_Prescriptions " +
                                           "WHERE Invoice_ID='" + Convert.ToInt32(txtbx_invoiceID.Text) + "' " +
                                           "AND Prescription_ID='" + Convert.ToInt32(objDataRowView["Prescription_ID"].ToString()) + "'";

                        // Create SQL command
                        SqlCommand command = new SqlCommand(sqlDelete, conn);

                        // Open connection
                        conn.Open();

                        // Execute query
                        command.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(ex.Message);
                    }
                    finally
                    {
                        // Close connection
                        conn.Close();
                    }
                }
            }
        }

        private void btn_clearInvoice_Click(object sender, EventArgs e)
        {
            // Call the method to clear all input/selection fields.
            Clear();
        }

        public void Clear()
        {
            txtbx_findInvoice.Clear();
            txtbx_invoiceID.Clear();
            //txtbx_csrID.Clear();
            txtbx_csrID.Text = "2";
            cmb_invoicePatient.SelectedIndex = -1;
            dtp_invoiceDate.Value = DateTime.Today;
            lbl_ValueInDollars.Text = "$0.00";
            dgv_findInvoice.ClearSelection();

            populating = true;
            lbx_prescription.DataSource = null;
            lbx_services.DataSource = null;
            populating = false;

            txtbx_csrID.Focus();
        }

        public void FillPrescriptionsListBox()
        {
            // Database Connection.
            SqlConnection conn = new SqlConnection(myconnstr);
            DataTable dt = new DataTable();

            try
            {
                string sql = "SELECT Prescription.Prescription_ID, Drug.Name " +
                             "FROM Patient INNER JOIN " +
                                "Prescription ON Patient.Patient_ID = Prescription.Patient_ID INNER JOIN " +
                                "Drug ON Prescription.Drug_ID = Drug.Drug_ID " +
                             "WHERE Patient.Patient_ID= '" + Convert.ToInt32(cmb_invoicePatient.SelectedValue.ToString()) + "'";

                // Create cmd using sql and conn.
                SqlCommand cmd = new SqlCommand(sql, conn);

                conn.Open();

                // Execute query
                dt.Load(cmd.ExecuteReader());

                // Set populating value to true.
                populating = true;
                
                // Assign Table to ListBox.
                lbx_prescription.DataSource = dt;

                // Assign KeyValue pair to ListBox.
                lbx_prescription.ValueMember = "Prescription_ID";
                lbx_prescription.DisplayMember = "Name";

                // De-select all items in ListBox.
                lbx_prescription.SelectedIndex = -1;

                populating = false;
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                // Close connection.
                conn.Close();
            }
        }

        public void FillServicesListBox()
        {
            // Database Connection.
            SqlConnection conn = new SqlConnection(myconnstr);
            DataTable dt = new DataTable();

            try
            {
                string sql = "SELECT Service_ID, Name FROM Service";

                // Create cmd using sql and conn
                SqlCommand cmd = new SqlCommand(sql, conn);

                conn.Open();

                // Execute query.
                dt.Load(cmd.ExecuteReader());

                // Set populating value to true.
                populating = true;
                
                // Assign DataTable to ListBox.
                lbx_services.DataSource = dt;

                // Assign KeyValue pair to ListBox
                lbx_services.ValueMember = "Service_ID";
                lbx_services.DisplayMember = "Name";

                // De-select all items in ListBox
                lbx_services.SelectedIndex = -1;

                populating = false;
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                // Close connection
                conn.Close();
            }
        }
 
        public void FillPatientComboBox()
        {
            // Step 1: Create new Database Connection.
            SqlConnection conn = new SqlConnection(myconnstr);
            DataTable dt = new DataTable();
            
            try
            {
                // Step 2: Write SQL select query.
                string sql = "SELECT Patient_ID, " +
                             "CONCAT(First_Name, ' ', Last_Name) AS Name " +
                             "FROM Patient " +
                             "ORDER BY Last_Name";

                // Create cmd using sql and conn.
                SqlCommand cmd = new SqlCommand(sql, conn);

                conn.Open();

                //Execute query and load into DataTable.
                dt.Load(cmd.ExecuteReader());

                // Assign DataTable to Patient combo box.
                cmb_invoicePatient.DataSource = dt;

                // Assign KeyValue pair to Patient combo box.
                cmb_invoicePatient.ValueMember = "Patient_ID";
                cmb_invoicePatient.DisplayMember = "Name";

                // De-select all items in combo box.
                cmb_invoicePatient.SelectedIndex = -1;
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                // Close connection.
                conn.Close();
            }
        }

        public void SelectItemsInServicesListBox()
        {
            // Database Connection.
            SqlConnection conn = new SqlConnection(myconnstr);

            // Iterate through items in ListBox.
            for (int i = 0; i < lbx_services.Items.Count; i++)
            {
                // Create new instance of DataRowView class.
                DataRowView objDataRowView = (DataRowView) lbx_services.Items[i];

                // Create SQL Statement to select record from Database
                string sql = "SELECT * FROM Invoice_Services " +
                             "WHERE Invoice_ID='" + Convert.ToInt32(txtbx_invoiceID.Text) + "' AND " +
                             "Service_ID='" + Convert.ToInt32(objDataRowView["Service_ID"].ToString()) + "'";

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
                    lbx_services.SelectedIndex = i;
                }

                // Close connection
                conn.Close();
            }
        }

        public void SelectItemsInPrescriptionsListBox()
        {
            // Database Connection.
            SqlConnection conn = new SqlConnection(myconnstr);

            // Iterate through items in ListBox.
            for (int i = 0; i < lbx_prescription.Items.Count; i++)
            {
                // Create new instance of DataRowView class.
                DataRowView objDataRowView = (DataRowView) lbx_prescription.Items[i];

                // Create SQL Statement to select record from Database.
                string sql = "SELECT * FROM Invoice_Prescriptions " +
                             "WHERE Invoice_ID='" + Convert.ToInt32(txtbx_invoiceID.Text) + "' AND " +
                             "Prescription_ID='" + Convert.ToInt32(objDataRowView["Prescription_ID"].ToString()) + "'";

                // Create cmd using sql and conn.
                SqlCommand cmd = new SqlCommand(sql, conn);

                // Open connection.
                conn.Open();

                // Execute query and assign its return value to variable.
                var recordExists = cmd.ExecuteScalar();

                // Check if record exists in Database.
                if (recordExists != DBNull.Value && recordExists != null)
                {
                    // Select item at index 'i' in ListBox.
                    lbx_prescription.SelectedIndex = i;
                }

                // Close connection.
                conn.Close();
            }
        }

        private void cmb_invoicePatient_DropDownClosed(object sender, EventArgs e)
        {
            // Check if a patient is selected in combo box.
            if (!(string.IsNullOrWhiteSpace(cmb_invoicePatient.Text)))
            {
                // Fill List boxes with items
                FillServicesListBox();
                FillPrescriptionsListBox();
            }
        }

        private void dgv_findInvoice_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            // De-select all items in ListBoxes.
            lbx_services.SelectedIndex = -1;
            lbx_prescription.SelectedIndex = -1;

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

                txtbx_invoiceID.Text = dgv_findInvoice.Rows[rowIndex].Cells[0].Value.ToString();
                cmb_invoicePatient.Text = dgv_findInvoice.Rows[rowIndex].Cells[1].Value.ToString();
                dtp_invoiceDate.Text = dgv_findInvoice.Rows[rowIndex].Cells[2].Value.ToString();
                lbl_ValueInDollars.Text = string.Format("{0:C}", dgv_findInvoice.Rows[rowIndex].Cells[3].Value);
                txtbx_csrID.Text = dgv_findInvoice.Rows[rowIndex].Cells[5].Value.ToString();

                // Fill List boxes with items.
                FillServicesListBox();
                FillPrescriptionsListBox();

                // Select items in List boxes.
                SelectItemsInServicesListBox();
                SelectItemsInPrescriptionsListBox();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void lbx_services_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!populating)
            {
                // Step 1: Database Connection
                SqlConnection conn = new SqlConnection(myconnstr);

                // Initialize variables.
                total = 0;
                description = "";

                try
                {
                    // Iterate through items in Services ListBox.
                    for (int i = 0; i < lbx_services.Items.Count; i++)
                    {
                        DataRowView objDataRowView = (DataRowView) lbx_services.Items[i];

                        // Check if item at index 'i' is selected.
                        if (lbx_services.GetSelected(i)) // Returns TRUE or FALSE.
                        {
                            DataTable dt = new DataTable();

                            // Step 2: Write SQL query
                            string sql = "SELECT Cost, Name FROM Service WHERE Service_ID ='" + Convert.ToInt32(objDataRowView["Service_ID"].ToString()) + "'";

                            // Create cmd using sql and conn
                            SqlCommand cmd = new SqlCommand(sql, conn);

                            // Create SQL DataAdapter using cmd
                            SqlDataAdapter adapter = new SqlDataAdapter(cmd);

                            conn.Open();

                            // Fill DataTable.
                            adapter.Fill(dt);

                            // Assign values from DataTable to variables.
                            decimal cost = dt.Rows[0].Field<decimal>("Cost");
                            total += (double) cost;
                            description += dt.Rows[0].Field<string>("Name") + ": " + string.Format("{0:C}", cost) + " ";

                            // Close connection.
                            conn.Close();
                        }
                    }

                    // Iterate through items in Prescriptions ListBox.
                    for (int i = 0; i < lbx_prescription.Items.Count; i++)
                    {
                        DataRowView objDataRowView = (DataRowView) lbx_prescription.Items[i];

                        // Check if item at index 'i' is selected.
                        if (lbx_prescription.GetSelected(i)) // Returns TRUE or FALSE.
                        {
                            DataTable dt = new DataTable();

                            // Step 2: Write SQL query.
                            string sql = "SELECT Drug.Name, Drug.Cost " +
                                         "FROM Prescription " +
                                            "INNER JOIN Drug ON Prescription.Drug_ID = Drug.Drug_ID " +
                                         "WHERE Prescription.Prescription_ID = '" + Convert.ToInt32(objDataRowView["Prescription_ID"].ToString()) + "'";

                            // Create cmd using sql and conn.
                            SqlCommand cmd = new SqlCommand(sql, conn);

                            // Create SQL DataAdapter using cmd.
                            SqlDataAdapter adapter = new SqlDataAdapter(cmd);

                            conn.Open();
                            // Fill DataTable.
                            adapter.Fill(dt);

                            // Assign values from DataTable to variables.
                            decimal cost = dt.Rows[0].Field<decimal>("Cost");
                            total += (double) cost;
                            description += dt.Rows[0].Field<string>("Name") + ": " + string.Format("{0:C}", cost) + " ";

                            // Close connection.
                            conn.Close();
                        }
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
                
                // Assign total value to Label on Form.
                lbl_ValueInDollars.Text = string.Format("{0:C}", total);

                // DEBUG
                //MessageBox.Show(description);
            }
        }

        private void lbx_prescription_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!populating)
            {
                // Step 1: Database Connection
                SqlConnection conn = new SqlConnection(myconnstr);

                // Initialize variables.
                total = 0;
                description = "";

                try
                {
                    // Iterate through items in Services ListBox
                    for (int i = 0; i < lbx_services.Items.Count; i++)
                    {
                        DataRowView objDataRowView = (DataRowView) lbx_services.Items[i];

                        // Check if item at index 'i' is selected.
                        if (lbx_services.GetSelected(i)) // Returns TRUE or FALSE.
                        {
                            DataTable dt = new DataTable();

                            // Step 2: Write SQL query
                            string sql = "SELECT Cost, Name FROM Service WHERE Service_ID ='" + Convert.ToInt32(objDataRowView["Service_ID"].ToString()) + "'";

                            // Create cmd using sql and conn
                            SqlCommand cmd = new SqlCommand(sql, conn);

                            // Create SQL DataAdapter using cmd
                            SqlDataAdapter adapter = new SqlDataAdapter(cmd);

                            conn.Open();

                            // Fill DataTable.
                            adapter.Fill(dt);

                            // Assign values from DataTable to variables.
                            decimal cost = dt.Rows[0].Field<decimal>("Cost");
                            total += (double) cost;
                            description += dt.Rows[0].Field<string>("Name") + ": " + string.Format("{0:C}", cost) + " ";

                            // Close connection.
                            conn.Close();
                        }
                    }

                    // Iterate through items in Prescriptions ListBox
                    for (int i = 0; i < lbx_prescription.Items.Count; i++)
                    {
                        DataRowView objDataRowView = (DataRowView) lbx_prescription.Items[i];

                        // Check if item at index 'i' is selected.
                        if (lbx_prescription.GetSelected(i)) // Returns TRUE or FALSE.
                        {
                            DataTable dt = new DataTable();

                            // Step 2: Write SQL query
                            string sql = "SELECT Drug.Name, Drug.Cost " +
                                         "FROM Prescription " +
                                            "INNER JOIN Drug ON Prescription.Drug_ID = Drug.Drug_ID " +
                                         "WHERE Prescription.Prescription_ID = '" + Convert.ToInt32(objDataRowView["Prescription_ID"].ToString()) + "'";

                            // Create cmd using sql and conn
                            SqlCommand cmd = new SqlCommand(sql, conn);

                            // Create SQL DataAdapter using cmd
                            SqlDataAdapter adapter = new SqlDataAdapter(cmd);

                            conn.Open();
                            adapter.Fill(dt);

                            decimal cost = dt.Rows[0].Field<decimal>("Cost");
                            total += (double) cost;
                            description += dt.Rows[0].Field<string>("Name") + ": " + string.Format("{0:C}", cost) + " ";

                            conn.Close();
                        }
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
                
                // Assign total value to label
                lbl_ValueInDollars.Text = string.Format("{0:C}", total);

                // DEBUG
                //MessageBox.Show(description);
            }
        }

        private void btn_findInvoice_Click(object sender, EventArgs e)
        {
            try
            {
                // Get the value from text box
                string keyword = txtbx_findInvoice.Text;

                SqlConnection conn = new SqlConnection(myconnstr);
                SqlDataAdapter sda = new SqlDataAdapter("SELECT Invoice.Invoice_ID, " +
                                                            "CONCAT(Patient.First_Name, ' ', Patient.Last_Name) AS Patient_Name, " +
                                                            "Invoice.Date, Invoice.Total, Invoice.Description, Invoice.CSR_ID " +
                                                        "FROM Patient " +
                                                            "INNER JOIN Invoice " +
                                                            "ON Patient.Patient_ID = Invoice.Patient_ID " +
                                                        "WHERE " +
                                                            "Patient.First_Name LIKE '%" + keyword + "%' OR " +
                                                            "Patient.Last_Name LIKE '%" + keyword + "%'", conn);

                DataTable dt = new DataTable();
                sda.Fill(dt);
                dgv_findInvoice.DataSource = dt;
                dgv_findInvoice.ClearSelection();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void txtbx_findInvoice_KeyDown(object sender, KeyEventArgs e)
        {
            // Pressing the Enter key while the Search text box is highlighted
            // will perform a search (instead of clicking the Search button).
            if (e.KeyCode == Keys.Enter){
                btn_findInvoice.PerformClick();
            }
        }

        private void btn_saveToFile_Click(object sender, EventArgs e)
        {
            // Check if patient is selected.
            if (string.IsNullOrEmpty(txtbx_invoiceID.Text))
            {
                MessageBox.Show("Please select a patient.");
            }
            else
            {
                try
                {
                    // Assign save path to variable
                    string path = Environment.GetFolderPath(Environment.SpecialFolder.Desktop);

                    // Pass the filepath and filename to the StreamWriter Constructor.
                    StreamWriter sw = new StreamWriter(path + "\\invoice.txt");
                    
                    // Write to text file.
                    sw.WriteLine("PremierCare Hospital");
                    sw.WriteLine("Patient Name: " + cmb_invoicePatient.Text);
                    sw.WriteLine("Description: " + description);
                    sw.WriteLine("Total: " + string.Format("{0:C}", total));

                    //Close the file.
                    sw.Close();
                    
                    MessageBox.Show("Invoice saved successfully.\nCheck your desktop for an 'invoice.txt' file.");
                }
                catch(Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
        }

        private void PrintInvoice()
        {
            PrintDialog printDialog = new PrintDialog();
            PrintDocument printDocument = new PrintDocument();

            printDialog.Document = printDocument;

            printDocument.PrintPage += PrintDocument_PrintPage;

            DialogResult result = printDialog.ShowDialog();

            if (result == DialogResult.OK)
            {
                  printDocument.Print();
            }
        }

        private void PrintDocument_PrintPage(object sender, PrintPageEventArgs e)
        {
            Graphics graphic = e.Graphics;

            Font font = new Font("Courier New", 12);

            float fontHeight = font.GetHeight();

            int startX = 10;
            int startY = 10;
            int offset = 40;

            total = 0;

            // Draw text to document.
            graphic.DrawString("PremierCare Hospital", new Font("Courier New", 18, FontStyle.Bold), new SolidBrush(Color.DarkRed), startX, startY);
            graphic.DrawString("Patient Name: " + cmb_invoicePatient.Text, new Font("Courier New", 11), new SolidBrush(Color.DarkBlue), startX, startY + offset);
            
            // Increase vertical spacing.
            offset = offset + (int) fontHeight + 10;

            // Step 1: Database Connection
            SqlConnection conn = new SqlConnection(myconnstr);

            try
            {
                // Iterate through items in Services ListBox
                for (int i = 0; i < lbx_services.Items.Count; i++)
                {
                    DataRowView objDataRowView = (DataRowView) lbx_services.Items[i];

                    // Check if item at index 'i' is selected.
                    if (lbx_services.GetSelected(i)) // Returns TRUE or FALSE.
                    {
                        DataTable dt = new DataTable();

                        // Step 2: Write SQL query
                        string sql = "SELECT Cost, Name FROM Service WHERE Service_ID ='" + Convert.ToInt32(objDataRowView["Service_ID"].ToString()) + "'";

                        // Create cmd using sql and conn
                        SqlCommand cmd = new SqlCommand(sql, conn);

                        // Create SQL DataAdapter using cmd
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);

                        conn.Open();
                        adapter.Fill(dt);

                        string serviceName = dt.Rows[0].Field<string>("Name").PadRight(30);
                        decimal cost = dt.Rows[0].Field<decimal>("Cost");
                        string serviceCost = string.Format("{0:C}", cost);
                        string serviceLine = serviceName + serviceCost;

                        // Draw text to Document.
                        graphic.DrawString(serviceLine, font, new SolidBrush(Color.Black), startX, startY + offset);

                        // Increase vertical spacing.
                        offset = offset + (int) fontHeight + 5;

                        total += (double) cost;

                        conn.Close();
                    }
                }

                // Iterate through items in Prescriptions ListBox
                for (int i = 0; i < lbx_prescription.Items.Count; i++)
                {
                    DataRowView objDataRowView = (DataRowView) lbx_prescription.Items[i];

                    // Check if item at index 'i' is selected.
                    if (lbx_prescription.GetSelected(i)) // Returns TRUE or FALSE.
                    {
                        DataTable dt = new DataTable();

                        // Step 2: Write SQL query
                        string sql = "SELECT Drug.Name, Drug.Cost " +
                                     "FROM Prescription " +
                                        "INNER JOIN Drug ON Prescription.Drug_ID = Drug.Drug_ID " +
                                     "WHERE Prescription.Prescription_ID = '" + Convert.ToInt32(objDataRowView["Prescription_ID"].ToString()) + "'";

                        // Create cmd using sql and conn
                        SqlCommand cmd = new SqlCommand(sql, conn);

                        // Create SQL DataAdapter using cmd
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);

                        conn.Open();
                        adapter.Fill(dt);
                        
                        string prescriptionName = dt.Rows[0].Field<string>("Name").PadRight(30);
                        decimal cost = dt.Rows[0].Field<decimal>("Cost");
                        string prescriptionCost = string.Format("{0:C}", cost);
                        string prescriptionLine = prescriptionName + prescriptionCost;
                        
                        // Draw text to Document.
                        graphic.DrawString(prescriptionLine, font, new SolidBrush(Color.Black), startX, startY + offset);

                        // Increase vertical spacing.
                        offset = offset + (int) fontHeight + 5;

                        total += (double) cost;

                        conn.Close();
                    }
                }

                // Increase vertical spacing.
                offset = offset + 20;

                // Draw text to Document.
                graphic.DrawString("Total".PadRight(30) + string.Format("{0:C}", total), new Font("Courier New", 12, FontStyle.Bold), new SolidBrush(Color.Black), startX, startY + offset);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btn_printInvoice_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtbx_invoiceID.Text))
            {
                MessageBox.Show("Please select a patient.");
            }
            else
            {
                // Call the method to print invoice.
                PrintInvoice();
            }
        }
    }
}
