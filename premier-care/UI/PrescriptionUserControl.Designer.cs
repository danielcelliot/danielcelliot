namespace PremierCare.UI
{
    partial class PrescriptionUserControl
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(PrescriptionUserControl));
            this.label1 = new System.Windows.Forms.Label();
            this.txtbx_prescID = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.txtbx_dosage = new System.Windows.Forms.TextBox();
            this.txtbx_prescDesc = new System.Windows.Forms.TextBox();
            this.gpb_Prescription = new System.Windows.Forms.GroupBox();
            this.panel1 = new System.Windows.Forms.Panel();
            this.dgv_findPrescription = new System.Windows.Forms.DataGridView();
            this.cmb_prescDrug = new System.Windows.Forms.ComboBox();
            this.cmb_prescDoctor = new System.Windows.Forms.ComboBox();
            this.cmb_prescPatient = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.txtbx_findPrescription = new System.Windows.Forms.TextBox();
            this.btn_findPrescription = new System.Windows.Forms.Button();
            this.btn_clearPrescription = new System.Windows.Forms.Button();
            this.btn_deletePrescription = new System.Windows.Forms.Button();
            this.btn_updatePrescription = new System.Windows.Forms.Button();
            this.btn_addPrescription = new System.Windows.Forms.Button();
            this.label9 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.txtbx_prescPeriod = new System.Windows.Forms.TextBox();
            this.gpb_Prescription.SuspendLayout();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_findPrescription)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(39, 30);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(96, 17);
            this.label1.TabIndex = 46;
            this.label1.Text = "Prescription ID:";
            // 
            // txtbx_prescID
            // 
            this.txtbx_prescID.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtbx_prescID.Location = new System.Drawing.Point(42, 50);
            this.txtbx_prescID.Name = "txtbx_prescID";
            this.txtbx_prescID.ReadOnly = true;
            this.txtbx_prescID.Size = new System.Drawing.Size(170, 25);
            this.txtbx_prescID.TabIndex = 47;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(288, 30);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(40, 17);
            this.label2.TabIndex = 48;
            this.label2.Text = "Drug:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(39, 93);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(51, 17);
            this.label3.TabIndex = 50;
            this.label3.Text = "Doctor:";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.Location = new System.Drawing.Point(531, 93);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(56, 17);
            this.label7.TabIndex = 54;
            this.label7.Text = "Dosage:";
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label8.Location = new System.Drawing.Point(39, 160);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(77, 17);
            this.label8.TabIndex = 55;
            this.label8.Text = "Description:";
            // 
            // txtbx_dosage
            // 
            this.txtbx_dosage.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtbx_dosage.Location = new System.Drawing.Point(531, 113);
            this.txtbx_dosage.Name = "txtbx_dosage";
            this.txtbx_dosage.Size = new System.Drawing.Size(170, 25);
            this.txtbx_dosage.TabIndex = 5;
            // 
            // txtbx_prescDesc
            // 
            this.txtbx_prescDesc.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtbx_prescDesc.Location = new System.Drawing.Point(42, 180);
            this.txtbx_prescDesc.Multiline = true;
            this.txtbx_prescDesc.Name = "txtbx_prescDesc";
            this.txtbx_prescDesc.Size = new System.Drawing.Size(659, 25);
            this.txtbx_prescDesc.TabIndex = 6;
            // 
            // gpb_Prescription
            // 
            this.gpb_Prescription.Controls.Add(this.panel1);
            this.gpb_Prescription.Controls.Add(this.cmb_prescDrug);
            this.gpb_Prescription.Controls.Add(this.cmb_prescDoctor);
            this.gpb_Prescription.Controls.Add(this.cmb_prescPatient);
            this.gpb_Prescription.Controls.Add(this.label4);
            this.gpb_Prescription.Controls.Add(this.txtbx_findPrescription);
            this.gpb_Prescription.Controls.Add(this.btn_findPrescription);
            this.gpb_Prescription.Controls.Add(this.btn_clearPrescription);
            this.gpb_Prescription.Controls.Add(this.btn_deletePrescription);
            this.gpb_Prescription.Controls.Add(this.btn_updatePrescription);
            this.gpb_Prescription.Controls.Add(this.btn_addPrescription);
            this.gpb_Prescription.Controls.Add(this.label9);
            this.gpb_Prescription.Controls.Add(this.label5);
            this.gpb_Prescription.Controls.Add(this.txtbx_prescPeriod);
            this.gpb_Prescription.Controls.Add(this.txtbx_prescID);
            this.gpb_Prescription.Controls.Add(this.label3);
            this.gpb_Prescription.Controls.Add(this.label7);
            this.gpb_Prescription.Controls.Add(this.label1);
            this.gpb_Prescription.Controls.Add(this.txtbx_prescDesc);
            this.gpb_Prescription.Controls.Add(this.label8);
            this.gpb_Prescription.Controls.Add(this.label2);
            this.gpb_Prescription.Controls.Add(this.txtbx_dosage);
            this.gpb_Prescription.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.gpb_Prescription.Location = new System.Drawing.Point(49, 0);
            this.gpb_Prescription.Name = "gpb_Prescription";
            this.gpb_Prescription.Size = new System.Drawing.Size(752, 543);
            this.gpb_Prescription.TabIndex = 58;
            this.gpb_Prescription.TabStop = false;
            this.gpb_Prescription.Text = "PRESCRIPTION INFORMATION";
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.dgv_findPrescription);
            this.panel1.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.panel1.Location = new System.Drawing.Point(4, 348);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(740, 189);
            this.panel1.TabIndex = 99;
            // 
            // dgv_findPrescription
            // 
            this.dgv_findPrescription.AllowUserToAddRows = false;
            this.dgv_findPrescription.AllowUserToDeleteRows = false;
            this.dgv_findPrescription.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_findPrescription.Location = new System.Drawing.Point(36, 4);
            this.dgv_findPrescription.MultiSelect = false;
            this.dgv_findPrescription.Name = "dgv_findPrescription";
            this.dgv_findPrescription.ReadOnly = true;
            this.dgv_findPrescription.RowHeadersWidth = 10;
            this.dgv_findPrescription.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgv_findPrescription.Size = new System.Drawing.Size(658, 169);
            this.dgv_findPrescription.TabIndex = 13;
            this.dgv_findPrescription.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgv_findPrescription_CellClick);
            // 
            // cmb_prescDrug
            // 
            this.cmb_prescDrug.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_prescDrug.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.cmb_prescDrug.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_prescDrug.FormattingEnabled = true;
            this.cmb_prescDrug.Location = new System.Drawing.Point(291, 50);
            this.cmb_prescDrug.Name = "cmb_prescDrug";
            this.cmb_prescDrug.Size = new System.Drawing.Size(170, 25);
            this.cmb_prescDrug.TabIndex = 1;
            // 
            // cmb_prescDoctor
            // 
            this.cmb_prescDoctor.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_prescDoctor.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.cmb_prescDoctor.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_prescDoctor.FormattingEnabled = true;
            this.cmb_prescDoctor.Location = new System.Drawing.Point(42, 113);
            this.cmb_prescDoctor.Name = "cmb_prescDoctor";
            this.cmb_prescDoctor.Size = new System.Drawing.Size(170, 25);
            this.cmb_prescDoctor.TabIndex = 3;
            // 
            // cmb_prescPatient
            // 
            this.cmb_prescPatient.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_prescPatient.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.cmb_prescPatient.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_prescPatient.FormattingEnabled = true;
            this.cmb_prescPatient.Location = new System.Drawing.Point(531, 50);
            this.cmb_prescPatient.Name = "cmb_prescPatient";
            this.cmb_prescPatient.Size = new System.Drawing.Size(170, 25);
            this.cmb_prescPatient.TabIndex = 2;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(40, 316);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(108, 17);
            this.label4.TabIndex = 92;
            this.label4.Text = "Find Prescription:";
            // 
            // txtbx_findPrescription
            // 
            this.txtbx_findPrescription.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtbx_findPrescription.Location = new System.Drawing.Point(160, 313);
            this.txtbx_findPrescription.Name = "txtbx_findPrescription";
            this.txtbx_findPrescription.Size = new System.Drawing.Size(478, 25);
            this.txtbx_findPrescription.TabIndex = 11;
            this.txtbx_findPrescription.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtbx_findPrescription_KeyDown);
            // 
            // btn_findPrescription
            // 
            this.btn_findPrescription.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_findPrescription.FlatAppearance.BorderSize = 0;
            this.btn_findPrescription.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_findPrescription.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_findPrescription.Image = ((System.Drawing.Image)(resources.GetObject("btn_findPrescription.Image")));
            this.btn_findPrescription.ImageAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btn_findPrescription.Location = new System.Drawing.Point(656, 305);
            this.btn_findPrescription.Name = "btn_findPrescription";
            this.btn_findPrescription.Size = new System.Drawing.Size(39, 39);
            this.btn_findPrescription.TabIndex = 12;
            this.btn_findPrescription.UseVisualStyleBackColor = true;
            this.btn_findPrescription.Click += new System.EventHandler(this.btn_findPrescription_Click);
            // 
            // btn_clearPrescription
            // 
            this.btn_clearPrescription.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.btn_clearPrescription.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_clearPrescription.FlatAppearance.BorderColor = System.Drawing.Color.Orange;
            this.btn_clearPrescription.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(128)))));
            this.btn_clearPrescription.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_clearPrescription.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Bold);
            this.btn_clearPrescription.Location = new System.Drawing.Point(567, 247);
            this.btn_clearPrescription.Name = "btn_clearPrescription";
            this.btn_clearPrescription.Size = new System.Drawing.Size(133, 35);
            this.btn_clearPrescription.TabIndex = 10;
            this.btn_clearPrescription.Text = "Clear";
            this.btn_clearPrescription.UseVisualStyleBackColor = false;
            this.btn_clearPrescription.Click += new System.EventHandler(this.btn_clearPrescription_Click);
            // 
            // btn_deletePrescription
            // 
            this.btn_deletePrescription.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.btn_deletePrescription.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_deletePrescription.FlatAppearance.BorderColor = System.Drawing.Color.Red;
            this.btn_deletePrescription.FlatAppearance.MouseOverBackColor = System.Drawing.Color.LightSalmon;
            this.btn_deletePrescription.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_deletePrescription.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Bold);
            this.btn_deletePrescription.Location = new System.Drawing.Point(392, 247);
            this.btn_deletePrescription.Name = "btn_deletePrescription";
            this.btn_deletePrescription.Size = new System.Drawing.Size(133, 35);
            this.btn_deletePrescription.TabIndex = 9;
            this.btn_deletePrescription.Text = "Delete";
            this.btn_deletePrescription.UseVisualStyleBackColor = false;
            this.btn_deletePrescription.Click += new System.EventHandler(this.btn_deletePrescription_Click);
            // 
            // btn_updatePrescription
            // 
            this.btn_updatePrescription.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.btn_updatePrescription.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_updatePrescription.FlatAppearance.BorderColor = System.Drawing.Color.Blue;
            this.btn_updatePrescription.FlatAppearance.MouseOverBackColor = System.Drawing.Color.LightBlue;
            this.btn_updatePrescription.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_updatePrescription.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Bold);
            this.btn_updatePrescription.Location = new System.Drawing.Point(217, 247);
            this.btn_updatePrescription.Name = "btn_updatePrescription";
            this.btn_updatePrescription.Size = new System.Drawing.Size(133, 35);
            this.btn_updatePrescription.TabIndex = 8;
            this.btn_updatePrescription.Text = "Update";
            this.btn_updatePrescription.UseVisualStyleBackColor = false;
            this.btn_updatePrescription.Click += new System.EventHandler(this.btn_updatePrescription_Click);
            // 
            // btn_addPrescription
            // 
            this.btn_addPrescription.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.btn_addPrescription.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_addPrescription.FlatAppearance.BorderColor = System.Drawing.Color.Green;
            this.btn_addPrescription.FlatAppearance.MouseOverBackColor = System.Drawing.Color.LightGreen;
            this.btn_addPrescription.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_addPrescription.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_addPrescription.Location = new System.Drawing.Point(42, 247);
            this.btn_addPrescription.Name = "btn_addPrescription";
            this.btn_addPrescription.Size = new System.Drawing.Size(133, 35);
            this.btn_addPrescription.TabIndex = 7;
            this.btn_addPrescription.Text = "Add";
            this.btn_addPrescription.UseVisualStyleBackColor = false;
            this.btn_addPrescription.Click += new System.EventHandler(this.btn_addPrescription_Click_1);
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label9.Location = new System.Drawing.Point(528, 30);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(50, 17);
            this.label9.TabIndex = 69;
            this.label9.Text = "Patient:";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(288, 93);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(49, 17);
            this.label5.TabIndex = 60;
            this.label5.Text = "Period:";
            // 
            // txtbx_prescPeriod
            // 
            this.txtbx_prescPeriod.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtbx_prescPeriod.Location = new System.Drawing.Point(291, 113);
            this.txtbx_prescPeriod.Name = "txtbx_prescPeriod";
            this.txtbx_prescPeriod.Size = new System.Drawing.Size(170, 25);
            this.txtbx_prescPeriod.TabIndex = 4;
            // 
            // PrescriptionUserControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.gpb_Prescription);
            this.Name = "PrescriptionUserControl";
            this.Size = new System.Drawing.Size(851, 546);
            this.Load += new System.EventHandler(this.PrescriptionUserControl_Load);
            this.gpb_Prescription.ResumeLayout(false);
            this.gpb_Prescription.PerformLayout();
            this.panel1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgv_findPrescription)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtbx_prescID;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.TextBox txtbx_dosage;
        private System.Windows.Forms.TextBox txtbx_prescDesc;
        private System.Windows.Forms.GroupBox gpb_Prescription;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox txtbx_prescPeriod;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Button btn_clearPrescription;
        private System.Windows.Forms.Button btn_deletePrescription;
        private System.Windows.Forms.Button btn_updatePrescription;
        private System.Windows.Forms.Button btn_addPrescription;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox txtbx_findPrescription;
        private System.Windows.Forms.Button btn_findPrescription;
        private System.Windows.Forms.ComboBox cmb_prescDrug;
        private System.Windows.Forms.ComboBox cmb_prescDoctor;
        private System.Windows.Forms.ComboBox cmb_prescPatient;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.DataGridView dgv_findPrescription;
    }
}
