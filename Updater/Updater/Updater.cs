using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;
using System.Net;

namespace Updater
{

    public partial class Updater : Form
    {
        private const string host = "http://server.hhcsdtc.com:9999";       // 结尾不能带"/"

        public Updater(string name)
        {
            InitializeComponent();
            exeName = name;
            this.label1.Text = "Updating: " + name;
            this.FormBorderStyle = FormBorderStyle.None;
            this.label01.Visible = false;
            this.label02.Visible = false;
            this.label03.Visible = false;
            this.label04.Visible = false;
        }

        private string exeName = "";


        private void Updater_Shown(object sender, EventArgs e)
        {
            Task.Run(() =>
            {
                int sleep = 1000;

                // kill old window process (if exists)
                this.Invoke(new MethodInvoker(()=> {
                    this.label01.Text = "1. Killing process " + exeName + ".exe ...";
                    this.label01.Visible = true;
                    this.Update();
                }));
                Process[] procList = Process.GetProcessesByName(exeName);
                foreach (Process p in procList)
                {
                    if (true)
                    {
                        p.Kill();
                    }
                }
                Thread.Sleep(sleep);

                // delete old exe
                this.Invoke(new MethodInvoker(() => {
                    this.label02.Text = "2. Deleting " + exeName + ".exe ...";
                    this.label02.Visible = true;
                    this.Update();
                }));
                string exePath = Path.Combine(Application.StartupPath, exeName + ".exe");
                try
                {
                    if (File.Exists(exePath)) { File.Delete(exePath); }
                }
                catch (Exception) {; }
                Thread.Sleep(sleep);

                // download new exe
                this.Invoke(new MethodInvoker(() => {
                    this.label03.Text = "3. Downloading " + exeName + ".exe ...";
                    this.label03.Visible = true;
                    this.Update();
                }));
                FileStream fileStream = new FileStream(exePath, FileMode.Create);
                HttpWebRequest fileRequest = (HttpWebRequest)WebRequest.Create(host + "/File/Download/" + exeName + ".exe");
                WebResponse fileResponse = fileRequest.GetResponse();
                Stream fileResponseStream = fileResponse.GetResponseStream();
                byte[] bytes = new byte[1024];
                int size = fileResponseStream.Read(bytes, 0, bytes.Length);
                while (size > 0)
                {
                    fileStream.Write(bytes, 0, size);
                    size = fileResponseStream.Read(bytes, 0, bytes.Length);
                }
                fileStream.Close();
                fileResponseStream.Close();
                Thread.Sleep(sleep);

                // process start new exe
                this.Invoke(new MethodInvoker(() => {
                    this.label04.Text = "4. Starting " + exeName + ".exe ...";
                    this.label04.Visible = true;
                    this.Update();
                }));
                Process proc = new Process();
                ProcessStartInfo startInfo = new ProcessStartInfo();
                startInfo.FileName = exePath;
                Thread.Sleep(sleep);
                Process.Start(startInfo);
                

                // terminate current window
                this.Invoke(new MethodInvoker(() => {
                    this.Close();
                }));
            });
        }
    }
}
