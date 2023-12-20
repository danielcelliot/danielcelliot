using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PremierCare.Classes
{
    class InvoiceClass
    {
        // Getter Setter Properties
        // Acts as Data Carrier in Our Application
        public int InvoiceId { get; set; }
        public int CsrId { get; set; }
        public int PatientId { get; set; }
        public string Date { get; set; }
        public string Description { get; set; }
        public double Total { get; set; }

        private string myconnstr = GlobalClass.connectionString;

        // Selecting Data from Database
        public DataTable Select()
        {
            // Step 1: Database Connection
            SqlConnection conn = new SqlConnection(myconnstr);
            DataTable dt = new DataTable();
            
            try
            {
                // Step 2: Write SQL query
                string sql = "SELECT Invoice.Invoice_ID, " +
                                "CONCAT(Patient.First_Name, ' ', Patient.Last_Name) AS Patient_Name, " +
                                "Invoice.Date, Invoice.Total, Invoice.Description, Invoice.CSR_ID " +
                             "FROM Patient " +
                                "INNER JOIN Invoice " +
                                "ON Patient.Patient_ID = Invoice.Patient_ID";

                // Create cmd using sql and conn
                SqlCommand cmd = new SqlCommand(sql, conn);

                // Create SQL DataAdapter using cmd
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);

                conn.Open();
                adapter.Fill(dt);

            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                conn.Close();
            }
            return dt;
        }

        // Insert data into Database
        public int Insert(InvoiceClass i)
        {
            // Step 1: Connect database
            SqlConnection conn = new SqlConnection(myconnstr);

            // Step 2: Create a SQL Query to insert data
            string sql = "INSERT INTO Invoice (CSR_ID, Patient_ID, Date, Description, Total) " +
                         "OUTPUT INSERTED.Invoice_ID " +
                         "VALUES (@CsrId, @PatientId, @Date, @Description, @Total)";

            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                // Create parameters to add data
                cmd.Parameters.AddWithValue("@CsrId", i.CsrId);
                cmd.Parameters.AddWithValue("@PatientId", i.PatientId);
                cmd.Parameters.AddWithValue("@Date", i.Date);
                cmd.Parameters.AddWithValue("@Description", i.Description);
                cmd.Parameters.AddWithValue("@Total", i.Total);

                conn.Open();

                int modified = (int)cmd.ExecuteScalar();

                if (conn.State == System.Data.ConnectionState.Open) 
                    conn.Close();

                return modified;
            }
        }

        // Method to delete data from database
        public bool Delete(InvoiceClass i)
        {
            // Create a default return type and set its default value to false
            bool isSuccess = false;

            // Create SQL connection
            SqlConnection conn = new SqlConnection(myconnstr);

            try
            {
                // SQL to delete data
                string sql = "DELETE FROM Invoice WHERE Invoice_ID=@InvoiceId";

                // Create SQL command
                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@InvoiceId", i.InvoiceId);

                // Open connection
                conn.Open();
                int rows = cmd.ExecuteNonQuery();

                // If the query runs successfully then the value of rows will be greater than zero else its value will be 0
                if (rows > 0)
                {
                    isSuccess = true;
                }
                else
                {
                    isSuccess = false;
                }
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
            return isSuccess;
        }
    }
}
