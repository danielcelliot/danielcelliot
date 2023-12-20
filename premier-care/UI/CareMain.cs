using System;
using System.Windows.Forms;

namespace PremierCare.UI
{
    public partial class CareMain : Form
    {
        // Add a drop shadow to form
        protected override CreateParams CreateParams {
            get 
            {
                const int CS_DROPSHADOW = 0x00020000;
                CreateParams cp = base.CreateParams;
                cp.ClassStyle |= CS_DROPSHADOW;
                return cp;
            }
        }

        public CareMain()
        {
            InitializeComponent();

            SidePanel.Height = btn_Patient.Height;
            SidePanel.Top = btn_Patient.Top;
            patientUserControl1.BringToFront();
            
            // Call the method to load DataGrid view
            patientUserControl1.LoadPatientDgvData();

            // Call the clear method to empty all boxes
            patientUserControl1.Clear();
        }
        
        private void btn_Patient_Click(object sender, EventArgs e)
        {
            SidePanel.Height = btn_Patient.Height;
            SidePanel.Top = btn_Patient.Top;
            patientUserControl1.BringToFront();
            
            // Call the method to load DataGrid view
            patientUserControl1.LoadPatientDgvData();

            // Call the clear method to empty all boxes
            patientUserControl1.Clear();
        }

        private void btn_Appointment_Click(object sender, EventArgs e)
        {
            SidePanel.Height = btn_Appointment.Height;
            SidePanel.Top = btn_Appointment.Top;
            appointmentUserControl1.BringToFront();

            // Call the methods to fill combo boxes on the Appointment page
            appointmentUserControl1.FillPatientComboBox();
            appointmentUserControl1.FillDoctorComboBox();
            appointmentUserControl1.FillServiceComboBox();
            
            // Call the method to load DataGrid view
            appointmentUserControl1.LoadAppointmentDgvData();

            // Call the clear method to empty all boxes
            appointmentUserControl1.Clear();
        }

        private void btn_Prescription_Click(object sender, EventArgs e)
        {
            SidePanel.Height = btn_Prescription.Height;
            SidePanel.Top = btn_Prescription.Top;
            prescriptionUserControl1.BringToFront();

            // Call the methods to fill combo boxes on the Prescription page
            prescriptionUserControl1.FillDrugComboBox();
            prescriptionUserControl1.FillPatientComboBox();
            prescriptionUserControl1.FillDoctorComboBox();
            
            // Call the method to load DataGrid view
            prescriptionUserControl1.LoadPrescriptionDgvData();

            // Call the clear method to empty all boxes
            prescriptionUserControl1.Clear();
        }

        private void btn_Invoice_Click(object sender, EventArgs e)
        {
            SidePanel.Height = btn_Invoice.Height;
            SidePanel.Top = btn_Invoice.Top;
            invoiceUserControl1.BringToFront();
            
            // Call the methods to fill combo boxes on the Invoice page
            invoiceUserControl1.FillPatientComboBox();
            
            // Call the method to load DataGrid view
            invoiceUserControl1.LoadInvoiceDgvData();
            
            // Call the clear method to empty all boxes
            invoiceUserControl1.Clear();
        }

        private void btn_Close_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void CareMain_FormClosing(object sender, FormClosingEventArgs e)
        {
            Application.Exit();
        }
    }
}
