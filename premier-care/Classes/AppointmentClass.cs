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
    class AppointmentClass
    {
        // Getter Setter Properties
        // Acts as Data Carrier in Our Application
        public int AppointmentId { get; set; }
        public int PatientId { get; set; }
        public string Date { get; set; }
        public string Time { get; set; }
        public int ServiceId { get; set; }
        public int DoctorId { get; set; }
        public int CsrId { get; set; }

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
                string sql = "SELECT Appointment.Appointment_ID, " +
                                "CONCAT(Patient.First_Name, ' ', Patient.Last_Name) AS Patient_Name, " +
                                "CONCAT(Staff.First_Name, ' ', Staff.Last_Name) AS Doctor_Name, " +
                                "Service.Name AS Service_Name, Appointment.Date, Appointment.Time, Appointment.CSR_ID " +
                             "FROM Appointment INNER JOIN " +
                                "Patient ON Appointment.Patient_ID = Patient.Patient_ID INNER JOIN " +
                                "Doctor ON Appointment.Doctor_ID = Doctor.Doctor_ID INNER JOIN " +
                                "Staff ON Doctor.Staff_ID = Staff.Staff_ID INNER JOIN " +
                                "Service ON Appointment.Service_ID = Service.Service_ID";

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
        public bool Insert(AppointmentClass a)
        {
            // Create a default return type and set its value to false
            bool isSuccess = false;

            // Step 1: Connect database
            SqlConnection conn = new SqlConnection(myconnstr);

            try
            {
                // Step 2: Create a SQL Query to insert data
                string sql = "INSERT INTO Appointment (Patient_ID, Doctor_ID, CSR_ID, Service_ID, Date, Time) " +
                            "VALUES (@PatientId, @DoctorId, @CsrId, @ServiceId, @Date, @Time)";

                // Create SQL command using sql and conn
                SqlCommand cmd = new SqlCommand(sql, conn);

                // Create parameters to add data
                cmd.Parameters.AddWithValue("@PatientId", a.PatientId);
                cmd.Parameters.AddWithValue("@DoctorId", a.DoctorId);
                cmd.Parameters.AddWithValue("@CsrId", a.CsrId);
                cmd.Parameters.AddWithValue("@ServiceId", a.ServiceId);
                cmd.Parameters.AddWithValue("@Date", a.Date);
                cmd.Parameters.AddWithValue("@Time", a.Time);
                
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
        public bool Update(AppointmentClass a)
        {
            // Create a default return type and set its default value to false
            bool isSuccess = false;
            SqlConnection conn = new SqlConnection(myconnstr);

            try
            {
                // SQL to update data in our database
                string sql = "UPDATE Appointment SET Patient_ID=@PatientId, Doctor_ID=@DoctorId, CSR_ID=@CsrId, Service_ID=@ServiceId, Date=@Date, Time=@Time " +
                            "WHERE Appointment_ID=@AppointmentId";

                // Create SQL command
                SqlCommand cmd = new SqlCommand(sql, conn);

                // Create parameters to add value
                cmd.Parameters.AddWithValue("@PatientId", a.PatientId);
                cmd.Parameters.AddWithValue("@DoctorId", a.DoctorId);
                cmd.Parameters.AddWithValue("@CsrId", a.CsrId);
                cmd.Parameters.AddWithValue("@ServiceId", a.ServiceId);
                cmd.Parameters.AddWithValue("@Date", a.Date);
                cmd.Parameters.AddWithValue("@Time", a.Time);
                cmd.Parameters.AddWithValue("AppointmentId", a.AppointmentId);

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
        public bool Delete(AppointmentClass a)
        {
            // Create a default return type and set its default value to false
            bool isSuccess = false;

            // Create SQL connection
            SqlConnection conn = new SqlConnection(myconnstr);

            try
            {
                // SQL to delete data
                string sql = "DELETE FROM Appointment WHERE Appointment_ID=@AppointmentId";

                // Create SQL command
                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@AppointmentId", a.AppointmentId);

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
