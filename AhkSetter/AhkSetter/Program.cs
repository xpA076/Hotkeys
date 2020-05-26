using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Security.Principal;
using System.Diagnostics;

using Microsoft.Win32;


namespace AhkSetter
{
    static class Program
    {
        /// <summary>
        /// 应用程序的主入口点。
        /// </summary>
        [STAThread]
        static void Main(string[] args)
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            if (RequireRegEdit())
            {
                WindowsIdentity identity = WindowsIdentity.GetCurrent();
                WindowsPrincipal principal = new WindowsPrincipal(identity);
                if (principal.IsInRole(WindowsBuiltInRole.Administrator))
                {
                    RegEdit();
                    Application.Run(new AhkSetter());
                }
                else
                {
                    ProcessStartInfo startInfo = new ProcessStartInfo();
                    startInfo.FileName = Application.ExecutablePath;
                    startInfo.Arguments = string.Join(" ", args);
                    startInfo.Verb = "runas"; // 新建process以管理员身份运行
                    Process.Start(startInfo);
                    Application.Exit();
                }
            }
            else
            {
                Application.Run(new AhkSetter());
            }
        }

        static bool RequireRegEdit()
        {
            try
            {
                string fileName = "\"" + Application.ExecutablePath + "\"";
                RegistryKey hkey = Registry.ClassesRoot;
                RegistryKey ahkReg = hkey.OpenSubKey("AhkSetter", false);
                if (ahkReg.GetValue("").ToString() != "AhkSetter")
                {
                    return true;
                }
                if (ahkReg.GetValue("URL Protocol").ToString() != fileName)
                {
                    return true;
                }
                RegistryKey iconReg = ahkReg.OpenSubKey("DefaultIcon", false);
                if (iconReg.GetValue("").ToString() != fileName)
                {
                    return true;
                }
                RegistryKey cmdReg = ahkReg.OpenSubKey("shell", false)
                    .OpenSubKey("open", false)
                    .OpenSubKey("command", false);
                if (cmdReg.GetValue("").ToString() != fileName + " \"%0\"")
                {
                    return true;
                }
                cmdReg.Close();
                iconReg.Close();
                ahkReg.Close();
            }
            catch (Exception)
            {
                return true;
            }
            return false;
        }

        static void RegEdit()
        {
            string fileName = "\"" + Application.ExecutablePath + "\"";
            RegistryKey hkey = Registry.ClassesRoot;
            RegistryKey ahkReg = hkey.CreateSubKey("AhkSetter");
            ahkReg.SetValue("", "AhkSetter");
            ahkReg.SetValue("URL Protocol", fileName);
            RegistryKey iconReg = ahkReg.CreateSubKey("DefaultIcon");
            iconReg.SetValue("", fileName);
            RegistryKey cmdReg = ahkReg.CreateSubKey("shell")
                .CreateSubKey("open")
                .CreateSubKey("command");
            cmdReg.SetValue("", fileName + " \"%0\"");
            cmdReg.Close();
            iconReg.Close();
            ahkReg.Close();
        }

    }
}
