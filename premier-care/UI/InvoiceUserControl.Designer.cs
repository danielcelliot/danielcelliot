namespace PremierCare.UI
{
    partial class InvoiceUserControl
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(InvoiceUserControl));
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.panel1 = new System.Windows.Forms.Panel();
            this.lbl_ValueInDollars = new System.Windows.Forms.Label();
            this.lbl_InvoiceTotal = new System.Windows.Forms.Label();
            this.btn_printInvoice = new System.Windows.Forms.Button();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.lbl_Discount = new System.Windows.Forms.Label();
            this.lbx_prescription = new System.Windows.Forms.ListBox();
            this.lbx_services = new System.Windows.Forms.ListBox();
            this.lbl_prescriptions = new System.Windows.Forms.Label();
            this.panel2 = new System.Windows.Forms.Panel();
            this.dgv_findInvoice = new System.Windows.Forms.DataGridView();
            this.lbl_servces = new System.Windows.Forms.Label();
            this.lblTotalValue = new System.Windows.Forms.Label();
            this.cmb_invoicePatient = new System.Windows.Forms.ComboBox();
            this.label5 = new System.Windows.Forms.Label();
            this.txtbx_csrID = new System.Windows.Forms.TextBox();
            this.btn_saveToFile = new System.Windows.Forms.Button();
            this.label4 = new System.Windows.Forms.Label();
            this.txtbx_findInvoice = new System.Windows.Forms.TextBox();
            this.btn_findInvoice = new System.Windows.Forms.Button();
            this.btn_clearInvoice = new System.Windows.Forms.Button();
            this.btn_deleteInvoice = new System.Windows.Forms.Button();
            this.btn_addInvoice = new System.Windows.Forms.Button();
            this.label6 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.dtp_invoiceDate = new System.Windows.Forms.DateTimePicker();
            this.txtbx_invoiceID = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.groupBox1.SuspendLayout();
            this.panel1.SuspendLayout();
            this.panel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_findInvoice)).BeginInit();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.panel1);
            this.groupBox1.Controls.Add(this.btn_printInvoice);
            this.groupBox1.Controls.Add(this.textBox1);
            this.groupBox1.Controls.Add(this.lbl_Discount);
            this.groupBox1.Controls.Add(this.lbx_prescription);
            this.groupBox1.Controls.Add(this.lbx_services);
            this.groupBox1.Controls.Add(this.lbl_prescriptions);
            this.groupBox1.Controls.Add(this.panel2);
            this.groupBox1.Controls.Add(this.lbl_servces);
            this.groupBox1.Controls.Add(this.lblTotalValue);
            this.groupBox1.Controls.Add(this.cmb_invoicePatient);
            this.groupBox1.Controls.Add(this.label5);
            this.groupBox1.Controls.Add(this.txtbx_csrID);
            this.groupBox1.Controls.Add(this.btn_saveToFile);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.txtbx_findInvoice);
            this.groupBox1.Controls.Add(this.btn_findInvoice);
            this.groupBox1.Controls.Add(this.btn_clearInvoice);
            this.groupBox1.Controls.Add(this.btn_deleteInvoice);
            this.groupBox1.Controls.Add(this.btn_addInvoice);
            this.groupBox1.Controls.Add(this.label6);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.dtp_invoiceDate);
            this.groupBox1.Controls.Add(this.txtbx_invoiceID);
            this.groupBox1.Controls.Add(this.label7);
            this.groupBox1.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(49, 0);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(752, 543);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "INVOICE INFORMATION";
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.White;
            this.panel1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel1.Controls.Add(this.lbl_ValueInDollars);
            this.panel1.Controls.Add(this.lbl_InvoiceTotal);
            this.panel1.Location = new System.Drawing.Point(40, 494);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(133, 25);
            this.panel1.TabIndex = 109;
            // 
            // lbl_ValueInDollars
            // 
            this.lbl_ValueInDollars.AutoSize = true;
            this.lbl_ValueInDollars.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_ValueInDollars.Location = new System.Drawing.Point(47, 3);
            this.lbl_ValueInDollars.Name = "lbl_ValueInDollars";
            this.lbl_ValueInDollars.Size = new System.Drawing.Size(39, 17);
            this.lbl_ValueInDollars.TabIndex = 105;
            this.lbl_ValueInDollars.Text = "$0.00";
            // 
            // lbl_InvoiceTotal
            // 
            this.lbl_InvoiceTotal.AutoSize = true;
            this.lbl_InvoiceTotal.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_InvoiceTotal.Location = new System.Drawing.Point(3, 3);
            this.lbl_InvoiceTotal.Name = "lbl_InvoiceTotal";
            this.lbl_InvoiceTotal.Size = new System.Drawing.Size(43, 17);
            this.lbl_InvoiceTotal.TabIndex = 104;
            this.lbl_InvoiceTotal.Text = "Total:";
            // 
            // btn_printInvoice
            // 
            this.btn_printInvoice.BackColor = System.Drawing.SystemColors.ControlLight;
            this.btn_printInvoice.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_printInvoice.FlatAppearance.BorderColor = System.Drawing.Color.Gray;
            this.btn_printInvoice.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Snow;
            this.btn_printInvoice.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_printInvoice.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_printInvoice.Location = new System.Drawing.Point(415, 494);
            this.btn_printInvoice.Name = "btn_printInvoice";
            this.btn_printInvoice.Size = new System.Drawing.Size(133, 25);
            this.btn_printInvoice.TabIndex = 108;
            this.btn_printInvoice.Text = "Print Invoice";
            this.btn_printInvoice.UseVisualStyleBackColor = false;
            this.btn_printInvoice.Click += new System.EventHandler(this.btn_printInvoice_Click);
            // 
            // textBox1
            // 
            this.textBox1.Enabled = false;
            this.textBox1.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textBox1.Location = new System.Drawing.Point(528, 50);
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(170, 25);
            this.textBox1.TabIndex = 107;
            // 
            // lbl_Discount
            // 
            this.lbl_Discount.AutoSize = true;
            this.lbl_Discount.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_Discount.Location = new System.Drawing.Point(525, 30);
            this.lbl_Discount.Name = "lbl_Discount";
            this.lbl_Discount.Size = new System.Drawing.Size(84, 17);
            this.lbl_Discount.TabIndex = 106;
            this.lbl_Discount.Text = "Discount (%):";
            // 
            // lbx_prescription
            // 
            this.lbx_prescription.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbx_prescription.FormattingEnabled = true;
            this.lbx_prescription.ItemHeight = 17;
            this.lbx_prescription.Location = new System.Drawing.Point(291, 180);
            this.lbx_prescription.Name = "lbx_prescription";
            this.lbx_prescription.SelectionMode = System.Windows.Forms.SelectionMode.MultiSimple;
            this.lbx_prescription.Size = new System.Drawing.Size(170, 106);
            this.lbx_prescription.TabIndex = 5;
            this.lbx_prescription.SelectedIndexChanged += new System.EventHandler(this.lbx_prescription_SelectedIndexChanged);
            // 
            // lbx_services
            // 
            this.lbx_services.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbx_services.FormattingEnabled = true;
            this.lbx_services.ItemHeight = 17;
            this.lbx_services.Location = new System.Drawing.Point(42, 180);
            this.lbx_services.Name = "lbx_services";
            this.lbx_services.SelectionMode = System.Windows.Forms.SelectionMode.MultiSimple;
            this.lbx_services.Size = new System.Drawing.Size(169, 106);
            this.lbx_services.TabIndex = 4;
            this.lbx_services.SelectedIndexChanged += new System.EventHandler(this.lbx_services_SelectedIndexChanged);
            // 
            // lbl_prescriptions
            // 
            this.lbl_prescriptions.AutoSize = true;
            this.lbl_prescriptions.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_prescriptions.Location = new System.Drawing.Point(288, 160);
            this.lbl_prescriptions.Name = "lbl_prescriptions";
            this.lbl_prescriptions.Size = new System.Drawing.Size(86, 17);
            this.lbl_prescriptions.TabIndex = 71;
            this.lbl_prescriptions.Text = "Prescriptions:";
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.dgv_findInvoice);
            this.panel2.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.panel2.Location = new System.Drawing.Point(4, 348);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(740, 144);
            this.panel2.TabIndex = 103;
            // 
            // dgv_findInvoice
            // 
            this.dgv_findInvoice.AllowUserToAddRows = false;
            this.dgv_findInvoice.AllowUserToDeleteRows = false;
            this.dgv_findInvoice.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_findInvoice.Location = new System.Drawing.Point(36, 4);
            this.dgv_findInvoice.MultiSelect = false;
            this.dgv_findInvoice.Name = "dgv_findInvoice";
            this.dgv_findInvoice.ReadOnly = true;
            this.dgv_findInvoice.RowHeadersWidth = 10;
            this.dgv_findInvoice.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgv_findInvoice.Size = new System.Drawing.Size(658, 126);
            this.dgv_findInvoice.TabIndex = 12;
            this.dgv_findInvoice.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgv_findInvoice_CellClick);
            // 
            // lbl_servces
            // 
            this.lbl_servces.AutoSize = true;
            this.lbl_servces.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_servces.Location = new System.Drawing.Point(39, 160);
            this.lbl_servces.Name = "lbl_servces";
            this.lbl_servces.Size = new System.Drawing.Size(58, 17);
            this.lbl_servces.TabIndex = 70;
            this.lbl_servces.Text = "Services:";
            // 
            // lblTotalValue
            // 
            this.lblTotalValue.AutoSize = true;
            this.lblTotalValue.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblTotalValue.Location = new System.Drawing.Point(99, 502);
            this.lblTotalValue.Name = "lblTotalValue";
            this.lblTotalValue.Size = new System.Drawing.Size(0, 17);
            this.lblTotalValue.TabIndex = 101;
            // 
            // cmb_invoicePatient
            // 
            this.cmb_invoicePatient.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_invoicePatient.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.cmb_invoicePatient.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_invoicePatient.FormattingEnabled = true;
            this.cmb_invoicePatient.Location = new System.Drawing.Point(42, 113);
            this.cmb_invoicePatient.Name = "cmb_invoicePatient";
            this.cmb_invoicePatient.Size = new System.Drawing.Size(172, 25);
            this.cmb_invoicePatient.TabIndex = 2;
            this.cmb_invoicePatient.DropDownClosed += new System.EventHandler(this.cmb_invoicePatient_DropDownClosed);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(288, 30);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(50, 17);
            this.label5.TabIndex = 97;
            this.label5.Text = "CSR ID:";
            // 
            // txtbx_csrID
            // 
            this.txtbx_csrID.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtbx_csrID.Location = new System.Drawing.Point(291, 50);
            this.txtbx_csrID.Name = "txtbx_csrID";
            this.txtbx_csrID.Size = new System.Drawing.Size(170, 25);
            this.txtbx_csrID.TabIndex = 1;
            // 
            // btn_saveToFile
            // 
            this.btn_saveToFile.BackColor = System.Drawing.SystemColors.ControlLight;
            this.btn_saveToFile.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_saveToFile.FlatAppearance.BorderColor = System.Drawing.Color.Gray;
            this.btn_saveToFile.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Snow;
            this.btn_saveToFile.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_saveToFile.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_saveToFile.Location = new System.Drawing.Point(565, 494);
            this.btn_saveToFile.Name = "btn_saveToFile";
            this.btn_saveToFile.Size = new System.Drawing.Size(133, 25);
            this.btn_saveToFile.TabIndex = 13;
            this.btn_saveToFile.Text = "Save To File (.txt)";
            this.btn_saveToFile.UseVisualStyleBackColor = false;
            this.btn_saveToFile.Click += new System.EventHandler(this.btn_saveToFile_Click);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(40, 316);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(79, 17);
            this.label4.TabIndex = 92;
            this.label4.Text = "Find Invoice:";
            // 
            // txtbx_findInvoice
            // 
            this.txtbx_findInvoice.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtbx_findInvoice.Location = new System.Drawing.Point(160, 313);
            this.txtbx_findInvoice.Name = "txtbx_findInvoice";
            this.txtbx_findInvoice.Size = new System.Drawing.Size(478, 25);
            this.txtbx_findInvoice.TabIndex = 10;
            this.txtbx_findInvoice.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtbx_findInvoice_KeyDown);
            // 
            // btn_findInvoice
            // 
            this.btn_findInvoice.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_findInvoice.FlatAppearance.BorderSize = 0;
            this.btn_findInvoice.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_findInvoice.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_findInvoice.Image = ((System.Drawing.Image)(resources.GetObject("btn_findInvoice.Image")));
            this.btn_findInvoice.ImageAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btn_findInvoice.Location = new System.Drawing.Point(656, 305);
            this.btn_findInvoice.Name = "btn_findInvoice";
            this.btn_findInvoice.Size = new System.Drawing.Size(39, 39);
            this.btn_findInvoice.TabIndex = 11;
            this.btn_findInvoice.UseVisualStyleBackColor = true;
            this.btn_findInvoice.Click += new System.EventHandler(this.btn_findInvoice_Click);
            // 
            // btn_clearInvoice
            // 
            this.btn_clearInvoice.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.btn_clearInvoice.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_clearInvoice.FlatAppearance.BorderColor = System.Drawing.Color.Orange;
            this.btn_clearInvoice.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(128)))));
            this.btn_clearInvoice.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_clearInvoice.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Bold);
            this.btn_clearInvoice.Location = new System.Drawing.Point(546, 251);
            this.btn_clearInvoice.Name = "btn_clearInvoice";
            this.btn_clearInvoice.Size = new System.Drawing.Size(133, 35);
            this.btn_clearInvoice.TabIndex = 9;
            this.btn_clearInvoice.Text = "Clear";
            this.btn_clearInvoice.UseVisualStyleBackColor = false;
            this.btn_clearInvoice.Click += new System.EventHandler(this.btn_clearInvoice_Click);
            // 
            // btn_deleteInvoice
            // 
            this.btn_deleteInvoice.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.btn_deleteInvoice.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_deleteInvoice.FlatAppearance.BorderColor = System.Drawing.Color.Red;
            this.btn_deleteInvoice.FlatAppearance.MouseOverBackColor = System.Drawing.Color.LightSalmon;
            this.btn_deleteInvoice.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_deleteInvoice.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Bold);
            this.btn_deleteInvoice.Location = new System.Drawing.Point(546, 180);
            this.btn_deleteInvoice.Name = "btn_deleteInvoice";
            this.btn_deleteInvoice.Size = new System.Drawing.Size(133, 35);
            this.btn_deleteInvoice.TabIndex = 8;
            this.btn_deleteInvoice.Text = "Delete";
            this.btn_deleteInvoice.UseVisualStyleBackColor = false;
            this.btn_deleteInvoice.Click += new System.EventHandler(this.btn_deleteInvoice_Click);
            // 
            // btn_addInvoice
            // 
            this.btn_addInvoice.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.btn_addInvoice.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn_addInvoice.FlatAppearance.BorderColor = System.Drawing.Color.Green;
            this.btn_addInvoice.FlatAppearance.MouseOverBackColor = System.Drawing.Color.LightGreen;
            this.btn_addInvoice.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn_addInvoice.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_addInvoice.Location = new System.Drawing.Point(546, 110);
            this.btn_addInvoice.Name = "btn_addInvoice";
            this.btn_addInvoice.Size = new System.Drawing.Size(133, 35);
            this.btn_addInvoice.TabIndex = 6;
            this.btn_addInvoice.Text = "Add";
            this.btn_addInvoice.UseVisualStyleBackColor = false;
            this.btn_addInvoice.Click += new System.EventHandler(this.btn_addInvoice_Click_1);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(288, 93);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(38, 17);
            this.label6.TabIndex = 64;
            this.label6.Text = "Date:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(39, 30);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(67, 17);
            this.label3.TabIndex = 62;
            this.label3.Text = "Invoice ID:";
            // 
            // dtp_invoiceDate
            // 
            this.dtp_invoiceDate.CalendarFont = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtp_invoiceDate.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtp_invoiceDate.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtp_invoiceDate.Location = new System.Drawing.Point(291, 113);
            this.dtp_invoiceDate.Name = "dtp_invoiceDate";
            this.dtp_invoiceDate.Size = new System.Drawing.Size(170, 25);
            this.dtp_invoiceDate.TabIndex = 3;
            // 
            // txtbx_invoiceID
            // 
            this.txtbx_invoiceID.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtbx_invoiceID.Location = new System.Drawing.Point(42, 50);
            this.txtbx_invoiceID.Name = "txtbx_invoiceID";
            this.txtbx_invoiceID.ReadOnly = true;
            this.txtbx_invoiceID.Size = new System.Drawing.Size(170, 25);
            this.txtbx_invoiceID.TabIndex = 63;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.Location = new System.Drawing.Point(39, 93);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(50, 17);
            this.label7.TabIndex = 57;
            this.label7.Text = "Patient:";
            // 
            // InvoiceUserControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.groupBox1);
            this.Name = "InvoiceUserControl";
            this.Size = new System.Drawing.Size(851, 546);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgv_findInvoice)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.DateTimePicker dtp_invoiceDate;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txtbx_invoiceID;
        private System.Windows.Forms.Label lbl_prescriptions;
        private System.Windows.Forms.Button btn_clearInvoice;
        private System.Windows.Forms.Button btn_deleteInvoice;
        private System.Windows.Forms.Button btn_addInvoice;
        private System.Windows.Forms.Button btn_saveToFile;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox txtbx_findInvoice;
        private System.Windows.Forms.Button btn_findInvoice;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox txtbx_csrID;
        private System.Windows.Forms.ComboBox cmb_invoicePatient;
        private System.Windows.Forms.Label lblTotalValue;
        private System.Windows.Forms.ListBox lbx_prescription;
        private System.Windows.Forms.ListBox lbx_services;
        private System.Windows.Forms.Label lbl_servces;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.DataGridView dgv_findInvoice;
        private System.Windows.Forms.Label lbl_ValueInDollars;
        private System.Windows.Forms.Label lbl_InvoiceTotal;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.Label lbl_Discount;
        private System.Windows.Forms.Button btn_printInvoice;
        private System.Windows.Forms.Panel panel1;
    }
}
