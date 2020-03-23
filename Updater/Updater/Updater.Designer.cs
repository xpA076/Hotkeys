namespace Updater
{
    partial class Updater
    {
        /// <summary>
        /// 必需的设计器变量。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清理所有正在使用的资源。
        /// </summary>
        /// <param name="disposing">如果应释放托管资源，为 true；否则为 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows 窗体设计器生成的代码

        /// <summary>
        /// 设计器支持所需的方法 - 不要修改
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent()
        {
            this.label1 = new System.Windows.Forms.Label();
            this.label01 = new System.Windows.Forms.Label();
            this.label02 = new System.Windows.Forms.Label();
            this.label03 = new System.Windows.Forms.Label();
            this.label04 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("微软雅黑", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.label1.ForeColor = System.Drawing.SystemColors.Control;
            this.label1.Location = new System.Drawing.Point(12, 19);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(177, 22);
            this.label1.TabIndex = 0;
            this.label1.Text = "Updating: AhkSetter";
            // 
            // label01
            // 
            this.label01.AutoSize = true;
            this.label01.Font = new System.Drawing.Font("宋体", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.label01.ForeColor = System.Drawing.Color.White;
            this.label01.Location = new System.Drawing.Point(51, 51);
            this.label01.Name = "label01";
            this.label01.Size = new System.Drawing.Size(192, 16);
            this.label01.TabIndex = 1;
            this.label01.Text = "1. killing process ... ";
            // 
            // label02
            // 
            this.label02.AutoSize = true;
            this.label02.Font = new System.Drawing.Font("宋体", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.label02.ForeColor = System.Drawing.Color.White;
            this.label02.Location = new System.Drawing.Point(51, 81);
            this.label02.Name = "label02";
            this.label02.Size = new System.Drawing.Size(152, 16);
            this.label02.TabIndex = 1;
            this.label02.Text = "2. delete exe ... ";
            // 
            // label03
            // 
            this.label03.AutoSize = true;
            this.label03.Font = new System.Drawing.Font("宋体", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.label03.ForeColor = System.Drawing.Color.White;
            this.label03.Location = new System.Drawing.Point(51, 111);
            this.label03.Name = "label03";
            this.label03.Size = new System.Drawing.Size(184, 16);
            this.label03.TabIndex = 1;
            this.label03.Text = "3. downloading exe ...";
            // 
            // label04
            // 
            this.label04.AutoSize = true;
            this.label04.Font = new System.Drawing.Font("宋体", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.label04.ForeColor = System.Drawing.Color.White;
            this.label04.Location = new System.Drawing.Point(51, 141);
            this.label04.Name = "label04";
            this.label04.Size = new System.Drawing.Size(160, 16);
            this.label04.TabIndex = 1;
            this.label04.Text = "4. starting exe ...";
            // 
            // Updater
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.ClientSize = new System.Drawing.Size(348, 179);
            this.Controls.Add(this.label04);
            this.Controls.Add(this.label03);
            this.Controls.Add(this.label02);
            this.Controls.Add(this.label01);
            this.Controls.Add(this.label1);
            this.Name = "Updater";
            this.Opacity = 0.8D;
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Form1";
            this.Shown += new System.EventHandler(this.Updater_Shown);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label01;
        private System.Windows.Forms.Label label02;
        private System.Windows.Forms.Label label03;
        private System.Windows.Forms.Label label04;
    }
}

