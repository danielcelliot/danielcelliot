namespace PremierCare.UI
{
    partial class AppointmentUserControl
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

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(AppointmentUserControl));
            this.btn_clearAppointment = new System.Windows.Forms.Button();
            this.btn_deleteAppointment = new System.Windows.Forms.Button();
            this.btn_updateAppointment = new System.Windows.Forms.Button();
            this.btn_addAppointment = new System.Windows.Forms.Button();
            this.cmb_aptDoctor = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.txtbx_findAppointment = new System.Windows.Forms.TextBox();
            this.btn_findAppointment = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.dtp_aptDate = new System.Windows.Forms.DateTimePicker();
            this.label3 = new System.Windows.Forms.Label();
            this.label10 = new System.Windows.Forms.Label();
            this.txtbx_csrID = new System.Windows.Forms.TextBox();
            this.label9 = new System.Windows.Forms.Label();
            this.cmb_aptService = new System.Windows.Forms.ComboBox();
            this.label7 = new System.Windows.Forms.Label();
            this.txtbx_aptID = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.panel1 = new System.Windows.Forms.Panel();
            this.dgv_findAppointment = new System.Windows.Forms.DataGridView();
            this.cmb_aptPatient = new System.Windows.Forms.ComboBox();
            this.dtp_aptTime = new System.Windows.Forms.DateTimePicker();
            this.groupBox1.SuspendLayout();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_findAppointment)).BeginInit();
            this.SuspendLayout();
            // 
            // btn_clearAppointment
            // 
            this.btn_clearAppointment.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.btn_clearAppointment.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_clearAppointment.FlatAppearance.BorderColor = System.Drawing.Color.Orange;
            this.btn_clearAppointment.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(128)))));
            this.btn_clearAppointment.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_clearAppointment.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Bold);
            this.btn_clearAppointment.Location = new System.Drawing.Point(567, 247);
            this.btn_clearAppointment.Name = "btn_clearAppointment";
            this.btn_clearAppointment.Size = new System.Drawing.Size(133, 35);
            this.btn_clearAppointment.TabIndex = 9;
            this.btn_clearAppointment.Text = "Clear";
            this.btn_clearAppointment.UseVisualStyleBackColor = false;
            this.btn_clearAppointment.Click += new System.EventHandler(this.btn_clearAppointment_Click);
            // 
            // btn_deleteAppointment
            // 
            this.btn_deleteAppointment.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.btn_deleteAppointment.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_deleteAppointment.FlatAppearance.BorderColor = System.Drawing.Color.Red;
            this.btn_deleteAppointment.FlatAppearance.MouseOverBackColor = System.Drawing.Color.LightSalmon;
            this.btn_deleteAppointment.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_deleteAppointment.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Bold);
            this.btn_deleteAppointment.Location = new System.Drawing.Point(392, 247);
            this.btn_deleteAppointment.Name = "btn_deleteAppointment";
            this.btn_deleteAppointment.Size = new System.Drawing.Size(133, 35);
            this.btn_deleteAppointment.TabIndex = 8;
            this.btn_deleteAppointment.Text = "Delete";
            this.btn_deleteAppointment.UseVisualStyleBackColor = false;
            this.btn_deleteAppointment.Click += new System.EventHandler(this.btn_deleteAppointment_Click);
            // 
            // btn_updateAppointment
            // 
            this.btn_updateAppointment.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.btn_updateAppointment.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_updateAppointment.FlatAppearance.BorderColor = System.Drawing.Color.Blue;
            this.btn_updateAppointment.FlatAppearance.MouseOverBackColor = System.Drawing.Color.LightBlue;
            this.btn_updateAppointment.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_updateAppointment.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Bold);
            this.btn_updateAppointment.Location = new System.Drawing.Point(217, 247);
            this.btn_updateAppointment.Name = "btn_updateAppointment";
            this.btn_updateAppointment.Size = new System.Drawing.Size(133, 35);
            this.btn_updateAppointment.TabIndex = 7;
            this.btn_updateAppointment.Text = "Update";
            this.btn_updateAppointment.UseVisualStyleBackColor = false;
            this.btn_updateAppointment.Click += new System.EventHandler(this.btn_updateAppointment_Click);
            // 
            // btn_addAppointment
            // 
            this.btn_addAppointment.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.btn_addAppointment.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_addAppointment.FlatAppearance.BorderColor = System.Drawing.Color.Green;
            this.btn_addAppointment.FlatAppearance.MouseOverBackColor = System.Drawing.Color.LightGreen;
            this.btn_addAppointment.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_addAppointment.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Bold);
            this.btn_addAppointment.Location = new System.Drawing.Point(42, 247);
            this.btn_addAppointment.Name = "btn_addAppointment";
            this.btn_addAppointment.Size = new System.Drawing.Size(133, 35);
            this.btn_addAppointment.TabIndex = 6;
            this.btn_addAppointment.Text = "Add";
            this.btn_addAppointment.UseVisualStyleBackColor = false;
            this.btn_addAppointment.Click += new System.EventHandler(this.btn_addAppointment_Click);
            // 
            // cmb_aptDoctor
            // 
            this.cmb_aptDoctor.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_aptDoctor.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.cmb_aptDoctor.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_aptDoctor.FormattingEnabled = true;
            this.cmb_aptDoctor.Location = new System.Drawing.Point(291, 179);
            this.cmb_aptDoctor.Name = "cmb_aptDoctor";
            this.cmb_aptDoctor.Size = new System.Drawing.Size(172, 25);
            this.cmb_aptDoctor.TabIndex = 4;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(40, 316);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(114, 17);
            this.label4.TabIndex = 77;
            this.label4.Text = "Find Appointment:";
            // 
            // txtbx_findAppointment
            // 
            this.txtbx_findAppointment.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtbx_findAppointment.Location = new System.Drawing.Point(160, 313);
            this.txtbx_findAppointment.Name = "txtbx_findAppointment";
            this.txtbx_findAppointment.Size = new System.Drawing.Size(478, 25);
            this.txtbx_findAppointment.TabIndex = 10;
            this.txtbx_findAppointment.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtbx_findAppointment_KeyDown);
            // 
            // btn_findAppointment
            // 
            this.btn_findAppointment.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_findAppointment.FlatAppearance.BorderSize = 0;
            this.btn_findAppointment.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_findAppointment.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_findAppointment.Image = ((System.Drawing.Image)(resources.GetObject("btn_findAppointment.Image")));
            this.btn_findAppointment.ImageAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btn_findAppointment.Location = new System.Drawing.Point(656, 305);
            this.btn_findAppointment.Name = "btn_findAppointment";
            this.btn_findAppointment.Size = new System.Drawing.Size(39, 39);
            this.btn_findAppointment.TabIndex = 11;
            this.btn_findAppointment.UseVisualStyleBackColor = true;
            this.btn_findAppointment.Click += new System.EventHandler(this.btn_findAppointment_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(531, 159);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(50, 17);
            this.label2.TabIndex = 63;
            this.label2.Text = "CSR ID:";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(39, 93);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(50, 17);
            this.label1.TabIndex = 64;
            this.label1.Text = "Patient:";
            // 
            // dtp_aptDate
            // 
            this.dtp_aptDate.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtp_aptDate.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtp_aptDate.Location = new System.Drawing.Point(291, 113);
            this.dtp_aptDate.Name = "dtp_aptDate";
            this.dtp_aptDate.Size = new System.Drawing.Size(169, 25);
            this.dtp_aptDate.TabIndex = 1;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(39, 30);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(102, 17);
            this.label3.TabIndex = 65;
            this.label3.Text = "Appointment ID:";
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label10.Location = new System.Drawing.Point(39, 159);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(52, 17);
            this.label10.TabIndex = 75;
            this.label10.Text = "Service:";
            // 
            // txtbx_csrID
            // 
            this.txtbx_csrID.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtbx_csrID.Location = new System.Drawing.Point(531, 179);
            this.txtbx_csrID.Name = "txtbx_csrID";
            this.txtbx_csrID.Size = new System.Drawing.Size(169, 25);
            this.txtbx_csrID.TabIndex = 5;
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label9.Location = new System.Drawing.Point(531, 93);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(39, 17);
            this.label9.TabIndex = 72;
            this.label9.Text = "Time:";
            // 
            // cmb_aptService
            // 
            this.cmb_aptService.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_aptService.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.cmb_aptService.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_aptService.FormattingEnabled = true;
            this.cmb_aptService.Location = new System.Drawing.Point(42, 179);
            this.cmb_aptService.Name = "cmb_aptService";
            this.cmb_aptService.Size = new System.Drawing.Size(170, 25);
            this.cmb_aptService.TabIndex = 3;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.Location = new System.Drawing.Point(288, 93);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(133, 17);
            this.label7.TabIndex = 71;
            this.label7.Text = "Date of Appointment:";
            // 
            // txtbx_aptID
            // 
            this.txtbx_aptID.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtbx_aptID.Location = new System.Drawing.Point(42, 50);
            this.txtbx_aptID.Name = "txtbx_aptID";
            this.txtbx_aptID.ReadOnly = true;
            this.txtbx_aptID.Size = new System.Drawing.Size(170, 25);
            this.txtbx_aptID.TabIndex = 69;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(288, 159);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(51, 17);
            this.label6.TabIndex = 83;
            this.label6.Text = "Doctor:";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.panel1);
            this.groupBox1.Controls.Add(this.cmb_aptPatient);
            this.groupBox1.Controls.Add(this.dtp_aptTime);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.btn_clearAppointment);
            this.groupBox1.Controls.Add(this.txtbx_aptID);
            this.groupBox1.Controls.Add(this.btn_deleteAppointment);
            this.groupBox1.Controls.Add(this.label7);
            this.groupBox1.Controls.Add(this.btn_updateAppointment);
            this.groupBox1.Controls.Add(this.btn_addAppointment);
            this.groupBox1.Controls.Add(this.cmb_aptService);
            this.groupBox1.Controls.Add(this.label6);
            this.groupBox1.Controls.Add(this.label9);
            this.groupBox1.Controls.Add(this.cmb_aptDoctor);
            this.groupBox1.Controls.Add(this.txtbx_csrID);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.label10);
            this.groupBox1.Controls.Add(this.txtbx_findAppointment);
            this.groupBox1.Controls.Add(this.btn_findAppointment);
            this.groupBox1.Controls.Add(this.dtp_aptDate);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold);
            this.groupBox1.Location = new System.Drawing.Point(49, 0);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(752, 543);
            this.groupBox1.TabIndex = 88;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "APPOINTMENT INFORMATION";
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.dgv_findAppointment);
            this.panel1.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.panel1.Location = new System.Drawing.Point(4, 348);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(740, 189);
            this.panel1.TabIndex = 90;
            // 
            // dgv_findAppointment
            // 
            this.dgv_findAppointment.AllowUserToAddRows = false;
            this.dgv_findAppointment.AllowUserToDeleteRows = false;
            this.dgv_findAppointment.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_findAppointment.Location = new System.Drawing.Point(36, 4);
            this.dgv_findAppointment.MultiSelect = false;
            this.dgv_findAppointment.Name = "dgv_findAppointment";
            this.dgv_findAppointment.ReadOnly = true;
            this.dgv_findAppointment.RowHeadersWidth = 10;
            this.dgv_findAppointment.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgv_findAppointment.Size = new System.Drawing.Size(658, 169);
            this.dgv_findAppointment.TabIndex = 0;
            this.dgv_findAppointment.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgv_findAppointment_CellClick);
            // 
            // cmb_aptPatient
            // 
            this.cmb_aptPatient.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_aptPatient.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.cmb_aptPatient.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_aptPatient.FormattingEnabled = true;
            this.cmb_aptPatient.Location = new System.Drawing.Point(42, 113);
            this.cmb_aptPatient.Name = "cmb_aptPatient";
            this.cmb_aptPatient.Size = new System.Drawing.Size(172, 25);
            this.cmb_aptPatient.TabIndex = 0;
            // 
            // dtp_aptTime
            // 
            this.dtp_aptTime.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtp_aptTime.Format = System.Windows.Forms.DateTimePickerFormat.Time;
            this.dtp_aptTime.Location = new System.Drawing.Point(531, 113);
            this.dtp_aptTime.Name = "dtp_aptTime";
            this.dtp_aptTime.ShowUpDown = true;
            this.dtp_aptTime.Size = new System.Drawing.Size(169, 25);
            this.dtp_aptTime.TabIndex = 2;
            // 
            // AppointmentUserControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.groupBox1);
            this.Name = "AppointmentUserControl";
            this.Size = new System.Drawing.Size(851, 546);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.panel1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgv_findAppointment)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btn_clearAppointment;
        private System.Windows.Forms.Button btn_deleteAppointment;
        private System.Windows.Forms.Button btn_updateAppointment;
        private System.Windows.Forms.Button btn_addAppointment;
        private System.Windows.Forms.ComboBox cmb_aptDoctor;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox txtbx_findAppointment;
        private System.Windows.Forms.Button btn_findAppointment;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DateTimePicker dtp_aptDate;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.TextBox txtbx_csrID;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.ComboBox cmb_aptService;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox txtbx_aptID;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.DateTimePicker dtp_aptTime;
        private System.Windows.Forms.ComboBox cmb_aptPatient;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.DataGridView dgv_findAppointment;
    }
}
