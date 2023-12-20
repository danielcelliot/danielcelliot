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
    class PatientClass
    {
        // Getter Setter Properties
        // Acts as Data Carrier in Our Application
        public int PatientId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string ContactNo { get; set; }
        public string Dob { get; set; }
        public string Sex { get; set; }
        public string BloodType { get; set; }
        public string Address { get; set; }

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
                string sql = "SELECT * FROM Patient";

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
        public bool Insert(PatientClass p)
        {
            // Create a default return type and set its value to false
            bool isSuccess = false;

            // Step 1: Connect database
            SqlConnection conn = new SqlConnection(myconnstr);

            try
            {
                // Step 2: Create a SQL Query to insert data
                string sql = "INSERT INTO Patient (First_Name, Last_Name, Contact, Address, Sex, DOB, Blood_Type) " +
                            "VALUES (@FirstName, @LastName, @ContactNo, @Address, @Sex, @Dob, @BloodType)";

                // Create SQL command using sql and conn
                SqlCommand cmd = new SqlCommand(sql, conn);

                // Create parameters to add data
                cmd.Parameters.AddWithValue("@FirstName", p.FirstName);
                cmd.Parameters.AddWithValue("@LastName", p.LastName);
                cmd.Parameters.AddWithValue("@ContactNo", p.ContactNo);
                cmd.Parameters.AddWithValue("@Address", p.Address);
                cmd.Parameters.AddWithValue("@Sex", p.Sex);
                cmd.Parameters.AddWithValue("@Dob", p.Dob);
                cmd.Parameters.AddWithValue("@BloodType", p.BloodType);
                
                // Open connection here
                conn.Open();
                int rows = cmd.ExecuteNonQuery();

                // If the query runs successfully then the value of rows will be
                // greater than zero else its value will be 0
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
        public bool Update(PatientClass p)
        {
            // Create a default return type and set its default value to false
            bool isSuccess = false;
            SqlConnection conn = new SqlConnection(myconnstr);

            try
            {
                // SQL to update data in our database
                string sql = "UPDATE Patient SET First_Name=@FirstName, Last_Name=@LastName, Contact=@ContactNo, Address=@Address, Sex=@Sex, DOB=@Dob, Blood_Type=@BloodType " +
                            "WHERE Patient_ID=@PatientId";

                // Create SQL command
                SqlCommand cmd = new SqlCommand(sql, conn);

                // Create parameters to add value
                cmd.Parameters.AddWithValue("@FirstName", p.FirstName);
                cmd.Parameters.AddWithValue("@LastName", p.LastName);
                cmd.Parameters.AddWithValue("@ContactNo", p.ContactNo);
                cmd.Parameters.AddWithValue("@Address", p.Address);
                cmd.Parameters.AddWithValue("@Sex", p.Sex);
                cmd.Parameters.AddWithValue("@Dob", p.Dob);
                cmd.Parameters.AddWithValue("@BloodType", p.BloodType);
                cmd.Parameters.AddWithValue("PatientId", p.PatientId);

                // Open database connection
                conn.Open();

                int rows = cmd.ExecuteNonQuery();

                // If the query runs successfully then the value of rows will be
                // greater than zero else its value will be 0
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
        public bool Delete(PatientClass p)
        {
            // Create a default return type and set its default value to false
            bool isSuccess = false;

            // Create SQL connection
            SqlConnection conn = new SqlConnection(myconnstr);

            try
            {
                // SQL to delete data
                string sql = "DELETE FROM Patient WHERE Patient_ID=@PatientId";

                // Create SQL command
                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@PatientId", p.PatientId);

                // Open connection
                conn.Open();
                int rows = cmd.ExecuteNonQuery();

                // If the query runs successfully then the value of rows will be
                // greater than zero else its value will be 0
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
