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
    class PrescriptionClass
    {
        // Getter Setter Properties
        // Acts as Data Carrier in Our Application
        public int PrescriptionId { get; set; }
        public int PatientId { get; set; }
        public int DoctorId { get; set; }
        public int DrugId { get; set; }
        public string Date { get; set; }
        public string Period { get; set; }
        public string Dosage { get; set; }
        public string Description { get; set; }

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
                string sql = "SELECT Prescription.Prescription_ID, " +
                                "CONCAT(Patient.First_Name, ' ', Patient.Last_Name) AS Patient_Name, " +
                                "Drug.Name AS Drug_Name, Prescription.Date, Prescription.Period, " +
                                "Prescription.Dosage, CONCAT(Staff.First_Name, ' ', Staff.Last_Name) AS Doctor_Name, " +
                             "Prescription.Description FROM Prescription INNER JOIN " +
                                "Patient ON Prescription.Patient_ID = Patient.Patient_ID INNER JOIN " +
                                "Doctor ON Prescription.Doctor_ID = Doctor.Doctor_ID INNER JOIN " +
                                "Drug ON Prescription.Drug_ID = Drug.Drug_ID INNER JOIN " +
                                "Staff ON Doctor.Staff_ID = Staff.Staff_ID";

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
        public bool Insert(PrescriptionClass p)
        {
            // Create a default return type and set its value to false
            bool isSuccess = false;

            // Step 1: Connect database
            SqlConnection conn = new SqlConnection(myconnstr);

            try
            {
                // Step 2: Create a SQL Query to insert data
                string sql = "INSERT INTO Prescription (Patient_ID, Doctor_ID, Drug_ID, Date, Period, Dosage, Description) " +
                            "VALUES (@PatientId, @DoctorId, @DrugId, @Date, @Period, @Dosage, @Description)";

                // Create SQL command using sql and conn
                SqlCommand cmd = new SqlCommand(sql, conn);

                // Create parameters to add data
                cmd.Parameters.AddWithValue("@PatientId", p.PatientId);
                cmd.Parameters.AddWithValue("@DoctorId", p.DoctorId);
                cmd.Parameters.AddWithValue("@DrugId", p.DrugId);
                cmd.Parameters.AddWithValue("@Date", p.Date);
                cmd.Parameters.AddWithValue("@Period", p.Period);
                cmd.Parameters.AddWithValue("@Dosage", p.Dosage);
                cmd.Parameters.AddWithValue("@Description", p.Description);
                
                // Open connection here
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
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                conn.Close();
            }
            return isSuccess;
        }

        // Method to update data in database from our application
        public bool Update(PrescriptionClass p)
        {
            // Create a default return type and set its default value to false
            bool isSuccess = false;
            SqlConnection conn = new SqlConnection(myconnstr);

            try
            {
                // SQL to update data in our database
                string sql = "UPDATE Prescription SET Patient_ID=@PatientId, Doctor_ID=@DoctorId, Drug_ID=@DrugId, Date=@Date, Period=@Period, Dosage=@Dosage, Description=@Description " +
                            "WHERE Prescription_ID=@PrescriptionId";

                // Create SQL command
                SqlCommand cmd = new SqlCommand(sql, conn);

                // Create parameters to add value
                cmd.Parameters.AddWithValue("@PatientId", p.PatientId);
                cmd.Parameters.AddWithValue("@DoctorId", p.DoctorId);
                cmd.Parameters.AddWithValue("@DrugId", p.DrugId);
                cmd.Parameters.AddWithValue("@Date", p.Date);
                cmd.Parameters.AddWithValue("@Period", p.Period);
                cmd.Parameters.AddWithValue("@Dosage", p.Dosage);
                cmd.Parameters.AddWithValue("@Description", p.Description);
                cmd.Parameters.AddWithValue("PrescriptionId", p.PrescriptionId);

                // Open database connection
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
                conn.Close();
            }
            return isSuccess;
        }

        // Method to delete data from database
        public bool Delete(PrescriptionClass p)
        {
            // Create a default return type and set its default value to false
            bool isSuccess = false;

            // Create SQL connection
            SqlConnection conn = new SqlConnection(myconnstr);

            try
            {
                // SQL to delete data
                string sql = "DELETE FROM Prescription WHERE Prescription_ID=@PrescriptionId";

                // Create SQL command
                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@PrescriptionId", p.PrescriptionId);

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
