using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;
using PremierCare.Classes;

namespace PremierCare.UI
{
    public partial class Login : Form
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

        public Login()
        {
            InitializeComponent();
        }

        private void btn_clearLogin_Click(object sender, EventArgs e)
        {
            txtbx_username.Clear();
            txtbx_password.Clear();
            txtbx_username.Focus();
        }

        private void btn_Login_Click(object sender, EventArgs e)
        {
            // Ensure login credentials come from DB
            SqlConnection con = new SqlConnection(GlobalClass.connectionString);
            string sql = "SELECT * FROM[dbo].[Login] " +
                         "WHERE User_Name = '" + txtbx_username.Text + "' AND " +
                         "Password = " + "'" + txtbx_password.Text + "'";

            SqlDataAdapter sda = new SqlDataAdapter(sql, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            if (dt.Rows.Count == 1)
            {
                CareMain main = new CareMain();
                main.Show();
                Hide();
            }
            else
            {
                MessageBox.Show("Invalid Username & Password.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                btn_clearLogin_Click(sender, e);
            }
        }

        private void btn_Close_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void txtbx_username_KeyDown(object sender, KeyEventArgs e)
        {
            // Pressing the Enter key while the Search text box is highlighted
            // will perform a search (instead of clicking the Search button).
            if (e.KeyCode == Keys.Enter){
                btn_Login.PerformClick();
            }
        }

        private void txtbx_password_KeyDown(object sender, KeyEventArgs e)
        {
            // Pressing the Enter key while the Search text box is highlighted
            // will perform a search (instead of clicking the Search button).
            if (e.KeyCode == Keys.Enter){
                btn_Login.PerformClick();
            }
        }
    }
}
