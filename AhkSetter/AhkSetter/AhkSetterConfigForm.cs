using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml.Linq;

namespace AhkSetter
{
    public partial class AhkSetterConfigForm : Form
    {
        private AhkSetter parent;
        public AhkSetterConfigForm(AhkSetter parent)
        {
            InitializeComponent();
            this.parent = parent;
        }

        private void buttonPath_Click(object sender, EventArgs e)
        {
            if (this.folderBrowserDialog1.ShowDialog() == DialogResult.OK)
            {
                this.textBoxPath.Text = this.folderBrowserDialog1.SelectedPath;
            }
        }

        private void buttonSet_Click(object sender, EventArgs e)
        {
            try
            {
                XDocument doc = XDocument.Load(Application.StartupPath + "\\AhkSetter.config");
                XElement root = doc.Root;
                root.Element("ahkPath").SetAttributeValue("path", this.textBoxPath.Text);
                root.Element("user").SetElementValue("username", this.textBoxUsername.Text);
                root.Element("user").SetElementValue("password", this.textBoxPassword.Text);
                root.Save(Application.StartupPath + "\\AhkSetter.config");
                this.parent.loadNames();
                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void AhkSetterConfigForm_Load(object sender, EventArgs e)
        {
            try
            {
                XDocument doc = XDocument.Load(Application.StartupPath + "\\AhkSetter.config");
                XElement root = doc.Root;
                this.textBoxPath.Text = root.Element("ahkPath").Attribute("path").Value;
                this.textBoxUsername.Text = root.Element("user").Element("username").Value;
                this.textBoxPassword.Text = root.Element("user").Element("password").Value;
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
