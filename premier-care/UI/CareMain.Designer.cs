namespace PremierCare.UI
{
    partial class CareMain
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(CareMain));
            this.panel1 = new System.Windows.Forms.Panel();
            this.btn_Invoice = new System.Windows.Forms.Button();
            this.button4 = new System.Windows.Forms.Button();
            this.SidePanel = new System.Windows.Forms.Panel();
            this.btn_Prescription = new System.Windows.Forms.Button();
            this.btn_Appointment = new System.Windows.Forms.Button();
            this.btn_Patient = new System.Windows.Forms.Button();
            this.panel2 = new System.Windows.Forms.Panel();
            this.panel4 = new System.Windows.Forms.Panel();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.btn_Close = new System.Windows.Forms.Button();
            this.btn_Settings = new System.Windows.Forms.Button();
            this.invoiceUserControl1 = new PremierCare.UI.InvoiceUserControl();
            this.prescriptionUserControl1 = new PremierCare.UI.PrescriptionUserControl();
            this.appointmentUserControl1 = new PremierCare.UI.AppointmentUserControl();
            this.patientUserControl1 = new PremierCare.UI.PatientUserControl();
            this.panel1.SuspendLayout();
            this.panel4.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(41)))), ((int)(((byte)(39)))), ((int)(((byte)(40)))));
            this.panel1.Controls.Add(this.btn_Invoice);
            this.panel1.Controls.Add(this.button4);
            this.panel1.Controls.Add(this.SidePanel);
            this.panel1.Controls.Add(this.btn_Prescription);
            this.panel1.Controls.Add(this.btn_Appointment);
            this.panel1.Controls.Add(this.btn_Patient);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Left;
            this.panel1.Location = new System.Drawing.Point(0, 0);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(160, 717);
            this.panel1.TabIndex = 0;
            // 
            // btn_Invoice
            // 
            this.btn_Invoice.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_Invoice.FlatAppearance.BorderSize = 0;
            this.btn_Invoice.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_Invoice.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_Invoice.ForeColor = System.Drawing.Color.White;
            this.btn_Invoice.Image = ((System.Drawing.Image)(resources.GetObject("btn_Invoice.Image")));
            this.btn_Invoice.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btn_Invoice.Location = new System.Drawing.Point(10, 306);
            this.btn_Invoice.Name = "btn_Invoice";
            this.btn_Invoice.Size = new System.Drawing.Size(150, 50);
            this.btn_Invoice.TabIndex = 3;
            this.btn_Invoice.Text = "Invoice";
            this.btn_Invoice.UseMnemonic = false;
            this.btn_Invoice.UseVisualStyleBackColor = true;
            this.btn_Invoice.Click += new System.EventHandler(this.btn_Invoice_Click);
            // 
            // button4
            // 
            this.button4.Cursor = System.Windows.Forms.Cursors.Hand;
            this.button4.FlatAppearance.BorderSize = 0;
            this.button4.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button4.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.button4.ForeColor = System.Drawing.Color.White;
            this.button4.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.button4.Location = new System.Drawing.Point(0, 683);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(37, 34);
            this.button4.TabIndex = 4;
            this.button4.Text = "?";
            this.button4.UseVisualStyleBackColor = true;
            // 
            // SidePanel
            // 
            this.SidePanel.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(204)))), ((int)(((byte)(51)))), ((int)(((byte)(51)))));
            this.SidePanel.Location = new System.Drawing.Point(0, 137);
            this.SidePanel.Name = "SidePanel";
            this.SidePanel.Size = new System.Drawing.Size(10, 50);
            this.SidePanel.TabIndex = 3;
            // 
            // btn_Prescription
            // 
            this.btn_Prescription.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_Prescription.FlatAppearance.BorderSize = 0;
            this.btn_Prescription.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_Prescription.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_Prescription.ForeColor = System.Drawing.Color.White;
            this.btn_Prescription.Image = ((System.Drawing.Image)(resources.GetObject("btn_Prescription.Image")));
            this.btn_Prescription.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btn_Prescription.Location = new System.Drawing.Point(10, 249);
            this.btn_Prescription.Name = "btn_Prescription";
            this.btn_Prescription.Size = new System.Drawing.Size(150, 50);
            this.btn_Prescription.TabIndex = 2;
            this.btn_Prescription.Text = "     Prescription";
            this.btn_Prescription.UseMnemonic = false;
            this.btn_Prescription.UseVisualStyleBackColor = true;
            this.btn_Prescription.Click += new System.EventHandler(this.btn_Prescription_Click);
            // 
            // btn_Appointment
            // 
            this.btn_Appointment.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_Appointment.FlatAppearance.BorderSize = 0;
            this.btn_Appointment.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_Appointment.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_Appointment.ForeColor = System.Drawing.Color.White;
            this.btn_Appointment.Image = ((System.Drawing.Image)(resources.GetObject("btn_Appointment.Image")));
            this.btn_Appointment.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btn_Appointment.Location = new System.Drawing.Point(10, 193);
            this.btn_Appointment.Name = "btn_Appointment";
            this.btn_Appointment.Size = new System.Drawing.Size(150, 50);
            this.btn_Appointment.TabIndex = 1;
            this.btn_Appointment.Text = "      Appointment";
            this.btn_Appointment.UseVisualStyleBackColor = true;
            this.btn_Appointment.Click += new System.EventHandler(this.btn_Appointment_Click);
            // 
            // btn_Patient
            // 
            this.btn_Patient.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_Patient.FlatAppearance.BorderSize = 0;
            this.btn_Patient.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_Patient.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_Patient.ForeColor = System.Drawing.Color.White;
            this.btn_Patient.Image = ((System.Drawing.Image)(resources.GetObject("btn_Patient.Image")));
            this.btn_Patient.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btn_Patient.Location = new System.Drawing.Point(10, 137);
            this.btn_Patient.Name = "btn_Patient";
            this.btn_Patient.Size = new System.Drawing.Size(150, 50);
            this.btn_Patient.TabIndex = 0;
            this.btn_Patient.Text = "Patient";
            this.btn_Patient.UseVisualStyleBackColor = true;
            this.btn_Patient.Click += new System.EventHandler(this.btn_Patient_Click);
            // 
            // panel2
            // 
            this.panel2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(204)))), ((int)(((byte)(51)))), ((int)(((byte)(51)))));
            this.panel2.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel2.Location = new System.Drawing.Point(160, 0);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(851, 10);
            this.panel2.TabIndex = 1;
            // 
            // panel4
            // 
            this.panel4.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(204)))), ((int)(((byte)(51)))), ((int)(((byte)(51)))));
            this.panel4.Controls.Add(this.label3);
            this.panel4.Controls.Add(this.label2);
            this.panel4.Controls.Add(this.pictureBox1);
            this.panel4.Location = new System.Drawing.Point(205, 0);
            this.panel4.Name = "panel4";
            this.panel4.Size = new System.Drawing.Size(133, 165);
            this.panel4.TabIndex = 0;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.ForeColor = System.Drawing.Color.White;
            this.label3.Location = new System.Drawing.Point(-3, 137);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(140, 15);
            this.label3.TabIndex = 4;
            this.label3.Text = "\"Where you come first\"";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Segoe UI", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.ForeColor = System.Drawing.Color.White;
            this.label2.Location = new System.Drawing.Point(2, 102);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(127, 25);
            this.label2.TabIndex = 3;
            this.label2.Text = "Premier Care";
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
            this.pictureBox1.Location = new System.Drawing.Point(0, 3);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(133, 85);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 0;
            this.pictureBox1.TabStop = false;
            // 
            // btn_Close
            // 
            this.btn_Close.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_Close.FlatAppearance.BorderSize = 0;
            this.btn_Close.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_Close.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_Close.ForeColor = System.Drawing.Color.White;
            this.btn_Close.Image = ((System.Drawing.Image)(resources.GetObject("btn_Close.Image")));
            this.btn_Close.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btn_Close.Location = new System.Drawing.Point(969, 10);
            this.btn_Close.Name = "btn_Close";
            this.btn_Close.Size = new System.Drawing.Size(42, 42);
            this.btn_Close.TabIndex = 5;
            this.btn_Close.UseVisualStyleBackColor = true;
            this.btn_Close.Click += new System.EventHandler(this.btn_Close_Click);
            // 
            // btn_Settings
            // 
            this.btn_Settings.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_Settings.FlatAppearance.BorderSize = 0;
            this.btn_Settings.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_Settings.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_Settings.ForeColor = System.Drawing.Color.White;
            this.btn_Settings.Image = ((System.Drawing.Image)(resources.GetObject("btn_Settings.Image")));
            this.btn_Settings.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btn_Settings.Location = new System.Drawing.Point(921, 10);
            this.btn_Settings.Name = "btn_Settings";
            this.btn_Settings.Size = new System.Drawing.Size(42, 42);
            this.btn_Settings.TabIndex = 6;
            this.btn_Settings.UseVisualStyleBackColor = true;
            // 
            // invoiceUserControl1
            // 
            this.invoiceUserControl1.Location = new System.Drawing.Point(160, 171);
            this.invoiceUserControl1.Name = "invoiceUserControl1";
            this.invoiceUserControl1.Size = new System.Drawing.Size(845, 529);
            this.invoiceUserControl1.TabIndex = 8;
            // 
            // prescriptionUserControl1
            // 
            this.prescriptionUserControl1.Location = new System.Drawing.Point(160, 171);
            this.prescriptionUserControl1.Name = "prescriptionUserControl1";
            this.prescriptionUserControl1.Size = new System.Drawing.Size(845, 529);
            this.prescriptionUserControl1.TabIndex = 7;
            // 
            // appointmentUserControl1
            // 
            this.appointmentUserControl1.Location = new System.Drawing.Point(160, 171);
            this.appointmentUserControl1.Name = "appointmentUserControl1";
            this.appointmentUserControl1.Size = new System.Drawing.Size(845, 529);
            this.appointmentUserControl1.TabIndex = 5;
            // 
            // patientUserControl1
            // 
            this.patientUserControl1.Location = new System.Drawing.Point(160, 171);
            this.patientUserControl1.Name = "patientUserControl1";
            this.patientUserControl1.Size = new System.Drawing.Size(845, 529);
            this.patientUserControl1.TabIndex = 4;
            // 
            // CareMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.ControlLight;
            this.ClientSize = new System.Drawing.Size(1011, 717);
            this.Controls.Add(this.invoiceUserControl1);
            this.Controls.Add(this.prescriptionUserControl1);
            this.Controls.Add(this.btn_Settings);
            this.Controls.Add(this.btn_Close);
            this.Controls.Add(this.appointmentUserControl1);
            this.Controls.Add(this.patientUserControl1);
            this.Controls.Add(this.panel4);
            this.Controls.Add(this.panel2);
            this.Controls.Add(this.panel1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "CareMain";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Form1";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.CareMain_FormClosing);
            this.panel1.ResumeLayout(false);
            this.panel4.ResumeLayout(false);
            this.panel4.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Button btn_Appointment;
        private System.Windows.Forms.Button btn_Patient;
        private System.Windows.Forms.Button btn_Prescription;
        private System.Windows.Forms.Panel SidePanel;
        private System.Windows.Forms.Panel panel4;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Button button4;
        private PatientUserControl patientUserControl1;
        private AppointmentUserControl appointmentUserControl1;
        private System.Windows.Forms.Button btn_Close;
        private System.Windows.Forms.Button btn_Settings;
        private PrescriptionUserControl prescriptionUserControl1;
        private System.Windows.Forms.Button btn_Invoice;
        private InvoiceUserControl invoiceUserControl1;
        private System.Windows.Forms.Label label3;
    }
}

