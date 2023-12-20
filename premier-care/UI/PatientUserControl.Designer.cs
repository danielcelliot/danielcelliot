namespace PremierCare.UI
{
    partial class PatientUserControl
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(PatientUserControl));
            this.dtp_patientDOB = new System.Windows.Forms.DateTimePicker();
            this.txtbx_patientContact = new System.Windows.Forms.TextBox();
            this.label10 = new System.Windows.Forms.Label();
            this.label9 = new System.Windows.Forms.Label();
            this.cmb_patientBloodType = new System.Windows.Forms.ComboBox();
            this.label7 = new System.Windows.Forms.Label();
            this.txtbx_patientAddress = new System.Windows.Forms.TextBox();
            this.txtbx_patientID = new System.Windows.Forms.TextBox();
            this.txtbx_patientFName = new System.Windows.Forms.TextBox();
            this.txtbx_patientLName = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.llbl_allergy = new System.Windows.Forms.LinkLabel();
            this.label4 = new System.Windows.Forms.Label();
            this.txtbx_search = new System.Windows.Forms.TextBox();
            this.btn_findPatient = new System.Windows.Forms.Button();
            this.cmb_patientSex = new System.Windows.Forms.ComboBox();
            this.label6 = new System.Windows.Forms.Label();
            this.btn_addPatient = new System.Windows.Forms.Button();
            this.btn_updatePatient = new System.Windows.Forms.Button();
            this.btn_deletePatient = new System.Windows.Forms.Button();
            this.btn_clearPatient = new System.Windows.Forms.Button();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.panel1 = new System.Windows.Forms.Panel();
            this.dgv_findPatient = new System.Windows.Forms.DataGridView();
            this.groupBox1.SuspendLayout();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_findPatient)).BeginInit();
            this.SuspendLayout();
            // 
            // dtp_patientDOB
            // 
            this.dtp_patientDOB.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtp_patientDOB.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtp_patientDOB.Location = new System.Drawing.Point(42, 180);
            this.dtp_patientDOB.Name = "dtp_patientDOB";
            this.dtp_patientDOB.Size = new System.Drawing.Size(169, 25);
            this.dtp_patientDOB.TabIndex = 4;
            // 
            // txtbx_patientContact
            // 
            this.txtbx_patientContact.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtbx_patientContact.Location = new System.Drawing.Point(42, 113);
            this.txtbx_patientContact.Name = "txtbx_patientContact";
            this.txtbx_patientContact.Size = new System.Drawing.Size(170, 25);
            this.txtbx_patientContact.TabIndex = 2;
            this.txtbx_patientContact.Text = "xxx-xxxx";
            this.txtbx_patientContact.Click += new System.EventHandler(this.patientContact_Click);
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label10.Location = new System.Drawing.Point(528, 160);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(76, 17);
            this.label10.TabIndex = 24;
            this.label10.Text = "Blood Type:";
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label9.Location = new System.Drawing.Point(39, 93);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(99, 17);
            this.label9.TabIndex = 19;
            this.label9.Text = "Phone Number:";
            // 
            // cmb_patientBloodType
            // 
            this.cmb_patientBloodType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_patientBloodType.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.cmb_patientBloodType.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_patientBloodType.FormattingEnabled = true;
            this.cmb_patientBloodType.Items.AddRange(new object[] {
            "O-",
            "O+",
            "A-",
            "A+",
            "B-",
            "B+",
            "AB-",
            "AB+"});
            this.cmb_patientBloodType.Location = new System.Drawing.Point(531, 180);
            this.cmb_patientBloodType.Name = "cmb_patientBloodType";
            this.cmb_patientBloodType.Size = new System.Drawing.Size(169, 25);
            this.cmb_patientBloodType.TabIndex = 6;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.Location = new System.Drawing.Point(39, 160);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(84, 17);
            this.label7.TabIndex = 16;
            this.label7.Text = "Date of Birth:";
            // 
            // txtbx_patientAddress
            // 
            this.txtbx_patientAddress.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtbx_patientAddress.Location = new System.Drawing.Point(291, 113);
            this.txtbx_patientAddress.Multiline = true;
            this.txtbx_patientAddress.Name = "txtbx_patientAddress";
            this.txtbx_patientAddress.Size = new System.Drawing.Size(409, 25);
            this.txtbx_patientAddress.TabIndex = 3;
            // 
            // txtbx_patientID
            // 
            this.txtbx_patientID.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtbx_patientID.Location = new System.Drawing.Point(42, 50);
            this.txtbx_patientID.Name = "txtbx_patientID";
            this.txtbx_patientID.ReadOnly = true;
            this.txtbx_patientID.Size = new System.Drawing.Size(170, 25);
            this.txtbx_patientID.TabIndex = 13;
            // 
            // txtbx_patientFName
            // 
            this.txtbx_patientFName.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtbx_patientFName.Location = new System.Drawing.Point(291, 50);
            this.txtbx_patientFName.Name = "txtbx_patientFName";
            this.txtbx_patientFName.Size = new System.Drawing.Size(169, 25);
            this.txtbx_patientFName.TabIndex = 0;
            // 
            // txtbx_patientLName
            // 
            this.txtbx_patientLName.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtbx_patientLName.Location = new System.Drawing.Point(531, 50);
            this.txtbx_patientLName.Name = "txtbx_patientLName";
            this.txtbx_patientLName.Size = new System.Drawing.Size(169, 25);
            this.txtbx_patientLName.TabIndex = 1;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(288, 93);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(59, 17);
            this.label5.TabIndex = 10;
            this.label5.Text = "Address:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(39, 30);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(66, 17);
            this.label3.TabIndex = 3;
            this.label3.Text = "Patient ID:";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(288, 30);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(74, 17);
            this.label1.TabIndex = 2;
            this.label1.Text = "First Name:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(528, 30);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(73, 17);
            this.label2.TabIndex = 1;
            this.label2.Text = "Last Name:";
            // 
            // llbl_allergy
            // 
            this.llbl_allergy.AutoSize = true;
            this.llbl_allergy.Cursor = System.Windows.Forms.Cursors.Hand;
            this.llbl_allergy.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.llbl_allergy.Location = new System.Drawing.Point(496, 509);
            this.llbl_allergy.Name = "llbl_allergy";
            this.llbl_allergy.Size = new System.Drawing.Size(199, 17);
            this.llbl_allergy.TabIndex = 13;
            this.llbl_allergy.TabStop = true;
            this.llbl_allergy.Text = "Click here if patient has allergies.\r\n";
            this.llbl_allergy.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.llbl_allergy_LinkClicked);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(40, 316);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(78, 17);
            this.label4.TabIndex = 42;
            this.label4.Text = "Find Patient:";
            // 
            // txtbx_search
            // 
            this.txtbx_search.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtbx_search.Location = new System.Drawing.Point(160, 313);
            this.txtbx_search.Name = "txtbx_search";
            this.txtbx_search.Size = new System.Drawing.Size(478, 25);
            this.txtbx_search.TabIndex = 11;
            this.txtbx_search.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtbx_search_KeyDown);
            // 
            // btn_findPatient
            // 
            this.btn_findPatient.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_findPatient.FlatAppearance.BorderSize = 0;
            this.btn_findPatient.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_findPatient.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_findPatient.Image = ((System.Drawing.Image)(resources.GetObject("btn_findPatient.Image")));
            this.btn_findPatient.ImageAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btn_findPatient.Location = new System.Drawing.Point(656, 305);
            this.btn_findPatient.Name = "btn_findPatient";
            this.btn_findPatient.Size = new System.Drawing.Size(39, 39);
            this.btn_findPatient.TabIndex = 12;
            this.btn_findPatient.UseVisualStyleBackColor = true;
            this.btn_findPatient.Click += new System.EventHandler(this.btn_findPatient_Click);
            // 
            // cmb_patientSex
            // 
            this.cmb_patientSex.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_patientSex.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.cmb_patientSex.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_patientSex.FormattingEnabled = true;
            this.cmb_patientSex.Items.AddRange(new object[] {
            "Male",
            "Female"});
            this.cmb_patientSex.Location = new System.Drawing.Point(291, 180);
            this.cmb_patientSex.Name = "cmb_patientSex";
            this.cmb_patientSex.Size = new System.Drawing.Size(172, 25);
            this.cmb_patientSex.TabIndex = 5;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(288, 160);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(31, 17);
            this.label6.TabIndex = 58;
            this.label6.Text = "Sex:";
            // 
            // btn_addPatient
            // 
            this.btn_addPatient.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.btn_addPatient.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_addPatient.FlatAppearance.BorderColor = System.Drawing.Color.Green;
            this.btn_addPatient.FlatAppearance.MouseOverBackColor = System.Drawing.Color.LightGreen;
            this.btn_addPatient.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_addPatient.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_addPatient.Location = new System.Drawing.Point(42, 247);
            this.btn_addPatient.Name = "btn_addPatient";
            this.btn_addPatient.Size = new System.Drawing.Size(133, 35);
            this.btn_addPatient.TabIndex = 7;
            this.btn_addPatient.Text = "Add";
            this.btn_addPatient.UseVisualStyleBackColor = false;
            this.btn_addPatient.Click += new System.EventHandler(this.btn_addPatient_Click);
            // 
            // btn_updatePatient
            // 
            this.btn_updatePatient.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.btn_updatePatient.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_updatePatient.FlatAppearance.BorderColor = System.Drawing.Color.Blue;
            this.btn_updatePatient.FlatAppearance.MouseOverBackColor = System.Drawing.Color.LightBlue;
            this.btn_updatePatient.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_updatePatient.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Bold);
            this.btn_updatePatient.Location = new System.Drawing.Point(217, 247);
            this.btn_updatePatient.Name = "btn_updatePatient";
            this.btn_updatePatient.Size = new System.Drawing.Size(133, 35);
            this.btn_updatePatient.TabIndex = 8;
            this.btn_updatePatient.Text = "Update";
            this.btn_updatePatient.UseVisualStyleBackColor = false;
            this.btn_updatePatient.Click += new System.EventHandler(this.btn_updatePatient_Click);
            // 
            // btn_deletePatient
            // 
            this.btn_deletePatient.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.btn_deletePatient.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_deletePatient.FlatAppearance.BorderColor = System.Drawing.Color.Red;
            this.btn_deletePatient.FlatAppearance.MouseOverBackColor = System.Drawing.Color.LightSalmon;
            this.btn_deletePatient.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_deletePatient.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Bold);
            this.btn_deletePatient.Location = new System.Drawing.Point(392, 247);
            this.btn_deletePatient.Name = "btn_deletePatient";
            this.btn_deletePatient.Size = new System.Drawing.Size(133, 35);
            this.btn_deletePatient.TabIndex = 9;
            this.btn_deletePatient.Text = "Delete";
            this.btn_deletePatient.UseVisualStyleBackColor = false;
            this.btn_deletePatient.Click += new System.EventHandler(this.btn_deletePatient_Click);
            // 
            // btn_clearPatient
            // 
            this.btn_clearPatient.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.btn_clearPatient.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_clearPatient.FlatAppearance.BorderColor = System.Drawing.Color.Orange;
            this.btn_clearPatient.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(128)))));
            this.btn_clearPatient.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_clearPatient.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Bold);
            this.btn_clearPatient.Location = new System.Drawing.Point(567, 247);
            this.btn_clearPatient.Name = "btn_clearPatient";
            this.btn_clearPatient.Size = new System.Drawing.Size(133, 35);
            this.btn_clearPatient.TabIndex = 10;
            this.btn_clearPatient.Text = "Clear";
            this.btn_clearPatient.UseVisualStyleBackColor = false;
            this.btn_clearPatient.Click += new System.EventHandler(this.btn_clearPatient_Click);
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.panel1);
            this.groupBox1.Controls.Add(this.txtbx_patientID);
            this.groupBox1.Controls.Add(this.btn_clearPatient);
            this.groupBox1.Controls.Add(this.txtbx_patientAddress);
            this.groupBox1.Controls.Add(this.btn_deletePatient);
            this.groupBox1.Controls.Add(this.label7);
            this.groupBox1.Controls.Add(this.btn_updatePatient);
            this.groupBox1.Controls.Add(this.txtbx_patientFName);
            this.groupBox1.Controls.Add(this.btn_addPatient);
            this.groupBox1.Controls.Add(this.cmb_patientBloodType);
            this.groupBox1.Controls.Add(this.label6);
            this.groupBox1.Controls.Add(this.label9);
            this.groupBox1.Controls.Add(this.cmb_patientSex);
            this.groupBox1.Controls.Add(this.txtbx_patientLName);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.label10);
            this.groupBox1.Controls.Add(this.txtbx_search);
            this.groupBox1.Controls.Add(this.label5);
            this.groupBox1.Controls.Add(this.llbl_allergy);
            this.groupBox1.Controls.Add(this.txtbx_patientContact);
            this.groupBox1.Controls.Add(this.btn_findPatient);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.dtp_patientDOB);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(49, 0);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(752, 543);
            this.groupBox1.TabIndex = 63;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "PATIENT INFORMATION";
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.dgv_findPatient);
            this.panel1.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.panel1.Location = new System.Drawing.Point(4, 348);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(740, 158);
            this.panel1.TabIndex = 63;
            // 
            // dgv_findPatient
            // 
            this.dgv_findPatient.AllowUserToAddRows = false;
            this.dgv_findPatient.AllowUserToDeleteRows = false;
            this.dgv_findPatient.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_findPatient.Location = new System.Drawing.Point(36, 4);
            this.dgv_findPatient.MultiSelect = false;
            this.dgv_findPatient.Name = "dgv_findPatient";
            this.dgv_findPatient.ReadOnly = true;
            this.dgv_findPatient.RowHeadersWidth = 10;
            this.dgv_findPatient.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgv_findPatient.Size = new System.Drawing.Size(658, 151);
            this.dgv_findPatient.TabIndex = 0;
            this.dgv_findPatient.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgv_findPatient_CellClick);
            // 
            // PatientUserControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.groupBox1);
            this.Name = "PatientUserControl";
            this.Size = new System.Drawing.Size(851, 546);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.panel1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgv_findPatient)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DateTimePicker dtp_patientDOB;
        private System.Windows.Forms.TextBox txtbx_patientContact;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.ComboBox cmb_patientBloodType;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox txtbx_patientAddress;
        private System.Windows.Forms.TextBox txtbx_patientFName;
        private System.Windows.Forms.TextBox txtbx_patientLName;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.LinkLabel llbl_allergy;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox txtbx_search;
        private System.Windows.Forms.Button btn_findPatient;
        private System.Windows.Forms.ComboBox cmb_patientSex;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Button btn_addPatient;
        private System.Windows.Forms.Button btn_updatePatient;
        private System.Windows.Forms.Button btn_deletePatient;
        private System.Windows.Forms.Button btn_clearPatient;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.DataGridView dgv_findPatient;
        public System.Windows.Forms.TextBox txtbx_patientID;
    }
}
